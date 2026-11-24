import 'package:eri/core/money.dart';
import 'package:eri/matching/text_match.dart';
import 'package:eri/parsing/bank_alert.dart' show banks;

// Receipt check (PLAN.md Day 3). A vendor shares a "transfer successful" screenshot into Eri. ML Kit reads
// the text ON THE PHONE (the image never leaves it); this file turns that text into fields and compares
// them with the money that actually landed. Deterministic: no LLM, no network.

class ReceiptFields {
  const ReceiptFields({this.amountKobo, this.sender, this.recipient, this.bank, this.time, this.sessionId});
  final int? amountKobo;
  final String? sender;
  final String? recipient;
  final String? bank;
  final DateTime? time;
  final String? sessionId;

  @override
  String toString() =>
      'Receipt(${amountKobo == null ? '?' : naira(amountKobo!)} from=$sender to=$recipient bank=$bank time=$time session=$sessionId)';
}

const _num = r'(\d{1,3}(?:,\d{3})+(?:\.\d{1,2})?|\d+(?:\.\d{1,2})?)';
final _money = RegExp('(?:₦|NGN|\\bN)\\s?$_num', caseSensitive: false);
final _amountLabel = RegExp(
  r'^\s*(?:amount|amount paid|transfer amount|total|you sent|sent)\s*:?\s*(.*)$',
  caseSensitive: false,
);
final _senderLabel = RegExp(
  r'^\s*(?:sender|sender name|from|paid by|debit account name|source account name|originator)\s*:?\s*(.*)$',
  caseSensitive: false,
);
final _recipientLabel = RegExp(
  r'^\s*(?:recipient|receiver|beneficiary|beneficiary name|to|credit account name|account name|destination account name)\s*:?\s*(.*)$',
  caseSensitive: false,
);
final _sessionLabel = RegExp(
  r'\b(?:session\s*id|session|transaction\s*ref(?:erence)?|reference|ref(?:erence)? no)\s*:?\s*([A-Za-z0-9]{10,40})',
  caseSensitive: false,
);
final _bareSession = RegExp(r'\b(\d{20,30})\b');

const _months = {
  'jan': 1,
  'feb': 2,
  'mar': 3,
  'apr': 4,
  'may': 5,
  'jun': 6,
  'jul': 7,
  'aug': 8,
  'sep': 9,
  'oct': 10,
  'nov': 11,
  'dec': 12,
};
// 21 Nov 2026 · 2:14 PM | 21-Nov-2026 14:14 | Nov 21, 2026 2:14 PM | 2026-11-21 14:14:08 | 21/11/2026 14:14
final _dateDmy = RegExp(
  r'\b(\d{1,2})[\s\-/]([A-Za-z]{3})[A-Za-z]*[\s\-/,]+(\d{2,4})\D{0,6}?(\d{1,2}):(\d{2})(?::\d{2})?\s*(am|pm)?',
  caseSensitive: false,
);
final _dateMdy = RegExp(
  r'\b([A-Za-z]{3})[A-Za-z]*\s+(\d{1,2}),?\s+(\d{4})\D{0,6}?(\d{1,2}):(\d{2})(?::\d{2})?\s*(am|pm)?',
  caseSensitive: false,
);
final _dateIso = RegExp(r'\b(\d{4})-(\d{2})-(\d{2})[ T](\d{1,2}):(\d{2})');
final _dateNum = RegExp(r'\b(\d{1,2})/(\d{1,2})/(\d{4})\D{0,6}?(\d{1,2}):(\d{2})\s*(am|pm)?', caseSensitive: false);

