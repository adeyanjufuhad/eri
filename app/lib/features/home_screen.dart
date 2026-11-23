import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';

/// Today: real money in, sales and profit from bank alerts; credits Eri wasn't sure about; the feed.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted = ref.watch(permissionProvider).value ?? true;
    final events = ref.watch(eventsProvider).value ?? const <BankEvent>[];
    final books = ref.watch(booksProvider);
    final v = Theme.of(context).extension<EriVerdicts>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('eri'),
        actions: [
          IconButton(
            tooltip: 'Alert log (on this phone)',
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => context.push('/debug'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
        children: [
          if (!granted) ...[_PermissionBanner(onTap: () => context.go('/welcome')), const SizedBox(height: 12)],
          EriCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Real money in today', style: TextStyle(color: EriColors.mutedForeground, fontSize: 13)),
                const SizedBox(height: 6),
                Text(naira(books.moneyInKobo), style: display(38)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Pill('${books.salesCount} ${books.salesCount == 1 ? 'sale' : 'sales'}'),
                    Pill(
                      'Profit ${naira(books.profitKobo)}',
                      color: v.landed.withValues(alpha: 0.12),
                      textColor: v.landed,
                    ),
                    Pill('Out ${naira(books.moneyOutKobo)}'),
                  ],
                ),
              ],
            ),
          ),
          if (books.lowStock.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final p in books.lowStock)
                  Pill(
                    'Low stock · ${p.name} · ${p.qtyOnHand} left',
                    color: v.suspicious.withValues(alpha: 0.12),
                    textColor: v.suspicious,
                  ),
              ],
            ),
          ],
          if (books.needsYou.isNotEmpty) ...[
            SectionLabel('Needs you (${books.needsYou.length})'),
            for (final e in books.needsYou) ...[NeedsYouCard(e), const SizedBox(height: 10)],
          ],
          const SectionLabel('Latest alerts'),
          if (events.isEmpty)
            const EriCard(
              padding: EdgeInsets.all(24),
              child: Text(
                'Waiting for your first bank alert. To test, send ₦100 between two of your own accounts.',
                style: TextStyle(color: EriColors.mutedForeground, height: 1.4),
              ),
            )
          else
            Material(
              color: EriColors.card,
              borderRadius: BorderRadius.circular(EriRadius.lg),
              clipBehavior: Clip.antiAlias, // tap ripples show on the card, inside its rounded corners
              child: Column(
                children: [
                  for (final (i, e) in events.take(30).indexed) ...[
                    if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
                    EventTile(
                      e,
                      label: books.labels[e.id],
                      onReopen: books.labels[e.id] == null ? null : () => _reopen(context, ref, e),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> _reopen(BuildContext context, WidgetRef ref, BankEvent e) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Change what this was?'),
      content: Text(
        '${naira(e.amountKobo)} from ${e.counterparty ?? 'this sender'} goes back to “Needs you”. If it was logged as a sale, the stock goes back too.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Change it')),
      ],
    ),
  );
  if (ok == true) await ref.read(salesProvider).undo(e.id);
}

/// A credit Eri couldn't place on its own: its best guesses as one-tap chips, plus pick / not a sale / ignore.
class NeedsYouCard extends ConsumerWidget {
  const NeedsYouCard(this.e, {super.key});
  final BankEvent e;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sales = ref.read(salesProvider);
    final products = {for (final p in ref.watch(productsProvider).value ?? const <Product>[]) p.id: p};
    final orders = {for (final o in ref.watch(ordersProvider).value ?? const <Order>[]) o.id: o};
    final out = ref.watch(suggestionsProvider(e.id)).value;
    final note = e.narration == null ? '' : ' · “${e.narration}”';

