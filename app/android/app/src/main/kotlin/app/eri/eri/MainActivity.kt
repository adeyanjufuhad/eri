package app.eri.eri

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import java.io.File
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
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

    /** "I've paid" warnings (lib/claims/claim_alerts.dart decides when). Returns false if the vendor said no. */
    private fun notifyClaim(id: Int, title: String, body: String): Boolean {
        if (Build.VERSION.SDK_INT >= 33 &&
            checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED
        ) return false
        if (Build.VERSION.SDK_INT >= 26) {
            getSystemService(NotificationManager::class.java).createNotificationChannel(
                NotificationChannel(CLAIMS_CHANNEL, "Payment claims", NotificationManager.IMPORTANCE_HIGH).apply {
                    description = "When someone says they paid and no money arrived"
                }
            )
        }
        val open = PendingIntent.getActivity(
            this, id, Intent(this, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        val n = NotificationCompat.Builder(this, CLAIMS_CHANNEL)
            .setSmallIcon(R.drawable.ic_stat_eri)
            .setColor(0xFFE5484D.toInt())
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setCategory(NotificationCompat.CATEGORY_STATUS)
            .setContentIntent(open)
            .setAutoCancel(true)
            .build()
        return runCatching { NotificationManagerCompat.from(this).notify(CLAIMS_TAG, id, n) }.isSuccess
    }

    companion object {
        private const val CLAIMS_CHANNEL = "eri_claims"
        private const val CLAIMS_TAG = "claim"
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
                "askToNotify" -> {
                    if (Build.VERSION.SDK_INT >= 33 &&
                        checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED
                    ) ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.POST_NOTIFICATIONS), 7)
                    result.success(null)
                }
                "notifyClaim" -> {
                    val a = call.arguments as Map<*, *>
                    result.success(notifyClaim((a["id"] as Number).toInt(), a["title"] as String, a["body"] as String))
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
