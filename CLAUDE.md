# CLAUDE.md: Eri

Read this file fully before doing anything in this repo.

## What Eri is

Eri (from Yoruba *ẹ̀rí*, "proof / evidence / witness") is an Android app for Nigerian social-commerce vendors (Instagram, WhatsApp, TikTok sellers). It:

1. **Reads bank credit/debit alerts** on the vendor's own phone (Android NotificationListenerService), across every bank.
2. **Logs sales automatically**: matches each credit to an order or product (order code → expected payment → narration → amount combination → one-tap confirm), reduces stock, records profit.
3. **Catches fake payments**: watches (opt-in) WhatsApp/Instagram message previews for "I've paid" claims and warns when no matching money arrives; checks shared receipt screenshots against real credits.
4. **Keeps the books**: daily/weekly P&L from real money, with debit alerts classified as expenses.
5. **Canary network**: fingerprints of caught fakes (hashes only) warn other Eri vendors.

Tagline: **Proof, not screenshots.**

Built for the **Mavuly Hackathon 2026** (build window 23–29 Nov 2026, submit by 11:59 PM WAT 29 Nov).

## Repo layout

```
/app        Flutter app (Android-first). This is what gets judged.
/web        Next.js landing page
/supabase   migrations, edge functions (receipt vision, LLM fallback)
/docs       PLAN, DATA_MODEL, DESIGN, COMPONENTS, ASSETS, inspo
/.claude/skills   Emil Kowalski's design/animation skills (MIT), use them
```

## Hard rules

1. **Branch:** work on `frontend`. Never commit to `main` directly. Final merge happens on Day 7.
2. **Build window:** no app or landing-page source code may be committed before **Mon 23 Nov 2026**. Docs/assets are fine.
3. **Commits:** do **not** add any `Co-authored-by: Claude` / `Co-Authored-By` trailer to commit messages. Small, frequent commits with clear messages.
4. **Privacy:** raw notification text and chat previews **never leave the device**. Sync only parsed fields + `raw_hash`. API keys live in Supabase Edge Function secrets, never in the app or the web bundle.
5. **Money:** integers in kobo everywhere. Format as `₦25,000` only at the UI edge.
6. **Deterministic first:** matching and P&L are plain code with unit tests. LLMs are a fallback for fuzzy narration and screenshot reading only.
7. **App before landing page.** If time is short, cut landing-page scope, never the core app loop.
8. **Ask, don't guess,** when a decision is expensive to undo (schema changes after Day 2, paid services, anything that sends data off the device).

## Stack

**App (`/app`)**: Flutter (stable), Dart 3, Riverpod, go_router, drift (SQLite), supabase_flutter, google_fonts. Notification listener: verify the best-maintained package on pub.dev (e.g. `notification_listener_service`); if unreliable, write a small Kotlin `NotificationListenerService` + MethodChannel. Android share intent for receiving receipt screenshots (`receive_sharing_intent`). Android-only for v1.

**Backend (`/supabase`)**: Postgres with RLS (schema in `docs/DATA_MODEL.md`), Edge Functions for: `check-receipt` (vision model extracts amount/sender/bank/time/session ID), `classify-narration` (LLM fallback), `canary-lookup`.

**Web (`/web`)**: Next.js App Router, TypeScript, Tailwind v4, `motion/react`, GSAP + ScrollTrigger, Lenis. Tokens and storyboard in `docs/DESIGN.md`. Components from `docs/COMPONENTS.md`.

## Design

- Follow `docs/DESIGN.md` exactly: sharp corners (`--radius: 0`), navy + electric blue `#3b5bff`, Lexend display, Inter body, verdict colours (landed / not-received / suspicious).
- Before writing any animation, read `.claude/skills/animate/SKILL.md` and `.claude/skills/choreograph/SKILL.md`. For polish, `emil-design-eng`. After a section is done, run `review-animations`. For Flutter motion, apply the same principles (curves, durations, interruptibility) even though `animate-expo` targets React Native.
- Respect `prefers-reduced-motion` (web) and `MediaQuery.disableAnimations` (Flutter).

## Definition of done (any feature)

- Works on a real Android device (not just the emulator) for notification features
- Unit tests for parsers and the matching engine
- No secrets in the repo (`git grep -i "sk-\|service_role"` returns nothing)
- README updated if setup changed
