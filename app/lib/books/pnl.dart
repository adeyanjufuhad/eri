import 'package:eri/data/db.dart';
import 'package:eri/matching/expenses.dart';

/// Profit and loss for a period, from real money only (PLAN.md Day 5). All amounts are kobo integers.
///
///   sales            what paid orders sold for (items only)
///   − cost of goods  the cost snapshot taken when each order was paid
///   = gross profit   (the "Profit" on Today)
///   + delivery fees  collected on paid orders: they pay for the Dispatch expenses below
///   − expenses       business debits by category ("Not business" left out)
///   = net
///
/// Orders still waiting for payment, cancelled orders and unclassified debits never count.
class Pnl {
  const Pnl({
    required this.from,
    required this.to,
    required this.salesCount,
    required this.salesKobo,
    required this.cogsKobo,
    required this.deliveryKobo,
    required this.expenses,
    required this.personalKobo,
  });

  /// The period is [from, to): from midnight, up to but not including [to].
  final DateTime from, to;
  final int salesCount, salesKobo, cogsKobo, deliveryKobo;

  /// Business expenses by category, largest first; never contains [ExpenseCategory.personal].
  final Map<ExpenseCategory, int> expenses;

  /// Debits marked "Not business": shown for reassurance, left out of the net.
  final int personalKobo;

  int get grossProfitKobo => salesKobo - cogsKobo;
  int get expensesKobo => expenses.values.fold(0, (s, v) => s + v);
  int get netKobo => grossProfitKobo + deliveryKobo - expensesKobo;
}

DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

/// Weeks start on Monday.
DateTime startOfWeek(DateTime d) => startOfDay(d).subtract(Duration(days: d.weekday - DateTime.monday));

bool _inside(DateTime t, DateTime from, DateTime to) => !t.isBefore(from) && t.isBefore(to);

Pnl computePnl({
  required DateTime from,
  required DateTime to,
  required Iterable<Order> orders,
  required Iterable<OrderItem> items,
  required Iterable<BankEvent> events,
  required Map<int, ExpenseCategory> expenseByEvent,
}) {
  final paid = {
    for (final o in orders)
      if (o.status == 'paid' && o.paidAt != null && _inside(o.paidAt!, from, to)) o.id: o,
  };
  var sales = 0, cogs = 0;
  for (final i in items) {
    if (!paid.containsKey(i.orderId)) continue;
    sales += i.qty * i.unitPriceKobo;
    cogs += i.qty * i.unitCostKobo;
  }
  final byCat = <ExpenseCategory, int>{};
  var personal = 0;
  for (final e in events) {
    if (e.direction != 'debit' || !_inside(e.occurredAt, from, to)) continue;
    final cat = expenseByEvent[e.id];
    if (cat == null) continue;
    if (cat == ExpenseCategory.personal) {
      personal += e.amountKobo;
    } else {
      byCat[cat] = (byCat[cat] ?? 0) + e.amountKobo;
    }
  }
  final sorted = byCat.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  return Pnl(
    from: from,
    to: to,
    salesCount: paid.length,
    salesKobo: sales,
    cogsKobo: cogs,
    deliveryKobo: paid.values.fold(0, (s, o) => s + o.deliveryFeeKobo),
    expenses: {for (final e in sorted) e.key: e.value},
    personalKobo: personal,
  );
}

/// One P&L per day from Monday of [now]'s week to Sunday (days after today come back empty).
List<Pnl> weekByDay({
  required DateTime now,
  required Iterable<Order> orders,
  required Iterable<OrderItem> items,
  required Iterable<BankEvent> events,
  required Map<int, ExpenseCategory> expenseByEvent,
}) {
  final monday = startOfWeek(now);
  return [
    for (var d = 0; d < 7; d++)
      computePnl(
        from: DateTime(monday.year, monday.month, monday.day + d),
        to: DateTime(monday.year, monday.month, monday.day + d + 1),
        orders: orders,
        items: items,
        events: events,
        expenseByEvent: expenseByEvent,
      ),
  ];
}
