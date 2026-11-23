// Small, deterministic text helpers for matching narrations and names. No LLM here.

/// "Ankara-Gown!!" → "ankara gown"
String normalize(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim().replaceAll(RegExp(r'\s+'), ' ');

List<String> tokens(String s) => normalize(s).split(' ').where((t) => t.isNotEmpty).toList();

int levenshtein(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  var prev = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    final cur = List<int>.filled(b.length + 1, 0)..[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      cur[j] = [prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + cost].reduce((x, y) => x < y ? x : y);
    }
    prev = cur;
  }
  return prev[b.length];
}

/// 1.0 = same word, 0 = nothing alike. "ankra" vs "ankara" ≈ 0.83.
double wordSimilarity(String a, String b) {
  final len = a.length > b.length ? a.length : b.length;
  return len == 0 ? 1 : 1 - levenshtein(a, b) / len;
}

/// How well [phrase] (a product name or alias) appears in [text] (a narration), 0–1.
/// Whole phrase present → 1. Otherwise each word of the phrase is looked for (typos allowed, ≥ 0.75 alike)
/// and the score is the average; a word that isn't there counts 0.
double phraseScore(String phrase, String text) {
  final p = normalize(phrase), t = normalize(text);
  if (p.isEmpty || t.isEmpty) return 0;
  if (' $t '.contains(' $p ')) return 1;
  final tw = tokens(t);
  final pw = tokens(p);
  var sum = 0.0;
  for (final w in pw) {
    var best = 0.0;
    for (final x in tw) {
      final s = wordSimilarity(w, x);
      if (s > best) best = s;
    }
    if (best >= 0.75) sum += best;
  }
  return sum / pw.length;
}

/// Name likeness for "is this transfer from the customer we expected?": "CHIOMA OKAFOR" vs "Chioma O." → high.
/// Initials count: "o" matches "okafor".
double nameSimilarity(String a, String b) {
  final aw = tokens(a), bw = tokens(b);
  if (aw.isEmpty || bw.isEmpty) return 0;
  final (short, long) = aw.length <= bw.length ? (aw, bw) : (bw, aw);
  var sum = 0.0;
  for (final w in short) {
    var best = 0.0;
    for (final x in long) {
      final s = (w.length == 1 && x.startsWith(w)) || (x.length == 1 && w.startsWith(x)) ? 0.9 : wordSimilarity(w, x);
      if (s > best) best = s;
    }
    sum += best;
  }
  return sum / short.length;
}
