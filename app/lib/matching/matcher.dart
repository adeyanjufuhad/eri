import 'package:eri/matching/text_match.dart';

// The matching engine (PLAN.md Day 2). Pure Dart: no database, no network, no LLM, so it is fully testable.
// Given one credit and what the vendor sells, it proposes what the money was for, in this order:
//   1. order code in the note (ERI-104)        → that order
//   2. an order waiting for exactly this amount (+ the sender's name fits)
//   3. the note names a product ("ankara gown") and the amount fits
//   4. the amount alone fits one product (booked), or a quantity / combination (+ delivery fee) (suggested)
//   5. otherwise → the vendor confirms with one tap
// It only acts on its own when the best proposal is clearly ahead (see [MatchOutcome.auto]).

class MProduct {
  const MProduct({required this.id, required this.name, this.aliases = const [], required this.priceKobo, this.qty = 0});
  final int id;
  final String name;
  final List<String> aliases;
  final int priceKobo;
  final int qty;
}

class MOrder {
  const MOrder({required this.id, required this.code, required this.expectedKobo, this.customer, this.lines = const []});
  final int id;
  final String code; // 'ERI-104'
  final int expectedKobo; // items + delivery fee
  final String? customer;
  final List<SaleLine> lines;
}

class MEvent {
  const MEvent({required this.amountKobo, this.counterparty, this.narration});
  final int amountKobo;
  final String? counterparty;
  final String? narration;
}

class SaleLine {
  const SaleLine(this.productId, this.qty);
  final int productId;
  final int qty;

  @override
  bool operator ==(Object other) => other is SaleLine && other.productId == productId && other.qty == qty;
  @override
  int get hashCode => Object.hash(productId, qty);
}

enum MatchKind { orderCode, expectedPayment, narration, amountCombo }

class Proposal {
  const Proposal({required this.kind, required this.confidence, required this.lines, this.orderId, this.deliveryFeeKobo = 0});
  final MatchKind kind;
  final double confidence;
  final List<SaleLine> lines;
  final int? orderId; // set for kinds 1 and 2 (an existing order)
  final int deliveryFeeKobo;

  @override
  String toString() => 'Proposal(${kind.name} ${confidence.toStringAsFixed(2)} order=$orderId lines=${lines.map((l) => '${l.productId}x${l.qty}').join(',')})';
}

class MatchOutcome {
  const MatchOutcome({this.proposals = const [], this.ignored = false});
  final List<Proposal> proposals; // best first
  final bool ignored; // sender is on the vendor's ignore list

  /// Act without asking only when the best proposal is confident (≥ 0.6) AND clearly ahead of the next
  /// one (by ≥ 0.15). Anything else goes to the vendor as a one-tap choice.
  Proposal? get auto {
    if (ignored || proposals.isEmpty) return null;
    final best = proposals.first;
    if (best.confidence < autoThreshold) return null;
    if (proposals.length > 1 && best.confidence - proposals[1].confidence < 0.15) return null;
    return best;
  }

  static const autoThreshold = 0.6;
}

final _orderCode = RegExp(r'\beri[\s-]?(\d{2,6})\b', caseSensitive: false);
final _qtyBefore = RegExp(r'\b(\d{1,2})\s*(?:x|pcs|pieces)?\s*$', caseSensitive: false);
final _qtyX = RegExp(r'\bx\s*(\d{1,2})\b|\b(\d{1,2})\s*x\b', caseSensitive: false);

