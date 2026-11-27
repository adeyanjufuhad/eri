# Day 1 spike: can Eri read bank alerts on a real phone?

**Exit check (from PLAN.md):** send ₦100 between two of your own accounts → Eri shows a parsed credit within 5 seconds.

## How to run it

1. Accept the Android SDK licences once: `flutter doctor --android-licenses` (read them; this is your call).
2. Phone: Settings → About → tap *Build number* 7× → Developer options → USB debugging on. Plug in, accept the prompt.
3. `cd app && flutter run` (debug build).
4. Eri opens on the welcome screen → **Allow notification access** → turn on **Eri bank alerts** → back.
5. Send ₦100 between two of your own accounts. Watch the home screen; open the **Alert log** (receipt icon, top right) to see the raw text and what the parser made of it.
6. Repeat for each bank app you have, and once with the bank's **SMS** alert if you get those.

The listener only keeps notifications from known bank apps or ones that mention money (₦ / NGN / N + digit). WhatsApp, Instagram and Telegram are skipped. Raw text is stored only on the phone and deleted after 7 days.

## What to record (fill in on the phone)

| Bank | Channel (app push / SMS) | Android package (from the Alert log) | Amount shown? | Sender name? | Narration? | Session ID? | Delay (s) | Parsed right? |
|---|---|---|---|---|---|---|---|---|
| GTBank | | | | | | | | |
| OPay | | | | | | | | |
| Moniepoint | | | | | | | | |
| Kuda | | | | | | | | |
| PalmPay | | | | | | | | |
| SMS (any bank) | | | | | | | | |

## Then

- Fix the package names in **both** `app/lib/parsing/bank_alert.dart` (`banks`) and `app/android/.../EriNotificationListener.kt` (`BANK_APPS`). They are guesses until this table is filled.
- Copy each real alert's text (redact names, account digits and balances) into `app/test/bank_alert_test.dart` as a new case. The current cases are **synthetic**.
- If no bank shows a session ID in its notification, drop the session-ID claim from the pitch (PLAN.md risks table).
- Check the listener survives: lock the phone for 10 minutes, send ₦100, unlock, open Eri. The alert should be there (it's queued in the app's private storage while Eri is closed). Some phones (Tecno, Infinix, Xiaomi) kill background services: note which, and whether turning off battery optimisation for Eri fixes it.

## Results (Fri 27 Nov 2026, Tecno KM7, Android 15)

**Exit check: PASSED.** ₦100 Moniepoint → OPay: Eri logged the OPay credit with the sender's name 2 s after the Moniepoint debit alert.

Bank apps on this phone: OPay `team.opay.pay`, Moniepoint `com.moniepoint.personal`, PalmPay `com.transsnet.palmpay` (our guess `com.palmpay.android` was wrong), Zenith `com.zenithBank.eazymoney` and `com.zenithbank.eazybyzenith`. No GTBank or Kuda, so those parsers are still synthetic.

| Bank | Channel | Android package | Amount? | Sender name? | Narration? | Session ID? | Delay | Parsed right? |
|---|---|---|---|---|---|---|---|---|
| OPay (credit) | app push | `team.opay.pay` | ✓ ₦100.00 | ✓ "NAME has sent you" | ✗ | ✗ | ~2 s | ✓ after fix 1 |
| OPay (credit) | SMS "OPayInfo" | `com.google.android.apps.messaging` | ✓ Amt:NGN100.00 | ✓ (own line) | ✗ | ✗ | +13 s after the push | ✓; counted once after fix 3 |
| Moniepoint (debit) | app push | `com.moniepoint.personal` | ✓ NGN100.00 | ✓ "TRANSFER TO NAME Bank" | ✗ | a long reference after `TRF\|`; unconfirmed whether it is the NIBSS session ID | instant | ✓ after fix 2 |

**Bugs found and fixed (tests added with fake names):**
1. OPay appends "Get up to 6% bonus on OPay Airtime." to real credit alerts; the parser rejected anything mentioning "bonus". Promo words now reject only when nothing says a transfer happened.
2. Moniepoint puts the recipient's bank and masked account after the name; names now stop at `*`/digits and drop a trailing bank name.
3. Identical alerts (same sender, same amount) were treated as one: the dedupe hash now includes the post time. And a bank's app push plus its SMS for the same payment (same bank, direction, amount, within 2 min, different channel) now counts once.

**Decisions:** no credit alert showed a session ID, so per PLAN.md the session-ID structure check stays out of the pitch; "no matching credit" is the proof.

**Still to do on a phone:** lock for 10 min, send money, unlock (does the Tecno battery manager kill the listener?); a PalmPay and a Zenith alert; a narration ("ankara gown") in the transfer note to see if OPay shows it.
