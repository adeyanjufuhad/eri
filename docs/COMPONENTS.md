# Component Sources (web landing page)

Pull components from these, then **restyle to `docs/DESIGN.md` tokens** (sharp corners, Eri colours). Never ship a component's default look unchanged. Record every component you take, and its source URL and license, in the table at the bottom.

| Library | Where | Notes |
|---|---|---|
| **React Bits** | https://reactbits.dev/c/components | Text animations (split/blur/shiny text, scroll reveal), backgrounds, cursors. Good for section 2 word reveal and hero background. |
| **Aceternity UI** | https://ui.aceternity.com/components | Parallax, sticky scroll reveal, container scroll animation, world map (section 7), spotlight/beams. |
| **BoardUI** | Launched on Product Hunt; install with `npx boardui add <component>` | 100+ React components incl. data charts. Use for the P&L chart (section 6). Confirm the docs URL before installing. |
| **HorizonX** | Premium library (search "HorizonX UI") | Premium/paid. Use only what's free, or what the owner (Fuhad) has access to. Ask before paying. |
| **ObsidianUI** | React component library (listed on Peerlist) | Confirm the official site and license before use. |
| **transitions.dev** | https://transitions.dev | Page/section transition ideas. Confirm what it offers when you open it. |
| **Bencho** | https://bencho.dev | 100+ live interactive React blocks and micro-interactions (press, hover, drag, loading, swipe, slide), e.g. Pay button, Confirm send, Tilt card, 3D bar chart, Shimmer text, Swipe deck, Time scrubber. Has Docs, MCP, Pricing and Licence pages: check install method and licence before use. Good fits: Pay/Confirm-send for the verdict reveal, Tilt card for hero alert cards, Shimmer text for "Checking…", 3D bar chart for the P&L section. |

Rules:
- Prefer copy-in (shadcn-style) components over npm dependencies.
- Check each library's license allows commercial use.
- Run `pick-ui-library` (in `.claude/skills`) before hand-rolling toasts, drawers, OTP inputs, etc.

## Components used

Shortlisted 21 Nov 2026 (status: shortlisted). Licences checked on each site that day:
React Bits = MIT + Commons Clause (fine for a product; we can't resell the components). Aceternity free components = Aceternity licence (end products OK). Bencho free blocks = MIT; Pro blocks need a paid account, and the Code pane shows which tier a block is, so check before copying.

| Component | Library | URL | License | Used in section | Status |
|---|---|---|---|---|---|
| Container Scroll Animation (phone rises + tilts toward camera) | Aceternity UI | https://ui.aceternity.com/components/container-scroll-animation | Aceternity (free) | 1 Hero | shortlisted |
| Tilted Card (3D-tilted bank alert cards in the fan) | React Bits | https://reactbits.dev/components/tilted-card | MIT + Commons Clause | 1 Hero | shortlisted |
| Hero blue grid stage | Hand-rolled CSS (`background-image` linear-gradient grid) | — | ours | 1 Hero | shortlisted (no lib needed) |
| Scroll Reveal (word-by-word opacity on scroll) | React Bits | https://reactbits.dev/text-animations/scroll-reveal | MIT + Commons Clause | 2 Word reveal | shortlisted |
| Toast stack (notification sliding down onto a stack) | Bencho | https://bencho.dev/blocks/toast-stack | MIT if free tier | 3 Alert lands, 5 "I don pay" | shortlisted |
| Rolling counter (stock 4→3, digits roll) | Bencho | https://bencho.dev/blocks/rolling-counter | MIT if free tier | 3 Alert lands | shortlisted |
| Count Up (profit +₦7,500, P&L totals) | React Bits | https://reactbits.dev/text-animations/count-up | MIT + Commons Clause | 3, 6 | shortlisted |
| Scanner (scan line sweeping both receipts) | React Bits | https://reactbits.dev/backgrounds/scanner | MIT + Commons Clause | 4 The fake | shortlisted |
| Text Type (verdict reasons type out) | React Bits | https://reactbits.dev/text-animations/text-type | MIT + Commons Clause | 4 The fake | shortlisted |
| 10-min ring timer | Hand-rolled SVG circle, `stroke-dashoffset` scrubbed | — | ours | 5 "I don pay" | shortlisted (no lib needed) |
| Stacked bars (sales / cost / expenses per day) | Bencho | https://bencho.dev/blocks/stacked-bars | MIT if free tier | 6 Books | shortlisted |
| World Map (dots + travelling arcs; crop to Nigeria) | Aceternity UI | https://ui.aceternity.com/components/world-map | Aceternity (free) | 7 Canary | shortlisted |
| Dot Grid (alt: vendor dots as a field) | React Bits | https://reactbits.dev/backgrounds/dot-grid | MIT + Commons Clause | 7 Canary | shortlisted |
| Bio → score morph | Hand-rolled `motion/react` `layoutId` | — | ours | 9 Eri Score | shortlisted (no lib needed) |

### In the site (21 Nov 2026)

Copied unchanged into `web/components/reactbits/`, each with a header naming its source and licence. That folder is excluded from lint because the published code trips two React hook rules.

| Component | Library | Source | License | Used in section | Status |
|---|---|---|---|---|---|
| Tilted Card | React Bits | https://reactbits.dev/r/TiltedCard-TS-TW.json | MIT + Commons Clause | 1 Hero: bank alert cards tilt and catch glare under the mouse | used |
| Scroll Reveal | React Bits | https://reactbits.dev/r/ScrollReveal-TS-TW.json | MIT + Commons Clause | 2 Word reveal (section is no longer pinned) | used |
| Count Up | React Bits | https://reactbits.dev/r/CountUp-TS-TW.json | MIT + Commons Clause | 3 Alert lands: profit ₦12,000 → ₦19,500 (`count`), stock 4 → 3 (`roll`) | used |
| Text Type | React Bits | https://reactbits.dev/r/TextType-TS-TW.json | MIT + Commons Clause | 4 The fake: verdict reasons type out | used |
| Stacked bars | Bencho (free) | https://github.com/cabralorenzo/bencho/tree/main/blocks/stacked-bars | MIT | 6 Books: 7-day P&L (profit + cost + expenses per day, fakes caught under the baseline), Day/Week switch, hover breakdown. Adapted: Eri data and labels, sharp corners, Eri colours, no bar on zero-fake days. Lives in `web/components/bencho/`. | used |

Checked and not used:
- World Map (Aceternity) and Dot Grid (React Bits): §7 needs Nigeria alone, not a crop of a world map, so the map is drawn in-house: a simplified border filled with a square dot grid (`web/components/canary.tsx`).
- Container Scroll Animation (Aceternity): would replace the hand-holding-phone hero. Ask Fuhad before swapping.
- Scanner (React Bits): a full-screen WebGL shader background, not a scan line across a card. §4 keeps its CSS scan line.
- Toast stack (Bencho, MIT, free): toast text is hard-coded and it fans out on hover; doesn't fit the single alert in §3.
- Rolling counter (Bencho, MIT, free): a +/- number input, not a display. Count Up's roll mode covers §3.

Not opened yet: BoardUI, HorizonX (paid), ObsidianUI and transitions.dev. Every section is already covered above, so only open them if a shortlisted piece fails on Day 5–6.
