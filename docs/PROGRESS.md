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
