# Progress log

## Sat 21 Nov 2026 (Day 0, Part A)
- **Done:** A2 Blox motion notes (`docs/inspo/BLOX_NOTES.md`). A4 component shortlist per section (`docs/COMPONENTS.md`). A1 has 19 light-theme Pinterest references in `docs/inspo/README.md` (picked from pin descriptions; check them visually). Flow stills from earlier today are in `docs/assets-staging/`.
- **Done (later):** A3: hand + phone stills (2), 2 hero loops (made seamless with forward + reverse) and the parcel loop are in `docs/assets-staging/` and logged in `docs/ASSETS.md`. 30 Flow credits spent (approved).
- **Weak:** The parcel loop came out dark with a blurry sign in the background. Crop it or regenerate on Day 5.
- **Next:** Mon 23 Nov → Day 1: Flutter scaffold, notification listener spike on the real phone, parsers for 4 banks.
- **Open questions:** Bank alert samples (20) and receipts (10 real + 5 fake) are needed before the Day 1 parsers. Phone + USB debugging on Monday.

## Sun 22 Nov 2026 (landing page, Round 3 redesign)
- **Done:** Fuhad found the radius-0 page too blocky and messy. Researched 8 fintech sites (Round 3 in `docs/inspo/README.md`), agreed a direction, and rebuilt `web/` with a radius scale (10/16/24/32px + pill), soft shadows instead of hard borders, Lexend 600 in sentence case (800 dropped), and no crosshairs, faint grids, mono tags, ticker or coins. The hero subline now names the problem, with a fake screenshot ("Not received") and a real alert ("Landed") either side of the phone. New problem section with 3 pain cards that link to Step 1/2/3. Canary moved before Books. `docs/DESIGN.md` updated.
- **Checked:** `tsc --noEmit` and `npm run lint` clean; 1280×800 and 375×812 in the browser pane (no overflow, every pinned stage fits). Reduced-motion collapse unchanged.
- **Not done:** Lighthouse not re-run (layers and a font weight were removed, so it shouldn't be worse). `web/public/media/coins-*.webp` are now unused. `web/` stays uncommitted until Mon 23 Nov.

## Sun 22 Nov 2026 (app scaffold, written early, uncommitted)
- **Decision:** Fuhad chose to start the app today and keep `app/` uncommitted until Mon 23 Nov (same as `web/`).
- **Done:** Flutter project in `app/` (Android, `minSdk 24`, Riverpod, go_router, drift, google_fonts). Own Kotlin `NotificationListenerService` (no plugin): keeps bank-app or money-looking notifications, skips WhatsApp/Instagram/Telegram, queues them in private storage so nothing is lost while the app is closed. Dart side drains the queue, stores raw text on the device only (7-day purge), parses and stores bank events (deduped by `raw_hash`). Deterministic parser for GTBank / OPay / Moniepoint / Kuda styles (amount, direction, sender, note, session ID; skips balances, OTPs, promos). Screens: welcome/permission, today's money in/out, alert log with "Simulate alert" in debug builds. Theme from `docs/DESIGN.md` (Round 3 radius scale). `docs/SPIKE.md` = what to test on the phone.
- **Checked:** `flutter analyze` clean, `flutter test` 18/18 (parser, money, ingest), `flutter build apk --debug` OK (Kotlin listener compiles). An ingest test caught a dedupe-count bug, fixed. Not yet run on a phone.
- **Weak:** parser cases are SYNTHETIC; bank package names are guesses. Both need the real-phone spike.
- **Next (Mon 23 Nov):** run `docs/SPIKE.md` on a real phone, replace synthetic test cases with redacted real alerts, commit `app/`. Then Day 2: products, matching engine, Supabase sync.

## Sun 22 – Mon 23 Nov 2026 (Day 2: the core loop, on-device)
- **Done:** schema v2 (products, stock movements, orders + items, matches, ignore rules; v1→v2 migration). Deterministic matching engine in `app/lib/matching/matcher.dart`: order code (ERI-101) → expected payment (exact amount + fuzzy name) → narration → product (typos ok, quantity from note or amount) → amount alone → one-tap confirm. Applying a sale is one transaction: order, items with cost snapshot, stock down, match row. Moving-average cost on restock. "Not a sale", "Always ignore this sender", and **Undo** for every choice (stock goes back). Screens: Today (money in, sales, profit, low stock, "Needs you" with one-tap suggestions, feed with "Sold: … · +₦7,500 · 3 left"), Products (add/edit/restock), Orders (set up an order → code for the transfer note). Debug/preview: "Demo shop" + "Simulate alert".
- **Decision:** amount-only matches book a sale on their own only for exactly 1 unit of 1 product. Quantities or combinations guessed from an amount are suggestions (a test showed a ₦50,000 transfer from "MY SAVINGS" being booked as 2 gowns).
- **Checked:** `flutter analyze` clean; `flutter test` 44/44, including a widget test that drives the real screens through the Day 2 exit check (₦25,000 "ankara gown" → Sold · +₦7,500 · 3 left, zero taps). Browser preview shows "Needs you" suggestions working.
- **Not done:** Supabase sync (needs a Supabase project: Fuhad's call, sends data off the phone). Nothing run on a real phone yet (docs/SPIKE.md). Delivery fee setting (engine supports it; no UI yet).
- **Next:** real-phone spike; then Day 3: "I don pay" chat claims (opt-in), receipt check, debits → expenses.

## Mon 23 Nov 2026 (app motion pass, Emil Kowalski skills)
- **Done:** motion tokens + helpers (`app/lib/theme/motion.dart`: PressScale, EnterOnce, MoneyTicker, Swap) applied across Today, Products, Orders, sheets and the welcome screen. Rules in `docs/DESIGN.md` (Flutter motion). Calmer ripple, faster tab indicator, no motion on tab switches or steppers. Reduced motion supported.
- **Also fixed today:** Needs-you suggestions vanished after a cold start (fixed, committed); Undo for every Needs-you choice; feed rows on a Material surface so tap ripples show.
- **Checked:** analyze clean, 48/48 tests (4 new motion tests incl. reduced motion). Browser preview checked.

## Mon 23 Nov 2026 (Day 3: catching fakes)
- **Decision (Fuhad):** receipt screenshots are read with **on-phone OCR** (Google ML Kit), not a vision model: free, offline, the image never leaves the phone. No Supabase/vision dependency.
- **Done:**
  - **"I don pay" claims (opt-in):** Settings switch (stored natively). The Kotlin listener reads WhatsApp / WhatsApp Business / Instagram previews only when it's on, and drops anything that doesn't mention paying before it touches storage. `app/lib/claims/claims.dart` detects claims (pidgin included; promises like "I go pay tomorrow" and questions are ignored), waits 10 minutes, then: verified quietly / ⚠ "Tunde says he paid ₦45,000. No money has arrived." / mismatch when the amount differs. Previews deleted after 24h; chat text never enters the alert log.
  - **Receipt check:** "Check a receipt" (Today) and Share → Eri. ML Kit OCR (same-row lines merged) → `app/lib/receipts/receipt.dart` parser (amount, sender, recipient, bank, time, session ID) → verdict vs real credits: Landed / Not received / Looks edited ("₦4,500 → ₦45,000", as on the landing page) / Can't read. Stored without the image (image hash kept for Canary later).
  - **Debits → expenses:** keyword rules (dispatch, ads, data & airtime, rent, supplier, other, not business); one-tap change, remembered per recipient. Today shows Spent and **Net today**.
- **Checked:** analyze clean, 69/69 tests (engines + DB flows + the full-screen Day 2 test). Session-ID structure check NOT built (no confirmed format yet, per PLAN).
- **Not done / to check on the phone:** OCR on real receipts; WhatsApp preview format for group chats; claim warnings only show in-app (no system notification yet).

## Tue 24 Nov 2026 (Canary on Neon + UI revamp)
- **Canary network (Day 4 item):** new Neon project **"eri"** (`solitary-lake-38011399`, London). Data API + Neon Auth anonymous guest tokens, so no secrets in the app. Table `scam_fingerprints` with RLS: guests may only insert (kind, hash, reporter); reading is denied (tested: 403); counts via `canary_count()` (last 30 days, distinct reporters). Only SHA-256 hashes leave the phone (normalised sender name, screenshot bytes, hashed random install id). "Flagged by N Eri vendors" on claims and receipt checks; "Warn other vendors" is a deliberate tap; Settings switch. Fuhad's older canary-* Neon projects are unrelated and untouched.
- **UI revamp (Round 4 Pinterest refs, Emil rules):** dark floating pill tab bar (transform-only highlight, 180ms, no bounce), gradient hero on Today, quick-action row, round header buttons, product avatars.
- **Checked:** analyze clean; 71/71 tests before the final one-line label fix (later runs blocked: disk full). Web preview builds; the browser pane crops the emulated phone, so the tab bar was verified by the widget test, not a screenshot.
- **Blocker:** drive C: keeps filling (≈300 MB free). Builds and tests fail until several GB are freed.
- **Note for the landing page:** its Canary copy says "1 report per vendor, so counts can't be faked". Reports are 1 per install, which a determined faker could game; soften that line.

## Fri 27 Nov 2026 (Day 5: Books, claim notifications, fixes)
- **Fix:** two Day 3 claim tests broke once the real date passed their fixed test date. `ingest` judged claims against the wall clock; it now uses the newest alert in the batch (a replayed backlog can't mark a claim "not received" before the money alerts behind it are read). The 30-second tick still uses real time. `cfa7416`
- **React Bits rebuilt in Flutter** (`87bd9f3`): rolling-digit money (Counter), touch spotlight (Spotlight Card), once-per-session list reveal (Animated List), onboarding stepper (Stepper). Checked once in the web preview: the stepper renders, no console errors.
- **Books screen (daily/weekly P&L)** `ef76a04`: `lib/books/pnl.dart` is one pure sum in kobo: sales − cost of goods = gross profit; + delivery fees collected; − business expenses by category ("Not business" left out); = net. Weeks start Monday; waiting/cancelled orders never count. Today's Profit/Spent/Net use the same sum (so Net now includes delivery fees). Opens from the hero's Net row and a "Books" quick action (replaced the Products shortcut; Products has its own tab). Week view has static day-by-day net bars.
- **Claim warnings as Android notifications:** when a claim turns "not received" or "different amount", the phone shows e.g. "No money from Tunde Bakare yet · They said they paid ₦45,000 on WhatsApp. Nothing has arrived in your bank. Don't send the goods yet." Each claim warns once; nothing is sent if "I've paid" checks are off. Android 13+ asks for notification permission when the vendor turns the checks on. Native `notifyClaim` in MainActivity.kt (channel "Payment claims"), no new package.
  - **Limit:** claims are judged by the Flutter side (on each alert, every 30 s while Eri is alive, and on reopen). If Android has fully closed Eri, a 10-minute timeout is only noticed when Eri next runs. Fix later: a headless Flutter engine started from the listener service, or a small native timer.
- **Landing page:** Canary copy now matches the app (one-tap reports, image + name hashes only, "1 report per phone"). `90acafe`
- **Tests:** 87/87.
