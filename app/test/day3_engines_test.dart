import 'package:eri/claims/claims.dart';
import 'package:eri/matching/expenses.dart';
import 'package:eri/receipts/receipt.dart';
import 'package:flutter_test/flutter_test.dart';

// SYNTHETIC chat lines and receipt texts (written to look like real ones). Replace with real, redacted samples.
void main() {
  group('expenses', () {
    test('keywords', () {
      expect(classifyDebit(counterparty: 'GIG LOGISTICS'), ExpenseCategory.dispatch);
      expect(classifyDebit(counterparty: 'FACEBK ADS', narration: 'meta ads boost'), ExpenseCategory.ads);
      expect(classifyDebit(narration: 'MTN airtime'), ExpenseCategory.dataAirtime);
      expect(classifyDebit(counterparty: 'BALOGUN MARKET FABRICS'), ExpenseCategory.supplier);
      expect(classifyDebit(counterparty: 'ADA OBI'), ExpenseCategory.other);
    });
    test('the vendor’s earlier choice wins', () {
      expect(
        classifyDebit(counterparty: 'ADA OBI', remembered: {'ada obi': ExpenseCategory.supplier}),
        ExpenseCategory.supplier,
      );
    });
  });

  group('chat claims', () {
    test('claims, pidgin included', () {
      expect(detectClaim(title: 'Tunde Bakare', text: 'I don pay, check am 🙏')!.sender, 'Tunde Bakare');
      expect(detectClaim(title: 'Chioma', text: "I've sent it, check your account")!.amountKobo, isNull);
      expect(detectClaim(title: 'Chioma', text: 'Transfer don go. ₦45,000')!.amountKobo, 4500000);
      expect(detectClaim(title: 'Ada', text: 'payment made 45k')!.amountKobo, 4500000);
      expect(detectClaim(title: 'Lagos Buyers: Femi A', text: 'I have paid')!.sender, 'Femi A');
    });
    test('promises and questions are not claims', () {
      expect(detectClaim(title: 'Tunde', text: 'I will pay tomorrow'), isNull);
      expect(detectClaim(title: 'Tunde', text: 'I go send am later'), isNull);
      expect(detectClaim(title: 'Tunde', text: 'Have you received?'), isNull);
      expect(detectClaim(title: 'Tunde', text: "I haven't paid yet"), isNull);
      expect(detectClaim(title: 'Tunde', text: 'Is the gown still available'), isNull);
    });

    final at = DateTime(2026, 11, 24, 14, 0);
    ClaimCredit c(int id, int kobo, int minutes, [String? who]) => ClaimCredit(
      id: id,
      amountKobo: kobo,
      occurredAt: at.add(Duration(minutes: minutes)),
      counterparty: who,
    );

    test('money from the same person → verified', () {
      final r = resolveClaim(
        sender: 'Chioma Okafor',
        amountKobo: 4500000,
        claimedAt: at,
        now: at.add(const Duration(minutes: 2)),
        credits: [c(1, 4500000, 1, 'CHIOMA OKAFOR')],
      );
      expect(r.status, ClaimStatus.verified);
      expect(r.bankEventId, 1);
    });
    test('still within the 10 minutes → pending', () {
      expect(
        resolveClaim(sender: 'Tunde', claimedAt: at, now: at.add(const Duration(minutes: 5)), credits: const []).status,
        ClaimStatus.pending,
      );
    });
    test('10 minutes, nothing from Tunde (other money landed) → not received', () {
      final r = resolveClaim(
        sender: 'Tunde Bakare',
        amountKobo: 4500000,
        claimedAt: at,
        now: at.add(const Duration(minutes: 11)),
        credits: [c(2, 1800000, 4, 'AMAKA EZE')],
      );
      expect(r.status, ClaimStatus.notReceived);
    });
    test('same person, different amount → mismatch', () {
      final r = resolveClaim(
        sender: 'Tunde Bakare',
        amountKobo: 4500000,
        claimedAt: at,
        now: at.add(const Duration(minutes: 11)),
        credits: [c(3, 450000, 3, 'TUNDE BAKARE')],
      );
      expect(r.status, ClaimStatus.mismatch);
      expect(r.bankEventId, 3);
    });
    test('a credit already used for another claim doesn’t count twice', () {
      final r = resolveClaim(
        sender: 'Tunde Bakare',
        claimedAt: at,
        now: at.add(const Duration(minutes: 11)),
        credits: [c(4, 4500000, 1, 'TUNDE BAKARE')],
        taken: {4},
      );
      expect(r.status, ClaimStatus.notReceived);
    });
  });

  group('receipts', () {
    const real = '''
Transfer receipt
Successful
Amount
₦25,000.00
Sender
CHIOMA OKAFOR
Beneficiary
ADAEZE STORES
GTBank
21 Nov 2026 · 2:14 PM
Session ID
000013261121141408123456''';

    test('parses a labelled receipt', () {
      final f = parseReceipt(real);
      expect(f.amountKobo, 2500000);
      expect(f.sender, 'CHIOMA OKAFOR');
      expect(f.recipient, 'ADAEZE STORES');
      expect(f.bank, 'GTBank');
      expect(f.time, DateTime(2026, 11, 21, 14, 14));
      expect(f.sessionId, '000013261121141408123456');
    });

    test('other date formats', () {
      expect(parseReceipt('Nov 21, 2026 2:14 PM').time, DateTime(2026, 11, 21, 14, 14));
      expect(parseReceipt('2026-11-21 14:14:08').time, DateTime(2026, 11, 21, 14, 14));
      expect(parseReceipt('21/11/2026 14:14').time, DateTime(2026, 11, 21, 14, 14));
    });

    test('no label: largest naira figure, ignoring balance and fees', () {
      final f = parseReceipt('You sent ₦45,000.00\nFee ₦10.75\nBalance ₦912,300.00');
      expect(f.amountKobo, 4500000);
    });

    final now = DateTime(2026, 11, 21, 14, 30);
    ReceiptCredit rc(int id, int kobo, int h, int m, String who) => ReceiptCredit(
      id: id,
      amountKobo: kobo,
      occurredAt: DateTime(2026, 11, 21, h, m),
      counterparty: who,
      bank: 'GTBank',
    );

    test('real receipt → landed', () {
      final v = checkReceipt(parseReceipt(real), [rc(1, 2500000, 14, 14, 'CHIOMA OKAFOR')], now: now);
      expect(v.verdict, Verdict.landed);
      expect(v.bankEventId, 1);
      expect(v.reasons.single, contains('2:14 PM'));
    });

    test('edited amount → mismatch with the closest real credit (the landing page story)', () {
      final fake = parseReceipt('Amount\n₦45,000.00\nSender\nTUNDE BAKARE\nMoniepoint\n21 Nov 2026 · 2:14 PM');
      final v = checkReceipt(fake, [rc(2, 450000, 14, 9, 'TUNDE BAKARE')], now: now);
      expect(v.verdict, Verdict.mismatch);
      expect(v.reasons.last, 'The amount looks edited: ₦4,500 → ₦45,000.');
    });

    test('nothing landed → not received', () {
      final fake = parseReceipt('Amount\n₦45,000.00\nSender\nTUNDE BAKARE\n21 Nov 2026 · 2:14 PM');
      final v = checkReceipt(fake, [rc(3, 1800000, 14, 5, 'AMAKA EZE')], now: now);
      expect(v.verdict, Verdict.notReceived);
    });

    test('no amount → unreadable, not a false accusation', () {
      expect(checkReceipt(parseReceipt('blurry photo'), const [], now: now).verdict, Verdict.unreadable);
    });
  });
}
