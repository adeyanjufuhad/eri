// Flutter rebuilds of four React Bits components (reactbits.dev, MIT), adapted to Eri's motion rules:
// strong ease-out, nothing replays on a screen opened twenty times a day, reduced motion respected.
//
//   Counter        → RollingMoney   (digits roll like an odometer when money lands)
//   Spotlight Card → Spotlight      (a soft glow follows the finger while pressing)
//   Animated List  → RevealScope / RevealItem (items scale + fade in, once per app session)
//   Stepper        → EriStepper     (numbered steps, filling connector, sliding content)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

// ─── Counter → RollingMoney ──────────────────────────────────────────────────────────────────────────────

/// The amount as rolling digit columns: when money lands, each place rolls to its new digit.
/// Places are keyed from the right, so ₦9,500 → ₦12,000 keeps the units column still and adds a new one.
/// Screen readers get the whole amount as one label.
class RollingMoney extends StatelessWidget {
  const RollingMoney({super.key, required this.kobo, required this.format, required this.style});
  final int kobo;
  final String Function(int kobo) format;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final text = format(kobo);
    final s = style.copyWith(fontFeatures: tabular, height: 1);
    final tp = TextPainter(
      text: TextSpan(text: '0', style: s),
      textDirection: TextDirection.ltr,
    )..layout();
    final h = tp.height, w = tp.width;
    final duration = reduceMotion(context) ? Duration.zero : EriDurations.tick;
    final chars = text.characters.toList();
    var place = 0;
    final cells = <Widget>[];
    for (var i = chars.length - 1; i >= 0; i--) {
      final c = chars[i];
      final d = int.tryParse(c);
      if (d == null) {
        cells.add(Text(c, style: s));
      } else {
        cells.add(_DigitColumn(key: ValueKey('p$place'), digit: d, width: w, height: h, style: s, duration: duration));
        place++;
      }
    }
    // a big day (₦1,250,000) on a small phone scales down instead of overflowing the card
    return Semantics(
      label: text,
      excludeSemantics: true,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(mainAxisSize: MainAxisSize.min, children: cells.reversed.toList()),
      ),
    );
  }
}