/// OCR text (lines in reading order) → fields. Labels may share a line with the value ("Sender: ADA")
/// or sit on the line above it, which is how most bank apps lay out receipts.
ReceiptFields parseReceipt(String ocr) {
  final lines = ocr.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();

  String? labelled(RegExp re) {
    for (var i = 0; i < lines.length; i++) {
      final m = re.firstMatch(lines[i]);
      if (m == null) continue;
      final same = (m.group(1) ?? '').trim();
      if (same.isNotEmpty) return same;
      if (i + 1 < lines.length) return lines[i + 1];
    }
    return null;
  }

  // amount: the labelled one, else the largest naira figure that isn't a balance or a fee
  int? amount;
  final a = labelled(_amountLabel);
  if (a != null) {
    final m = _money.firstMatch(a) ?? RegExp('^$_num\$').firstMatch(a.replaceAll(' ', ''));
    if (m != null) amount = parseKobo(m.group(1)!);
  }
  if (amount == null) {
    for (final l in lines) {
      if (RegExp(r'\b(bal|balance|fee|charge|vat|stamp duty)\b', caseSensitive: false).hasMatch(l)) continue;
      for (final m in _money.allMatches(l)) {
        final k = parseKobo(m.group(1)!);
        if (k != null && (amount == null || k > amount)) amount = k;
      }
    }
  }

  String? name(String? s) {
    if (s == null) return null;
    final t = s
        .replaceAll(RegExp(r'\s*[|/].*$'), '')
        .replaceAll(RegExp(r'\b\d{6,}\b'), '')
        .replaceAll(RegExp(r'[^A-Za-z .\x27&-]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return t.length < 3 ? null : t;
  }

  final hay = ocr.toLowerCase();
  String? bank;
  for (final b in banks) {
    if (b.hints.any((h) => RegExp('\\b${RegExp.escape(h)}\\b').hasMatch(hay))) {
      bank = b.name;
      break;
    }
  }

  final sm = _sessionLabel.firstMatch(ocr) ?? _bareSession.firstMatch(ocr);

  return ReceiptFields(
    amountKobo: amount,
    sender: name(labelled(_senderLabel)),
    recipient: name(labelled(_recipientLabel)),
    bank: bank,
    time: _time(ocr),
    sessionId: sm?.group(1),
  );
}

DateTime? _time(String s) {
  int h(String hh, String? ampm) {
    var x = int.parse(hh);
    if (ampm != null) {
      final pm = ampm.toLowerCase() == 'pm';
      if (pm && x < 12) x += 12;
      if (!pm && x == 12) x = 0;
    }
    return x;
  }

  int y(String yy) => yy.length == 2 ? 2000 + int.parse(yy) : int.parse(yy);

  var m = _dateDmy.firstMatch(s);
  if (m != null && _months[m.group(2)!.toLowerCase()] != null) {
    return DateTime(
      y(m.group(3)!),
      _months[m.group(2)!.toLowerCase()]!,
      int.parse(m.group(1)!),
      h(m.group(4)!, m.group(6)),
      int.parse(m.group(5)!),
    );
  }
  m = _dateMdy.firstMatch(s);
  if (m != null && _months[m.group(1)!.toLowerCase()] != null) {
    return DateTime(
      int.parse(m.group(3)!),
      _months[m.group(1)!.toLowerCase()]!,
      int.parse(m.group(2)!),
      h(m.group(4)!, m.group(6)),
      int.parse(m.group(5)!),
    );
  }
  m = _dateIso.firstMatch(s);
  if (m != null) {
    return DateTime(
      int.parse(m.group(1)!),
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
      int.parse(m.group(4)!),
      int.parse(m.group(5)!),
    );
  }
  m = _dateNum.firstMatch(s); // Nigerian order: day/month/year
  if (m != null) {
    return DateTime(
      int.parse(m.group(3)!),
      int.parse(m.group(2)!),
      int.parse(m.group(1)!),
      h(m.group(4)!, m.group(6)),
      int.parse(m.group(5)!),
    );
  }
  return null;
}

// ── verdict ────────────────────────────────────────────────────────────────

enum Verdict { landed, notReceived, mismatch, unreadable }

class ReceiptCredit {
  const ReceiptCredit({
    required this.id,
    required this.amountKobo,
    required this.occurredAt,
    this.counterparty,
    this.bank,
  });
  final int id;
  final int amountKobo;
  final DateTime occurredAt;
  final String? counterparty;
  final String? bank;
}

class ReceiptVerdict {
  const ReceiptVerdict(this.verdict, this.reasons, {this.bankEventId});
  final Verdict verdict;
  final List<String> reasons; // plain sentences for the vendor, most important first
  final int? bankEventId;
}

String _clock(DateTime t) {
  final hh = t.hour % 12 == 0 ? 12 : t.hour % 12;
  return '$hh:${t.minute.toString().padLeft(2, '0')} ${t.hour < 12 ? 'AM' : 'PM'}';
}

/// Compares a receipt with the credits that really landed. The screenshot is never the proof: the bank alert is.
/// Window: 2 hours either side of the receipt's time (or the last 48 hours if it shows no time).
ReceiptVerdict checkReceipt(ReceiptFields r, List<ReceiptCredit> credits, {required DateTime now}) {
  final amount = r.amountKobo;
  if (amount == null) {
    return const ReceiptVerdict(Verdict.unreadable, [
      'Eri couldn’t find an amount on this screenshot. Try a clearer one, or check your bank app.',
    ]);
  }
  final center = r.time ?? now;
  final span = r.time == null ? const Duration(hours: 48) : const Duration(hours: 2);
  final near = credits.where((c) => c.occurredAt.difference(center).abs() <= span).toList();
  bool sameName(String? a, String? b) => a != null && b != null && nameSimilarity(a, b) >= 0.6;

  // 1. the exact money from the right person (or an alert with no name on it)
  for (final c in near.where((c) => c.amountKobo == amount)) {
    if (r.sender == null || c.counterparty == null || sameName(r.sender, c.counterparty)) {
      return ReceiptVerdict(Verdict.landed, [
        'Matches a real ${c.bank ?? 'bank'} credit: ${naira(amount)}${c.counterparty == null ? '' : ' from ${c.counterparty}'} at ${_clock(c.occurredAt)}.',
      ], bankEventId: c.id);
    }
  }

  // 2. money from the same person, but a different amount: the classic edited screenshot
  final fromSender = near.where((c) => sameName(r.sender, c.counterparty)).toList()
    ..sort((a, b) => (a.amountKobo - amount).abs().compareTo((b.amountKobo - amount).abs()));
  if (fromSender.isNotEmpty) {
    final c = fromSender.first;
    return ReceiptVerdict(Verdict.mismatch, [
      'No credit of ${naira(amount)} landed${r.time == null ? ' recently' : ' near ${_clock(r.time!)}'}.',
      'Closest real credit: ${naira(c.amountKobo)} from ${c.counterparty} at ${_clock(c.occurredAt)}.',
      'The amount looks edited: ${naira(c.amountKobo)} → ${naira(amount)}.',
    ], bankEventId: c.id);
  }

  // 3. nothing
  final reasons = [
    'No credit of ${naira(amount)} landed in any of your banks ${r.time == null ? 'in the last 48 hours' : 'within 2 hours of ${_clock(r.time!)}'}.',
  ];
  if (r.time != null && r.time!.isAfter(now.add(const Duration(minutes: 5)))) {
    reasons.add('The receipt’s time is in the future (${_clock(r.time!)}).');
  }
  final sameAmountOther = near.where((c) => c.amountKobo == amount).firstOrNull;
  if (sameAmountOther != null) {
    reasons.add(
      '${naira(amount)} did land at ${_clock(sameAmountOther.occurredAt)}, but from ${sameAmountOther.counterparty}, not ${r.sender}.',
    );
  }
  return ReceiptVerdict(Verdict.notReceived, reasons);
}
