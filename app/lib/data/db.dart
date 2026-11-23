import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'db.g.dart';

// On-device tables (docs/DATA_MODEL.md). Money is kobo (int). Raw text lives only in RawNotifications, on
// this phone, and is deleted after 7 days. Everything else mirrors the Supabase tables and will sync later.

/// Raw notification text, on the phone only. Never synced.
class RawNotifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get package => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  DateTimeColumn get postedAt => dateTime()();
  TextColumn get rawHash => text().unique()();
  BoolColumn get parsed => boolean().withDefault(const Constant(false))();
}

/// A parsed bank credit or debit. Mirrors `bank_events` in Supabase.
class BankEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get rawHash => text().unique()();
  TextColumn get bank => text()();
  TextColumn get direction => text()(); // 'credit' | 'debit'
  IntColumn get amountKobo => integer()();
  TextColumn get counterparty => text().nullable()();
  TextColumn get narration => text().nullable()();
  TextColumn get sessionId => text().nullable()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get parser => text().withDefault(const Constant('template'))(); // template | llm | manual
  RealColumn get confidence => real()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  /// Other words buyers use for it, comma-separated ("gown, ankara, the blue gown").
  TextColumn get aliases => text().withDefault(const Constant(''))();
  IntColumn get sellPriceKobo => integer()();
  /// Moving average of what each unit cost you; updated on restock.
  IntColumn get avgCostKobo => integer()();
  IntColumn get qtyOnHand => integer().withDefault(const Constant(0))();
  IntColumn get lowStockThreshold => integer().withDefault(const Constant(2))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class StockMovements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get delta => integer()(); // +5 restock, -1 sale
  TextColumn get reason => text()(); // restock | sale | adjustment | return
  IntColumn get unitCostKobo => integer().nullable()();
  IntColumn get orderId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Every sale is an order: ones the vendor sets up ahead (awaiting_payment, with a code like ERI-104 for the
/// transfer note), and ones Eri creates itself when money lands and it recognises what was bought.
class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get customerName => text().nullable()();
  TextColumn get status => text()(); // awaiting_payment | paid | cancelled
  IntColumn get expectedAmountKobo => integer().nullable()();
  IntColumn get deliveryFeeKobo => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get paidAt => dateTime().nullable()();
}

class OrderItems extends Table {
  IntColumn get orderId => integer().references(Orders, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get qty => integer()();
  IntColumn get unitPriceKobo => integer()();
  /// Snapshot of the moving-average cost when paid, so a sale's profit never changes afterwards.
  IntColumn get unitCostKobo => integer()();

  @override
  Set<Column<Object>> get primaryKey => {orderId, productId};
}

/// What a bank event turned out to be. No row = not decided yet (shown in "Needs you").
/// (Row class is SaleMatch: `Match` would clash with dart:core's regex Match.)
@DataClassName('SaleMatch')
class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bankEventId => integer().unique().references(BankEvents, #id)();
  IntColumn get orderId => integer().nullable().references(Orders, #id)();
  TextColumn get kind => text()(); // order_code | expected_payment | narration | amount_combo | manual | not_sale
  RealColumn get confidence => real()();
  BoolColumn get confirmedByUser => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// "Always ignore this sender" (e.g. your own savings account, a family member).
class IgnoreRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get senderKey => text().unique()(); // normalised counterparty name
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [RawNotifications, BankEvents, Products, StockMovements, Orders, OrderItems, Matches, IgnoreRules])
class EriDb extends _$EriDb {
  EriDb([QueryExecutor? e])
      : super(e ??
            driftDatabase(
              name: 'eri',
              // browser preview only (the real app is Android): files from drift's 2.35.4 release, in web/
              web: DriftWebOptions(sqlite3Wasm: Uri.parse('sqlite3.wasm'), driftWorker: Uri.parse('drift_worker.js')),
            ));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // Day 2: products, orders, matching
            for (final TableInfo<Table, dynamic> t in [products, stockMovements, orders, orderItems, matches, ignoreRules]) {
              await m.createTable(t);
            }
          }
        },
        beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
      );

  Stream<List<BankEvent>> watchEvents({int limit = 100}) => (select(bankEvents)
        ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)])
        ..limit(limit))
      .watch();

  Stream<List<RawNotification>> watchRaw({int limit = 100}) => (select(rawNotifications)
        ..orderBy([(t) => OrderingTerm.desc(t.postedAt)])
        ..limit(limit))
      .watch();

  Stream<List<Product>> watchProducts() => (select(products)
        ..where((t) => t.active.equals(true))
        ..orderBy([(t) => OrderingTerm.asc(t.name)]))
      .watch();

  Stream<List<Order>> watchOrders() =>
      (select(orders)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Stream<List<SaleMatch>> watchMatches() => select(matches).watch();

  Stream<List<OrderItem>> watchOrderItems() => select(orderItems).watch();

  /// Raw text is kept 7 days at most.
  Future<int> purgeOldRaw({DateTime? now}) {
    final cutoff = (now ?? DateTime.now()).subtract(const Duration(days: 7));
    return (delete(rawNotifications)..where((t) => t.postedAt.isSmallerThanValue(cutoff))).go();
  }
}
