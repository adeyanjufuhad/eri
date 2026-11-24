import 'package:eri/core/money.dart';
import 'package:eri/matching/text_match.dart';

// "I don pay, check am" (PLAN.md Day 3). Opt-in: Eri reads WhatsApp / Instagram notification PREVIEWS on the
// phone, keeps only the ones that claim a payment, and waits for the money. Pure Dart, no network.

/// Chat apps whose previews are read only when the vendor turns on chat checks. Keep in sync with
/// CHAT_APPS in android/.../EriNotificationListener.kt.
const chatApps = {
  'com.whatsapp': 'WhatsApp',
  'com.whatsapp.w4b': 'WhatsApp Business',
  'com.instagram.android': 'Instagram',
};

/// How long Eri waits for the money after "I've paid" (payment_claims.expires_at default).
const claimWindow = Duration(minutes: 10);

class DetectedClaim {
  const DetectedClaim({required this.sender, this.amountKobo});
  final String sender;
  final int? amountKobo;
}

// "I've paid", "I have sent it", "I don pay", "I don send am", "check your account", "transfer done", "payment made"
final _claim = RegExp(
  r"\b(i\s*(?:'ve|have|has|just|don|do)?\s*(?:just\s+)?(?:paid|pay|sent|send|transferred|transfer|made (?:the )?(?:payment|transfer))\b"
  r"|check (?:your|ur|ya|my) (?:account|acct|acc|alert|bank|phone)"
  r"|(?:payment|transfer|money) (?:has been |don |is )?(?:made|sent|done|successful|gone)"
  r"|(?:transfer|payment) don (?:go|enter|land)"
  r"|sent (?:it|am|the money)\b"
  r"|done (?:the )?(?:transfer|payment)"
  r"|alert (?:don|has) (?:come|enter|land))",
  caseSensitive: false,
);

// promises and questions are not claims: "I will pay", "I go send am", "have you received?", "I haven't paid"
final _notYet = RegExp(
  r"\b(will|would|i go (?:pay|send|transfer)|gonna|going to|about to|wan|want to|plan to|before i|when i|once i|after i|haven'?t|have not|didn'?t|not yet|yet to|can'?t|cannot|abeg wait|tomorrow|tmrw|later|soon|tonight|next week|by evening)\b"
  r"|\?\s*$",
  caseSensitive: false,
);

final _amount = RegExp(
  r'(?:₦|ngn|\bn)\s?(\d{1,3}(?:,\d{3})+|\d+)(?:\.\d{1,2})?|\b(\d{1,4})\s?k\b',
  caseSensitive: false,
);

/// Reads one chat preview. Returns the claim, or null when the message isn't someone saying they paid.
/// [title] is the notification title: the sender ("Chioma Okafor"), or "Group: Sender" / "Sender @ Group".
DetectedClaim? detectClaim({required String title, required String text}) {
  if (!_claim.hasMatch(text) || _notYet.hasMatch(text)) return null;
  var sender = title.trim();
  if (sender.contains(':')) sender = sender.split(':').last.trim();
  if (sender.contains(' @ ')) sender = sender.split(' @ ').first.trim();
  sender = sender.replaceAll(RegExp(r'\s*\(\d+ messages?\)$'), '').trim();
  if (sender.isEmpty) return null;

  int? kobo;
  final m = _amount.firstMatch(text);
  if (m != null) {
    kobo = m.group(1) != null ? parseKobo(m.group(1)!) : int.parse(m.group(2)!) * 100000; // 45k = ₦45,000
  }
  return DetectedClaim(sender: sender, amountKobo: kobo);
}

// ── resolving a claim against the money that actually landed ───────────────

class ClaimCredit {
  const ClaimCredit({required this.id, required this.amountKobo, required this.occurredAt, this.counterparty});
  final int id;
  final int amountKobo;
  final DateTime occurredAt;
  final String? counterparty;
}

enum ClaimStatus { pending, verified, mismatch, notReceived }

class ClaimResolution {
  const ClaimResolution(this.status, {this.bankEventId});
  final ClaimStatus status;
  final int? bankEventId;
}

/// Did the money from this claim arrive? Looks at credits from 30 minutes before the claim (people often
/// pay, then message) up to the end of the wait. [taken]: credits already used to prove another claim.
///  - from the same name and the amount fits (or no amount was said) → verified
///  - the exact amount, from an account with no name on the alert → verified
///  - from the same name but a different amount → mismatch ("said ₦45,000, ₦4,500 landed")
///  - nothing by the end of the wait → not received
ClaimResolution resolveClaim({
  required String sender,
  int? amountKobo,
  required DateTime claimedAt,
  required List<ClaimCredit> credits,
  required DateTime now,
  Set<int> taken = const {},
  Duration window = claimWindow,
}) {
  final from = claimedAt.subtract(const Duration(minutes: 30));
  final until = claimedAt.add(window);
  final near = credits.where(
    (c) => !taken.contains(c.id) && !c.occurredAt.isBefore(from) && !c.occurredAt.isAfter(until),
  );

  int? mismatchId;
  for (final c in near) {
    final named = c.counterparty != null && nameSimilarity(sender, c.counterparty!) >= 0.6;
    final amountOk = amountKobo == null || c.amountKobo == amountKobo;
    if (named && amountOk) return ClaimResolution(ClaimStatus.verified, bankEventId: c.id);
    if (c.counterparty == null && amountKobo != null && c.amountKobo == amountKobo) {
      return ClaimResolution(ClaimStatus.verified, bankEventId: c.id);
    }
    if (named && !amountOk) mismatchId ??= c.id;
  }
  if (now.isBefore(until)) return const ClaimResolution(ClaimStatus.pending);
  if (mismatchId != null) return ClaimResolution(ClaimStatus.mismatch, bankEventId: mismatchId);
  return const ClaimResolution(ClaimStatus.notReceived);
}
