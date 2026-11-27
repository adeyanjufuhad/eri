import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/notification_bridge.dart';
import 'package:eri/books/pnl.dart';
import 'package:eri/canary/canary.dart';
import 'package:eri/claims/claim_service.dart';
import 'package:eri/matching/costing.dart';
import 'package:eri/matching/expenses.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/matching/sales.dart';
import 'package:eri/receipts/receipt_service.dart';

final dbProvider = Provider<EriDb>((ref) {
  final db = EriDb();
  ref.onDispose(db.close);
  return db;
});

final bridgeProvider = Provider<NotificationBridge>((_) => NotificationBridge());

final salesProvider = Provider<Sales>((ref) => Sales(ref.watch(dbProvider)));
final claimsProvider = Provider<Claims>((ref) => Claims(ref.watch(dbProvider)));
final receiptsProvider = Provider<Receipts>((ref) => Receipts(ref.watch(dbProvider)));

final expensesProvider = StreamProvider<List<Expense>>((ref) => ref.watch(dbProvider).watchExpenses());
final claimListProvider = StreamProvider<List<PaymentClaim>>((ref) => ref.watch(dbProvider).watchClaims());

/// Canary client with this install's random id (created once, kept on the phone).
final canaryProvider = FutureProvider<CanaryClient>((ref) async {
  final db = ref.watch(dbProvider);
  var id = await db.setting('install_id');
  if (id == null) {
    id = newInstallId();
    await db.setSetting('install_id', id);
  }
  return CanaryClient(installId: id);
});

/// Scam warnings from other Eri vendors (sends a hash to check). On unless the vendor turns it off.
final canaryOnProvider = FutureProvider<bool>((ref) async => await ref.watch(dbProvider).setting('canary') != 'off');

/// "Flagged by N Eri vendors": by sender name and/or receipt image hash. 0 when off or offline.
final canaryFlagsProvider = FutureProvider.family<int, ({String? sender, String? imageHash})>((ref, q) async {
  if (!await ref.watch(canaryOnProvider.future)) return 0;
  return (await ref.watch(canaryProvider.future)).flags(sender: q.sender, imageHash: q.imageHash);
});

/// Opt-in "I've paid" checks (stored natively so the listener can read it).
final chatChecksProvider = FutureProvider<bool>((ref) => ref.watch(bridgeProvider).chatChecks());

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
  const EventLabel(this.text, {this.sale = false, this.expense});
  final String text;
  final bool sale;
  final ExpenseCategory? expense; // set for debits: tap to change the category
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
    required this.spentKobo,
    required this.deliveryKobo,
    required this.claims,
  });

  final int moneyInKobo, moneyOutKobo, salesCount, profitKobo;

  /// Business expenses today (debits, minus "not business").
  final int spentKobo;

  /// Delivery fees collected on today's paid orders (they pay for the Dispatch expenses).
  final int deliveryKobo;

  /// Same sum as the Books screen (computePnl): gross profit + delivery − business expenses.
  int get netKobo => profitKobo + deliveryKobo - spentKobo;

  /// "I've paid" claims still worth showing: waiting, or the money didn't come (last 24h, not dismissed).
  final List<PaymentClaim> claims;
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
  final expenses = ref.watch(expensesProvider).value ?? const [];
  final claims = ref.watch(claimListProvider).value ?? const [];
  final now = DateTime.now();
  final expenseByEvent = {for (final x in expenses) x.bankEventId: ExpenseCategory.fromName(x.category)};

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
    final cat = expenseByEvent[e.id];
    if (e.direction == 'debit' && cat != null) {
      labels[e.id] = EventLabel(
        cat == ExpenseCategory.personal ? 'Not business' : 'Expense · ${cat.label}',
        expense: cat,
      );
      continue;
    }
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
  final weekAgo = now.subtract(const Duration(days: 7));
  final pnl = computePnl(
    from: startOfDay(now),
    to: startOfDay(now).add(const Duration(days: 1)),
    orders: orders,
    items: items,
    events: events,
    expenseByEvent: expenseByEvent,
  );

  return Books(
    moneyInKobo: today.where((e) => e.direction == 'credit').fold(0, (s, e) => s + e.amountKobo),
    moneyOutKobo: today.where((e) => e.direction == 'debit').fold(0, (s, e) => s + e.amountKobo),
    salesCount: pnl.salesCount,
    profitKobo: pnl.grossProfitKobo,
    deliveryKobo: pnl.deliveryKobo,
    needsYou: [
      for (final e in events)
        if (e.direction == 'credit' && !matchByEvent.containsKey(e.id) && e.occurredAt.isAfter(weekAgo)) e,
    ],
    labels: labels,
    spentKobo: pnl.expensesKobo,
    claims: [
      for (final c in claims)
        if (!c.dismissed && c.status != 'verified' && now.difference(c.claimedAt) < const Duration(hours: 24)) c,
    ],
    lowStock: [
      for (final p in products)
        if (p.qtyOnHand <= p.lowStockThreshold) p,
    ],
  );
});

/// Everything the Books screen sums, in one place (the P&L itself is computed in lib/books/pnl.dart).
final pnlSourceProvider =
    Provider<({List<Order> orders, List<OrderItem> items, List<BankEvent> events, Map<int, ExpenseCategory> cats})>((
      ref,
    ) {
      final expenses = ref.watch(expensesProvider).value ?? const [];
      return (
        orders: ref.watch(ordersProvider).value ?? const [],
        items: ref.watch(orderItemsProvider).value ?? const [],
        events: ref.watch(eventsProvider).value ?? const [],
        cats: {for (final x in expenses) x.bankEventId: ExpenseCategory.fromName(x.category)},
      );
    });
