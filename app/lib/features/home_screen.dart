import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/features/claims_widgets.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/bits.dart';
import 'package:eri/theme/motion.dart';

/// Today: real money in, sales and profit from bank alerts; credits Eri wasn't sure about; the feed.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted = ref.watch(permissionProvider).value ?? true;
    final events = ref.watch(eventsProvider).value ?? const <BankEvent>[];
    final books = ref.watch(booksProvider);
    final v = Theme.of(context).extension<EriVerdicts>()!;

    final h = DateTime.now().hour;
    final greeting = h < 12 ? 'Good morning' : (h < 17 ? 'Good afternoon' : 'Good evening');

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            // header: who and when, with the two utilities as round buttons (Round 4, A2)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(greeting, style: const TextStyle(color: EriColors.mutedForeground, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text('Your money today', style: display(24)),
                    ],
                  ),
                ),
                _RoundIcon(
                  icon: Icons.receipt_long_outlined,
                  tooltip: 'Alert log (on this phone)',
                  onTap: () => context.push('/debug'),
                ),
                const SizedBox(width: 8),
                _RoundIcon(
                  icon: Icons.tune_rounded,
                  tooltip: 'Settings',
                  onTap: () => showEriSheet<void>(context, (_) => const SettingsSheet()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!granted) ...[_PermissionBanner(onTap: () => context.go('/welcome')), const SizedBox(height: 12)],
            // hero: the one number that matters, on Eri's blue (Round 4, A1). The glow follows a finger on it
            // (React Bits Spotlight Card).
            Spotlight(
              color: Colors.white.withValues(alpha: 0.22),
              radius: EriRadius.xl - 4,
              size: 260,
              child: Container(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(EriRadius.xl - 4),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [EriColors.primary, Color(0xFF5B6FFF), Color(0xFF8E9BFF)],
                  ),
                  boxShadow: const [
                    BoxShadow(color: Color(0x553B5BFF), blurRadius: 36, offset: Offset(0, 18), spreadRadius: -14),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Real money in today',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 13),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(EriRadius.pill),
                          ),
                          child: const Text(
                            'From bank alerts',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // each digit rolls to its new value when money lands (React Bits Counter): the product's
                    // whole promise, in one motion
                    RollingMoney(
                      kobo: books.moneyInKobo,
                      format: naira,
                      style: display(42, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _HeroPill('${books.salesCount} ${books.salesCount == 1 ? 'sale' : 'sales'}'),
                        _HeroPill('Profit ${naira(books.profitKobo)}'),
                        _HeroPill('Spent ${naira(books.spentKobo)}'),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(height: 1, color: Colors.white.withValues(alpha: 0.18)),
                    const SizedBox(height: 12),
                    // net = profit on what sold + delivery − business expenses (the Books sum); tap for the full P&L
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => context.push('/books'),
                      child: Row(
                        children: [
                          const Text('Net today', style: TextStyle(color: Color(0xDDFFFFFF))),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xDDFFFFFF)),
                          const Spacer(),
                          Text(
                            naira(books.netKobo),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFeatures: tabular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // quick actions, the way banking apps put Send / Receive under the balance (Round 4, A3)
            // they scale in 40ms apart the first time Today opens this session (React Bits Animated List)
            RevealScope(
              id: 'today-actions',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RevealItem(
                    index: 0,
                    child: _QuickAction(
                      icon: Icons.fact_check_outlined,
                      label: 'Check receipt',
                      onTap: () => context.push('/receipt'),
                    ),
                  ),
                  RevealItem(
                    index: 1,
                    child: _QuickAction(
                      icon: Icons.add_shopping_cart_rounded,
                      label: 'New order',
                      onTap: () => context.go('/orders'),
                    ),
                  ),
                  RevealItem(
                    index: 2,
                    child: _QuickAction(
                      icon: Icons.bar_chart_rounded,
                      label: 'Books',
                      onTap: () => context.push('/books'),
                    ),
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
            // "I've paid" claims first: a fake one costs the vendor the goods
            if (books.claims.isNotEmpty) ...[
              SectionLabel('Payment claims (${books.claims.length})'),
              for (final c in books.claims) ...[
                EnterOnce(
                  key: ValueKey('claim-${c.id}-${c.status}'),
                  animate: justNow(c.claimedAt) || c.status != 'pending',
                  child: Spotlight(child: ClaimCard(c)),
                ),
                const SizedBox(height: 10),
              ],
            ],
            if (books.needsYou.isNotEmpty) ...[
              SectionLabel('Needs you (${books.needsYou.length})'),
              // a credit that just landed rises in; once decided, the card leaves at once (no lingering gap)
              for (final e in books.needsYou) ...[
                EnterOnce(
                  key: ValueKey('needs-${e.id}'),
                  animate: justNow(e.occurredAt),
                  child: Spotlight(child: NeedsYouCard(e)),
                ),
                const SizedBox(height: 10),
              ],
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
                      EnterOnce(
                        key: ValueKey('event-${e.id}'),
                        animate: justNow(e.occurredAt),
                        child: EventTile(
                          e,
                          label: books.labels[e.id],
                          onReopen: switch (books.labels[e.id]) {
                            null => null,
                            final EventLabel l when l.expense != null => () => showEriSheet<void>(
                              context,
                              (_) => ExpenseSheet(e, l.expense!),
                            ),
                            _ => () => _reopen(context, ref, e),
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
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
                PressScale(
                  child: ActionChip(
                    label: Text(labelOf(p)),
                    avatar: const Icon(Icons.check, size: 16),
                    shape: const StadiumBorder(),
                    backgroundColor: EriColors.primary.withValues(alpha: 0.08),
                    side: BorderSide.none,
                    onPressed: () => act(() => sales.apply(e, p, byUser: true), 'Logged: ${labelOf(p)}'),
                  ),
                ),
              PressScale(
                child: ActionChip(
                  label: const Text('Pick products…'),
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: EriColors.border),
                  onPressed: products.isEmpty
                      ? () => context.go('/products')
                      : () => showEriSheet<void>(context, (_) => _PickProducts(e, products.values.toList())),
                ),
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
        PressScale(
          enabled: qty.values.any((q) => q > 0),
          child: FilledButton(
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${e.bank} · ${clock(e.occurredAt)}', style: const TextStyle(color: EriColors.mutedForeground)),
          // "Needs you" → "Sold: …" crossfades in place: the state change is the news
          if (status != null)
            Swap(
              child: Text(
                status,
                key: ValueKey(status),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: label?.sale == true ? v.landed : (label == null ? v.suspicious : EriColors.mutedForeground),
                ),
              ),
            ),
        ],
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

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.tooltip, required this.onTap});
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: PressScale(
      child: Material(
        color: EriColors.card,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(11), child: Icon(icon, size: 20)),
        ),
      ),
    ),
  );
}

class _HeroPill extends StatelessWidget {
  const _HeroPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(EriRadius.pill),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, fontFeatures: tabular),
    ),
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => PressScale(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 96,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: EriColors.card,
                shape: BoxShape.circle,
                boxShadow: const [BoxShadow(color: Color(0x140F141D), blurRadius: 18, offset: Offset(0, 8))],
              ),
              child: Icon(icon, color: EriColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}
