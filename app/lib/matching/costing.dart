/// Moving-average unit cost after a restock, in kobo, rounded to the nearest kobo.
/// 4 units at ₦17,500 + 2 more at ₦19,000 → ₦18,000.
/// If nothing (or less than nothing) is on hand, the new batch's cost is the average.
int movingAverageCost({required int oldQty, required int oldAvgKobo, required int addQty, required int unitCostKobo}) {
  if (addQty <= 0) return oldAvgKobo;
  if (oldQty <= 0) return unitCostKobo;
  final total = oldQty * oldAvgKobo + addQty * unitCostKobo;
  final n = oldQty + addQty;
  return (total + n ~/ 2) ~/ n;
}

/// Gross profit of a sale: what it sold for minus what the units cost (snapshotted at sale time).
int grossProfit(Iterable<({int qty, int unitPriceKobo, int unitCostKobo})> lines) =>
    lines.fold(0, (s, l) => s + l.qty * (l.unitPriceKobo - l.unitCostKobo));
