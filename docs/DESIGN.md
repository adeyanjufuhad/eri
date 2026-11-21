# Eri — Design System & Landing Page Storyboard

## Reference

The motion reference is **Blox Studio** (https://bloxweb-production.up.railway.app/). What makes it work:

- **Scroll-pinned "simulation" sections.** Each feature section is very tall (`h-[320vh]` to `h-[520vh]`) with a **sticky stage** inside. As you scroll, a mock product UI on the stage plays out step by step, as if someone is using it: a cursor moves, elements get dragged, panels open, values change. Scroll position drives the timeline (scrubbed, not time-based).
- **Word-by-word text reveal.** Big headlines where words go from dim to full colour as you scroll ("Other tools make you learn animation. Here it's clicks…").
- **Sharp geometry.** `--radius: 0`. Square cards, square buttons, hard edges.
- **Dark navy base with one electric-blue accent**, plus light mode.
- **Heavy display type** for the hero, clean grotesk for body.

Eri borrows the **pattern and the tokens**, not Blox's content or brand. Eri's stage is a **phone**, not an editor.

## Tokens (adapted from the reference)

```css
:root {                       /* light */
  --radius: 0rem;
  --background: #e5eaf2;
  --foreground: #0f141d;
  --card: #ffffff;
  --muted: #e2e6ee;
  --muted-foreground: #5f636c;
  --border: #d2d6dd;
  --input: #c0c4cc;
  --primary: #3b5bff;
  --primary-bright: #0015ec;
  --primary-foreground: #ffffff;
  --ring: #3b5bff;
  /* Eri verdict colours */
  --landed: #3d9c5e;          /* ✅ money arrived */
  --not-received: #d9312f;    /* ❌ no money */
  --suspicious: #c98a0b;      /* ⚠️ mismatch */
}
.dark {
  --background: #171d27;
  --foreground: #eff2f7;
  --card: #000000;
  --muted: #343840;
  --muted-foreground: #9498a0;
  --border: #3f4249;
  --input: #4a4d54;
  --primary: #3b5bff;
  --primary-bright: #8a95ff;
  --primary-foreground: #ffffff;
  --ring: #3b5bff;
  --landed: #58b575;
  --not-received: #f05653;
  --suspicious: #f5a524;
  --footer: #0a0d14;
}
```

**Type**
- Display (hero, section titles): **Lexend**, 800 weight, tight tracking (-0.02em), uppercase for the hero only.
- Body/UI: **Inter** (or system UI stack), 400/500/600.
- Numbers (amounts, P&L): Inter with `font-variant-numeric: tabular-nums` so ticking numbers don't jitter.
- Naira always formatted `₦25,000` (no decimals unless needed).

**Motion rules** (from Emil Kowalski's skills in `.claude/skills`. Read `animate`, `choreograph`, `emil-design-eng` before writing motion)
- Enter: `ease-out`, 200–400ms. Never `ease-in` for things appearing.
- Scroll-driven sections are **scrubbed** (tied to scroll), not autoplaying timelines.
- Animate `transform` and `opacity` only. No layout properties.
- Respect `prefers-reduced-motion`: pinned sections become static step cards.
- Every animation must explain the product. Decoration-only motion gets removed (`remove-animations` skill).

**Flutter app** uses the same tokens (`ThemeData` + `ThemeExtension` for verdict colours), square corners, Lexend + Inter via `google_fonts`.

## Stack (web)

- Next.js (App Router) + TypeScript + Tailwind CSS v4 (tokens above as CSS variables, shadcn-style)
- **Motion** (`motion/react`) for component animation; **GSAP + ScrollTrigger** for the pinned, scrubbed simulations; **Lenis** for smooth scrolling
- Components pulled from the libraries in `docs/COMPONENTS.md` and restyled to these tokens (sharp corners)
- Deployed on Vercel

## Landing page storyboard

Each "pinned" section = tall wrapper (`h-[300vh]`–`h-[450vh]`) + `sticky top-0 h-screen` stage + scroll-scrubbed timeline.

| # | Section | Height | What plays as you scroll |
|---|---|---|---|
| 1 | **Hero**: "PROOF, NOT SCREENSHOTS." | 100vh | Phone floats in with parallax layers (phone, notification cards, ₦ glyphs at different depths). Subline: "Eri reads your bank alerts, logs every sale, and catches fake payments. You touch nothing." CTA: Join the waitlist / Download APK. |
| 2 | **Word reveal** | 200vh | "Customers send screenshots. Screenshots lie. **Bank alerts don't.**" Words light up one by one. |
| 3 | **The alert lands** (pinned) | 400vh | Notification slides down: *GTBank: Credit ₦25,000 from CHIOMA OKAFOR, "ankara gown"*. Eri card picks it up → matches *Ankara Gown* (highlight) → stock ticks 4→3 → profit counter +₦7,500. A finger icon *doesn't* tap anything: label "0 taps". |
| 4 | **The fake** (pinned) | 400vh | Two identical receipts side by side. Scan line passes over both. Left gets ✅ *Landed 2:14 PM*. Right gets ❌ *No matching credit · amount edited*. Reasons type out. |
| 5 | **"I don pay"** (pinned) | 350vh | WhatsApp preview bubble "I don pay, check am 🙏". A 10-minute ring timer drains as you scroll. No alert arrives → ⚠️ *Chioma says she paid. No money has arrived.* |
| 6 | **The books write themselves** | 350vh | P&L chart draws itself; sales, cost, expenses and net profit count up; low-stock chip pops in. |
| 7 | **Canary network** | 300vh | Map of Nigeria, dots for vendors. One vendor catches a fake → pulse travels → another vendor gets *Flagged by 3 Eri vendors this week*. |
| 8 | **Privacy** | 100vh | "Your alerts never leave your phone." On-device diagram: raw text stays inside the phone outline; only ₦ amounts and matches cross the line. |
| 9 | **Eri Score + CTA** | 100vh | Instagram bio with an Eri link → morphs into the verified score page. Waitlist form. Footer (`--footer` background). |

## Visual assets

- **Google Flow:** hero background loops (abstract navy/blue light trails, market-to-phone motion), phone mockup renders, Nigerian vendor lifestyle shots (packing orders, phone on table with notification). Export MP4 (≤8MB each for web) + WebP stills. Every generated asset gets an entry in `docs/ASSETS.md` (prompt, date, file).
- **Pinterest:** moodboard only. Save links and short notes in `docs/inspo/README.md`. Do not commit downloaded Pinterest images (copyright).
- No photos of real public figures. No other brands' logos except bank names in plain text inside mock notifications.
