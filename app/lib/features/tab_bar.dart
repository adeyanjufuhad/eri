import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

class EriTab {
  const EriTab(this.icon, this.activeIcon, this.label);
  final IconData icon, activeIcon;
  final String label;
}

/// A dark pill that floats above the content (Round 4 references A5/A6). The white highlight slides to the
/// selected tab: transform only, 180ms strong ease-out, no bounce — vendors switch tabs dozens of times a day,
/// so it must feel instant, never playful. Content swaps immediately; only the highlight moves.
class EriTabBar extends StatelessWidget {
  const EriTabBar({super.key, required this.tabs, required this.index, required this.onTap});
  final List<EriTab> tabs;
  final int index;
  final ValueChanged<int> onTap;

  static const height = 64.0;

  @override
  Widget build(BuildContext context) {
    final reduce = reduceMotion(context);
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: EriColors.foreground,
            borderRadius: BorderRadius.circular(EriRadius.pill),
            boxShadow: const [
              BoxShadow(color: Color(0x400F141D), blurRadius: 32, offset: Offset(0, 14), spreadRadius: -12),
            ],
          ),
          child: LayoutBuilder(
            builder: (_, c) {
              final w = c.maxWidth / tabs.length;
              return Stack(
                children: [
                  // the highlight: one object that slides, so the eye follows it from tab to tab
                  // transform only (never `left`), and an implicit tween so a quick second tap retargets mid-slide
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: w,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(end: w * index),
                      duration: reduce ? Duration.zero : const Duration(milliseconds: 180),
                      curve: EriCurves.out,
                      builder: (_, x, child) => Transform.translate(offset: Offset(x, 0), child: child),
                      child: Container(
                        decoration: BoxDecoration(
                          color: EriColors.card,
                          borderRadius: BorderRadius.circular(EriRadius.pill),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (final (i, t) in tabs.indexed)
                        Expanded(
                          child: _TabButton(tab: t, selected: i == index, onTap: () => onTap(i)),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.tab, required this.selected, required this.onTap});
  final EriTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? EriColors.foreground : Colors.white.withValues(alpha: 0.72);
    return Semantics(
      selected: selected,
      button: true,
      label: tab.label,
      child: PressScale(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (!selected) HapticFeedback.selectionClick();
            onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(selected ? tab.activeIcon : tab.icon, color: color, size: 20),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  tab.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
