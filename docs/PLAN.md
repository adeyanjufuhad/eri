# Eri — 7-Day Build Plan (Mavuly Hackathon 2026)

> **Proof, not screenshots.**
> Eri reads the bank alerts on an online vendor's Android phone, logs every real sale automatically, keeps stock and profit up to date, and catches fake "I've paid" claims before goods leave.

## Ground rules

- **Build window:** Mon 23 Nov – Sun 29 Nov 2026, submissions close **11:59 PM WAT on 29 Nov**.
- **Before 23 Nov:** only docs, design research, assets and skills go in the repo. **No app or landing-page code before Mon 23 Nov** (Mavuly rule C: a new app must be built inside the window).
- **What to submit:** project name, short description, public GitHub repo with a README judges can follow, and a demo video (MP4/WebM/MOV, ≤300MB).
- **Branch:** all work goes on `frontend`. Do not push to `main` until the final merge on Day 7.
- **Priority order:** the Flutter app is what gets judged. The landing page is a bonus. If time runs short, cut from the landing page first.

## The user (say it in one sentence on the submission)

> Instagram, WhatsApp and TikTok vendors in Nigeria who ship goods after a customer sends a payment screenshot, and who lose track of sales, stock and profit across several bank apps.

## The judging criteria, and how Eri answers each

| Mavuly criterion | Eri's answer |
|---|---|
| Would people actually use it? | It runs by itself. Vendors get value on day one without typing anything. |
| Can someone understand it in seconds? | Money arrives → "Sold: Ankara Gown · +₦7,500 · 3 left". A fake screenshot → ❌. |
| Does it run without breaking? | Core flow is deterministic matching. The AI is only a fallback. |
| Clear problem for a clear group of people? | Fake payment proof and messy books for social-commerce vendors. |

---

## Day 0: Sat 21 – Sun 22 Nov (prep only, no app code)

- [x] Lock the idea, name (Eri) and scope
- [x] Repo `eri` with `frontend` branch, docs, Emil Kowalski skills vendored in `.claude/skills`
- [ ] Pinterest moodboard → `docs/inspo/` (links + notes, no copyrighted images committed)
- [ ] Google Flow: hero visuals + short loops → `docs/assets-staging/` (moved into `web/public` on Day 1)
- [ ] Collect **20 real bank notification samples** (screenshots of notification shade + SMS) from GTBank, OPay, Moniepoint, Kuda, Access, PalmPay, Zenith, UBA. Redact names/amounts as needed.
- [ ] Collect **10 real transfer receipts** + make **5 fake ones** (for testing only, never shared) to test the session-ID check
- [ ] Attend the Mavuly onboarding session (Sat 22 Nov)
- [ ] Recruit 2–3 real vendors to try the APK on Day 4

## Day 1: Mon 23 Nov (lock the hard part first)

**Goal: prove Eri can read bank alerts on a real Android phone.**

- Flutter project in `/app` (Android-first, `minSdk 24`)
- Notification listener working (verify package on pub.dev, e.g. `notification_listener_service`; fall back to a small Kotlin `NotificationListenerService` via platform channel if the package is flaky)
- Permission onboarding screen: explains exactly what Eri reads and that raw text never leaves the phone
- Log raw notifications from bank apps to a local debug screen
- Write **parsers** for the top 4 banks from the Day 0 samples (regex templates): amount, direction (credit/debit), counterparty, narration, time, session ID if present
- **Spike result to record in `docs/SPIKE.md`:** which banks show narration in the notification, which show the sender's name, and whether session IDs appear anywhere
- Next.js app scaffold in `/web` with design tokens only (30 min max)

**Exit check:** send ₦100 between two of your own accounts → Eri shows a parsed credit event within 5 seconds.

## Day 2: Tue 24 Nov (the core loop)

**Goal: alert in → sale logged, stock down, profit up, with no taps.**

- Local DB (drift/SQLite) + Supabase sync for: products, orders, bank events, matches
- Product setup: name, aliases, cost price, selling price, quantity (manual entry; add bulk entry later)
- **Matching engine (deterministic, in Dart), in this order:**
  1. Order code in narration (`ERI-482`)
  2. Expected payment (order with `awaiting_payment`, amount ± ₦0, name fuzzy match)
  3. Narration → product (aliases + fuzzy match; LLM only if confidence < 0.6)
  4. Amount → single product or combination (+ delivery fee)
  5. Otherwise → one-tap confirm card
