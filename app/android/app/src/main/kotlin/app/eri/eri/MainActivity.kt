package app.eri.eri

import android.content.Intent
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** Bridges the notification listener to Dart: lib/listener/notification_bridge.dart is the other side. */
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, "eri/notifications").setMethodCallHandler { call, result ->
            when (call.method) {
                "isPermissionGranted" -> result.success(
                    NotificationManagerCompat.getEnabledListenerPackages(this).contains(packageName)
                )
                "openPermissionSettings" -> {
                    startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
                    result.success(null)
                }
                "drain" -> result.success(EriNotificationListener.drain(filesDir))
                else -> result.notImplemented()
            }
        }

        EventChannel(messenger, "eri/notifications/ping").setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                EriNotificationListener.sink = events
            }

            override fun onCancel(arguments: Any?) {
                EriNotificationListener.sink = null
            }
        })
    }
}
