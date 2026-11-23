import 'package:flutter/material.dart';

// Motion tokens: the same curves as the landing page (web/app/globals.css --ease-out / --ease-in-out), from the
// animate skill. One family for the whole product. Rules (Emil Kowalski, .claude/skills/animate):
//  - animate only what explains something: feedback, a state change, money arriving, a sheet opening
//  - never animate what vendors do dozens of times a day (tab switches, +/- steppers, typing)
//  - ease-out for things entering, never ease-in; UI stays under 300ms (sheets are the exception)
//  - transform + opacity only; never from scale 0
//  - reduced motion keeps the fades and drops the movement

abstract final class EriCurves {
  /// Strong ease-out: anything appearing, press feedback.
  static const out = Cubic(0.23, 1, 0.32, 1);

  /// Strong ease-in-out: things moving on screen.
  static const inOut = Cubic(0.77, 0, 0.175, 1);

  /// iOS-like sheet curve (Ionic).
  static const drawer = Cubic(0.32, 0.72, 0, 1);
}

abstract final class EriDurations {
  static const press = Duration(milliseconds: 120);
  static const swap = Duration(milliseconds: 180); // crossfades, status changes
  static const enter = Duration(milliseconds: 240); // a new alert, a card appearing
  static const sheetIn = Duration(milliseconds: 320);
  static const sheetOut = Duration(milliseconds: 200); // leaving is faster than arriving
  static const tick = Duration(milliseconds: 450); // the money counter: rare, explanatory
}

/// True when the system asks for less motion (Android "Remove animations").
bool reduceMotion(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

/// Press feedback: shrinks to 0.97 while held, so a tap feels heard. With reduced motion it dims instead.
class PressScale extends StatefulWidget {
  const PressScale({super.key, required this.child, this.enabled = true});
  final Widget child;
  final bool enabled;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _down = false;

  void _set(bool v) {
    if (widget.enabled && v != _down) setState(() => _down = v);
  }

  @override
  Widget build(BuildContext context) {
    final reduce = reduceMotion(context);
    final pressed = _down && widget.enabled;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: reduce
          ? AnimatedOpacity(
              opacity: pressed ? 0.8 : 1,
              duration: EriDurations.press,
              curve: EriCurves.out,
              child: widget.child,
            )
          : AnimatedScale(
              scale: pressed ? 0.97 : 1,
              duration: EriDurations.press,
              curve: EriCurves.out,
              child: widget.child,
            ),
    );
  }
}

/// Fades in and rises 8px, once, when [animate] is true (e.g. an alert that just landed). Everything else
/// renders at rest: a screen the vendor opens twenty times a day shouldn't replay its entrance.
class EnterOnce extends StatefulWidget {
  const EnterOnce({super.key, required this.child, this.animate = true, this.delay = Duration.zero, this.rise = 8});
  final Widget child;
  final bool animate;
  final Duration delay;
  final double rise;

  @override
  State<EnterOnce> createState() => _EnterOnceState();
}

class _EnterOnceState extends State<EnterOnce> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: EriDurations.enter,
    value: widget.animate ? 0 : 1,
  );
  late final Animation<double> _t = CurvedAnimation(parent: _c, curve: EriCurves.out);

  @override
  void initState() {
    super.initState();
    if (widget.animate) Future<void>.delayed(widget.delay, () => mounted ? _c.forward() : null);
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
        child: reduce ? child : Transform.translate(offset: Offset(0, widget.rise * (1 - _t.value)), child: child),
      ),
    );
  }
}

/// True for something that happened in the last few seconds: worth announcing with motion.
bool justNow(DateTime t) => DateTime.now().difference(t).inSeconds.abs() < 20;

/// Counts from the old amount to the new one when money lands; retargets smoothly if more arrives mid-count.
/// [format] turns kobo into text (naira() at the UI edge).
class MoneyTicker extends StatelessWidget {
  const MoneyTicker({super.key, required this.kobo, required this.format, this.style});
  final int kobo;
  final String Function(int kobo) format;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: kobo.toDouble()),
    duration: reduceMotion(context) ? Duration.zero : EriDurations.tick,
    curve: EriCurves.out,
    builder: (_, v, _) => Text(format(v.round()), style: style),
  );
}

/// Crossfade for a value that changes in place (a status line, a stock count): the old one doesn't linger.
class Swap extends StatelessWidget {
  const Swap({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: reduceMotion(context) ? Duration.zero : EriDurations.swap,
    switchInCurve: EriCurves.out,
    switchOutCurve: EriCurves.out,
    layoutBuilder: (current, previous) => Stack(alignment: Alignment.centerLeft, children: [...previous, ?current]),
    child: child,
  );
}