- "Not a sale" + "always ignore this sender"
- Stock movement + gross profit per sale (moving average cost)

**Exit check:** create "Ankara Gown ₦25,000 (cost ₦17,500, qty 4)". Transfer ₦25,000 with narration "ankara gown" → dashboard shows *Sold · +₦7,500 · 3 left* with zero taps.

## Day 3: Wed 25 Nov (catching fakes)

**Goal: fake payment claims get caught automatically.**

- **Payment claims from chat previews (opt-in):** read WhatsApp / WhatsApp Business / Instagram notification previews on-device, detect payment phrases ("I've paid", "sent", "I don pay", "check your account", "transferred"), create a `payment_claim`, wait up to N minutes for a matching credit → ✅ quietly mark paid, or ⚠️ warn "Chioma says she paid. No money has arrived."
- **Receipt check (manual backup):** share a screenshot into Eri (Android share intent) → Edge Function calls a vision model → extract amount, sender, bank, time, session ID → compare against bank events → ✅ Landed / ❌ Not received / ⚠️ Mismatch with reasons
- Session-ID structure check, **only if the Day 0/1 samples confirm the format**. Otherwise drop it from the pitch.
- Debit alerts → expenses (supplier, dispatch, ads, other) so P&L is net, not just gross

**Exit check:** a fake screenshot of ₦45,000 → ❌ within 10 seconds; a real one → ✅.

## Day 4: Thu 26 Nov (playtest with real vendors)

- Build a release APK, install it on 2–3 real vendors' phones (or a friend's, with real bank apps)
- Watch them: where do they hesitate? What does the permission screen make them feel?
- Log every confusion in `docs/PLAYTEST.md`
- Canary network (light version): when a fake is caught, hash its fingerprint (image pHash, sender name, phone) and store it; a second test phone shows "⚠️ Flagged by 1 Eri vendor today" for the same fingerprint

## Day 5: Fri 27 Nov (fix and polish)

- Fix everything from playtesting first
- Dashboard: today's sales, profit, low-stock alerts, recent events feed
- Daily / weekly P&L screen (sales, cost of goods, expenses, net)
- Motion pass on the app using the `animate` / `review-animations` skills (only purposeful motion: event arriving, number ticking, verdict reveal)
- Landing page sections 1–4 (see `docs/DESIGN.md`)

## Day 6: Sat 28 Nov (record and document)

- Landing page sections 5–9, deploy to Vercel
- **Demo video (≤3 min)** following the script below
- README: what it is, who it's for, how to run it, how to install the APK, privacy model, screenshots
- Eri Score public page (stretch; skip if behind)

## Day 7: Sun 29 Nov (final checks and submit)

- Fresh clone → follow README exactly → does it run?
- Repo public, links work, APK in GitHub Releases
- Merge `frontend` → `main`
- Submit on mavuly.com **before 6 PM WAT** (leave a buffer before the 11:59 PM deadline)

---

## Demo video script (≤3 minutes)

1. **0:00–0:20 The problem.** Vendor's DM: a payment screenshot. "Did the money actually land? She has 30 of these a day across 3 banks."
2. **0:20–0:50 Real payment, zero taps.** Phone on the table. A transfer arrives with narration "ankara gown". Eri updates itself: *Sold: Ankara Gown · +₦7,500 · 3 left*.
3. **0:50–1:30 Fake payment.** WhatsApp: "I don pay, check am" + screenshot. No alert arrives. Eri: *⚠️ Chioma says she paid. No money has arrived.* Then share the screenshot → ❌ with reasons.
4. **1:30–2:00 Canary.** Second phone, different vendor. Same scammer messages → *⚠️ Flagged by 1 Eri vendor today.*
5. **2:00–2:30 The books write themselves.** Weekly P&L: sales, cost, expenses, net profit. Low-stock alert.
6. **2:30–3:00 Privacy + vision.** "Raw alerts never leave the phone." Eri Score → verified sales history → credit for vendors.

## Risks and fallbacks

| Risk | Fallback |
|---|---|
| A bank's notification hides the amount or narration | Template per bank + LLM fallback; order codes in narration; expected payments |
| Notification listener package breaks | Native Kotlin `NotificationListenerService` + MethodChannel |
| Session-ID format not confirmed | Drop the claim; rely on "no matching credit" as the proof |
| Vision model latency | Show "Checking…" with the bank-event comparison first; vision is second |
| iPhone users | Android-only for v1; say so up front |
