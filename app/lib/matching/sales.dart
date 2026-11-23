import 'package:drift/drift.dart';
import 'package:eri/data/db.dart';
import 'package:eri/matching/costing.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/matching/text_match.dart';

/// Everything that changes the books: turning a credit into a sale (order + items + stock + match),
/// "not a sale", ignore rules, products and restocks, and orders set up ahead of payment.
/// Each write is one transaction, so stock and matches never disagree.
class Sales {
  Sales(this.db, {this.deliveryFeeKobo = 0});

  final EriDb db;

  /// The vendor's usual delivery fee, used when an amount = items + delivery. 0 until there's a setting.
  final int deliveryFeeKobo;

  // ── matching ─────────────────────────────────────────────────────────────

  /// What the engine thinks [e] was for. Used by [autoMatch] and by the "Needs you" card.
  Future<MatchOutcome> outcomeFor(BankEvent e) async {
    final products = await (db.select(db.products)..where((t) => t.active.equals(true))).get();
    final open = await (db.select(db.orders)..where((t) => t.status.equals('awaiting_payment'))).get();
    final items = await db.select(db.orderItems).get();
    final ignored = (await db.select(db.ignoreRules).get()).map((r) => r.senderKey).toSet();
    return matchCredit(
      MEvent(amountKobo: e.amountKobo, counterparty: e.counterparty, narration: e.narration),
      products: [
        for (final p in products)
          MProduct(
            id: p.id,
            name: p.name,
            aliases: p.aliases.split(',').map((a) => a.trim()).where((a) => a.isNotEmpty).toList(),
            priceKobo: p.sellPriceKobo,
            qty: p.qtyOnHand,
          ),
      ],
      openOrders: [
        for (final o in open)
          MOrder(
            id: o.id,
            code: o.code,
            expectedKobo: o.expectedAmountKobo ?? 0,
            customer: o.customerName,
            lines: [for (final i in items.where((i) => i.orderId == o.id)) SaleLine(i.productId, i.qty)],
          ),
      ],
      ignoredSenders: ignored,
      deliveryFeeKobo: deliveryFeeKobo,
    );
  }

  /// Runs on every new credit. Applies the sale when the engine is sure, files ignored senders as
  /// "not a sale", and otherwise leaves the event for the vendor (no match row = "Needs you").
  Future<void> autoMatch(int bankEventId) async {
    final e = await (db.select(db.bankEvents)..where((t) => t.id.equals(bankEventId))).getSingleOrNull();
    if (e == null || e.direction != 'credit' || await _decided(e.id)) return;
    final out = await outcomeFor(e);
    if (out.ignored) return notSale(e, byUser: false);
    final p = out.auto;
    if (p != null) await apply(e, p);
  }

  Future<bool> _decided(int eventId) async =>
      await (db.select(db.matches)..where((t) => t.bankEventId.equals(eventId))).getSingleOrNull() != null;

  /// Books [e] as the sale [p] describes: pays an existing order, or creates one; takes the units out of
  /// stock; snapshots unit costs so the profit is fixed from now on. [byUser]: the vendor tapped it;
  /// [manual]: the vendor picked the products themselves.
  Future<void> apply(BankEvent e, Proposal p, {bool byUser = false, bool manual = false}) => db.transaction(() async {
        if (await _decided(e.id)) return;
        final int orderId;
        if (p.orderId != null) {
          orderId = p.orderId!;
          await (db.update(db.orders)..where((t) => t.id.equals(orderId)))
              .write(OrdersCompanion(status: const Value('paid'), paidAt: Value(e.occurredAt)));
          final items = await (db.select(db.orderItems)..where((t) => t.orderId.equals(orderId))).get();
          for (final i in items) {
            final prod = await _product(i.productId);
            await (db.update(db.orderItems)
                  ..where((t) => t.orderId.equals(orderId) & t.productId.equals(i.productId)))
                .write(OrderItemsCompanion(unitCostKobo: Value(prod.avgCostKobo)));
            await _takeStock(prod, i.qty, orderId);
          }
        } else {
          orderId = await db.into(db.orders).insert(OrdersCompanion.insert(
                code: await nextOrderCode(),
                customerName: Value(e.counterparty),
                status: 'paid',
                expectedAmountKobo: Value(e.amountKobo),
                deliveryFeeKobo: Value(p.deliveryFeeKobo),
                paidAt: Value(e.occurredAt),
              ));
          for (final l in p.lines) {
            final prod = await _product(l.productId);
            await db.into(db.orderItems).insert(OrderItemsCompanion.insert(
                  orderId: orderId,
                  productId: l.productId,
                  qty: l.qty,
                  unitPriceKobo: prod.sellPriceKobo,
                  unitCostKobo: prod.avgCostKobo,
                ));
            await _takeStock(prod, l.qty, orderId);
          }
        }
        await db.into(db.matches).insert(MatchesCompanion.insert(
              bankEventId: e.id,
              orderId: Value(orderId),
              kind: manual ? 'manual' : _kindName(p.kind),
              confidence: byUser ? 1.0 : p.confidence,
              confirmedByUser: Value(byUser),
            ));
      });

