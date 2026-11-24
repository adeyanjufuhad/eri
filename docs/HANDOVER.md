# Handover prompt (paste into Google Antigravity or any coding agent)

You are continuing **Eri**, an Android app (Flutter) for Nigerian social-commerce vendors, built for the Mavuly Hackathon 2026 (build window Mon 23 – Sun 29 Nov 2026, submit before 11:59 PM WAT 29 Nov; aim for 6 PM). Repo: `C:\Users\User\Downloads\eri`, branch **`frontend`** (never commit to `main`; final merge Day 7).

**Read first, in this order:** `CLAUDE.md` (hard rules), `docs/PLAN.md` (day plan), `docs/PROGRESS.md` (what's done, newest at the bottom), `docs/DATA_MODEL.md`, `docs/DESIGN.md` (tokens, radius scale, Flutter motion rules), `docs/SPIKE.md` (real-phone test checklist), `app/README.md`.

## Hard rules (from CLAUDE.md, do not break)
- Money is integer **kobo** everywhere; format with `naira()` only in widgets.
- **Raw notification text and chat previews never leave the phone.** Only parsed fields + `raw_hash` may ever sync. No API keys in the app or web bundle.
- **Deterministic first:** parser, matching, claims, receipt check are plain Dart with unit tests. No LLM in those paths.
- Commits: small, clear messages, **no `Co-authored-by` trailers**. Commit only on `frontend`.
- Ask the owner (Fuhad) before anything paid, anything that sends data off the device, or schema changes that are expensive to undo.
- App before landing page. Light theme; radius scale 10/16/24/32 + pills; motion per `docs/DESIGN.md` (respect `MediaQuery.disableAnimations`).

## Where things stand (24 Nov)
- **Landing page** `web/` (Next.js 16): done and committed. Dev server config in `.claude/launch.json` ("web" :3000).
- **App** `app/` (Flutter 3.44, Riverpod 3, go_router, drift, Android-only):
  - Day 1: native Kotlin `NotificationListenerService` (`android/.../EriNotificationListener.kt`) queues money-looking notifications to a private file; Dart drains via MethodChannel `eri/notifications`. Parser `lib/parsing/bank_alert.dart`. Raw text purged after 7 days.
  - Day 2: drift schema; matching engine `lib/matching/matcher.dart` (order code → expected payment → narration → amount → one-tap confirm); `lib/matching/sales.dart` (apply sale in one transaction, stock, moving-average cost, undo, ignore sender). Screens: Today / Products / Orders, "Needs you", alert log with "Demo shop" + "Simulate alert".
  - Motion pass: `lib/theme/motion.dart` (PressScale, EnterOnce, MoneyTicker, Swap).
  - **Day 3 (written, NOT yet committed):** schema v3 (expenses, payment_claims, receipt_checks); opt-in chat claims (`lib/claims/`), Kotlin reads WhatsApp/Instagram previews only when the Settings switch is on and drops non-payment messages before storage; receipt check with on-phone **Google ML Kit OCR** (`lib/receipts/`), verdict Landed / Not received / Looks edited / Can't read; debits → expenses with one-tap category and "Net today". Share → Eri handled natively in `MainActivity.kt` (the `receive_sharing_intent` plugin was removed: it needs compileSdk 37 and broke the build).

## Your first steps
1. `cd app && flutter pub get && dart run build_runner build --delete-conflicting-outputs`
2. `flutter analyze` (expect clean) and `flutter test` (expect **69/69**).
3. `flutter build apk --debug`. The last attempts failed **only on network** downloading ML Kit artifacts from dl.google.com (Gradle "Could not GET"); curl to the same URLs returns 200, so just retry. If it keeps failing, check Gradle proxy settings / JDK (the machine has JDK 25).
4. When green, commit Day 3 on `frontend`, e.g. `App: Day 3 — "I don pay" chat claims (opt-in), on-phone receipt check (ML Kit OCR), debits as expenses`. Include `docs/PROGRESS.md` and this file.
5. Real phone (Fuhad has it): follow `docs/SPIKE.md`. Fill the table, fix bank package names in BOTH `lib/parsing/bank_alert.dart` (`banks`) and `EriNotificationListener.kt` (`BANK_APPS`), and replace the SYNTHETIC test alerts in `test/bank_alert_test.dart` with redacted real ones. Test OCR on 10 real receipts + a few edited ones.

## Remaining plan (see docs/PLAN.md)
- **Day 4:** release APK on 2–3 vendor phones, log confusion in `docs/PLAYTEST.md`. Canary network (light): fingerprint of a caught fake (receipt image hash is already stored in `receipt_checks.image_hash`; add sender-name hash + phone hash) → needs a shared backend. **Supabase is not set up yet: ask Fuhad** before creating anything (it sends hashes off-device; only hashes, never images/text).
- **Day 5:** fix playtest issues; weekly P&L screen (sales, cost of goods, expenses, net); claim warnings as a system notification (currently in-app only).
- **Day 6:** demo video (≤3 min, script in PLAN.md), README with install + privacy model, landing page deploy.
- **Day 7:** fresh clone → README works; APK in GitHub Releases; merge `frontend` → `main`; submit.
- Also open: Supabase sync of products/orders/bank events (Day 2 item, needs Fuhad's project); delivery-fee setting (engine supports it, no UI).

## Gotchas learned the hard way
- **Widget tests with drift:** never `pumpAndSettle` (drift stream timers never settle). Use the `settle()` helper in `test/app_flow_test.dart` (alternating `runAsync` delays and `pump`), start DB writes in the test zone and drive them with `settle()`, then `pump(1s)` after unmounting before `runAsync(db.close)`.
- Platform plugins in widget tests throw `MissingPluginException`: inject them behind providers and override (see `sharedImagesProvider`, `_FakeBridge`).
- **Browser preview** (`flutter build web --pwa-strategy=none`, then launch "app-web" on :8090): OCR, the listener and chat checks are Android-only (conditional imports `*_stub.dart` / `*_io.dart` / `ocr_mlkit.dart`). The browser caches `main.dart.js` hard: force-refresh after each build.
- drift row class for `Matches` is `SaleMatch` (avoids clashing with dart:core `Match`).
- After changing tables, bump `schemaVersion` and add an `onUpgrade` step in `lib/data/db.dart`, then rerun build_runner.
- Amount-only matching books a sale by itself only for exactly 1 unit of 1 product (a test caught "₦50,000 from MY SAVINGS" being booked as 2 gowns). Keep that rule.

Always end a work session by appending a short dated note to `docs/PROGRESS.md` (Done / Checked / Not done / Next).
