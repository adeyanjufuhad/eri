package app.eri.eri

import android.app.Notification
import android.content.Context
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import io.flutter.plugin.common.EventChannel
import org.json.JSONArray
import org.json.JSONObject
import java.io.File

/**
 * Reads notifications on the phone and keeps the ones that look like money (bank apps, bank SMS).
 *
 * Privacy: nothing here touches the network. Kept notifications go into a small queue file in the app's
 * private storage; the Flutter side drains it, parses it on the device and stores it in SQLite.
 * Chat apps (WhatsApp, Instagram) are read ONLY when the vendor turns on chat checks, and only previews that
 * mention paying are kept (everything else is dropped here, before it touches storage).
 *
 * Every kept notification is queued, even when the Flutter UI isn't running, so no alert is lost.
 * When the UI is listening, it also gets a ping to drain straight away.
 */
class EriNotificationListener : NotificationListenerService() {

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (sbn.packageName == packageName) return
        val n = sbn.notification ?: return
        if (n.flags and Notification.FLAG_GROUP_SUMMARY != 0) return
        val chat = sbn.packageName in CHAT_APPS
        if (chat && !chatChecksOn(applicationContext)) return

        val extras = n.extras
        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString().orEmpty()
        // the expanded text has the full alert; the collapsed text is often cut short
        val text = (extras.getCharSequence(Notification.EXTRA_BIG_TEXT)
            ?: extras.getCharSequence(Notification.EXTRA_TEXT))?.toString().orEmpty()
        if (text.isBlank()) return

        if (chat) {
            if (!PAID_HINT.containsMatchIn(text)) return
        } else {
            val known = sbn.packageName in BANK_APPS
            if (!known && !MONEY.containsMatchIn("$title $text")) return
        }

        val item = JSONObject()
            .put("package", sbn.packageName)
            .put("title", title)
            .put("text", text)
            .put("postedAt", sbn.postTime)
        enqueue(applicationContext.filesDir, item)
        sink?.success(null)
    }

    companion object {
        /** Set by MainActivity while the Flutter UI is listening. */
        @Volatile
        var sink: EventChannel.EventSink? = null

        private const val QUEUE = "eri_pending.jsonl"
        private val lock = Any()

        // ₦25,000 · NGN 25,000.00 · N25,000 (N must be followed by a digit, so plain words don't match)
        private val MONEY = Regex("""(₦|NGN|\bN)\s?\d""", RegexOption.IGNORE_CASE)

        // Known bank apps. Package names still need checking on a real phone (docs/SPIKE.md).
        // Bank SMS alerts arrive through the SMS app and are caught by the money pattern instead.
        val BANK_APPS = setOf(
            "com.gtbank.gtworldv1",
            "team.opay.pay",
            "com.moniepoint.personal",
            "com.teamapt.monnify.pos.moniepointapp",
            "com.kudabank.app",
            "com.palmpay.android",
            "com.transsnet.palmpay", // confirmed on a Tecno KM7, 27 Nov
            "com.zenithBank.eazymoney",
            "com.zenithbank.eazybyzenith",
            "com.ubanquity.ubamobilebanking",
            "com.accessbank.accessmobile",
        )

        // Keep in sync with chatApps in lib/claims/claims.dart. Telegram etc. are never read.
        private val CHAT_APPS = setOf("com.whatsapp", "com.whatsapp.w4b", "com.instagram.android")

        // loose first pass for chat previews; lib/claims/claims.dart decides properly
        private val PAID_HINT = Regex("""\b(paid|pay|sent|send|transfer|transferred|alert|account|acct|payment)\b""", RegexOption.IGNORE_CASE)

        private const val PREFS = "eri"
        private const val CHAT_KEY = "chat_checks"

        fun chatChecksOn(ctx: Context): Boolean =
            ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getBoolean(CHAT_KEY, false)

        fun setChatChecks(ctx: Context, on: Boolean) =
            ctx.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit().putBoolean(CHAT_KEY, on).apply()

        fun enqueue(dir: File, item: JSONObject) = synchronized(lock) {
            File(dir, QUEUE).appendText(item.toString() + "\n")
        }

        /** Returns everything queued so far as a JSON array string, and empties the queue. */
        fun drain(dir: File): String = synchronized(lock) {
            val f = File(dir, QUEUE)
            val out = JSONArray()
            if (f.exists()) {
                f.readLines().filter { it.isNotBlank() }.forEach { line ->
                    runCatching { out.put(JSONObject(line)) }
                }
                f.writeText("")
            }
            out.toString()
        }
    }
}
