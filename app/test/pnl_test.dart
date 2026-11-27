import 'package:eri/books/pnl.dart';
import 'package:eri/data/db.dart';
import 'package:eri/matching/expenses.dart';
import 'package:flutter_test/flutter_test.dart';

final fri = DateTime(2026, 11, 27, 15); // a Friday

Order order(int id, String status, DateTime? paidAt, {int fee = 0}) => Order(
  id: id,
  code: 'ERI-$id',
  status: status,
  deliveryFeeKobo: fee,
  createdAt: DateTime(2026, 11, 20),
  paidAt: paidAt,
);

OrderItem item(int orderId, int productId, int qty, int price, int cost) =>
    OrderItem(orderId: orderId, productId: productId, qty: qty, unitPriceKobo: price, unitCostKobo: cost);

BankEvent debit(int id, int kobo, DateTime at) => BankEvent(
  id: id,
  rawHash: 'h$id',
  bank: 'OPay',
  direction: 'debit',
  amountKobo: kobo,
  occurredAt: at,
  parser: 'v1',
  confidence: 1,
);

void main() {
  final orders = [
    order(1, 'paid', DateTime(2026, 11, 27, 10), fee: 150000), // today, ₦1,500 delivery
    order(2, 'paid', DateTime(2026, 11, 24, 12)), // Tuesday this week
    order(3, 'awaiting_payment', null), // never counts
    order(4, 'cancelled', DateTime(2026, 11, 27, 9)), // never counts
    order(5, 'paid', DateTime(2026, 11, 22, 23, 59)), // last Sunday: not this week
  ];
  final items = [
    item(1, 10, 2, 2500000, 1750000), // 2 gowns: sales ₦50,000, cost ₦35,000
    item(1, 11, 1, 850000, 500000), // 1 cap: sales ₦8,500, cost ₦5,000
    item(2, 10, 1, 2500000, 1750000),
    item(3, 10, 5, 2500000, 1750000),
    item(4, 10, 1, 2500000, 1750000),
    item(5, 11, 1, 850000, 500000),
  ];
  final events = [
    debit(100, 415000, DateTime(2026, 11, 27, 11)), // dispatch ₦4,150
    debit(101, 2000000, DateTime(2026, 11, 27, 12)), // supplier ₦20,000
    debit(102, 5000000, DateTime(2026, 11, 27, 13)), // to self: not business
    debit(103, 300000, DateTime(2026, 11, 27, 14)), // no category yet: not counted
    debit(104, 100000, DateTime(2026, 11, 25, 9)), // data, Wednesday
  ];
  final cats = {
    100: ExpenseCategory.dispatch,
    101: ExpenseCategory.supplier,
    102: ExpenseCategory.personal,
    104: ExpenseCategory.dataAirtime,
  };

  test('today: sales − cost of goods + delivery − business expenses, in kobo', () {
    final p = computePnl(
      from: startOfDay(fri),
      to: startOfDay(fri).add(const Duration(days: 1)),
      orders: orders,
      items: items,
      events: events,
      expenseByEvent: cats,
    );
    expect(p.salesCount, 1);
    expect(p.salesKobo, 5850000);
    expect(p.cogsKobo, 4000000);
    expect(p.grossProfitKobo, 1850000);
    expect(p.deliveryKobo, 150000);
    expect(p.expenses, {ExpenseCategory.supplier: 2000000, ExpenseCategory.dispatch: 415000}); // largest first
    expect(p.expenses.keys.first, ExpenseCategory.supplier);
    expect(p.expensesKobo, 2415000);
    expect(p.personalKobo, 5000000);
    expect(p.netKobo, 1850000 + 150000 - 2415000); // −₦4,150
  });

  test('this week starts Monday and leaves out last Sunday', () {
    expect(startOfWeek(fri), DateTime(2026, 11, 23));
    expect(startOfWeek(DateTime(2026, 11, 23, 0, 0)), DateTime(2026, 11, 23));
    expect(startOfWeek(DateTime(2026, 11, 29, 23)), DateTime(2026, 11, 23)); // Sunday belongs to its week
    final p = computePnl(
      from: startOfWeek(fri),
      to: startOfWeek(fri).add(const Duration(days: 7)),
      orders: orders,
      items: items,
      events: events,
      expenseByEvent: cats,
    );
    expect(p.salesCount, 2);
    expect(p.salesKobo, 5850000 + 2500000);
    expect(p.cogsKobo, 4000000 + 1750000);
    expect(p.expensesKobo, 2415000 + 100000);
    expect(p.netKobo, (8350000 - 5750000) + 150000 - 2515000);
  });

  test('day by day adds up to the week', () {
    final days = weekByDay(now: fri, orders: orders, items: items, events: events, expenseByEvent: cats);
    expect(days, hasLength(7));
    expect(days.first.from, DateTime(2026, 11, 23));
    expect(days[1].salesCount, 1); // Tuesday
    expect(days[2].expensesKobo, 100000); // Wednesday
    expect(days.last.netKobo, 0); // Sunday, still ahead
    final week = computePnl(
      from: startOfWeek(fri),
      to: startOfWeek(fri).add(const Duration(days: 7)),
      orders: orders,
      items: items,
      events: events,
      expenseByEvent: cats,
    );
    expect(days.fold(0, (s, d) => s + d.netKobo), week.netKobo);
  });

  test('a quiet day is all zeros, not an error', () {
    final p = computePnl(
      from: DateTime(2026, 12, 1),
      to: DateTime(2026, 12, 2),
      orders: orders,
      items: items,
      events: events,
      expenseByEvent: cats,
    );
    expect([p.salesCount, p.salesKobo, p.cogsKobo, p.expensesKobo, p.netKobo], everyElement(0));
  });
}