MatchOutcome matchCredit(
  MEvent e, {
  required List<MProduct> products,
  List<MOrder> openOrders = const [],
  Set<String> ignoredSenders = const {},
  int deliveryFeeKobo = 0,
}) {
  if (e.counterparty != null && ignoredSenders.contains(normalize(e.counterparty!))) {
    return const MatchOutcome(ignored: true);
  }
  final out = <Proposal>[];
  final note = e.narration ?? '';

  // 1. order code
  final code = _orderCode.firstMatch('$note ${e.counterparty ?? ''}');
  if (code != null) {
    final wanted = 'ERI-${code.group(1)}';
    for (final o in openOrders.where((o) => o.code.toUpperCase() == wanted)) {
      // paid in full → certain; short → the vendor decides (part payment)
      out.add(Proposal(
          kind: MatchKind.orderCode, confidence: e.amountKobo >= o.expectedKobo ? 1.0 : 0.5, lines: o.lines, orderId: o.id));
    }
  }

  // 2. expected payment: exact amount, and the name fits if we have both names
  for (final o in openOrders.where((o) => o.expectedKobo == e.amountKobo)) {
    if (out.any((p) => p.orderId == o.id)) continue;
    final double c;
    if (o.customer == null || e.counterparty == null) {
      c = 0.75; // amount only
    } else {
      final sim = nameSimilarity(o.customer!, e.counterparty!);
      c = sim >= 0.6 ? 0.9 + 0.05 * sim : 0.45; // someone else paying the same amount → ask
    }
    out.add(Proposal(kind: MatchKind.expectedPayment, confidence: c, lines: o.lines, orderId: o.id));
  }

  // 3. the note names a product
  if (note.trim().isNotEmpty) {
    for (final p in products) {
      final names = [p.name, ...p.aliases].where((n) => n.trim().isNotEmpty);
      var best = 0.0;
      String? bestName;
      for (final n in names) {
        final s = phraseScore(n, note);
        if (s > best) (best, bestName) = (s, n);
      }
      if (best < 0.6 || bestName == null) continue;

      var qty = _qtyIn(note, bestName);
      // no quantity written, but the amount is an exact multiple of the price: "₦50,000 · ankara gown" = 2
      if (qty == 1 && p.priceKobo > 0 && e.amountKobo % p.priceKobo == 0) {
        final n = e.amountKobo ~/ p.priceKobo;
        if (n >= 1 && n <= 10) qty = n;
      }
      final total = p.priceKobo * qty;
      final fits = e.amountKobo == total || (deliveryFeeKobo > 0 && e.amountKobo == total + deliveryFeeKobo);
      out.add(Proposal(
        kind: MatchKind.narration,
        confidence: fits ? 0.5 + 0.5 * best : 0.5 * best,
        lines: [SaleLine(p.id, qty)],
        deliveryFeeKobo: fits && e.amountKobo != total ? deliveryFeeKobo : 0,
      ));
    }
  }

  // 4. the amount alone
  if (out.every((p) => p.confidence < MatchOutcome.autoThreshold)) {
    final combos = _amountCombos(e.amountKobo, products, deliveryFeeKobo);
    // prefer what is actually in stock
    final inStock = combos.where((c) => c.$1.every((l) => products.firstWhere((p) => p.id == l.productId).qty >= l.qty)).toList();
    final pick = inStock.isNotEmpty ? inStock : combos;
    for (final (lines, fee) in pick) {
      // Only "exactly one unit of exactly one product" is safe to book on the amount alone. Quantities and
      // combinations guessed from an amount (₦50,000 = 2 gowns?) are offered as a one-tap suggestion instead:
      // a transfer from your own savings account must never turn into a sale.
      final single = lines.length == 1 && lines.first.qty == 1 && fee == 0;
      out.add(Proposal(
        kind: MatchKind.amountCombo,
        confidence: pick.length == 1 ? (single ? 0.7 : 0.55) : 0.4,
        lines: lines,
        deliveryFeeKobo: fee,
      ));
    }
  }

  out.sort((a, b) => b.confidence.compareTo(a.confidence));
  return MatchOutcome(proposals: _dedupe(out));
}

int _qtyIn(String note, String name) {
  final n = normalize(note);
  final at = n.indexOf(normalize(name));
  if (at > 0) {
    final m = _qtyBefore.firstMatch(n.substring(0, at));
    if (m != null) return int.parse(m.group(1)!).clamp(1, 99);
  }
  final x = _qtyX.firstMatch(note);
  if (x != null) return int.parse((x.group(1) ?? x.group(2))!).clamp(1, 99);
  return 1;
}

/// Ways the amount can be made from the catalogue: one product ×1–3, or two different products ×1 each,
/// with or without the delivery fee. Small on purpose: past this, the vendor is quicker than a guess.
List<(List<SaleLine>, int)> _amountCombos(int amount, List<MProduct> products, int fee) {
  final out = <(List<SaleLine>, int)>[];
  for (final f in {0, fee}) {
    final rest = amount - f;
    if (rest <= 0) continue;
    for (final p in products) {
      for (var q = 1; q <= 3; q++) {
        if (p.priceKobo * q == rest) out.add(([SaleLine(p.id, q)], f));
      }
    }
    for (var i = 0; i < products.length; i++) {
      for (var j = i + 1; j < products.length; j++) {
        if (products[i].priceKobo + products[j].priceKobo == rest) {
          out.add(([SaleLine(products[i].id, 1), SaleLine(products[j].id, 1)], f));
        }
      }
    }
  }
  return out;
}

List<Proposal> _dedupe(List<Proposal> ps) {
  final seen = <String>{};
  return [
    for (final p in ps)
      if (seen.add('${p.orderId}|${p.lines.map((l) => '${l.productId}x${l.qty}').join(',')}')) p,
  ];
}
