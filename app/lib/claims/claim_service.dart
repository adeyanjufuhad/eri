import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:eri/claims/claims.dart';
import 'package:eri/data/db.dart';
import 'package:eri/parsing/bank_alert.dart' as p;

/// Stores "I've paid" claims from chat previews and settles them against real credits.
/// Previews that aren't claims are dropped here and never stored.
class Claims {
  Claims(this.db);
  final EriDb db;

  /// Returns how many new claims were recorded.
  Future<int> ingestChat(Iterable<p.RawNotification> previews) async {
    var added = 0;
    for (final n in previews) {
      final app = chatApps[n.package];
      if (app == null) continue;
      final c = detectClaim(title: n.title, text: n.text);
      if (c == null) continue; // not a claim: never stored
      final row = await db
          .into(db.paymentClaims)
          .insertReturningOrNull(
            PaymentClaimsCompanion.insert(
              app: app,
              sender: c.sender,
              amountKobo: Value(c.amountKobo),
              preview: Value(n.text),
              previewHash: sha256.convert(utf8.encode('${n.package}\n${n.title}\n${n.text}')).toString(),
              claimedAt: n.postedAt,
              expiresAt: n.postedAt.add(claimWindow),
              status: 'pending',
            ),
            mode: InsertMode.insertOrIgnore,
          );
      if (row != null) added++;
    }
    return added;
  }

  /// Settles every pending claim it can: after a new credit, on a timer, and when the app comes back.
  Future<void> resolve({DateTime? now}) async {
    final at = now ?? DateTime.now();
    final pending = await (db.select(db.paymentClaims)..where((t) => t.status.equals('pending'))).get();
    if (pending.isEmpty) return;
    final credits = [
      for (final e in await (db.select(db.bankEvents)..where((t) => t.direction.equals('credit'))).get())
        ClaimCredit(id: e.id, amountKobo: e.amountKobo, occurredAt: e.occurredAt, counterparty: e.counterparty),
    ];
    final taken = {
      for (final c in await (db.select(db.paymentClaims)..where((t) => t.bankEventId.isNotNull())).get())
        c.bankEventId!,
    };
    for (final c in pending) {
      final r = resolveClaim(
        sender: c.sender,
        amountKobo: c.amountKobo,
        claimedAt: c.claimedAt,
        credits: credits,
        now: at,
        taken: taken,
        window: c.expiresAt.difference(c.claimedAt),
      );
      if (r.status == ClaimStatus.pending) continue;
      if (r.bankEventId != null) taken.add(r.bankEventId!);
      await (db.update(db.paymentClaims)..where((t) => t.id.equals(c.id))).write(
        PaymentClaimsCompanion(
          status: Value(switch (r.status) {
            ClaimStatus.verified => 'verified',
            ClaimStatus.mismatch => 'mismatch',
            _ => 'not_received',
          }),
          bankEventId: Value(r.bankEventId),
        ),
      );
    }
  }

  /// The vendor checked their bank app and the money is there (e.g. paid from someone else's account).
  Future<void> markPaid(int claimId) => (db.update(db.paymentClaims)..where((t) => t.id.equals(claimId))).write(
    const PaymentClaimsCompanion(status: Value('verified'), dismissed: Value(true)),
  );

  Future<void> dismiss(int claimId) => (db.update(
    db.paymentClaims,
  )..where((t) => t.id.equals(claimId))).write(const PaymentClaimsCompanion(dismissed: Value(true)));
}
