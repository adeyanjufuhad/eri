import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:eri/data/db.dart';
import 'package:eri/receipts/receipt.dart';
import 'package:eri/receipts/ocr_stub.dart' if (dart.library.io) 'package:eri/receipts/ocr_mlkit.dart' as ocr;

export 'package:eri/receipts/ocr_stub.dart'
    if (dart.library.io) 'package:eri/receipts/ocr_mlkit.dart'
    show ocrAvailable;

class ReceiptResult {
  const ReceiptResult(this.fields, this.verdict);
  final ReceiptFields fields;
  final ReceiptVerdict verdict;
}

/// Shared screenshot → text (on the phone) → fields → compared with real credits → stored (without the image).
class Receipts {
  Receipts(this.db);
  final EriDb db;

  Future<ReceiptResult> checkImage(String path, List<int> bytes) async =>
      checkText(await ocr.ocrImage(path), imageHash: sha256.convert(bytes).toString());

  Future<ReceiptResult> checkText(String text, {String? imageHash, DateTime? now}) async {
    final fields = parseReceipt(text);
    final credits = [
      for (final e in await (db.select(db.bankEvents)..where((t) => t.direction.equals('credit'))).get())
        ReceiptCredit(
          id: e.id,
          amountKobo: e.amountKobo,
          occurredAt: e.occurredAt,
          counterparty: e.counterparty,
          bank: e.bank,
        ),
    ];
    final v = checkReceipt(fields, credits, now: now ?? DateTime.now());
    await db
        .into(db.receiptChecks)
        .insert(
          ReceiptChecksCompanion.insert(
            amountKobo: Value(fields.amountKobo),
            sender: Value(fields.sender),
            bank: Value(fields.bank),
            receiptTime: Value(fields.time),
            verdict: switch (v.verdict) {
              Verdict.landed => 'landed',
              Verdict.notReceived => 'not_received',
              Verdict.mismatch => 'mismatch',
              Verdict.unreadable => 'unreadable',
            },
            reasons: v.reasons.join('\n'),
            bankEventId: Value(v.bankEventId),
            imageHash: Value(imageHash),
          ),
        );
    return ReceiptResult(fields, v);
  }
}
