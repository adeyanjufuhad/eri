import 'package:eri/core/money.dart';
import 'package:eri/data/db.dart';
import 'package:eri/listener/notification_bridge.dart';

/// What the phone says when an "I've paid" turns out wrong. Plain words, the name first, and the one action
/// that matters: don't send the goods yet. Returns null for statuses that don't need a warning.
({String title, String body})? claimWarning(PaymentClaim c) {
  final amount = c.amountKobo == null ? '' : ' ${naira(c.amountKobo!)}';
  return switch (c.status) {
    'not_received' => (
      title: 'No money from ${c.sender} yet',
      body: 'They said they paid$amount on ${c.app}. Nothing has arrived in your bank. Don’t send the goods yet.',
    ),
    'mismatch' => (
      title: 'Different amount from ${c.sender}',
      body: 'They said they paid$amount on ${c.app}, but a different amount arrived. Check before you send the goods.',
    ),
    _ => null,
  };
}

/// Posts the warning as an Android notification, only while the vendor still has "I've paid" checks on.
Future<void> warnOnPhone(NotificationBridge bridge, PaymentClaim c) async {
  final w = claimWarning(c);
  if (w == null || !await bridge.chatChecks()) return;
  await bridge.notifyClaim(c.id, w.title, w.body);
}
