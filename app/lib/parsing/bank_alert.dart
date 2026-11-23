import 'package:eri/core/money.dart';

/// A notification as the listener hands it over. Stays on the phone.
class RawNotification {
  const RawNotification({required this.package, required this.title, required this.text, required this.postedAt});

  final String package;
  final String title;
  final String text;
  final DateTime postedAt;
}

enum Direction { credit, debit }

/// The structured fields Eri keeps from an alert. These (plus a hash of the raw text) are all that may sync.
class BankAlert {
  const BankAlert({
    required this.bank,
    required this.direction,
    required this.amountKobo,
    required this.occurredAt,
    required this.confidence,
    this.counterparty,
    this.narration,
    this.sessionId,
  });

  final String bank;
  final Direction direction;
  final int amountKobo;
  final String? counterparty;
  final String? narration;
  final String? sessionId;
  final DateTime occurredAt;

  /// 0–1: how much of the alert we understood (amount + direction is the floor; a known bank, the sender
  /// and the narration add to it). The matching engine treats low-confidence events with more care.
  final double confidence;

  @override
  String toString() =>
      'BankAlert($bank ${direction.name} ${naira(amountKobo)} from=$counterparty note=$narration session=$sessionId)';
}

class BankProfile {
  const BankProfile(this.name, {this.packages = const {}, this.hints = const []});

  final String name;
  final Set<String> packages;

  /// Words that name the bank in an SMS title or text ("GTBank", "GTB", …), lowercase.
  final List<String> hints;
}

// Package names are best guesses until checked on a real phone (docs/SPIKE.md); keep them in sync with
// BANK_APPS in android/.../EriNotificationListener.kt.
const banks = <BankProfile>[
  BankProfile('GTBank', packages: {'com.gtbank.gtworldv1'}, hints: ['gtbank', 'gtb', 'guaranty trust', 'gtworld']),
  BankProfile('OPay', packages: {'team.opay.pay'}, hints: ['opay']),
  BankProfile(
    'Moniepoint',
    packages: {'com.moniepoint.personal', 'com.teamapt.monnify.pos.moniepointapp'},
    hints: ['moniepoint'],
  ),
  BankProfile('Kuda', packages: {'com.kudabank.app'}, hints: ['kuda']),
  BankProfile('PalmPay', packages: {'com.palmpay.android'}, hints: ['palmpay']),
  BankProfile('Zenith', packages: {'com.zenithBank.eazymoney'}, hints: ['zenith']),
  BankProfile('UBA', packages: {'com.ubanquity.ubamobilebanking'}, hints: ['uba']),
  BankProfile('Access', packages: {'com.accessbank.accessmobile'}, hints: ['access bank', 'accessbank']),
];

// ── patterns ────────────────────────────────────────────────────────────────
const _num = r'(\d{1,3}(?:,\d{3})+(?:\.\d{1,2})?|\d+(?:\.\d{1,2})?)';
final _amount = RegExp('(?:₦|NGN|\\bN)\\s?$_num', caseSensitive: false);
final _labelledAmount = RegExp('\\b(?:amt|amount)\\s*:?\\s*(?:₦|NGN|N)?\\s?$_num', caseSensitive: false);
final _balanceBefore = RegExp(r'(bal(ance)?|avail(able)?)\W{0,3}\w{0,6}\W{0,3}$', caseSensitive: false);

final _creditCue = RegExp(
  r'\b(cr|credit(ed)?|received|receive|got|inflow|deposit(ed)?|incoming|money in)\b',
  caseSensitive: false,
);
final _debitCue = RegExp(
  r'\b(dr|debit(ed)?|sent|withdrawal|withdrawn|purchase|paid to|transfer to|outflow|charged|money out)\b',
  caseSensitive: false,
);

// OTPs, tokens and promos mention naira too; they're never a payment.
final _reject = RegExp(
  r'\b(otp|token|one[- ]time|verification code|win|promo|bonus|giveaway|loan offer)\b',
  caseSensitive: false,
);

// a name runs until punctuation, a line break, " - ", or the next labelled field
const _nameEnd =
    r'(?=\s*(?:[.,|;\n]|\s-\s|\bdesc|\bnarration|\bremark|\bnote\b|\bref|\bsession|\bon\s+\d|\bat\s+\d|\bvia\b|[“"‘]|$))';
