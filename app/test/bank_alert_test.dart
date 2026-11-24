import 'package:eri/core/money.dart';
import 'package:eri/parsing/bank_alert.dart';
import 'package:flutter_test/flutter_test.dart';

// SYNTHETIC samples, written to look like common Nigerian alert styles. They are NOT copied from real phones.
// Replace / extend them with the real samples from Day 0 (docs/SPIKE.md) before trusting the parser.
final _t = DateTime(2026, 11, 23, 14, 14);
RawNotification n(String text, {String title = '', String package = 'com.google.android.apps.messaging'}) =>
    RawNotification(package: package, title: title, text: text, postedAt: _t);

void main() {
  group('naira / parseKobo', () {
    test('formats kobo at the edge', () {
      expect(naira(2500000), '₦25,000');
      expect(naira(2500050), '₦25,000.50');
      expect(naira(0), '₦0');
      expect(naira(-50000), '-₦500');
    });
    test('parses written amounts without floats', () {
      expect(parseKobo('25,000.00'), 2500000);
      expect(parseKobo('25000'), 2500000);
      expect(parseKobo('1,250.5'), 125050);
      expect(parseKobo('12,34'), isNull);
    });
  });

  group('credits', () {
    test('GTBank SMS: skips the balance, reads sender and note', () {
      final a = parseAlert(
        n(
          'GTBank: Acct 01******89 Cr NGN25,000.00\nfrom CHIOMA OKAFOR Desc: ankara gown\nAvail Bal: NGN412,300.00  21-Nov-26 14:14',
        ),
      )!;
      expect(a.bank, 'GTBank');
      expect(a.direction, Direction.credit);
      expect(a.amountKobo, 2500000);
      expect(a.counterparty, 'CHIOMA OKAFOR');
      expect(a.narration, 'ankara gown');
      expect(a.occurredAt, _t);
      expect(a.confidence, 1.0);
    });

    test('GTBank labelled SMS: Amt line, balance first is ignored', () {
      final a = parseAlert(
        n(
          'Acct: 01******89\nAvail Bal: NGN412,300.00\nAmt: NGN25,000.00 CR\nDesc: CHIOMA OKAFOR/ankara gown',
          title: 'GTBank',
        ),
      )!;
      expect(a.amountKobo, 2500000);
      expect(a.direction, Direction.credit);
      expect(a.narration, 'CHIOMA OKAFOR/ankara gown');
    });

    test('OPay push: bank from the package', () {
      final a = parseAlert(
        n('You have received ₦8,500.00 from FEMI ADEYEMI.', title: 'Transfer received', package: 'team.opay.pay'),
      )!;
      expect(a.bank, 'OPay');
      expect(a.amountKobo, 850000);
      expect(a.counterparty, 'FEMI ADEYEMI');
      expect(a.narration, isNull);
    });

    test('Moniepoint: NGN with a space, Narration label', () {
      final a = parseAlert(n('Credit Alert! NGN 18,000.00 from AMAKA EZE. Narration: adire set', title: 'Moniepoint'))!;
      expect(a.amountKobo, 1800000);
      expect(a.counterparty, 'AMAKA EZE');
      expect(a.narration, 'adire set');
    });

    test('Kuda: quoted note after a dash', () {
      final a = parseAlert(
        n('You just got ₦12,000 from Bola Sanni - “aso-oke cap”', title: 'Money in!', package: 'com.kudabank.app'),
      )!;
      expect(a.bank, 'Kuda');
      expect(a.amountKobo, 1200000);
      expect(a.counterparty, 'Bola Sanni');
      expect(a.narration, 'aso-oke cap');
    });

    test('session ID when present', () {
      final a = parseAlert(
        n('Credit Alert! NGN 45,000.00 from TUNDE BAKARE. Session ID: 090405261121141402987654321012'),
      )!;
      expect(a.sessionId, '090405261121141402987654321012');
      expect(a.counterparty, 'TUNDE BAKARE');
    });

    test('unknown bank still parses, with lower confidence', () {
      final a = parseAlert(n('You received N5,000 from ADA OBI'))!;
      expect(a.bank, 'Unknown bank');
      expect(a.amountKobo, 500000);
      expect(a.confidence, closeTo(0.7, 1e-9));
    });
  });

  group('debits', () {
    test('GTBank DR is an expense', () {
      final a = parseAlert(
        n(
          'Acct: 01******89\nAmt: NGN3,500.00 DR\nDesc: POS PURCHASE DISPATCH RIDER\nAvail Bal: NGN408,800.00',
          title: 'GTBank',
        ),
      )!;
      expect(a.direction, Direction.debit);
      expect(a.amountKobo, 350000);
    });

    test('OPay sent: counterparty is who you paid', () {
      final a = parseAlert(n('You sent ₦4,150.00 to GIG LOGISTICS.', package: 'team.opay.pay'))!;
      expect(a.direction, Direction.debit);
      expect(a.counterparty, 'GIG LOGISTICS');
    });
  });

  group('not payments', () {
    test('OTP', () => expect(parseAlert(n('Your OTP is 482913 for a NGN 5,000.00 transfer. Do not share.')), isNull));
    test('promo', () => expect(parseAlert(n('Win up to ₦1,000,000 this December! Play now')), isNull));
    test('balance only', () => expect(parseAlert(n('Your available balance is NGN412,300.00')), isNull));
    test('chat with no money', () => expect(parseAlert(n('I have received the gown, thank you')), isNull));
  });
}
