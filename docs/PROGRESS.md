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