  /// The vendor picked the products themselves.
  Future<void> confirmManual(BankEvent e, List<SaleLine> lines) =>
      apply(e, Proposal(kind: MatchKind.narration, confidence: 1, lines: lines), byUser: true, manual: true);

  Future<void> notSale(BankEvent e, {bool byUser = true}) async {
    if (await _decided(e.id)) return;
    await db.into(db.matches).insert(MatchesCompanion.insert(
          bankEventId: e.id,
          kind: 'not_sale',
          confidence: 1,
          confirmedByUser: Value(byUser),
        ));
  }

  /// "Always ignore this sender": this event and every future one from the same name.
  Future<void> ignoreSender(BankEvent e) => db.transaction(() async {
        final who = e.counterparty;
        if (who != null && normalize(who).isNotEmpty) {
          await db.into(db.ignoreRules).insert(IgnoreRulesCompanion.insert(senderKey: normalize(who)),
              mode: InsertMode.insertOrIgnore);
        }
        await notSale(e);
      });

  /// Puts a decided credit back in "Needs you": the vendor tapped the wrong thing.
  /// A sale Eri created is removed (stock goes back); an order set up ahead goes back to waiting.
  Future<void> undo(int bankEventId) => db.transaction(() async {
        final m = await (db.select(db.matches)..where((t) => t.bankEventId.equals(bankEventId))).getSingleOrNull();
        if (m == null) return;
        await (db.delete(db.matches)..where((t) => t.id.equals(m.id))).go();
        final orderId = m.orderId;
        if (orderId == null) return; // was "not a sale"

        final items = await (db.select(db.orderItems)..where((t) => t.orderId.equals(orderId))).get();
        for (final i in items) {
          final p = await _product(i.productId);
          await (db.update(db.products)..where((t) => t.id.equals(p.id)))
              .write(ProductsCompanion(qtyOnHand: Value(p.qtyOnHand + i.qty)));
        }
        await (db.delete(db.stockMovements)..where((t) => t.orderId.equals(orderId) & t.reason.equals('sale'))).go();

        if (m.kind == 'order_code' || m.kind == 'expected_payment') {
          await (db.update(db.orders)..where((t) => t.id.equals(orderId)))
              .write(const OrdersCompanion(status: Value('awaiting_payment'), paidAt: Value(null)));
        } else {
          await (db.delete(db.orderItems)..where((t) => t.orderId.equals(orderId))).go();
          await (db.delete(db.orders)..where((t) => t.id.equals(orderId))).go();
        }
      });

  // ── products and stock ───────────────────────────────────────────────────

  Future<int> addProduct({
    required String name,
    String aliases = '',
    required int sellPriceKobo,
    required int costKobo,
    required int qty,
  }) =>
      db.transaction(() async {
        final id = await db.into(db.products).insert(ProductsCompanion.insert(
              name: name.trim(),
              aliases: Value(aliases.trim()),
              sellPriceKobo: sellPriceKobo,
              avgCostKobo: costKobo,
              qtyOnHand: Value(qty),
            ));
        if (qty > 0) {
          await db.into(db.stockMovements).insert(StockMovementsCompanion.insert(
              productId: id, delta: qty, reason: 'restock', unitCostKobo: Value(costKobo)));
        }
        return id;
      });

