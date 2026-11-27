import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eri/core/money.dart';
import 'package:eri/core/time.dart';
import 'package:eri/data/db.dart';
import 'package:eri/features/widgets.dart';
import 'package:eri/matching/expenses.dart';
import 'package:eri/providers.dart';
import 'package:eri/theme/eri_theme.dart';
import 'package:eri/theme/motion.dart';

/// "Tunde says he paid ₦45,000" — waiting, or the warning when the money didn't come.
class ClaimCard extends ConsumerWidget {
  const ClaimCard(this.c, {super.key});
  final PaymentClaim c;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = Theme.of(context).extension<EriVerdicts>()!;
    final claims = ref.read(claimsProvider);
    final events = ref.watch(eventsProvider).value ?? const <BankEvent>[];
    final landed = c.bankEventId == null ? null : events.where((e) => e.id == c.bankEventId).firstOrNull;
    final said = c.amountKobo == null ? 'they paid' : 'they paid ${naira(c.amountKobo!)}';

    final (title, body, color) = switch (c.status) {
      'not_received' => (
        '${c.sender} says $said. No money has arrived.',
        'Nothing from ${c.sender} landed in any of your banks within 10 minutes. Don’t ship yet.',
        v.notReceived,
      ),
      'mismatch' => (
        '${c.sender} said ${c.amountKobo == null ? 'they paid' : naira(c.amountKobo!)}. ${landed == null ? 'A different amount' : naira(landed.amountKobo)} landed.',
        'Check before you ship: the amount doesn’t match what they said.',
        v.suspicious,
      ),
      _ => (
        '${c.sender} says $said.',
        'Waiting for the money until ${clock(c.expiresAt)}. You’ll see it here if it doesn’t come.',
        EriColors.primary,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EriColors.card,
        borderRadius: BorderRadius.circular(EriRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.5), width: c.status == 'pending' ? 1 : 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(c.status == 'pending' ? Icons.hourglass_top_rounded : Icons.warning_rounded, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: c.status == 'pending' ? null : color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(color: EriColors.mutedForeground, height: 1.35)),
          if (c.preview != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: EriColors.muted, borderRadius: BorderRadius.circular(EriRadius.sm)),
              child: Text(
                '${c.app}: “${c.preview}”',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
          CanaryNote(sender: c.sender),
          if (c.status != 'pending')
            Wrap(
              children: [
                TextButton(onPressed: () => claims.markPaid(c.id), child: const Text('It arrived')),
                TextButton(onPressed: () => claims.dismiss(c.id), child: const Text('Dismiss')),
                if (c.status == 'not_received') WarnVendorsButton(sender: c.sender),
              ],
            ),
        ],
      ),
    );
  }
}

/// Settings: chat checks (opt-in) with exactly what it reads.
class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final on = ref.watch(chatChecksProvider).value ?? false;
    final canaryOn = ref.watch(canaryOnProvider).value ?? true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Settings', style: display(22)),
        const SizedBox(height: 16),
        EriCard(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: on,
                onChanged: kIsWeb
                    ? null
                    : (v) async {
                        await ref.read(bridgeProvider).setChatChecks(v);
                        if (v) await ref.read(bridgeProvider).askToNotify(); // so a warning can reach the lock screen
                        ref.invalidate(chatChecksProvider);
                      },
                title: const Text('Check “I’ve paid” messages', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('WhatsApp, WhatsApp Business and Instagram'),
              ),
              const Text(
                'When someone says they paid, Eri waits 10 minutes for the money and warns you if it doesn’t come.\n\n'
                'Eri reads only the message previews in your notifications, on this phone. Messages that aren’t about '
                'paying are ignored and never saved. Saved previews are deleted after 24 hours. Nothing is uploaded.',
                style: TextStyle(color: EriColors.mutedForeground, height: 1.4, fontSize: 13),
              ),
              if (kIsWeb)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Available in the Android app.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        EriCard(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: canaryOn,
                onChanged: (v) async {
                  await ref.read(dbProvider).setSetting('canary', v ? 'on' : 'off');
                  ref.invalidate(canaryOnProvider);
                },
                title: const Text('Scam warnings from other vendors', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Canary network'),
              ),
              const Text(
                'Eri checks a one-way fingerprint of a sender’s name or a receipt against fakes other Eri vendors '
                'caught. Only the fingerprint is sent: never names, numbers, pictures or messages. You choose when '
                'to warn others.',
                style: TextStyle(color: EriColors.mutedForeground, height: 1.4, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Change what a debit was (and Eri remembers it for that recipient).
class ExpenseSheet extends ConsumerWidget {
  const ExpenseSheet(this.e, this.current, {super.key});
  final BankEvent e;
  final ExpenseCategory current;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('${naira(e.amountKobo)} to ${e.counterparty ?? 'someone'}', style: display(20)),
      const SizedBox(height: 4),
      const Text('What was this? Eri will remember for next time.', style: TextStyle(color: EriColors.mutedForeground)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final c in ExpenseCategory.values)
            PressScale(
              child: ChoiceChip(
                label: Text(c.label),
                selected: c == current,
                shape: const StadiumBorder(),
                onSelected: (_) {
                  ref.read(salesProvider).setExpenseCategory(e.id, c);
                  Navigator.pop(context);
                },
              ),
            ),
        ],
      ),
    ],
  );
}

/// "⚠ Flagged by 3 Eri vendors in the last 30 days" — from the Canary network (hashes only). Shows nothing
/// when the count is 0, the switch is off, or there's no network.
class CanaryNote extends ConsumerWidget {
  const CanaryNote({super.key, this.sender, this.imageHash});
  final String? sender;
  final String? imageHash;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(canaryFlagsProvider((sender: sender, imageHash: imageHash))).value ?? 0;
    if (n == 0) return const SizedBox.shrink();
    final v = Theme.of(context).extension<EriVerdicts>()!;
    return EnterOnce(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Pill(
          '⚠ Flagged by $n Eri ${n == 1 ? 'vendor' : 'vendors'} in the last 30 days',
          color: v.notReceived.withValues(alpha: 0.1),
          textColor: v.notReceived,
        ),
      ),
    );
  }
}

/// Deliberate, one tap: sends only hashes (sender name, screenshot) so other vendors get warned.
class WarnVendorsButton extends ConsumerWidget {
  const WarnVendorsButton({super.key, this.sender, this.imageHash});
  final String? sender;
  final String? imageHash;

  @override
  Widget build(BuildContext context, WidgetRef ref) => TextButton.icon(
    icon: const Icon(Icons.campaign_outlined, size: 18),
    label: const Text('Warn other vendors'),
    onPressed: () async {
      final messenger = ScaffoldMessenger.of(context);
      String msg;
      try {
        await (await ref.read(canaryProvider.future)).report(sender: sender, imageHash: imageHash);
        ref.invalidate(canaryFlagsProvider);
        msg = 'Other Eri vendors will be warned. Only a fingerprint was shared, no names or pictures.';
      } catch (_) {
        msg = 'Couldn’t reach the network. Try again when you’re online.';
      }
      messenger.showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
    },
  );
}
