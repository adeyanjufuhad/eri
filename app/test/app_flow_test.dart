import 'package:drift/native.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/listener/notification_bridge.dart';
import 'package:eri/main.dart';
import 'package:eri/matching/sales.dart';
import 'package:eri/parsing/bank_alert.dart' as p;
import 'package:eri/providers.dart';
import 'package:eri/receipts/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eri/theme/eri_theme.dart';

/// No Android in tests: no listener, nothing queued, access granted.
class _FakeBridge extends NotificationBridge {
  @override
  Future<bool> isPermissionGranted() async => true;
  @override
  Future<List<p.RawNotification>> drain() async => const [];
  @override
  Stream<void> get pings => const Stream.empty();
}

void main() {
  setUpAll(() => eriGoogleFonts = false);

  testWidgets(
    'Day 2 exit check through the real screens: add a product, money lands, Today says Sold',
    (tester) async {
      final db = EriDb(NativeDatabase.memory());
      // drift's streams run on real async: let them deliver, then draw (pumpAndSettle would wait forever)
      Future<void> settle() async {
        for (var i = 0; i < 8; i++) {
          await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
          await tester.pump(const Duration(milliseconds: 150));
        }
      }

      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dbProvider.overrideWithValue(db),
            bridgeProvider.overrideWithValue(_FakeBridge()),
            sharedImagesProvider.overrideWithValue((_) => () {}),
          ],
          child: const EriApp(startAt: '/products'),
        ),
      );
      await settle();

      // 1. Products → Add product → Ankara Gown, ₦25,000, 4 at ₦17,500
      await tester.tap(find.widgetWithText(FloatingActionButton, 'Add product'));
      await settle();
      await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'Ankara Gown');
      await tester.enterText(find.widgetWithText(TextFormField, 'Other words buyers use'), 'gown');
      await tester.enterText(find.widgetWithText(TextFormField, 'Selling price'), '25,000');
      await tester.enterText(find.widgetWithText(TextFormField, 'How many you have'), '4');
      await tester.enterText(find.widgetWithText(TextFormField, 'Cost each'), '17500');
      await tester.tap(find.widgetWithText(FilledButton, 'Add product'));
      await settle();
      expect(find.text('4 left'), findsOneWidget);

      // 2. the bank alert lands (as the listener would hand it over)
      // started in the test zone and driven by settle(): the screen's drift streams share the same queue
      final landing = ingest(db, sales: Sales(db), [
        p.RawNotification(
          package: 'com.google.android.apps.messaging',
          title: 'GTBank',
          text: 'GTBank: Acct 01******89 Cr NGN25,000.00 from CHIOMA OKAFOR Desc: ankara gown Avail Bal: NGN412,300.00',
          postedAt: DateTime.now(),
        ),
      ]);
      await settle();
      await tester.runAsync(() => landing);
      await settle();
      expect(find.text('3 left'), findsOneWidget); // stock dropped on the Products screen

      // 3. Today: zero taps, the sale is logged with its profit
      await tester.tap(find.text('Today'));
      await settle();
      expect(find.textContaining('Sold: Ankara Gown · +₦7,500 · 3 left'), findsOneWidget);
      expect(find.text('Profit ₦7,500'), findsOneWidget);
      expect(find.text('1 sale'), findsOneWidget);
      expect(find.textContaining('Needs you'), findsNothing);

      // unmount (cancels the drift streams), then close the database on real async
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1)); // drift closes its streams on a timer
      await tester.runAsync(db.close);
    },
    timeout: const Timeout(Duration(seconds: 90)),
  );
}
