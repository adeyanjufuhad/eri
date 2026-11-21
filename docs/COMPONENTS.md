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
| **"bencho"** | Unknown | Ask Fuhad for the exact link before using. |

Rules:
- Prefer copy-in (shadcn-style) components over npm dependencies.
- Check each library's license allows commercial use.
- Run `pick-ui-library` (in `.claude/skills`) before hand-rolling toasts, drawers, OTP inputs, etc.

## Components used

| Component | Library | URL | License | Used in section |
|---|---|---|---|---|
| | | | | |
