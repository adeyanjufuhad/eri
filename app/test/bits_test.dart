import 'package:eri/core/money.dart';
import 'package:eri/theme/bits.dart';
import 'package:eri/theme/motion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child, {bool reduce = false}) => MaterialApp(
  home: MediaQuery(
    data: MediaQueryData(disableAnimations: reduce),
    child: Scaffold(body: Center(child: child)),
  ),
);

const _style = TextStyle(fontSize: 40);

void main() {
  testWidgets('rolling money: one label for screen readers, digits settle on the new amount', (tester) async {
    await tester.pumpWidget(_host(const RollingMoney(kobo: 950000, format: naira, style: _style)));
    expect(find.bySemanticsLabel('₦9,500'), findsOneWidget);

    await tester.pumpWidget(_host(const RollingMoney(kobo: 1200000, format: naira, style: _style)));
    await tester.pump(const Duration(milliseconds: 100));
    // mid-roll: some column is between digits
    final h = tester.getSize(find.byType(ClipRect).first).height;
    final ys = tester.widgetList<Transform>(find.byType(Transform)).map((t) => -t.transform.getTranslation().y / h);
    expect(ys.any((d) => (d - d.round()).abs() > 0.01), isTrue); // a column caught between two digits
    await tester.pump(EriDurations.tick);
    expect(find.bySemanticsLabel('₦12,000'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('spotlight shows under the finger and never blocks taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(
        Spotlight(
          child: SizedBox(
            width: 200,
            height: 100,
            child: TextButton(onPressed: () => taps++, child: const Text('Go')),
          ),
        ),
      ),
    );
    AnimatedOpacity glow() => tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(glow().opacity, 0);
    final g = await tester.startGesture(tester.getCenter(find.text('Go')));
    await tester.pump();
    expect(glow().opacity, 1);
    await g.up();
    await tester.pumpAndSettle();
    expect(glow().opacity, 0);
    expect(taps, 1);
  });

  testWidgets('reveal plays once per session, not when the tab is reopened', (tester) async {
    RevealScope.resetSession();
    Widget list() => const RevealScope(
      id: 'products',
      child: Column(
        children: [
          RevealItem(index: 0, child: Text('a')),
          RevealItem(index: 1, child: Text('b')),
        ],
      ),
    );
    await tester.pumpWidget(_host(list()));
    expect(tester.widget<Opacity>(find.ancestor(of: find.text('a'), matching: find.byType(Opacity))).opacity, 0);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    expect(tester.widget<Opacity>(find.ancestor(of: find.text('b'), matching: find.byType(Opacity))).opacity, 1);

    await tester.pumpWidget(_host(const SizedBox()));
    await tester.pumpWidget(_host(list())); // back to the tab
    expect(tester.widget<Opacity>(find.ancestor(of: find.text('a'), matching: find.byType(Opacity))).opacity, 1);
  });

  testWidgets('stepper: continue, back, finish on the last step', (tester) async {
    await tester.pumpWidget(
      _host(
        SingleChildScrollView(
          child: EriStepper(
            steps: const [
              EriStep(title: 'One', body: Text('first')),
              EriStep(title: 'Two', body: Text('second')),
            ],
            finish: const Text('ALLOW'),
            onSkip: () {},
          ),
        ),
      ),
    );
    expect(find.text('One'), findsOneWidget);
    expect(find.text('ALLOW'), findsNothing);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Two'), findsOneWidget);
    expect(find.text('ALLOW'), findsOneWidget);
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.text('One'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
