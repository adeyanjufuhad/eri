import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/money.dart';
import 'package:eri/data/db.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

/// What the vendor sells: price, what it cost (moving average), how many are left.
class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider).value ?? const <Product>[];
    final v = Theme.of(context).extension<EriVerdicts>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      floatingActionButton: PressScale(
        child: FloatingActionButton.extended(
          onPressed: () => showEriSheet<void>(context, (_) => const ProductForm()),
          icon: const Icon(Icons.add),
          label: const Text('Add product'),
        ),
      ),
      body: products.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: EriCard(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Add what you sell. Eri uses the name and the other words buyers use (like “gown”) to recognise what a payment was for.',
                  style: TextStyle(color: EriColors.mutedForeground, height: 1.4),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
              itemCount: products.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final p = products[i];
                final low = p.qtyOnHand <= p.lowStockThreshold;
                return PressScale(
                  child: Material(
                    color: EriColors.card,
                    borderRadius: BorderRadius.circular(EriRadius.lg),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(EriRadius.lg),
                      onTap: () => showEriSheet<void>(context, (_) => ProductForm(product: p)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Sells ${naira(p.sellPriceKobo)} · costs ${naira(p.avgCostKobo)}${p.aliases.isEmpty ? '' : '\nAlso: ${p.aliases}'}',
                                    style: const TextStyle(
                                      color: EriColors.mutedForeground,
                                      fontSize: 13,
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // the count crossfades when a sale takes one: that change is the news
                            Swap(
                              child: Pill(
                                key: ValueKey(p.qtyOnHand),
                                '${p.qtyOnHand} left',
                                color: low ? v.suspicious.withValues(alpha: 0.12) : null,
                                textColor: low ? v.suspicious : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

/// Add a product, or edit one and restock it.
class ProductForm extends ConsumerStatefulWidget {
  const ProductForm({super.key, this.product});
  final Product? product;

  @override
  ConsumerState<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends ConsumerState<ProductForm> {
  final _form = GlobalKey<FormState>();
  late final name = TextEditingController(text: widget.product?.name);
  late final aliases = TextEditingController(text: widget.product?.aliases);
  late final price = TextEditingController(text: _n(widget.product?.sellPriceKobo));
  final cost = TextEditingController();
  final qty = TextEditingController();

  static String? _n(int? kobo) => kobo == null ? null : naira(kobo).replaceFirst('₦', '');

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(p == null ? 'Add product' : p.name, style: display(22)),
          const SizedBox(height: 16),
          TextFormField(
            controller: name,
            textCapitalization: TextCapitalization.words,
            decoration: field('Name', hint: 'Ankara Gown'),
            validator: (v) => (v ?? '').trim().isEmpty ? 'Enter a name' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: aliases,
            decoration: field('Other words buyers use', hint: 'gown, ankara'),
          ),
          const SizedBox(height: 12),
          nairaField(price, 'Selling price'),
          const SizedBox(height: 20),
          Text(p == null ? 'Stock' : 'Restock (optional)', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: countField(qty, p == null ? 'How many you have' : 'How many more')),
              const SizedBox(width: 12),
              Expanded(child: nairaField(cost, 'Cost each', required: p == null)),
            ],
          ),
          if (p != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '${p.qtyOnHand} left now, costing ${naira(p.avgCostKobo)} each on average.',
                style: const TextStyle(color: EriColors.mutedForeground, fontSize: 13),
              ),
            ),
          const SizedBox(height: 20),
          PressScale(
            child: FilledButton(onPressed: _save, child: Text(p == null ? 'Add product' : 'Save')),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final p = widget.product;
    // when editing, the restock fields are optional: only validate them if something was typed
    if (p != null && qty.text.isEmpty && cost.text.isEmpty) {
      if (name.text.trim().isEmpty || parseKobo(price.text) == null) return;
    } else if (!_form.currentState!.validate()) {
      return;
    }
    final sales = ref.read(salesProvider);
    if (p == null) {
      await sales.addProduct(
        name: name.text,
        aliases: aliases.text,
        sellPriceKobo: readKobo(price),
        costKobo: readKobo(cost),
        qty: int.parse(qty.text),
      );
    } else {
      await sales.updateProduct(p.id, name: name.text, aliases: aliases.text, sellPriceKobo: readKobo(price));
      final more = int.tryParse(qty.text) ?? 0;
      if (more > 0) await sales.restock(p.id, qty: more, unitCostKobo: parseKobo(cost.text) ?? p.avgCostKobo);
    }
    if (mounted) Navigator.pop(context);
  }
}