final _from = RegExp('\\b(?:from|sender)\\s*:?\\s+([A-Za-z][A-Za-z .\'&-]{1,40}?)$_nameEnd', caseSensitive: false);
final _to = RegExp('\\b(?:to|beneficiary)\\s*:?\\s+([A-Za-z][A-Za-z .\'&-]{1,40}?)$_nameEnd', caseSensitive: false);

final _labelledNote = RegExp(
  r'\b(?:desc(?:ription)?|narration|remarks?|note|memo)\s*[:\-]\s*(.+?)(?=\s*(?:\n|\bavail|\bbal|\bdate|\bref|\btime|\bsession|$))',
  caseSensitive: false,
);
final _quotedNote = RegExp(r'[“"‘]([^”"’\n]{2,60})[”"’]');
final _session = RegExp(r'\bsession\s*(?:id)?\s*[:#]?\s*(\d{20,30})\b|\b(\d{30})\b', caseSensitive: false);

/// Reads one notification. Returns null when it isn't a bank credit or debit (OTP, promo, chatter, balance only).
/// Deterministic on purpose: no network, no LLM. Fuzzy cases go to the LLM fallback later, never here.
BankAlert? parseAlert(RawNotification n) {
  final text = '${n.title}\n${n.text}'.trim();
  if (_reject.hasMatch(text)) return null;

  final amountKobo = _firstAmount(text);
  if (amountKobo == null || amountKobo <= 0) return null;

  final direction = _direction(text);
  if (direction == null) return null;

  final bank = _bank(n);
  final counterparty = _clean((direction == Direction.credit ? _from : _to).firstMatch(text)?.group(1));
  final narration = _clean(_labelledNote.firstMatch(text)?.group(1) ?? _quotedNote.firstMatch(text)?.group(1));
  final sm = _session.firstMatch(text);
  final sessionId = sm?.group(1) ?? sm?.group(2);

  // counted in tenths so the score stays exact (0.5 + 0.2 + 0.2 + 0.1 drifts in floating point)
  var tenths = 5;
  if (bank != null) tenths += 2;
  if (counterparty != null) tenths += 2;
  if (narration != null) tenths += 1;

  return BankAlert(
    bank: bank ?? 'Unknown bank',
    direction: direction,
    amountKobo: amountKobo,
    counterparty: counterparty,
    narration: narration,
    sessionId: sessionId,
    occurredAt: n.postedAt,
    confidence: tenths.clamp(0, 10) / 10,
  );
}

int? _firstAmount(String text) {
  for (final re in [_labelledAmount, _amount]) {
    for (final m in re.allMatches(text)) {
      final before = text.substring((m.start - 24).clamp(0, m.start), m.start);
      if (_balanceBefore.hasMatch(before)) continue; // "Avail Bal: NGN412,300.00" is not the payment
      final kobo = parseKobo(m.group(1)!);
      if (kobo != null) return kobo;
    }
  }
  return null;
}

/// The first cue wins: "Credit Alert … from X" is a credit even if "debit" appears later in boilerplate.
Direction? _direction(String text) {
  final c = _creditCue.firstMatch(text)?.start;
  final d = _debitCue.firstMatch(text)?.start;
  if (c == null && d == null) return null;
  if (d == null) return Direction.credit;
  if (c == null) return Direction.debit;
  return c <= d ? Direction.credit : Direction.debit;
}

String? _bank(RawNotification n) {
  for (final b in banks) {
    if (b.packages.contains(n.package)) return b.name;
  }
  final hay = '${n.title} ${n.text}'.toLowerCase();
  for (final b in banks) {
    if (b.hints.any((h) => RegExp('\\b${RegExp.escape(h)}\\b').hasMatch(hay))) return b.name;
  }
  return null;
}

String? _clean(String? s) {
  if (s == null) return null;
  final t = s.replaceAll(RegExp(r'\s+'), ' ').replaceAll(RegExp(r'^[\s\-:]+|[\s.\-:,]+$'), '');
  return t.length < 2 ? null : t;
}
