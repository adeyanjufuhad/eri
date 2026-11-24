import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/bits.dart';
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

    final muted = Theme.of(context).textTheme.bodyLarge?.copyWith(color: EriColors.mutedForeground, height: 1.45);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          children: [
            Text('eri', style: display(28)),
            const SizedBox(height: 28),
            // first run only: three short steps (React Bits Stepper), the connector fills as the vendor goes
            EnterOnce(
              rise: 12,
              child: EriStepper(
                onSkip: () => context.go('/'),
                steps: [
                  EriStep(
                    title: 'Proof, not screenshots.',
                    body: Text(
                      'Eri logs every real payment the moment your bank alert lands, and tells you when an “I’ve paid” never turned into money.',
                      style: muted,
                    ),
                  ),
                  EriStep(
                    title: 'What Eri reads, and what it never does',
                    body: Container(
                      decoration: BoxDecoration(
                        color: EriColors.card,
                        borderRadius: BorderRadius.circular(EriRadius.lg),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          for (final (icon, title, body) in _points)
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: EriColors.primary.withValues(alpha: 0.1),
                                foregroundColor: EriColors.primary,
                                child: Icon(icon, size: 20),
                              ),
                              title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  body,
                                  style: const TextStyle(color: EriColors.mutedForeground, height: 1.35),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  EriStep(
                    title: 'Turn on bank alerts',
                    body: Text(
                      'Android will ask you to turn on “Eri bank alerts”. You can turn it off any time, and Eri never asks for your bank login.',
                      style: muted,
                    ),
                  ),
                ],
                finish: PressScale(
                  child: FilledButton(
                    onPressed: () => ref.read(bridgeProvider).openPermissionSettings(),
                    child: const Text('Allow notification access'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
