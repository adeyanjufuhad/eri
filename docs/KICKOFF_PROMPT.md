# Master Prompt for Claude Code

Copy everything inside the box below and paste it into Claude Code, run from the root of your local clone of `adeyanjufuhad/eri`.

**Run Part A on Sat 22 / Sun 23 Nov** (setup, research and assets; no source code). **Run Part B from Mon 23 Nov.**

---

```text
You are the lead engineer and design engineer for Eri, my Mavuly Hackathon 2026 entry.
Before anything else, read these files in full: CLAUDE.md, docs/PLAN.md, docs/DATA_MODEL.md,
docs/DESIGN.md, docs/COMPONENTS.md. They are the source of truth. If anything I say here
conflicts with them, stop and ask me.

## Operating rules
- Work only on the `frontend` branch. Run `git checkout frontend && git pull` first and
  confirm the branch before every commit. Never push to `main`.
- Never add a "Co-authored-by" / "Co-Authored-By" trailer to any commit message.
- No app or landing-page source code may be committed before Mon 23 Nov 2026 (WAT).
  Check today's date with `date` first. If it is before 23 Nov, do Part A only.
- Use a task list. Tick tasks off as you finish them. Commit after each finished task.
- When something needs me (a login, a paid service, a decision that's hard to undo),
  stop and ask in one short message. Don't guess.

## Skills
The Emil Kowalski skills are already vendored in .claude/skills (MIT). Confirm they load.
If they don't, run: npx skills@latest add emilkowalski/skills
Use them: `animate` + `choreograph` before writing any motion, `emil-design-eng` for polish,
`pick-ui-library` before hand-rolling UI primitives, `review-animations` after each section,
`break-ui` on every app screen before Day 5.

## PART A: Setup, research and assets (allowed before 23 Nov; no source code)

A1. Inspiration (Pinterest, via the Chrome browser tools; I am signed in to Pinterest in Chrome).
    Search boards for: "fintech app dark UI", "scrollytelling landing page", "phone mockup
    parallax", "bank notification UI", "brutalist sharp corners web design", "electric blue
    navy website", "African fintech app". Pick the 15–20 strongest references.
    Write docs/inspo/README.md: for each, the Pinterest URL, one line on what to borrow
    (layout, motion, colour, type), and which landing-page section (1–9 in DESIGN.md) it serves.
    Do NOT download or commit Pinterest images.

A2. Motion reference. Open https://bloxweb-production.up.railway.app/ in the browser,
    scroll slowly through every pinned section, and write docs/inspo/BLOX_NOTES.md:
    for each section, what is pinned, what moves, what scroll distance drives it, and how
    we'll translate that into Eri's phone-based sections. Borrow the pattern, never its content.

A3. Visual assets with Google Flow (I am signed in to Google in Chrome; open https://labs.google/fx/tools/flow).
    The site and app are LIGHT-themed. Generate in our palette (off-white #e5eaf2, white,
    electric blue #3b5bff, ink #0f141d), bright daylight, no text in images:
    - 2 hero background loops (8s, seamless, soft off-white with electric-blue light trails)
    - 3 stills: an Android phone on a light wooden table beside packed orders (nylon bags, tape),
      a Nigerian online vendor packing clothes in a bright room, close-up of a hand
      holding a phone with a glowing notification (screen content blank, we composite UI later)
    - 1 short loop (6–8s): a parcel being taped and labelled, warm light
    Download the best take of each to docs/assets-staging/. Log every prompt, date and
    filename in docs/ASSETS.md. No real public figures, no brand logos.

A4. Component scouting. Open each library in docs/COMPONENTS.md. For each landing-page
    section, shortlist 1–2 components (name + URL + license), and add them to the
    "Components used" table with status "shortlisted". Ask me for the "bencho" link.

A5. Commit docs/ and assets on `frontend` with a clear message. Stop and report:
    what you found, the asset list, and open questions.

## PART B: Build (from Mon 23 Nov; follow docs/PLAN.md day by day)

B1. Day 1 FIRST (the risky part): scaffold /app (Flutter, Android minSdk 24), get the
    notification listener running on my real phone, show raw bank notifications on a debug
    screen, write parsers for GTBank, OPay, Moniepoint, Kuda from the samples I give you,
    with unit tests. Record findings in docs/SPIKE.md (which banks show narration, sender
    name, session ID). Exit check from PLAN.md must pass before moving on.

B2. Supabase: create migrations from docs/DATA_MODEL.md exactly (enums, tables, RLS so a
    vendor only sees their own rows, the daily_pnl view). Ask me for the project URL/keys.
    Keys go in env files that are gitignored, and in Edge Function secrets.

B3. Continue Days 2–7 from docs/PLAN.md in order. Each day starts by re-reading that
    day's section and ends with its exit check + a commit + a 5-line progress note in
    docs/PROGRESS.md.

B4. Landing page (/web): Next.js + Tailwind v4 + motion/react + GSAP ScrollTrigger + Lenis.
    Build the 9 sections in docs/DESIGN.md. Pattern: tall wrapper + sticky stage +
    scroll-scrubbed timeline. The stage is a phone running a simulated Eri UI, built from
    real components (not images) so it stays crisp. Use the Flow assets from
    docs/assets-staging (move them to web/public/media, compress videos to ≤8MB, WebP stills).
    Reduced-motion fallback for every pinned section. Lighthouse performance ≥85 on mobile.
    Deploy to Vercel. Ask me before connecting the Vercel account.

## Quality bar
This should feel like a product a YC partner would remember: every animation explains
the product, nothing is decoration, the app works on a real phone, and a judge understands
it in 3 seconds. When in doubt, cut scope and polish what's left.
```
