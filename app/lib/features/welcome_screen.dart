import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

/// Permission onboarding: says exactly what Eri reads and what never leaves the phone, then sends the
/// vendor to Android's Notification access screen. When they come back with access on, it moves on.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  static const _points = [
    (
      Icons.notifications_active_outlined,
      'Reads your bank alerts',
      'GTBank, OPay, Moniepoint, Kuda and bank SMS. Only notifications that mention money.',
    ),
    (
      Icons.phone_android_outlined,
      'The full alert stays on this phone',
      'Eri keeps the amount, sender and note. The alert text itself is deleted after 7 days.',
    ),
    (
      Icons.chat_bubble_outline,
      'Your chats are skipped',
      'WhatsApp and Instagram are ignored. Checking “I’ve paid” messages will be a separate switch you choose.',
    ),
    (Icons.lock_outline, 'No bank login, ever', 'Eri never asks for your bank password or PIN.'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // coming back from Settings with access granted → straight to the dashboard
    ref.listen(permissionProvider, (_, next) {
      if (next.value == true) context.go('/');
    });

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
          children: [
            Text('eri', style: display(28)),
            const SizedBox(height: 28),
            // first run only, so it may take a moment: the headline leads and rises furthest, the promises
            // follow 60ms apart, the button lands last
            EnterOnce(rise: 16, child: Text('Proof, not screenshots.', style: display(36))),
            const SizedBox(height: 12),
            EnterOnce(
              rise: 12,
              delay: const Duration(milliseconds: 60),
              child: Text(
                'Eri logs every real payment the moment your bank alert lands, and tells you when an “I’ve paid” never turned into money.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EriColors.mutedForeground, height: 1.45),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(color: EriColors.card, borderRadius: BorderRadius.circular(EriRadius.lg)),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  for (final (i, (icon, title, body)) in _points.indexed)
                    EnterOnce(
                      delay: Duration(milliseconds: 120 + 60 * i),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: EriColors.primary.withValues(alpha: 0.1),
                          foregroundColor: EriColors.primary,
                          child: Icon(icon, size: 20),
                        ),
                        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(body, style: const TextStyle(color: EriColors.mutedForeground, height: 1.35)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            EnterOnce(
              delay: const Duration(milliseconds: 420),
              child: PressScale(
                child: FilledButton(
                  onPressed: () => ref.read(bridgeProvider).openPermissionSettings(),
                  child: const Text('Allow notification access'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Android will ask you to turn on “Eri bank alerts”. You can turn it off any time.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: EriColors.mutedForeground),
            ),
            const SizedBox(height: 4),
            TextButton(onPressed: () => context.go('/'), child: const Text('Not now')),
          ],
        ),
      ),
    );
  }
}
