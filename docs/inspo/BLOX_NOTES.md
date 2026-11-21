# Blox Studio: motion notes

Source: https://bloxweb-production.up.railway.app/ (walked through 21 Nov 2026 at a 1280×800 viewport).
We borrow the **pattern**: tall wrapper, sticky stage, scroll-scrubbed product simulation. We do not borrow its content or brand.

## How it's built

- Next.js + Lenis (`html.lenis`). There's no global GSAP; the scrub looks like `motion/react` `useScroll` on each wrapper. We'll use GSAP ScrollTrigger per DESIGN.md, which gives the same result.
- Every feature section has the same shape: `div.relative.h-[NNNvh]` > `div.sticky.top-0.h-svh.overflow-x-clip`. Scrub distance = wrapper height − 100vh.
- Section heights: hero 320vh, word reveal 320vh, start 460vh, 3D 380vh, effects 520vh, vector 480vh, UI screens 440vh, AI 400vh, export 380vh. The page is about 40 screens tall.
- The title + one-line subtitle stay at the top of the stage while the product mock below them does the work.

## Section by section

| # | Blox section | Pinned | What moves | Scrub distance | Eri translation |
|---|---|---|---|---|---|
| 1 | Hero "IT MOVES. IT'S EASY. IT'S ENDLESS." | Yes (320vh) | Headline + 2 square buttons at the top. An editor window rises from below, then tilts in 3D (rotateX/Y) and scales toward the camera as you scroll. The inner poster keeps animating. | ~220vh | Hero (DESIGN §1): headline + buttons on light bg, a blue grid stage, and the **phone** rising out of it. As you scroll, the phone tilts and scales and the alert cards and ₦ coins drift in parallax. At the end, hand the phone off to §3. |
| 2 | Word reveal "Other tools make you learn animation. Here it's clicks, drag & drop, or just asking through MCP." | Yes (320vh) | Words go from ~20% to 100% opacity one at a time. One inline word gets a square outline box (an "editor selection") as it lights up. | ~220vh | §2 "Customers send screenshots. Screenshots lie. **Bank alerts don't.**" Same per-word opacity scrub. Give "Bank alerts don't." the electric-blue colour plus a square selection box, mirroring their trick. |
| 3 | "Start from anything." | Yes (460vh) | Editor mock: left panel (Shape / Text / Photo / SVG / Blox). A fake cursor draws a selection rectangle, then a shape/text appears and gets styled (font list, fill, hole %). | ~360vh | §3 "The alert lands": the phone replaces the editor. The bank notification slides down, the Eri card picks it up, the product row highlights, stock 4→3 ticks, profit +₦7,500 counts. The "cursor" is the money itself, not a hand. Label "0 taps". |
| 4 | "From flat to 3D." | Yes (380vh) | A 3D logo object rotates under a studio light while a FINISH picker on the right steps through Glossy → Chrome → Clay → Holo as you scroll. | ~280vh | §4 "The fake": the same idea of one object with stepped states. Two receipts side by side, a scan line sweeps both, and the verdict chips step ✅ / ❌ the way their finish picker does. |
| 5 | "Effects that run live." | Yes (520vh) | One full-bleed canvas. An effects list on the right (Grid, Fluid, Kaleidoscope, ASCII, Newspaper, Thermal, Dithering…) and the active effect changes by scroll segment. | ~420vh | §5 "I don pay": one stage, state stepped by scroll. A WhatsApp preview, then a 10-min ring timer that drains with scroll, then the ⚠️ warning. Fewer states (3), so ~350vh is enough. |
| 6 | "Draw it by hand." | Yes (480vh) | Bezier "hello" with handles visible. Handles move, stroke width varies, then the path draws on (stroke-dashoffset). | ~380vh | §6 "Books write themselves": the P&L line/bar chart **draws on** the same way (stroke-dashoffset scrubbed), then the totals count up. |
| 7 | "Drop a static UI screen. Watch it build." | Yes (440vh) | A static dashboard screenshot, then its parts (sidebar, cards, charts) get outlined, labelled and animate in one by one. | ~340vh | §6/§8 alternative: the Eri dashboard assembles itself (sales card, profit card, low-stock chip). Good for the end of §6. |
| 8 | "Or just ask." | Yes (400vh) | Chat panel on the left (prompt, tool calls ticking ✓), canvas on the right building a poster layer by layer. | ~300vh | §7 Canary: the left column is a feed of "fake caught" events ticking in; the right is the Nigeria dot map with a pulse travelling between vendors. |
| 9 | "Send it anywhere." | Yes (380vh) | The canvas re-crops between aspect ratios (1:1, 9:16, 16:9) and the export panel updates. | ~280vh | §9 Eri Score: the Instagram bio link morphs into the verified score page (a crop/morph between two frames). |
| — | "Then share it." + final CTA | No | Static content, embed snippet, glow CTA. | — | §8 Privacy + footer: static, single dark band. |

## Rules we take from it

1. **One stage, one story per section.** Each pinned section shows one product action from start to finish. No section shows two features.
2. **Scrubbed, not autoplayed.** Every state is a function of scroll progress, so scrolling back rewinds. Small loops (the poster) can autoplay *inside* the stage.
3. **Title pinned at the top, mock below.** A judge reads the claim first, then watches it happen.
4. **~100vh of scroll per state change.** Blox gets 3–4 states into 300–500vh. For us: §3 has 4 states (alert, match, stock, profit) → 400vh. §4 has 3 → 400vh incl. the reasons typing. §5 has 3 → 350vh.
5. **Sharp corners, one blue accent.** Same as our tokens. Blox is dark; Eri stays light (`#e5eaf2` bg, white cards).
6. **Reduced motion:** Blox doesn't offer a fallback that we could see. We will: each pinned section becomes a static row of step cards.