class _DigitColumn extends StatelessWidget {
  const _DigitColumn({
    super.key,
    required this.digit,
    required this.width,
    required this.height,
    required this.style,
    required this.duration,
  });
  final int digit;
  final double width, height;
  final TextStyle style;
  final Duration duration;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: ClipRect(
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: digit.toDouble()),
        duration: duration,
        curve: EriCurves.out,
        builder: (_, v, child) => Transform.translate(offset: Offset(0, -v * height), child: child),
        child: OverflowBox(
          alignment: Alignment.topCenter,
          minWidth: width,
          maxWidth: width,
          minHeight: 0,
          maxHeight: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var n = 0; n < 10; n++)
                SizedBox(
                  height: height,
                  child: Text('$n', style: style),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── Spotlight Card → Spotlight ──────────────────────────────────────────────────────────────────────────

/// While a finger is down, a soft radial glow sits under it and follows it; it fades on release.
/// It answers the touch (never plays on its own), so it's fine on surfaces used all day. Doesn't take taps:
/// the child's own buttons and InkWells still work.
class Spotlight extends StatefulWidget {
  const Spotlight({super.key, required this.child, this.color, this.radius = EriRadius.lg, this.size = 220});
  final Widget child;
  final Color? color;
  final double radius;
  final double size;

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  Offset _at = Offset.zero;
  bool _on = false;

  void _move(PointerEvent e) => setState(() {
    _at = e.localPosition;
    _on = true;
  });

  void _off(PointerEvent _) => setState(() => _on = false);

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? EriColors.primary.withValues(alpha: 0.10);
    return Listener(
      onPointerDown: _move,
      onPointerMove: _move,
      onPointerUp: _off,
      onPointerCancel: _off,
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                child: AnimatedOpacity(
                  opacity: _on ? 1 : 0,
                  // appears with the touch, lingers a beat after: the light "follows" rather than blinks
                  duration: _on ? const Duration(milliseconds: 120) : const Duration(milliseconds: 260),
                  curve: EriCurves.out,
                  child: CustomPaint(painter: _GlowPainter(_at, color, widget.size)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter(this.at, this.color, this.size);
  final Offset at;
  final Color color;
  final double size;

  @override
  void paint(Canvas canvas, Size s) {
    final shader = RadialGradient(
      colors: [color, color.withValues(alpha: 0)],
    ).createShader(Rect.fromCircle(center: at, radius: size / 2));
    canvas.drawRect(Offset.zero & s, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.at != at || old.color != color || old.size != size;
}

// ─── Animated List → RevealScope / RevealItem ────────────────────────────────────────────────────────────

/// Wrap a list: its items scale up from 0.94 and fade in, 40ms apart, the FIRST time this list is shown in
/// this app session. Switching back to the tab later shows it at rest (no replayed entrance).
class RevealScope extends StatefulWidget {
  const RevealScope({super.key, required this.id, required this.child});
  final String id;
  final Widget child;

  static final _seen = <String>{};

  @visibleForTesting
  static void resetSession() => _seen.clear();

  @override
  State<RevealScope> createState() => _RevealScopeState();
}

class _RevealScopeState extends State<RevealScope> {
  late final bool _animate = RevealScope._seen.add(widget.id);

  @override
  Widget build(BuildContext context) => _Reveal(animate: _animate, child: widget.child);
}

class _Reveal extends InheritedWidget {
  const _Reveal({required this.animate, required super.child});
  final bool animate;

  @override
  bool updateShouldNotify(_Reveal old) => old.animate != animate;
}

class RevealItem extends StatefulWidget {
  const RevealItem({super.key, required this.index, required this.child});
  final int index;
  final Widget child;

  @override
  State<RevealItem> createState() => _RevealItemState();
}

class _RevealItemState extends State<RevealItem> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: EriDurations.enter);
  late final Animation<double> _t = CurvedAnimation(parent: _c, curve: EriCurves.out);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    final animate = context.dependOnInheritedWidgetOfExactType<_Reveal>()?.animate ?? false;
    // cap the stagger: item 12 shouldn't wait half a second to appear
    final delay = Duration(milliseconds: 40 * widget.index.clamp(0, 6));
    if (!animate) {
      _c.value = 1;
    } else {
      Future<void>.delayed(delay, () => mounted ? _c.forward() : null);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = reduceMotion(context);
    return AnimatedBuilder(
      animation: _t,
      child: widget.child,
      builder: (_, child) => Opacity(
        opacity: _t.value,
        child: reduce ? child : Transform.scale(scale: 0.94 + 0.06 * _t.value, child: child),
      ),
    );
  }
}

// ─── Stepper → EriStepper ────────────────────────────────────────────────────────────────────────────────

class EriStep {
  const EriStep({required this.title, required this.body});
  final String title;
  final Widget body;
}

/// Numbered steps: the connector fills as you advance, content slides in from the side you're heading to,
/// and the height eases to fit. The last step's buttons come from [finish]; [onSkip] is the quiet way out.
class EriStepper extends StatefulWidget {
  const EriStepper({super.key, required this.steps, required this.finish, this.onSkip});
  final List<EriStep> steps;
  final Widget finish;
  final VoidCallback? onSkip;

  @override
  State<EriStepper> createState() => _EriStepperState();
}

class _EriStepperState extends State<EriStepper> {
  int _i = 0;
  int _dir = 1;

  void _go(int to) {
    if (to < 0 || to >= widget.steps.length) return;
    HapticFeedback.selectionClick();
    setState(() {
      _dir = to > _i ? 1 : -1;
      _i = to;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduce = reduceMotion(context);
    final last = _i == widget.steps.length - 1;
    final step = widget.steps[_i];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (var n = 0; n < widget.steps.length; n++) ...[
              if (n > 0)
                Expanded(
                  child: _Connector(filled: n <= _i, reduce: reduce),
                ),
              _Dot(n: n, current: _i, onTap: n < _i ? () => _go(n) : null),
            ],
          ],
        ),
        const SizedBox(height: 24),
        AnimatedSize(
          duration: reduce ? Duration.zero : EriDurations.enter,
          curve: EriCurves.out,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: reduce ? Duration.zero : EriDurations.enter,
            switchInCurve: EriCurves.out,
            switchOutCurve: EriCurves.out,
            layoutBuilder: (cur, prev) => Stack(alignment: Alignment.topLeft, children: [...prev, ?cur]),
            transitionBuilder: (child, a) {
              final incoming = child.key == ValueKey(_i);
              final dx = (incoming ? 0.08 : -0.08) * _dir;
              return FadeTransition(
                opacity: a,
                child: reduce
                    ? child
                    : SlideTransition(
                        position: Tween(begin: Offset(dx, 0), end: Offset.zero).animate(a),
                        child: child,
                      ),
              );
            },
            child: Column(
              key: ValueKey(_i),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.title, style: display(26)),
                const SizedBox(height: 14),
                step.body,
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        if (last)
          widget.finish
        else
          PressScale(
            child: FilledButton(onPressed: () => _go(_i + 1), child: const Text('Continue')),
          ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              opacity: _i > 0 ? 1 : 0,
              duration: reduce ? Duration.zero : EriDurations.swap,
              child: TextButton(onPressed: _i > 0 ? () => _go(_i - 1) : null, child: const Text('Back')),
            ),
            if (widget.onSkip != null) TextButton(onPressed: widget.onSkip, child: const Text('Not now')),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.n, required this.current, this.onTap});
  final int n, current;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final done = n < current, active = n == current;
    return Semantics(
      label:
          'Step ${n + 1}${done
              ? ', done'
              : active
              ? ', current'
              : ''}',
      button: onTap != null,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: reduceMotion(context) ? Duration.zero : EriDurations.swap,
          curve: EriCurves.out,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done || active ? EriColors.primary : EriColors.card,
            border: Border.all(color: done || active ? EriColors.primary : EriColors.border, width: 1.5),
          ),
          alignment: Alignment.center,
          child: done
              ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
              : Text(
                  '${n + 1}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : EriColors.mutedForeground,
                  ),
                ),
        ),
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector({required this.filled, required this.reduce});
  final bool filled, reduce;

  @override
  Widget build(BuildContext context) => Container(
    height: 2,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    color: EriColors.border,
    alignment: Alignment.centerLeft,
    child: TweenAnimationBuilder<double>(
      tween: Tween(end: filled ? 1 : 0),
      duration: reduce ? Duration.zero : EriDurations.enter,
      curve: EriCurves.out,
      // scaleX, not width: transform only
      builder: (_, v, child) => Transform.scale(scaleX: v, alignment: Alignment.centerLeft, child: child),
      child: Container(color: EriColors.primary),
    ),
  );
}