  Future<void> updateProduct(int id, {required String name, required String aliases, required int sellPriceKobo}) =>
      (db.update(db.products)..where((t) => t.id.equals(id))).write(ProductsCompanion(
        name: Value(name.trim()),
        aliases: Value(aliases.trim()),
        sellPriceKobo: Value(sellPriceKobo),
      ));

  Future<void> restock(int productId, {required int qty, required int unitCostKobo}) => db.transaction(() async {
        final p = await _product(productId);
        await (db.update(db.products)..where((t) => t.id.equals(productId))).write(ProductsCompanion(
          qtyOnHand: Value(p.qtyOnHand + qty),
          avgCostKobo: Value(movingAverageCost(
              oldQty: p.qtyOnHand, oldAvgKobo: p.avgCostKobo, addQty: qty, unitCostKobo: unitCostKobo)),
        ));
        await db.into(db.stockMovements).insert(StockMovementsCompanion.insert(
            productId: productId, delta: qty, reason: 'restock', unitCostKobo: Value(unitCostKobo)));
      });

  // ── orders set up before payment ─────────────────────────────────────────

  /// An order waiting for money. The buyer puts its code (ERI-104) in the transfer note, or just pays the
  /// exact amount; either way Eri matches it.
  Future<Order> createOrder({String? customer, required List<SaleLine> lines, int deliveryFeeKobo = 0}) =>
      db.transaction(() async {
        var total = deliveryFeeKobo;
        final prices = <int, int>{};
        for (final l in lines) {
          final p = await _product(l.productId);
          prices[l.productId] = p.sellPriceKobo;
          total += p.sellPriceKobo * l.qty;
        }
        final id = await db.into(db.orders).insert(OrdersCompanion.insert(
              code: await nextOrderCode(),
              customerName: Value(customer?.trim().isEmpty ?? true ? null : customer!.trim()),
              status: 'awaiting_payment',
              expectedAmountKobo: Value(total),
              deliveryFeeKobo: Value(deliveryFeeKobo),
            ));
        for (final l in lines) {
          final p = await _product(l.productId);
          await db.into(db.orderItems).insert(OrderItemsCompanion.insert(
                orderId: id,
                productId: l.productId,
                qty: l.qty,
                unitPriceKobo: prices[l.productId]!,
                unitCostKobo: p.avgCostKobo, // re-snapshotted when it's paid
              ));
        }
        return (db.select(db.orders)..where((t) => t.id.equals(id))).getSingle();
      });

  Future<void> cancelOrder(int id) => (db.update(db.orders)..where((t) => t.id.equals(id) & t.status.equals('awaiting_payment')))
      .write(const OrdersCompanion(status: Value('cancelled')));

  /// ERI-101, ERI-102, … (short enough to type into a transfer note).
  Future<String> nextOrderCode() async {
    var max = 100;
    for (final o in await db.select(db.orders).get()) {
      final n = int.tryParse(RegExp(r'^ERI-(\d+)$').firstMatch(o.code)?.group(1) ?? '');
      if (n != null && n > max) max = n;
    }
    return 'ERI-${max + 1}';
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  Future<Product> _product(int id) => (db.select(db.products)..where((t) => t.id.equals(id))).getSingle();

  Future<void> _takeStock(Product p, int qty, int orderId) async {
    await (db.update(db.products)..where((t) => t.id.equals(p.id)))
        .write(ProductsCompanion(qtyOnHand: Value(p.qtyOnHand - qty)));
    await db.into(db.stockMovements).insert(
        StockMovementsCompanion.insert(productId: p.id, delta: -qty, reason: 'sale', orderId: Value(orderId)));
  }

  static String _kindName(MatchKind k) => switch (k) {
        MatchKind.orderCode => 'order_code',
        MatchKind.expectedPayment => 'expected_payment',
        MatchKind.narration => 'narration',
        MatchKind.amountCombo => 'amount_combo',
      };
}
