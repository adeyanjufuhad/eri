import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/notification_bridge.dart';
import 'package:eri/matching/costing.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/matching/sales.dart';

final dbProvider = Provider<EriDb>((ref) {
  final db = EriDb();
  ref.onDispose(db.close);
  return db;
});

final bridgeProvider = Provider<NotificationBridge>((_) => NotificationBridge());

final salesProvider = Provider<Sales>((ref) => Sales(ref.watch(dbProvider)));

/// Re-checked whenever the app comes back to the front (the user may have just granted it in Settings).
final permissionProvider = FutureProvider<bool>((ref) => ref.watch(bridgeProvider).isPermissionGranted());

final eventsProvider = StreamProvider<List<BankEvent>>((ref) => ref.watch(dbProvider).watchEvents());
final rawProvider = StreamProvider<List<RawNotification>>((ref) => ref.watch(dbProvider).watchRaw());
final productsProvider = StreamProvider<List<Product>>((ref) => ref.watch(dbProvider).watchProducts());
final ordersProvider = StreamProvider<List<Order>>((ref) => ref.watch(dbProvider).watchOrders());
final matchesProvider = StreamProvider<List<SaleMatch>>((ref) => ref.watch(dbProvider).watchMatches());
final orderItemsProvider = StreamProvider<List<OrderItem>>((ref) => ref.watch(dbProvider).watchOrderItems());

/// What the engine suggests for a credit waiting in "Needs you".
final suggestionsProvider = FutureProvider.family<MatchOutcome, int>((ref, eventId) async {
  ref.watch(productsProvider); // re-suggest when the catalogue changes
  ref.watch(ordersProvider);
  // straight from the database: the events stream may not have delivered yet on a cold start
  final db = ref.watch(dbProvider);
  final e = await (db.select(db.bankEvents)..where((t) => t.id.equals(eventId))).getSingleOrNull();
  if (e == null) return const MatchOutcome();
  return ref.read(salesProvider).outcomeFor(e);
});

/// One line per bank event for the feed: "Sold: Ankara Gown · +₦7,500 · 3 left", "Not a sale", or null
/// (still undecided).
class EventLabel {
  const EventLabel(this.text, {this.sale = false});
  final String text;
  final bool sale;
}

class Books {
  const Books({
    required this.moneyInKobo,
    required this.moneyOutKobo,
    required this.salesCount,
    required this.profitKobo,
    required this.needsYou,
    required this.labels,
    required this.lowStock,
  });

  final int moneyInKobo, moneyOutKobo, salesCount, profitKobo;
  final List<BankEvent> needsYou; // credits with no decision yet (last 7 days)
  final Map<int, EventLabel> labels; // bank event id → what it became
  final List<Product> lowStock;
}

final booksProvider = Provider<Books>((ref) {
  final events = ref.watch(eventsProvider).value ?? const [];
  final matches = ref.watch(matchesProvider).value ?? const [];
  final orders = ref.watch(ordersProvider).value ?? const [];
  final items = ref.watch(orderItemsProvider).value ?? const [];
  final products = ref.watch(productsProvider).value ?? const [];
  final now = DateTime.now();

  final byId = {for (final p in products) p.id: p};
  final itemsByOrder = <int, List<OrderItem>>{};
  for (final i in items) {
    (itemsByOrder[i.orderId] ??= []).add(i);
  }
  int profitOf(int orderId) => grossProfit(
    (itemsByOrder[orderId] ?? const []).map(
      (i) => (qty: i.qty, unitPriceKobo: i.unitPriceKobo, unitCostKobo: i.unitCostKobo),
    ),
  );

  final matchByEvent = {for (final m in matches) m.bankEventId: m};
  final labels = <int, EventLabel>{};
  for (final e in events) {
    final m = matchByEvent[e.id];
    if (m == null) continue;
    if (m.orderId == null) {
      labels[e.id] = const EventLabel('Not a sale');
      continue;
    }
    final lines = itemsByOrder[m.orderId] ?? const [];
    final names = lines.map((i) => '${byId[i.productId]?.name ?? 'Item'}${i.qty > 1 ? ' ×${i.qty}' : ''}').join(', ');
    final left = lines.length == 1 && byId[lines.first.productId] != null
        ? ' · ${byId[lines.first.productId]!.qtyOnHand} left'
        : '';
    labels[e.id] = EventLabel('Sold: $names · +${naira(profitOf(m.orderId!))}$left', sale: true);
  }

  final today = events.where((e) => sameDay(e.occurredAt, now));
  final paidToday = orders.where((o) => o.status == 'paid' && o.paidAt != null && sameDay(o.paidAt!, now));
  final weekAgo = now.subtract(const Duration(days: 7));

  return Books(
    moneyInKobo: today.where((e) => e.direction == 'credit').fold(0, (s, e) => s + e.amountKobo),
    moneyOutKobo: today.where((e) => e.direction == 'debit').fold(0, (s, e) => s + e.amountKobo),
    salesCount: paidToday.length,
    profitKobo: paidToday.fold(0, (s, o) => s + profitOf(o.id)),
    needsYou: [
      for (final e in events)
        if (e.direction == 'credit' && !matchByEvent.containsKey(e.id) && e.occurredAt.isAfter(weekAgo)) e,
    ],
    labels: labels,
    lowStock: [
      for (final p in products)
        if (p.qtyOnHand <= p.lowStockThreshold) p,
    ],
  );
});
