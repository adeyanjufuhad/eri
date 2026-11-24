package app.eri.eri

import android.content.Intent
import android.net.Uri
import android.os.Build
import java.io.File
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** Bridges the notification listener to Dart: lib/listener/notification_bridge.dart is the other side. */
class MainActivity : FlutterActivity() {
    private var sharedImage: String? = null

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        takeShare(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        takeShare(intent)
    }

    /** Copies a shared image into the app's cache (the source URI's permission doesn't last). Stays on the phone. */
    private fun takeShare(i: Intent?) {
        if (i?.action != Intent.ACTION_SEND || i.type?.startsWith("image/") != true) return
        val uri: Uri = (if (Build.VERSION.SDK_INT >= 33) i.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
        else @Suppress("DEPRECATION") i.getParcelableExtra(Intent.EXTRA_STREAM)) ?: return
        runCatching {
            val out = File(cacheDir, "shared_receipt_${System.currentTimeMillis()}.img")
            contentResolver.openInputStream(uri)?.use { input -> out.outputStream().use { input.copyTo(it) } }
            sharedImage = out.absolutePath
        }
    }

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
                // "Share -> Eri" on a receipt screenshot: the copy's path, once (lib/receipts/share_io.dart)
                "takeSharedImage" -> {
                    result.success(sharedImage)
                    sharedImage = null
                }
                "getChatChecks" -> result.success(EriNotificationListener.chatChecksOn(this))
                "setChatChecks" -> {
                    EriNotificationListener.setChatChecks(this, call.arguments as Boolean)
                    result.success(null)
                }
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
