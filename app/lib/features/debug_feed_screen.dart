import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/time.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';

/// The Day 1 spike screen: every money-looking notification the listener caught, raw, with whether the
/// parser understood it. Raw text is on this phone only and deleted after 7 days.
class DebugFeedScreen extends ConsumerWidget {
  const DebugFeedScreen({super.key});

  // lets the flow be shown without bank apps (emulator, browser preview). Synthetic text.
  static final _samples = [
    ('com.google.android.apps.messaging', 'GTBank',
        'GTBank: Acct 01******89 Cr NGN25,000.00 from CHIOMA OKAFOR Desc: ankara gown Avail Bal: NGN412,300.00'),
    ('team.opay.pay', 'Transfer received', 'You have received ₦8,500.00 from FEMI ADEYEMI.'),
    ('com.kudabank.app', 'Money out', 'You sent ₦4,150.00 to GIG LOGISTICS.'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raw = ref.watch(rawProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: const Text('Alert log'), actions: [
        if (kDebugMode || kIsWeb)
          TextButton.icon(
            onPressed: () async {
              // demo catalogue for trying the loop without typing (same products as the landing page)
              final sales = ref.read(salesProvider);
              final have = (await ref.read(dbProvider).select(ref.read(dbProvider).products).get()).map((p) => p.name).toSet();
              for (final (name, aliases, price, cost, qty) in const [
                ('Ankara Gown', 'gown, ankara', 2500000, 1750000, 4),
                ('Adire Two-piece', 'adire set, adire', 1800000, 1200000, 6),
                ('Aso-oke Cap', 'cap, aso oke', 850000, 500000, 9),
              ]) {
                if (!have.contains(name)) {
                  await sales.addProduct(name: name, aliases: aliases, sellPriceKobo: price, costKobo: cost, qty: qty);
                }
              }
            },
            icon: const Icon(Icons.storefront_outlined),
            label: const Text('Demo shop'),
          ),
      ]),
      // debug builds and the browser preview (which has no listener) only; never in the release APK
      floatingActionButton: kDebugMode || kIsWeb
          ? FloatingActionButton.extended(
              onPressed: () {
                final s = _samples[DateTime.now().second % _samples.length];
                ingest(ref.read(dbProvider), sales: ref.read(salesProvider), [
                  p.RawNotification(package: s.$1, title: s.$2, text: s.$3, postedAt: DateTime.now()),
                ]);
              },
              icon: const Icon(Icons.add),
              label: const Text('Simulate alert'),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text('On this phone only. Deleted after 7 days.', style: TextStyle(color: EriColors.mutedForeground)),
          ),
          if (raw.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Nothing caught yet.', textAlign: TextAlign.center),
            ),
          for (final r in raw) ...[
            _RawCard(r.package, r.title, r.body, r.postedAt, r.parsed),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _RawCard extends StatelessWidget {
  const _RawCard(this.package, this.title, this.body, this.postedAt, this.parsed);
  final String package, title, body;
  final DateTime postedAt;
  final bool parsed;

  @override
  Widget build(BuildContext context) {
    final alert = p.parseAlert(p.RawNotification(package: package, title: title, text: body, postedAt: postedAt));
    final v = Theme.of(context).extension<EriVerdicts>()!;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: EriColors.card, borderRadius: BorderRadius.circular(EriRadius.md)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Text('$package · ${clock(postedAt)}',
                  style: const TextStyle(fontSize: 12, color: EriColors.mutedForeground), overflow: TextOverflow.ellipsis),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: (parsed ? v.landed : v.suspicious).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(EriRadius.pill),
              ),
              child: Text(parsed ? 'Parsed' : 'Not a payment',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: parsed ? v.landed : v.suspicious)),
            ),
          ]),
          const SizedBox(height: 8),
          if (title.isNotEmpty) Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(body, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.4)),
          if (alert != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: EriColors.muted, borderRadius: BorderRadius.circular(EriRadius.sm)),
              child: Text(alert.toString(), style: const TextStyle(fontSize: 12, height: 1.4)),
            ),
          ],
        ],
      ),
    );
  }
}
