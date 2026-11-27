import 'package:eri/features/books_screen.dart';
import 'package:eri/matching/expenses.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'pnl_test.dart' as data;

void main() {
  setUpAll(() => eriGoogleFonts = false);

  testWidgets('Books: today and this week, with expense lines and the day-by-day bars', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pnlSourceProvider.overrideWithValue((
            orders: [
              data.order(1, 'paid', DateTime(2026, 11, 27, 10), fee: 150000),
              data.order(2, 'paid', DateTime(2026, 11, 24, 12)),
            ],
            items: [data.item(1, 10, 2, 2500000, 1750000), data.item(2, 10, 1, 2500000, 1750000)],
            events: [data.debit(100, 415000, DateTime(2026, 11, 27, 11))],
            cats: {100: ExpenseCategory.dispatch},
          )),
        ],
        child: MaterialApp(
          theme: eriTheme(),
          home: BooksScreen(now: data.fri),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Net profit · Fri 27 Nov'), findsOneWidget);
    expect(find.text('₦50,000'), findsOneWidget); // sales
    expect(find.text('−₦35,000'), findsOneWidget); // cost of goods
    expect(find.text('Dispatch'), findsOneWidget);
    // 15,000 gross + 1,500 delivery − 4,150 dispatch
    expect(find.text('₦12,350'), findsNWidgets(2)); // headline and the Net line
    expect(find.text('Day by day'), findsNothing);

    await tester.tap(find.text('This week'));
    await tester.pumpAndSettle();
    expect(find.text('Net profit · Mon 23 Nov – Sun 29 Nov'), findsOneWidget);
    expect(find.text('₦19,850'), findsNWidgets(2)); // + Tuesday's ₦7,500
    expect(find.text('Day by day'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Sun'), 120);
    final labels = tester
        .widgetList<Semantics>(find.byType(Semantics))
        .map((w) => w.properties.label)
        .whereType<String>()
        .where((l) => l.contains(': net'))
        .toList();
    expect(labels, hasLength(7));
    expect(labels[1], 'Tue: net ₦7,500');
    expect(tester.takeException(), isNull);
  });
}
