import 'package:drift/native.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EriDb db;
  setUp(() => db = EriDb(NativeDatabase.memory()));
  tearDown(() => db.close());

  final t = DateTime(2026, 11, 23, 14, 14);
  p.RawNotification n(String text, {DateTime? at}) =>
      p.RawNotification(package: 'team.opay.pay', title: 'OPay', text: text, postedAt: at ?? t);

  test('a payment becomes one bank event; a repeat of the same notification is ignored', () async {
    final alert = n('You have received ₦25,000.00 from CHIOMA OKAFOR.');
    expect(await ingest(db, [alert, alert]), 1);
    expect(await ingest(db, [alert]), 0);

    final events = await db.select(db.bankEvents).get();
    expect(events.single.amountKobo, 2500000);
    expect(events.single.direction, 'credit');
    expect(events.single.counterparty, 'CHIOMA OKAFOR');
  });

  test('non-payments are kept raw (on the phone) but make no bank event', () async {
    expect(await ingest(db, [n('Your OTP is 482913 for NGN 5,000.00')]), 0);
    expect((await db.select(db.rawNotifications).get()).single.parsed, isFalse);
    expect(await db.select(db.bankEvents).get(), isEmpty);
  });

  test('raw text older than 7 days is purged', () async {
    await ingest(db, [n('You have received ₦1,000.00 from ADA OBI.', at: DateTime(2026, 11, 1))]);
    expect(await db.purgeOldRaw(now: t), 1);
    expect(await db.select(db.rawNotifications).get(), isEmpty);
    expect(await db.select(db.bankEvents).get(), hasLength(1)); // the parsed event stays
  });

  test('two real payments with identical text both count (different post times)', () async {
    const text = 'You have received ₦100.00 from ADA OBI.';
    await ingest(db, [n(text, at: t), n(text, at: t.add(const Duration(minutes: 2)))]);
    await ingest(db, [n(text, at: t)]); // a re-delivery of the first notification is still a duplicate
    expect(await db.select(db.bankEvents).get(), hasLength(2));
  });

  test("a bank's app push and its SMS for the same payment count once", () async {
    final push = p.RawNotification(
      package: 'team.opay.pay',
      title: 'Incoming Transfer Successful',
      text: 'JOHN DOE has sent you ₦100.00.',
      postedAt: t,
    );
    final sms = p.RawNotification(
      package: 'com.google.android.apps.messaging',
      title: 'OPayInfo',
      text: 'JOHN DOE\nAcc:123****456\nAmt:NGN100.00\nBal:NGN305.88',
      postedAt: t.add(const Duration(seconds: 13)),
    );
    await ingest(db, [push, sms]);
    expect(await db.select(db.bankEvents).get(), hasLength(1));
    expect(await db.select(db.rawNotifications).get(), hasLength(2)); // both kept in the on-phone log
  });
}
