import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:eri/parsing/bank_alert.dart';

/// Dart side of android/.../EriNotificationListener.kt + MainActivity.kt.
/// The listener queues money-looking notifications on the phone; [drain] takes them out of the queue.
/// In the browser preview there is no listener: everything reports "no access, nothing queued".
class NotificationBridge {
  static const _methods = MethodChannel('eri/notifications');
  static const _ping = EventChannel('eri/notifications/ping');

  Future<bool> isPermissionGranted() async {
    if (kIsWeb) return false;
    return await _methods.invokeMethod<bool>('isPermissionGranted').catchError((_) => false) ?? false;
  }

  Future<void> openPermissionSettings() async {
    if (!kIsWeb) await _methods.invokeMethod<void>('openPermissionSettings');
  }

  /// Opt-in "I've paid" checks on WhatsApp / Instagram previews. Stored natively so the listener can read it.
  Future<bool> chatChecks() async {
    if (kIsWeb) return false;
    return await _methods.invokeMethod<bool>('getChatChecks').catchError((_) => false) ?? false;
  }

  Future<void> setChatChecks(bool on) async {
    if (!kIsWeb) await _methods.invokeMethod<void>('setChatChecks', on);
  }

  /// Android 13+ asks "Allow Eri to send notifications?" (once). Called when chat checks are turned on.
  Future<void> askToNotify() async {
    if (!kIsWeb) await _methods.invokeMethod<void>('askToNotify').catchError((_) {});
  }

  /// A system notification for a claim warning; false when notifications are off or unavailable.
  Future<bool> notifyClaim(int id, String title, String body) async {
    if (kIsWeb) return false;
    return await _methods
            .invokeMethod<bool>('notifyClaim', {'id': id, 'title': title, 'body': body})
            .catchError((_) => false) ??
        false;
  }

  /// Fires whenever the listener queues something while the app is open.
  Stream<void> get pings => kIsWeb ? const Stream.empty() : _ping.receiveBroadcastStream().map((_) {});

  Future<List<RawNotification>> drain() async {
    if (kIsWeb) return const [];
    final json = await _methods.invokeMethod<String>('drain') ?? '[]';
    return [
      for (final m in (jsonDecode(json) as List).cast<Map<String, dynamic>>())
        RawNotification(
          package: m['package'] as String,
          title: m['title'] as String? ?? '',
          text: m['text'] as String? ?? '',
          postedAt: DateTime.fromMillisecondsSinceEpoch(m['postedAt'] as int),
        ),
    ];
  }
}
