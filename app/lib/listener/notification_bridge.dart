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