    // every choice can be taken back: a mis-tap must never cost a vendor a sale or stock
    Future<void> act(Future<void> Function() f, String done) async {
      await f();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(done),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EriRadius.md)),
            action: SnackBarAction(label: 'Undo', onPressed: () => sales.undo(e.id)),
          ),
        );
    }

    String labelOf(Proposal p) {
      final items = p.lines
          .map((l) => '${products[l.productId]?.name ?? 'Item'}${l.qty > 1 ? ' ×${l.qty}' : ''}')
          .join(' + ');
      final order = p.orderId != null ? '${orders[p.orderId]?.code ?? 'Order'}: ' : '';
      final fee = p.deliveryFeeKobo > 0 ? ' + delivery' : '';
      return '$order$items$fee';
    }

    return EriCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${e.counterparty ?? 'Unknown sender'}$note',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              Text('+${naira(e.amountKobo)}', style: display(18, color: EriColors.landed)),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '${e.bank} · ${clock(e.occurredAt)} · What was this for?',
            style: const TextStyle(color: EriColors.mutedForeground, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final p in (out?.proposals ?? const <Proposal>[]).take(3))
                ActionChip(
                  label: Text(labelOf(p)),
                  avatar: const Icon(Icons.check, size: 16),
                  shape: const StadiumBorder(),
                  backgroundColor: EriColors.primary.withValues(alpha: 0.08),
                  side: BorderSide.none,
                  onPressed: () => act(() => sales.apply(e, p, byUser: true), 'Logged: ${labelOf(p)}'),
                ),
              ActionChip(
                label: const Text('Pick products…'),
                shape: const StadiumBorder(),
                side: const BorderSide(color: EriColors.border),
                onPressed: products.isEmpty
                    ? () => context.go('/products')
                    : () => showEriSheet<void>(context, (_) => _PickProducts(e, products.values.toList())),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              TextButton(
                onPressed: () => act(() => sales.notSale(e), 'Marked as not a sale'),
                child: const Text('Not a sale'),
              ),
              if (e.counterparty != null)
                Flexible(
                  child: TextButton(
                    onPressed: () => act(() => sales.ignoreSender(e), 'Ignoring ${e.counterparty} from now on'),
                    child: Text('Always ignore ${e.counterparty}', overflow: TextOverflow.ellipsis),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PickProducts extends ConsumerStatefulWidget {
  const _PickProducts(this.e, this.products);
  final BankEvent e;
  final List<Product> products;

  @override
  ConsumerState<_PickProducts> createState() => _PickProductsState();
}

class _PickProductsState extends ConsumerState<_PickProducts> {
  final qty = <int, int>{};

  @override
  Widget build(BuildContext context) {
    final total = widget.products.fold<int>(0, (s, p) => s + (qty[p.id] ?? 0) * p.sellPriceKobo);
    final diff = widget.e.amountKobo - total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('What did ${widget.e.counterparty ?? 'they'} buy?', style: display(22)),
        const SizedBox(height: 4),
        Text(
          '${naira(widget.e.amountKobo)} landed. Picked: ${naira(total)}${diff == 0
              ? ' ✓'
              : diff > 0
              ? ' (${naira(diff)} more paid)'
              : ''}',
          style: const TextStyle(color: EriColors.mutedForeground),
        ),
        const SizedBox(height: 12),
        EriCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (final p in widget.products)
                ListTile(
                  title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${naira(p.sellPriceKobo)} · ${p.qtyOnHand} left'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: (qty[p.id] ?? 0) == 0 ? null : () => setState(() => qty[p.id] = qty[p.id]! - 1),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '${qty[p.id] ?? 0}',
                        style: const TextStyle(fontFeatures: tabular, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () => setState(() => qty[p.id] = (qty[p.id] ?? 0) + 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: qty.values.every((q) => q == 0)
              ? null
              : () {
                  ref.read(salesProvider).confirmManual(widget.e, [
                    for (final MapEntry(:key, :value) in qty.entries)
                      if (value > 0) SaleLine(key, value),
                  ]);
                  Navigator.pop(context);
                },
          child: const Text('Log this sale'),
        ),
      ],
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile(this.e, {super.key, this.label, this.onReopen});
  final BankEvent e;
  final EventLabel? label;
  final VoidCallback? onReopen;

  @override
  Widget build(BuildContext context) {
    final credit = e.direction == 'credit';
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final who = [e.counterparty, if (e.narration != null) '“${e.narration}”'].whereType<String>().join(' · ');
    final status = label?.text ?? (credit ? 'Needs you' : null);
    return ListTile(
      leading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: credit ? v.landed : EriColors.mutedForeground),
      ),
      minLeadingWidth: 10,
      title: Text(
        who.isEmpty ? (credit ? 'Credit' : 'Debit') : who,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '${e.bank} · ${clock(e.occurredAt)}'),
            if (status != null)
              TextSpan(
                text: '\n$status',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: label?.sale == true ? v.landed : (label == null ? v.suspicious : EriColors.mutedForeground),
                ),
              ),
          ],
        ),
        style: const TextStyle(color: EriColors.mutedForeground),
      ),
      isThreeLine: status != null,
      onTap: onReopen,
      trailing: Text(
        '${credit ? '+' : '−'}${naira(e.amountKobo)}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFeatures: tabular,
          color: credit ? v.landed : EriColors.foreground,
        ),
      ),
    );
  }
}

class _PermissionBanner extends StatelessWidget {
  const _PermissionBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: EriColors.primary,
    borderRadius: BorderRadius.circular(EriRadius.md),
    child: InkWell(
      borderRadius: BorderRadius.circular(EriRadius.md),
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.notifications_off_outlined, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Eri can’t see your bank alerts yet. Tap to allow notification access.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
