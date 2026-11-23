import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/matching/matcher.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';

/// Orders: the ones waiting for money (with the code to put in the transfer note), and the paid ones.
class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider).value ?? const <Order>[];
    final items = ref.watch(orderItemsProvider).value ?? const <OrderItem>[];
    final products = {for (final p in ref.watch(productsProvider).value ?? const <Product>[]) p.id: p};
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final waiting = orders.where((o) => o.status == 'awaiting_payment').toList();
    final rest = orders.where((o) => o.status != 'awaiting_payment').toList();

    Widget tile(Order o) {
      final lines = items.where((i) => i.orderId == o.id)
          .map((i) => '${products[i.productId]?.name ?? 'Item'}${i.qty > 1 ? ' ×${i.qty}' : ''}').join(', ');
      final (label, color) = switch (o.status) {
        'paid' => ('Paid ${o.paidAt == null ? '' : clock(o.paidAt!)}', v.landed),
        'cancelled' => ('Cancelled', EriColors.mutedForeground),
        _ => ('Waiting for money', v.suspicious),
      };
      return EriCard(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(o.code, style: display(18)),
            const SizedBox(width: 8),
            Expanded(child: Text(o.customerName ?? '', overflow: TextOverflow.ellipsis)),
            Text(naira(o.expectedAmountKobo ?? 0), style: const TextStyle(fontWeight: FontWeight.w600, fontFeatures: tabular)),
          ]),
          const SizedBox(height: 4),
          Text(lines, style: const TextStyle(color: EriColors.mutedForeground)),
          const SizedBox(height: 10),
          Row(children: [
            Pill(label, color: color.withValues(alpha: 0.12), textColor: color),
            const Spacer(),
            if (o.status == 'awaiting_payment')
              TextButton(onPressed: () => ref.read(salesProvider).cancelOrder(o.id), child: const Text('Cancel')),
          ]),
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: products.isEmpty ? null : () => showEriSheet<void>(context, (_) => const NewOrderForm()),
        icon: const Icon(Icons.add),
        label: const Text('New order'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
        children: [
          if (orders.isEmpty)
            EriCard(
              padding: const EdgeInsets.all(24),
              child: Text(
                products.isEmpty
                    ? 'Add a product first. Sales from bank alerts show up here on their own.'
                    : 'Sales from bank alerts show up here on their own. Set up an order when a buyer is about to pay: Eri gives you a code like ERI-101 for their transfer note.',
                style: const TextStyle(color: EriColors.mutedForeground, height: 1.4),
              ),
            ),
          if (waiting.isNotEmpty) const SectionLabel('Waiting for money'),
          for (final o in waiting) ...[tile(o), const SizedBox(height: 10)],
          if (rest.isNotEmpty) const SectionLabel('Done'),
          for (final o in rest.take(50)) ...[tile(o), const SizedBox(height: 10)],
        ],
      ),
    );
  }
}

class NewOrderForm extends ConsumerStatefulWidget {
  const NewOrderForm({super.key});

  @override
  ConsumerState<NewOrderForm> createState() => _NewOrderFormState();
}

class _NewOrderFormState extends ConsumerState<NewOrderForm> {
  final customer = TextEditingController();
  final fee = TextEditingController();
  final qty = <int, int>{};
  Order? created;

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider).value ?? const <Product>[];
    if (created != null) return _Created(created!);
    final total = products.fold<int>(0, (s, p) => s + (qty[p.id] ?? 0) * p.sellPriceKobo) + (parseKobo(fee.text) ?? 0);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('New order', style: display(22)),
      const SizedBox(height: 16),
      TextField(controller: customer, textCapitalization: TextCapitalization.words, decoration: field('Buyer’s name', hint: 'Amaka Eze')),
      const SizedBox(height: 12),
      EriCard(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(children: [
          for (final p in products)
            ListTile(
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(naira(p.sellPriceKobo)),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  onPressed: (qty[p.id] ?? 0) == 0 ? null : () => setState(() => qty[p.id] = qty[p.id]! - 1),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('${qty[p.id] ?? 0}', style: const TextStyle(fontFeatures: tabular, fontWeight: FontWeight.w600)),
                IconButton(onPressed: () => setState(() => qty[p.id] = (qty[p.id] ?? 0) + 1), icon: const Icon(Icons.add_circle_outline)),
              ]),
            ),
        ]),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: fee,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: field('Delivery fee (optional)', prefix: '₦ '),
        onChanged: (_) => setState(() {}),
      ),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: qty.values.every((q) => q == 0)
            ? null
            : () async {
                final o = await ref.read(salesProvider).createOrder(
                      customer: customer.text,
                      lines: [for (final MapEntry(:key, :value) in qty.entries) if (value > 0) SaleLine(key, value)],
                      deliveryFeeKobo: parseKobo(fee.text) ?? 0,
                    );
                setState(() => created = o);
              },
        child: Text('Create order · ${naira(total)}'),
      ),
    ]);
  }
}

class _Created extends StatelessWidget {
  const _Created(this.o);
  final Order o;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Order ${o.code} is waiting', style: display(22)),
        const SizedBox(height: 12),
        EriCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Send this to the buyer', style: TextStyle(color: EriColors.mutedForeground, fontSize: 13)),
            const SizedBox(height: 8),
            SelectableText(
              'Please pay ${naira(o.expectedAmountKobo ?? 0)} and put ${o.code} in the transfer note.',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
            ),
          ]),
        ),
        const SizedBox(height: 12),
        const Text('When the money lands, Eri marks it paid and takes the items out of stock. No code? The exact amount from the same name works too.',
            style: TextStyle(color: EriColors.mutedForeground, height: 1.4)),
        const SizedBox(height: 16),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
      ]);
}
