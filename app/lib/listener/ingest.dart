import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:eri/claims/claim_service.dart';
import 'package:eri/claims/claims.dart' show chatApps;
import 'package:eri/data/db.dart';
import 'package:eri/matching/sales.dart';
import 'package:eri/parsing/bank_alert.dart' as p;

/// sha256 of the raw notification. Repeats of the same alert hash the same, so they're stored once.
String rawHash(p.RawNotification n) => sha256.convert(utf8.encode('${n.package}\n${n.title}\n${n.text}')).toString();

/// Stores each raw notification (on the phone only), parses it, and stores the bank event if it is one.
/// Each new credit then goes through the matching engine (sale logged with zero taps when it's sure).
/// Debits become expenses. Chat previews (opt-in) never enter the alert log: they go to the claims check,
/// which keeps only "I've paid" messages. Returns how many new bank events were added.
Future<int> ingest(EriDb db, Iterable<p.RawNotification> items, {Sales? sales, Claims? claims}) async {
  final added = <int>[];
  final chats = items.where((n) => chatApps.containsKey(n.package)).toList();
  final alerts = items.where((n) => !chatApps.containsKey(n.package));
  final c = claims ?? Claims(db);
  await c.ingestChat(chats);
  await db.transaction(() async {
    for (final n in alerts) {
      final hash = rawHash(n);
      final alert = p.parseAlert(n);
      // insertReturningOrNull gives null when the hash is already stored (insert() would return the last rowid)
      final inserted = await db
          .into(db.rawNotifications)
          .insertReturningOrNull(
            RawNotificationsCompanion.insert(
              package: n.package,
              title: n.title,
              body: n.text,
              postedAt: n.postedAt,
              rawHash: hash,
              parsed: Value(alert != null),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      if (inserted == null || alert == null) continue; // a repeat, or not a payment
      final ev = await db
          .into(db.bankEvents)
          .insertReturningOrNull(
            BankEventsCompanion.insert(
              rawHash: hash,
              bank: alert.bank,
              direction: alert.direction.name,
              amountKobo: alert.amountKobo,
              counterparty: Value(alert.counterparty),
              narration: Value(alert.narration),
              sessionId: Value(alert.sessionId),
              occurredAt: alert.occurredAt,
              confidence: alert.confidence,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      if (ev != null) added.add(ev.id);
    }
  });
  final s = sales ?? Sales(db);
  for (final id in added) {
    await s.autoMatch(id);
    await s.autoExpense(id);
  }
  // judge claims at the time of the newest alert in this batch, not the wall clock: a replayed backlog must not
  // mark a claim "not received" before the money alerts behind it are read. The periodic check uses real time.
  if (added.isNotEmpty || chats.isNotEmpty) {
    await c.resolve(now: items.map((n) => n.postedAt).reduce((a, b) => a.isAfter(b) ? a : b));
  }
  return added.length;
}
