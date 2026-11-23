// Money is kobo (int) everywhere; format only at the UI edge. ₦25,000 = 2500000 kobo.

/// `2500000` → `₦25,000`; `2500050` → `₦25,000.50`. Negative amounts get a leading minus: `-₦500`.
String naira(int kobo) {
  final sign = kobo < 0 ? '-' : '';
  final abs = kobo.abs();
  final whole = abs ~/ 100;
  final cents = abs % 100;
  final grouped = whole.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return '$sign₦$grouped${cents == 0 ? '' : '.${cents.toString().padLeft(2, '0')}'}';
}

/// Parses an amount as written in an alert (`25,000.00`, `25000`, `1,250.5`) into kobo, without floats.
/// Returns null if it isn't a plain amount.
int? parseKobo(String text) {
  final m = RegExp(r'^(\d{1,3}(?:,\d{3})+|\d+)(?:\.(\d{1,2}))?$').firstMatch(text.trim());
  if (m == null) return null;
  final whole = int.parse(m.group(1)!.replaceAll(',', ''));
  final frac = (m.group(2) ?? '').padRight(2, '0');
  return whole * 100 + int.parse(frac);
}
