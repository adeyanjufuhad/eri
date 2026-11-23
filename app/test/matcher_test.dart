import 'package:eri/matching/costing.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/matching/text_match.dart';
import 'package:flutter_test/flutter_test.dart';

const gown = MProduct(id: 1, name: 'Ankara Gown', aliases: ['gown'], priceKobo: 2500000, qty: 4);
const adire = MProduct(id: 2, name: 'Adire Two-piece', aliases: ['adire set'], priceKobo: 1800000, qty: 6);
const cap = MProduct(id: 3, name: 'Aso-oke Cap', priceKobo: 850000, qty: 9);
const catalogue = [gown, adire, cap];

MatchOutcome m(int kobo, {String? from, String? note, List<MOrder> orders = const [], Set<String> ignore = const {}, int fee = 0}) =>
    matchCredit(MEvent(amountKobo: kobo, counterparty: from, narration: note),
        products: catalogue, openOrders: orders, ignoredSenders: ignore, deliveryFeeKobo: fee);

void main() {
  group('text', () {
    test('typos still match a product phrase', () {
      expect(phraseScore('Ankara Gown', 'ankara gown'), 1);
      expect(phraseScore('Ankara Gown', 'pls this is for the ANKRA gwn'), greaterThan(0.75));
      expect(phraseScore('Ankara Gown', 'school fees'), 0);
    });
    test('names with initials', () {
      expect(nameSimilarity('CHIOMA OKAFOR', 'Chioma O.'), greaterThan(0.9));
      expect(nameSimilarity('CHIOMA OKAFOR', 'TUNDE BAKARE'), lessThan(0.5));
    });
  });

  group('matching', () {
    test('Day 2 exit check: ₦25,000 "ankara gown" → Ankara Gown ×1, automatically', () {
      final a = m(2500000, from: 'CHIOMA OKAFOR', note: 'ankara gown').auto!;
      expect(a.kind, MatchKind.narration);
      expect(a.lines, [const SaleLine(1, 1)]);
      expect(a.confidence, 1.0);
    });

    test('order code wins, even with no product words', () {
      const o = MOrder(id: 7, code: 'ERI-104', expectedKobo: 3350000, customer: 'Amaka Eze', lines: [SaleLine(2, 1), SaleLine(3, 1)]);
      final a = m(3350000, from: 'AMAKA EZE', note: 'eri 104', orders: [o]).auto!;
      expect(a.kind, MatchKind.orderCode);
      expect(a.orderId, 7);
    });

    test('order code but short payment → ask', () {
      const o = MOrder(id: 7, code: 'ERI-104', expectedKobo: 3350000);
      final out = m(2000000, note: 'ERI-104', orders: [o]);
      expect(out.auto, isNull);
      expect(out.proposals.first.orderId, 7);
    });

    test('expected payment: exact amount and the right name', () {
      const o = MOrder(id: 9, code: 'ERI-120', expectedKobo: 4500000, customer: 'Tunde Bakare', lines: [SaleLine(1, 1)]);
      final a = m(4500000, from: 'TUNDE BAKARE', orders: [o]).auto!;
      expect(a.kind, MatchKind.expectedPayment);
      expect(a.orderId, 9);
    });

    test('expected amount from a different name → ask', () {
      const o = MOrder(id: 9, code: 'ERI-120', expectedKobo: 4500000, customer: 'Tunde Bakare');
      expect(m(4500000, from: 'BOLA SANNI', orders: [o]).auto, isNull);
    });

    test('quantity from the amount: ₦50,000 "gown" → 2', () {
      expect(m(5000000, note: 'gown').auto!.lines, [const SaleLine(1, 2)]);
    });

    test('quantity written in the note: "2 adire set"', () {
      expect(m(3600000, note: '2 adire set').auto!.lines, [const SaleLine(2, 2)]);
    });

    test('product named but amount wrong → ask, product first', () {
      final out = m(2000000, note: 'ankara gown');
      expect(out.auto, isNull);
      expect(out.proposals.first.lines.first.productId, 1);
    });

    test('amount alone fits one product', () {
      final a = m(850000, from: 'FEMI ADEYEMI').auto!;
      expect(a.kind, MatchKind.amountCombo);
      expect(a.lines, [const SaleLine(3, 1)]);
    });

    test('amount alone fits a combination plus delivery fee → suggested, not booked', () {
      // adire + cap = ₦26,500, + ₦3,000 delivery
      final out = m(2950000, fee: 300000);
      expect(out.auto, isNull);
      expect(out.proposals.first.lines.toSet(), {const SaleLine(2, 1), const SaleLine(3, 1)});
      expect(out.proposals.first.deliveryFeeKobo, 300000);
    });

    test('amount alone never guesses a quantity: ₦50,000, no note → ask', () {
      final out = m(5000000, from: 'MY SAVINGS');
      expect(out.auto, isNull);
      expect(out.proposals.first.lines, [const SaleLine(1, 2)]);
    });

    test('ambiguous amount → ask with every option', () {
      // two products at the same price: the amount can't tell them apart
      final out = matchCredit(const MEvent(amountKobo: 1000000),
          products: const [MProduct(id: 1, name: 'A', priceKobo: 1000000, qty: 1), MProduct(id: 2, name: 'B', priceKobo: 1000000, qty: 1)]);
      expect(out.auto, isNull);
      expect(out.proposals, hasLength(2));
    });

    test('nothing fits → no proposals (one-tap confirm)', () {
      expect(m(123400, from: 'ADA OBI', note: 'school fees').proposals, isEmpty);
    });

    test('ignored sender', () {
      final out = m(2500000, from: 'MY SAVINGS', note: 'ankara gown', ignore: {'my savings'});
      expect(out.ignored, isTrue);
      expect(out.auto, isNull);
    });
  });

  group('costing', () {
    test('moving average on restock', () {
      expect(movingAverageCost(oldQty: 4, oldAvgKobo: 1750000, addQty: 2, unitCostKobo: 1900000), 1800000);
      expect(movingAverageCost(oldQty: 0, oldAvgKobo: 1750000, addQty: 5, unitCostKobo: 1600000), 1600000);
      expect(movingAverageCost(oldQty: 3, oldAvgKobo: 100, addQty: 0, unitCostKobo: 999), 100);
    });
    test('gross profit', () {
      expect(grossProfit([(qty: 1, unitPriceKobo: 2500000, unitCostKobo: 1750000)]), 750000);
    });
  });
}
