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

## Results

_Not run yet. Fill in on Mon 23 Nov._
