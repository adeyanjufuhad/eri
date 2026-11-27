import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/features/debug_feed_screen.dart';
import 'package:eri/features/books_screen.dart';
import 'package:eri/features/home_screen.dart';
import 'package:eri/features/orders_screen.dart';
import 'package:eri/features/products_screen.dart';
import 'package:eri/features/receipt_screen.dart';
import 'package:eri/features/tab_bar.dart';
import 'package:eri/receipts/share.dart';
import 'package:eri/features/welcome_screen.dart';
import 'package:eri/listener/ingest.dart';
import 'package:eri/listener/notification_bridge.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final granted = await NotificationBridge().isPermissionGranted();
  runApp(ProviderScope(child: EriApp(startAt: granted ? '/' : '/welcome')));
}

class EriApp extends ConsumerStatefulWidget {
  const EriApp({super.key, required this.startAt});
  final String startAt;

  @override
  ConsumerState<EriApp> createState() => _EriAppState();
}

class _EriAppState extends ConsumerState<EriApp> {
  late final GoRouter _router = GoRouter(
    initialLocation: widget.startAt,
    routes: [
      // three tabs, each keeping its own scroll position
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => _Tabs(shell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/', builder: (_, _) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/products', builder: (_, _) => const ProductsScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/orders', builder: (_, _) => const OrdersScreen())],
          ),
        ],
      ),
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
      GoRoute(path: '/debug', builder: (_, _) => const DebugFeedScreen()),
      GoRoute(path: '/books', builder: (_, _) => const BooksScreen()),
      GoRoute(
        path: '/receipt',
        builder: (_, state) => ReceiptScreen(sharedPath: state.extra as String?),
      ),
    ],
  );
  late final AppLifecycleListener _life;
  StreamSubscription<void>? _pings;
  Timer? _claimTick;
  void Function()? _stopShares;

  @override
  void initState() {
    super.initState();
    final db = ref.read(dbProvider);
    db.purgeOldRaw();
    _drain();
    // alerts that arrive while Eri is open
    _pings = ref.read(bridgeProvider).pings.listen((_) => _drain());
    // "I've paid" claims run out after 10 minutes even if no new alert arrives
    _claimTick = Timer.periodic(const Duration(seconds: 30), (_) => ref.read(claimsProvider).resolve());
    // "Share → Eri" on a receipt screenshot
    _stopShares = ref.read(sharedImagesProvider)((path) => _router.push('/receipt', extra: path));
    // alerts that arrived while it was closed, and permission granted in Settings
    _life = AppLifecycleListener(
      onResume: () {
        ref.invalidate(permissionProvider);
        _drain();
        ref.read(claimsProvider).resolve();
      },
    );
  }

  Future<void> _drain() async {
    try {
      final items = await ref.read(bridgeProvider).drain();
      if (items.isNotEmpty) {
        await ingest(ref.read(dbProvider), items, sales: ref.read(salesProvider), claims: ref.read(claimsProvider));
      }
    } catch (e) {
      debugPrint('eri: drain failed: $e'); // e.g. not on Android; the queue keeps the items for next time
    }
  }

  @override
  void dispose() {
    _pings?.cancel();
    _claimTick?.cancel();
    _stopShares?.call();
    _life.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      MaterialApp.router(title: 'Eri', debugShowCheckedModeBanner: false, theme: eriTheme(), routerConfig: _router);
}

class _Tabs extends StatelessWidget {
  const _Tabs(this.shell);
  final StatefulNavigationShell shell;

  static const _tabs = [
    EriTab(Icons.today_outlined, Icons.today_rounded, 'Today'),
    EriTab(Icons.inventory_2_outlined, Icons.inventory_2_rounded, 'Products'),
    EriTab(Icons.receipt_outlined, Icons.receipt_rounded, 'Orders'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    // screens end above the bar (so add buttons and snackbars are never hidden behind it); the bar
    // floats on the same background with its own margins
    body: shell,
    bottomNavigationBar: EriTabBar(
      tabs: _tabs,
      index: shell.currentIndex,
      onTap: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
    ),
  );
}
