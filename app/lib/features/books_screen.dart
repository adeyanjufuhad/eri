import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/books/pnl.dart';
import 'package:eri/core/money.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
String _date(DateTime d) => '${_days[d.weekday - 1]} ${d.day} ${_months[d.month - 1]}';

/// Daily / weekly P&L from real money (PLAN.md Day 5): sales, cost of goods, delivery, expenses, net.
/// The numbers are functional data, so nothing here animates except the period crossfade.
class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key, this.now});

  /// For tests; the app uses the real clock.
  final DateTime? now;

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  bool week = false;

  @override
  Widget build(BuildContext context) {
    final src = ref.watch(pnlSourceProvider);
    final now = widget.now ?? DateTime.now();
    final from = week ? startOfWeek(now) : startOfDay(now);
    final p = computePnl(
      from: from,
      to: from.add(Duration(days: week ? 7 : 1)),
      orders: src.orders,
      items: src.items,
      events: src.events,
      expenseByEvent: src.cats,
    );
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final period = week ? '${_date(from)} – ${_date(from.add(const Duration(days: 6)))}' : _date(from);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: false, label: Text('Today')),
              ButtonSegment(value: true, label: Text('This week')),
            ],
            selected: {week},
            onSelectionChanged: (s) => setState(() => week = s.first),
          ),
          const SizedBox(height: 16),
          Swap(
            child: Column(
              key: ValueKey(week),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EriCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Net profit · $period',
                        style: const TextStyle(color: EriColors.mutedForeground, fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          naira(p.netKobo),
                          style: display(36, color: p.netKobo < 0 ? v.notReceived : EriColors.foreground),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${p.salesCount} ${p.salesCount == 1 ? 'sale' : 'sales'} · only money that reached your bank',
                        style: const TextStyle(color: EriColors.mutedForeground, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                EriCard(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Column(
                    children: [
                      _Line('Sales', p.salesKobo),
                      _Line('Cost of goods', -p.cogsKobo),
                      const Divider(height: 20),
                      _Line('Gross profit', p.grossProfitKobo, bold: true),
                      if (p.deliveryKobo > 0) _Line('Delivery fees collected', p.deliveryKobo),
                      _Line('Expenses', -p.expensesKobo),
                      for (final e in p.expenses.entries) _Line(e.key.label, -e.value, indent: true),
                      const Divider(height: 20),
                      _Line('Net', p.netKobo, bold: true, color: p.netKobo < 0 ? v.notReceived : v.landed),
                    ],
                  ),
                ),
                if (week) ...[
                  const SectionLabel('Day by day'),
                  EriCard(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                    child: _WeekBars(
                      days: weekByDay(
                        now: now,
                        orders: src.orders,
                        items: src.items,
                        events: src.events,
                        expenseByEvent: src.cats,
                      ),
                      today: startOfDay(now),
                    ),
                  ),
                ],
                if (p.personalKobo > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      '${naira(p.personalKobo)} you marked “Not business” is left out.',
                      style: const TextStyle(color: EriColors.mutedForeground, fontSize: 13),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Orders still waiting for payment are not counted. Tap an alert on Today to change its category.',
                    style: TextStyle(color: EriColors.mutedForeground, fontSize: 13, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line(this.label, this.kobo, {this.bold = false, this.indent = false, this.color});
  final String label;
  final int kobo;
  final bool bold, indent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final w = bold ? FontWeight.w700 : FontWeight.w500;
    final c = indent ? EriColors.mutedForeground : (color ?? EriColors.foreground);
    final amount = kobo < 0 ? '−${naira(-kobo)}' : naira(kobo);
    return Padding(
      padding: EdgeInsets.fromLTRB(indent ? 14 : 0, 6, 0, 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: w, color: c, fontSize: indent ? 13 : 15),
            ),
          ),
          Text(
            amount,
            style: TextStyle(fontWeight: w, color: c, fontFeatures: tabular, fontSize: indent ? 13 : 15),
          ),
        ],
      ),
    );
  }
}

/// Seven columns, Monday to Sunday: net per day, up (green) or down (red) from a zero line.
/// Static on purpose: it's data, read at a glance.
class _WeekBars extends StatelessWidget {
  const _WeekBars({required this.days, required this.today});
  final List<Pnl> days;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final peak = days.fold<int>(1, (m, d) => d.netKobo.abs() > m ? d.netKobo.abs() : m);
    const half = 48.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final (i, d) in days.indexed)
          Expanded(
            child: Semantics(
              label: '${_days[i]}: net ${naira(d.netKobo)}',
              excludeSemantics: true,
              child: Opacity(
                opacity: d.from.isAfter(today) ? 0.35 : 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: half * 2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(height: 1, color: EriColors.border),
                          Align(
                            alignment: d.netKobo >= 0 ? Alignment.bottomCenter : Alignment.topCenter,
                            child: FractionallySizedBox(
                              heightFactor: 0.5,
                              child: Align(
                                alignment: d.netKobo >= 0 ? Alignment.bottomCenter : Alignment.topCenter,
                                child: Container(
                                  width: 14,
                                  height: half * d.netKobo.abs() / peak,
                                  decoration: BoxDecoration(
                                    color: d.netKobo >= 0 ? v.landed : v.notReceived,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _days[i],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: d.from == today ? FontWeight.w700 : FontWeight.w500,
                        color: d.from == today ? EriColors.foreground : EriColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
