import 'package:drift/drift.dart' show OrderingTerm;
import 'package:drift/native.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/matching/costing.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/matching/sales.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EriDb db;
  late Sales sales;
  setUp(() {
    db = EriDb(NativeDatabase.memory());
    sales = Sales(db);
  });
  tearDown(() => db.close());

  final t = DateTime(2026, 11, 24, 14, 14);
  p.RawNotification alert(String text) =>
      p.RawNotification(package: 'team.opay.pay', title: 'OPay', text: text, postedAt: t);

  Future<Product> product(int id) => (db.select(db.products)..where((x) => x.id.equals(id))).getSingle();
  Future<BankEvent> lastEvent() =>
      (db.select(db.bankEvents)
            ..orderBy([(x) => OrderingTerm.desc(x.id)])
            ..limit(1))
          .getSingle();

  test('Day 2 exit check: ₦25,000 "ankara gown" → Sold, +₦7,500, 3 left, zero taps', () async {
    final gown = await sales.addProduct(
      name: 'Ankara Gown',
      aliases: 'gown',
      sellPriceKobo: 2500000,
      costKobo: 1750000,
      qty: 4,
    );

    await ingest(db, [alert('You have received ₦25,000.00 from CHIOMA OKAFOR. Narration: ankara gown')], sales: sales);

    expect((await product(gown)).qtyOnHand, 3);
    final order = await db.select(db.orders).getSingle();
    expect(order.status, 'paid');
    expect(order.customerName, 'CHIOMA OKAFOR');
    final items = await db.select(db.orderItems).get();
    expect(
      grossProfit(items.map((i) => (qty: i.qty, unitPriceKobo: i.unitPriceKobo, unitCostKobo: i.unitCostKobo))),
      750000,
    );
    final match = await db.select(db.matches).getSingle();
    expect(match.kind, 'narration');
    expect(match.confirmedByUser, isFalse);
  });

  test('an order set up ahead is paid by its code', () async {
    final adire = await sales.addProduct(name: 'Adire Two-piece', sellPriceKobo: 1800000, costKobo: 1200000, qty: 6);
    final o = await sales.createOrder(customer: 'Amaka Eze', lines: [SaleLine(adire, 2)], deliveryFeeKobo: 300000);
    expect(o.code, 'ERI-101');
    expect(o.expectedAmountKobo, 3900000);

    await ingest(db, [alert('You have received ₦39,000.00 from AMAKA EZE. Narration: ERI-101')], sales: sales);

    final paid = await (db.select(db.orders)..where((x) => x.id.equals(o.id))).getSingle();
    expect(paid.status, 'paid');
    expect((await product(adire)).qtyOnHand, 4);
    expect((await db.select(db.matches).getSingle()).kind, 'order_code');
  });

  test('unclear credit waits for the vendor; one tap books it', () async {
    final cap = await sales.addProduct(name: 'Aso-oke Cap', sellPriceKobo: 850000, costKobo: 500000, qty: 9);
    await ingest(db, [alert('You have received ₦9,000.00 from FEMI ADEYEMI.')], sales: sales);
    expect(await db.select(db.matches).get(), isEmpty); // in "Needs you"

    await sales.confirmManual(await lastEvent(), [SaleLine(cap, 1)]);
    expect((await product(cap)).qtyOnHand, 8);
    final m = await db.select(db.matches).getSingle();
    expect(m.kind, 'manual');
    expect(m.confirmedByUser, isTrue);
  });

  test('"always ignore this sender" covers future credits too', () async {
    await sales.addProduct(name: 'Ankara Gown', sellPriceKobo: 2500000, costKobo: 1750000, qty: 4);
    await ingest(db, [alert('You have received ₦50,000.00 from MY SAVINGS.')], sales: sales);
    await sales.ignoreSender(await lastEvent());

    await ingest(db, [alert('You have received ₦25,000.00 from MY SAVINGS. Narration: ankara gown')], sales: sales);
    final ms = await db.select(db.matches).get();
    expect(ms.map((m) => m.kind), everyElement('not_sale'));
    expect(ms, hasLength(2));
    expect(await db.select(db.orders).get(), isEmpty); // no sale, stock untouched
  });

  test('debits are never sales', () async {
    await sales.addProduct(name: 'Aso-oke Cap', sellPriceKobo: 850000, costKobo: 500000, qty: 9);
    await ingest(db, [alert('You sent ₦8,500.00 to GIG LOGISTICS.')], sales: sales);
    expect(await db.select(db.matches).get(), isEmpty);
    expect(await db.select(db.orders).get(), isEmpty);
  });

  test('restock moves the average cost; later sales use it', () async {
    final gown = await sales.addProduct(name: 'Ankara Gown', sellPriceKobo: 2500000, costKobo: 1750000, qty: 4);
    await sales.restock(gown, qty: 2, unitCostKobo: 1900000);
    final g = await product(gown);
    expect(g.qtyOnHand, 6);
    expect(g.avgCostKobo, 1800000);

    await ingest(db, [alert('You have received ₦25,000.00 from ADA OBI. Narration: ankara gown')], sales: sales);
    expect((await db.select(db.orderItems).getSingle()).unitCostKobo, 1800000);
  });

  test('undo puts the credit back in "Needs you" and the stock back on the shelf', () async {
    final gown = await sales.addProduct(name: 'Ankara Gown', sellPriceKobo: 2500000, costKobo: 1750000, qty: 4);
    await ingest(db, [alert('You have received ₦25,000.00 from CHIOMA OKAFOR. Narration: ankara gown')], sales: sales);
    expect((await product(gown)).qtyOnHand, 3);

    await sales.undo((await lastEvent()).id);
    expect((await product(gown)).qtyOnHand, 4);
    expect(await db.select(db.matches).get(), isEmpty);
    expect(await db.select(db.orders).get(), isEmpty);
    expect(await db.select(db.stockMovements).get(), hasLength(1)); // only the opening stock

    // an order set up ahead goes back to waiting, not away
    final o = await sales.createOrder(customer: 'Amaka', lines: [SaleLine(gown, 1)]);
    await ingest(db, [alert('You have received ₦25,000.00 from AMAKA. Narration: ${o.code}')], sales: sales);
    await sales.undo((await lastEvent()).id);
    expect((await (db.select(db.orders)..where((x) => x.id.equals(o.id))).getSingle()).status, 'awaiting_payment');
    expect((await product(gown)).qtyOnHand, 4);
  });
}
