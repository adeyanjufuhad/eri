import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/features/debug_feed_screen.dart';
import 'package:eri/features/home_screen.dart';
import 'package:eri/features/orders_screen.dart';
import 'package:eri/features/products_screen.dart';
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
          StatefulShellBranch(routes: [GoRoute(path: '/', builder: (_, _) => const HomeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/products', builder: (_, _) => const ProductsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/orders', builder: (_, _) => const OrdersScreen())]),
        ],
      ),
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
      GoRoute(path: '/debug', builder: (_, _) => const DebugFeedScreen()),
    ],
  );
  late final AppLifecycleListener _life;
  StreamSubscription<void>? _pings;

  @override
  void initState() {
    super.initState();
    final db = ref.read(dbProvider);
    db.purgeOldRaw();
    _drain();
    // alerts that arrive while Eri is open
    _pings = ref.read(bridgeProvider).pings.listen((_) => _drain());
    // alerts that arrived while it was closed, and permission granted in Settings
    _life = AppLifecycleListener(onResume: () {
      ref.invalidate(permissionProvider);
      _drain();
    });
  }

  Future<void> _drain() async {
    try {
      final items = await ref.read(bridgeProvider).drain();
      if (items.isNotEmpty) await ingest(ref.read(dbProvider), items, sales: ref.read(salesProvider));
    } catch (e) {
      debugPrint('eri: drain failed: $e'); // e.g. not on Android; the queue keeps the items for next time
    }
  }

  @override
  void dispose() {
    _pings?.cancel();
    _life.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Eri',
        debugShowCheckedModeBanner: false,
        theme: eriTheme(),
        routerConfig: _router,
      );
}

class _Tabs extends StatelessWidget {
  const _Tabs(this.shell);
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: shell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.today_outlined), selectedIcon: Icon(Icons.today), label: 'Today'),
            NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Products'),
            NavigationDestination(icon: Icon(Icons.receipt_outlined), selectedIcon: Icon(Icons.receipt), label: 'Orders'),
          ],
        ),
      );
}
