# Eri — Design System & Landing Page Storyboard

## Reference

The motion reference is **Blox Studio** (https://bloxweb-production.up.railway.app/). What makes it work:

- **Scroll-pinned "simulation" sections.** Each feature section is very tall (`h-[320vh]` to `h-[520vh]`) with a **sticky stage** inside. As you scroll, a mock product UI on the stage plays out step by step, as if someone is using it: a cursor moves, elements get dragged, panels open, values change. Scroll position drives the timeline (scrubbed, not time-based).
- **Word-by-word text reveal.** Big headlines where words go from dim to full colour as you scroll ("Other tools make you learn animation. Here it's clicks…").
- ~~Sharp geometry~~ **Soft geometry (Round 3, 22 Nov).** Fuhad found radius 0 too blocky and messy. Eri now uses a radius scale (below): pill buttons, nav, tags and inputs; 16–32px cards. See Round 3 in `docs/inspo/README.md` (Mercury, Wise, Linear, Kuda).
- **One electric-blue accent** on a calm base. Blox defaults to dark; **Eri is light-first** (Fuhad's call, 21 Nov).
- **Heavy display type** for the hero, clean grotesk for body.

Eri borrows the **pattern** (pinned, scrubbed stages), not Blox's content, brand or sharp corners. Eri's stage is a **phone**, not an editor.

**Layout rules (Round 3):** calm over busy. One main surface per section, lots of white space, no HUD crosshairs, faint grids, mono uppercase tags or rotated ticker bands. Every section after the hero opens with a pill eyebrow that says where you are in the story (*The problem*, *Step 1*, *Step 2*, *Step 3*, *Privacy*).

## Tokens (adapted from the reference)

**Eri is light-themed** on both the website and the app. Light tokens are the default. `.dark` is kept only for the footer band and an optional dark mode later.

```css
:root {                       /* light */
  --radius: 16px;             /* default card radius; full scale below */
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
  --landed: #2b7a47;          /* ✅ money arrived (darkened 21 Nov for 4.5:1 contrast on white) */
  --not-received: #c62b29;    /* ❌ no money */
  --suspicious: #966500;      /* ⚠️ mismatch */
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

**Radius scale** (Tailwind `rounded-*` mapped in `web/app/globals.css` `@theme`)

| Token | Value | Use |
|---|---|---|
| `rounded-sm` | 10px | chips, small fields inside cards |
| `rounded-lg` | 16px | cards, alerts, banners, the default `--radius` |
| `rounded-2xl` | 24px | section panels, receipts, phone-UI cards |
| `rounded-3xl` | 32px | hero stage (28px mobile / 40px desktop), big surfaces |
| `rounded-full` | pill | buttons, nav bar, tags, inputs, status badges, dots |

Shadows: `shadow-soft` (resting cards) and `shadow-lift` (a card that pops forward). Prefer a soft shadow over a hard border.

**Type**
- Display (hero, section titles): **Lexend 600**, tight tracking (-0.03em to -0.035em), sentence case everywhere (the hero is no longer uppercase; 800 weight dropped).
- Body/UI: **Inter** (or system UI stack), 400/500/600.
- Numbers (amounts, P&L): Inter with `font-variant-numeric: tabular-nums` so ticking numbers don't jitter.
- Naira always formatted `₦25,000` (no decimals unless needed).

**Motion rules** (from Emil Kowalski's skills in `.claude/skills`. Read `animate`, `choreograph`, `emil-design-eng` before writing motion)
- Enter: `ease-out`, 200–400ms. Never `ease-in` for things appearing.
- Scroll-driven sections are **scrubbed** (tied to scroll), not autoplaying timelines.
- Animate `transform` and `opacity` only. No layout properties.
- Respect `prefers-reduced-motion`: pinned sections become static step cards.
- Every animation must explain the product. Decoration-only motion gets removed (`remove-animations` skill).

**Flutter motion (23 Nov, Emil Kowalski skills):** tokens in `app/lib/theme/motion.dart` reuse the web curves (`EriCurves.out` 0.23,1,0.32,1 · `inOut` 0.77,0,0.175,1 · `drawer` 0.32,0.72,0,1). What moves: press feedback (0.97, 120ms) on buttons, chips and product cards; a just-landed alert or "Needs you" card fades and rises 8px (240ms ease-out); the money-in-today number counts up (450ms); "Needs you" → "Sold" and stock counts crossfade in place (180ms); sheets open on the drawer curve (320ms in, 200ms out); the first-run welcome staggers in (60ms apart). What doesn't: tab switches, +/- steppers, typing, anything opened dozens of times a day. Reduced motion (`MediaQuery.disableAnimations`) keeps fades and drops movement. A decided card leaves at once, no gap.

**Flutter app** is light-themed: `ThemeData(brightness: Brightness.light)` built from the light tokens, `ThemeExtension` for verdict colours, the same radius scale (16px cards, pill buttons), Lexend 600 + Inter via `google_fonts`. Background `#e5eaf2`, cards `#ffffff`, text `#0f141d`, accent `#3b5bff`.

## Stack (web)

- Next.js (App Router) + TypeScript + Tailwind CSS v4 (tokens above as CSS variables, shadcn-style)
- **Motion** (`motion/react`) for component animation; **GSAP + ScrollTrigger** for the pinned, scrubbed simulations; **Lenis** for smooth scrolling
- Components pulled from the libraries in `docs/COMPONENTS.md` and restyled to these tokens (radius scale above)
- Deployed on Vercel

## Landing page storyboard

**Story order (Round 3):** Hero → The problem → Step 1 reads real alerts (§3) → Step 2 catches fakes (§4 receipt, §5 "I don pay", §7 Canary) → Step 3 books (§6) → Privacy → Waitlist. On the page Canary now sits before Books.

Each "pinned" section = tall wrapper (`h-[300vh]`–`h-[450vh]`) + `sticky top-0 h-screen` stage + scroll-scrubbed timeline.

| # | Section | Height | What plays as you scroll |
|---|---|---|---|
| 1 | **Hero**: "Proof, not screenshots." *(Round 3: the subline names the problem, fake "I've paid" screenshots; the rounded blue stage holds the hand-held phone between a chat screenshot marked ✕ Not received and a real GTBank alert marked ✓ Landed. The giant PROOF, HUD labels, ticker, coins and 4-card fan were removed.)* Original plan: | 100vh + 150vh exit | **Based on Fuhad's favourite reference** ([Ledger animated hero, Pinterest](https://www.pinterest.com/pin/622270873558113007/)): light page, centred headline + two buttons, and below it a **stage of electric-blue `#3b5bff` with a white square grid** (fits our sharp-corner system). A phone rises out of the grid showing the Eri dashboard (*₦412,000 this week · 23 sales · 0 fakes*). From the left, a fan of **bank-alert cards** (GTBank, OPay, Moniepoint, Kuda credit alerts, built in code as 3D-tilted DOM cards) slides in; from the right, **3D gold ₦ coins** (Flow asset) tumble in; a small "Credit ₦25,000" chip pops off the phone. On scroll, each layer moves at a different speed (parallax depth), then the phone detaches and travels into Section 3's pinned stage (shared-element handoff). |
| 2 | **The problem** | auto | "Customers send screenshots. Screenshots lie. **Bank alerts don't.**" Words light up one by one, then three pain cards (fake screenshots, checking every bank app, books that don't add up), each linking to the step that fixes it. |
| 3 | **The alert lands** (pinned) | 400vh | Notification slides down: *GTBank: Credit ₦25,000 from CHIOMA OKAFOR, "ankara gown"*. Eri card picks it up → matches *Ankara Gown* (highlight) → stock ticks 4→3 → profit counter +₦7,500. A finger icon *doesn't* tap anything: label "0 taps". |
| 4 | **The fake** (pinned) | 400vh | Two identical receipts side by side. Scan line passes over both. Left gets ✅ *Landed 2:14 PM*. Right gets ❌ *No matching credit · amount edited*. Reasons type out. |
| 5 | **"I don pay"** (pinned) | 350vh | WhatsApp preview bubble "I don pay, check am 🙏". A 10-minute ring timer drains as you scroll. No alert arrives → ⚠️ *Chioma says she paid. No money has arrived.* |
| 6 | **The books write themselves** | 350vh | P&L chart draws itself; sales, cost, expenses and net profit count up; low-stock chip pops in. |
| 7 | **Canary network** | 300vh | Map of Nigeria, dots for vendors. One vendor catches a fake → pulse travels → another vendor gets *Flagged by 3 Eri vendors this week*. |
| 8 | **Privacy** | 100vh | "Your alerts never leave your phone." On-device diagram: raw text stays inside the phone outline; only ₦ amounts and matches cross the line. |
| 9 | **Eri Score + CTA** | 100vh | Instagram bio with an Eri link → morphs into the verified score page. Waitlist form. Footer as a single dark band (`--footer`) for contrast; everything else stays light. |

## Visual assets

- **Google Flow:** light, airy imagery to match the light theme: hero background loops (soft off-white with electric-blue light trails), daylight product shots, phone mockup renders, Nigerian vendor lifestyle shots (packing orders, phone on table with notification). Export MP4 (≤8MB each for web) + WebP stills. Every generated asset gets an entry in `docs/ASSETS.md` (prompt, date, file).
- **Pinterest:** moodboard only. Save links and short notes in `docs/inspo/README.md`. Do not commit downloaded Pinterest images (copyright).
- No photos of real public figures. No other brands' logos except bank names in plain text inside mock notifications.
