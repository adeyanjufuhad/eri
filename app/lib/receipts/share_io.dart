import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const _channel = MethodChannel('eri/notifications');

/// "Share → Eri" on a screenshot: MainActivity copies the image into the app's cache and hands over the path,
/// once. Checked at start and whenever the app comes back to the front. Returns a cancel function.
void Function() listenForSharedImages(void Function(String path) onImage) {
  Future<void> take() async {
    try {
      final path = await _channel.invokeMethod<String>('takeSharedImage');
      if (path != null) onImage(path);
    } catch (_) {
      // not on Android
    }
  }

  take();
  final life = AppLifecycleListener(onResume: take);
  return life.dispose;
}
