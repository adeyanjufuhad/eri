import 'package:eri/core/money.dart';
import 'package:eri/theme/motion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child, {bool reduce = false}) => MediaQuery(
      data: MediaQueryData(disableAnimations: reduce),
      child: Directionality(textDirection: TextDirection.ltr, child: Center(child: child)),
    );

void main() {
  testWidgets('money counts up to the new amount with ease-out', (tester) async {
    await tester.pumpWidget(_host(const MoneyTicker(kobo: 0, format: naira)));
    await tester.pumpWidget(_host(const MoneyTicker(kobo: 2500000, format: naira)));
    await tester.pump(const Duration(milliseconds: 100));
    final mid = tester.widget<Text>(find.byType(Text)).data!;
    expect(mid, isNot('₦0'));
    expect(mid, isNot('₦25,000')); // still counting
    await tester.pump(EriDurations.tick);
    expect(find.text('₦25,000'), findsOneWidget);
  });

  testWidgets('reduced motion: the amount jumps straight there, enter has no movement', (tester) async {
    await tester.pumpWidget(_host(const MoneyTicker(kobo: 0, format: naira), reduce: true));
    await tester.pumpWidget(_host(const MoneyTicker(kobo: 2500000, format: naira), reduce: true));
    await tester.pump();
    expect(find.text('₦25,000'), findsOneWidget);

    await tester.pumpWidget(_host(const EnterOnce(child: Text('new alert')), reduce: true));
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byType(Transform), findsNothing); // fade only
    await tester.pump(EriDurations.enter);
  });

  testWidgets('press feedback shrinks to 0.97, never further', (tester) async {
    await tester.pumpWidget(_host(const PressScale(child: SizedBox(width: 100, height: 40, child: Text('Pay')))));
    final g = await tester.startGesture(tester.getCenter(find.text('Pay')));
    await tester.pump(EriDurations.press);
    expect(tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale, 0.97);
    await g.up();
    await tester.pump(EriDurations.press);
    expect(tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale, 1);
  });

  testWidgets('enter finishes fully visible, with and without a delay', (tester) async {
    await tester.pumpWidget(_host(const Column(children: [
      EnterOnce(child: Text('a')),
      EnterOnce(delay: Duration(milliseconds: 120), child: Text('b')),
    ])));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));
    for (final o in tester.widgetList<Opacity>(find.byType(Opacity))) {
      expect(o.opacity, 1);
    }
  });
}
