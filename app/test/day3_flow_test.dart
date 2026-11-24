import 'package:drift/native.dart';
import 'package:eri/claims/claim_service.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/matching/expenses.dart';
import 'package:eri/matching/sales.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:eri/receipts/receipt.dart';
import 'package:eri/receipts/receipt_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EriDb db;
  setUp(() => db = EriDb(NativeDatabase.memory()));
  tearDown(() => db.close());

  final t0 = DateTime(2026, 11, 24, 14, 0);
  p.RawNotification n(String pkg, String title, String text, int minute) => p.RawNotification(
    package: pkg,
    title: title,
    text: text,
    postedAt: t0.add(Duration(minutes: minute)),
  );

  test('"I don pay" with no money → not received after 10 minutes; chat text never enters the alert log', () async {
    await ingest(db, [n('com.whatsapp', 'Tunde Bakare', 'I don pay, check am 🙏 ₦45,000', 0)]);
    // other money lands, but not Tunde's
    await ingest(db, [n('team.opay.pay', 'OPay', 'You have received ₦18,000.00 from AMAKA EZE.', 4)]);

    expect((await db.select(db.paymentClaims).getSingle()).status, 'pending');
    expect((await db.select(db.rawNotifications).get()).map((r) => r.package), everyElement('team.opay.pay'));

    await Claims(db).resolve(now: t0.add(const Duration(minutes: 11)));
    final c = await db.select(db.paymentClaims).getSingle();
    expect(c.status, 'not_received');
    expect(c.amountKobo, 4500000);
  });

  test('the money arrives → claim verified quietly', () async {
    await ingest(db, [n('com.whatsapp', 'Chioma Okafor', "I've paid, check your account", 0)]);
    await ingest(db, [n('team.opay.pay', 'OPay', 'You have received ₦25,000.00 from CHIOMA OKAFOR.', 2)]);
    expect((await db.select(db.paymentClaims).getSingle()).status, 'verified');
  });

  test('chat chatter is dropped, not stored', () async {
    await ingest(db, [n('com.whatsapp', 'Chioma', 'Is the gown available in blue?', 0)]);
    expect(await db.select(db.paymentClaims).get(), isEmpty);
    expect(await db.select(db.rawNotifications).get(), isEmpty);
  });

  test('debits become expenses; the vendor’s correction is remembered for that recipient', () async {
    final sales = Sales(db);
    await ingest(db, [n('team.opay.pay', 'OPay', 'You sent ₦4,150.00 to GIG LOGISTICS.', 0)], sales: sales);
    expect((await db.select(db.expenses).getSingle()).category, 'dispatch');

    await ingest(db, [n('team.opay.pay', 'OPay', 'You sent ₦50,000.00 to ADA OBI.', 1)], sales: sales);
    final ada = (await db.select(db.bankEvents).get()).last;
    await sales.setExpenseCategory(ada.id, ExpenseCategory.supplier);
    await ingest(db, [n('team.opay.pay', 'OPay', 'You sent ₦30,000.00 to ADA OBI.', 2)], sales: sales);
    final cats = (await db.select(db.expenses).get()).map((e) => e.category).toList();
    expect(cats, ['dispatch', 'supplier', 'supplier']);
  });

  test('receipt check: edited screenshot → mismatch, stored without the image', () async {
    await ingest(db, [
      n('com.google.android.apps.messaging', 'Moniepoint', 'Credit Alert! NGN 4,500.00 from TUNDE BAKARE.', 9),
    ]);
    final r = await Receipts(db).checkText(
      'Transfer receipt\nAmount  ₦45,000.00\nSender  TUNDE BAKARE\nMoniepoint\n24 Nov 2026 · 2:14 PM',
      imageHash: 'abc',
      now: t0.add(const Duration(minutes: 20)),
    );
    expect(r.verdict.verdict, Verdict.mismatch);
    final row = await db.select(db.receiptChecks).getSingle();
    expect(row.verdict, 'mismatch');
    expect(row.imageHash, 'abc');
  });
}
