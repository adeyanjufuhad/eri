import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eri/core/money.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

/// White rounded surface: the one container style the app uses.
class EriCard extends StatelessWidget {
  const EriCard({super.key, required this.child, this.padding = const EdgeInsets.all(20), this.radius = EriRadius.lg});
  final Widget child;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(color: EriColors.card, borderRadius: BorderRadius.circular(radius)),
    child: child,
  );
}

class Pill extends StatelessWidget {
  const Pill(this.label, {super.key, this.color, this.textColor});
  final String label;
  final Color? color, textColor;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: color ?? EriColors.muted, borderRadius: BorderRadius.circular(EriRadius.pill)),
    child: Text(
      label,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFeatures: tabular, color: textColor),
    ),
  );
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 24, 4, 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, color: EriColors.mutedForeground),
    ),
  );
}

/// Rounded text field used in every form sheet.
InputDecoration field(String label, {String? hint, String? prefix}) => InputDecoration(
  labelText: label,
  hintText: hint,
  prefixText: prefix,
  filled: true,
  fillColor: EriColors.card,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(EriRadius.md),
    borderSide: const BorderSide(color: EriColors.border),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(EriRadius.md),
    borderSide: const BorderSide(color: EriColors.border),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(EriRadius.md),
    borderSide: const BorderSide(color: EriColors.primary, width: 2),
  ),
);

/// Naira field: the vendor types "25000" or "25,000"; the form reads kobo with [readKobo].
TextFormField nairaField(TextEditingController c, String label, {bool required = true}) => TextFormField(
  controller: c,
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
  decoration: field(label, prefix: '₦ '),
  validator: (v) {
    if ((v ?? '').trim().isEmpty) return required ? 'Enter an amount' : null;
    return parseKobo(v!) == null ? 'Like 25,000' : null;
  },
);

int readKobo(TextEditingController c) => parseKobo(c.text) ?? 0;

TextFormField countField(TextEditingController c, String label) => TextFormField(
  controller: c,
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  decoration: field(label),
  validator: (v) => int.tryParse(v ?? '') == null ? 'Enter a number' : null,
);

/// Bottom sheet with Eri's rounded top and room for the keyboard.
Future<T?> showEriSheet<T>(BuildContext context, Widget Function(BuildContext) builder) => showModalBottomSheet<T>(
  context: context,
  isScrollControlled: true,
  backgroundColor: EriColors.background,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(EriRadius.xl))),
  // drawer curve; leaving is quicker than arriving (the vendor already decided)
  sheetAnimationStyle: reduceMotion(context)
      ? AnimationStyle.noAnimation
      : AnimationStyle(
          duration: EriDurations.sheetIn,
          reverseDuration: EriDurations.sheetOut,
          curve: EriCurves.drawer,
          reverseCurve: EriCurves.drawer,
        ),
  builder: (ctx) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
    child: SafeArea(
      child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 20), child: builder(ctx)),
    ),
  ),
);
