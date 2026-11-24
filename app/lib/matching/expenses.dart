import 'package:eri/matching/text_match.dart';

/// Debit alerts become expenses, so profit is net, not just gross. Keyword rules first; the vendor can
/// change any category with one tap (and that's remembered per recipient).
enum ExpenseCategory {
  supplier('Supplier'),
  dispatch('Dispatch'),
  ads('Ads'),
  rent('Rent'),
  dataAirtime('Data & airtime'),
  other('Other'),
  personal('Not business'); // transfers to yourself, family: left out of net profit

  const ExpenseCategory(this.label);
  final String label;

  static ExpenseCategory fromName(String n) => values.firstWhere((c) => c.name == n, orElse: () => other);
}

const _rules = <ExpenseCategory, List<String>>{
  ExpenseCategory.dispatch: [
    'gig',
    'logistics',
    'dispatch',
    'rider',
    'delivery',
    'courier',
    'bolt',
    'uber',
    'kwik',
    'sendbox',
    'dhl',
    'waybill',
    'park',
  ],
  ExpenseCategory.ads: [
    'facebook',
    'meta',
    'instagram',
    'ads',
    'advert',
    'google',
    'tiktok',
    'boost',
    'promote',
    'promotion',
  ],
  ExpenseCategory.dataAirtime: ['airtime', 'data', 'mtn', 'glo', 'airtel', '9mobile', 'recharge', 'vtu'],
  ExpenseCategory.rent: ['rent', 'landlord', 'caution fee', 'agent fee'],
  ExpenseCategory.supplier: [
    'supplier',
    'fabric',
    'fabrics',
    'wholesale',
    'market',
    'stock',
    'goods',
    'textile',
    'tailor',
    'materials',
  ],
};

/// [remembered]: normalised recipient → category the vendor chose before.
ExpenseCategory classifyDebit({
  String? counterparty,
  String? narration,
  Map<String, ExpenseCategory> remembered = const {},
}) {
  if (counterparty != null) {
    final r = remembered[normalize(counterparty)];
    if (r != null) return r;
  }
  final words = ' ${normalize('${counterparty ?? ''} ${narration ?? ''}')} ';
  for (final MapEntry(key: cat, value: keys) in _rules.entries) {
    if (keys.any((k) => words.contains(' $k '))) return cat;
  }
  return ExpenseCategory.other;
}
