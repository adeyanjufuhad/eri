# Inspiration Board

Links and notes only. **Do not commit downloaded Pinterest images** (they belong to their creators).

## Motion reference: Blox Studio

https://bloxweb-production.up.railway.app/

- 10 feature sections, each a tall scroll wrapper (`h-[320vh]` to `h-[520vh]`) with a sticky stage.
- The stage is a **live mock of the product** (an editor), and scrolling drives a fake cursor through real actions: dragging a shape, picking a colour, toggling 3D material (Glossy / Chrome / Clay / Matte).
- Headlines use **scroll-driven word reveal** (dim → full colour, one word at a time).
- `--radius: 0` everywhere, Lexend display type, navy `#171d27` + electric blue `#3b5bff`, square buttons.
- **Eri translation:** the stage is a **phone**; the "cursor" is a bank notification and the matching engine; scrolling plays a sale being logged, a fake being caught, a claim timing out. See `docs/DESIGN.md` storyboard.

## Pinterest (first pass, dark-theme searches, 21 Nov 2026; kept for reference, the light picks are below)

Open each search, pick the 2–3 strongest pins per row, and add their URL + what to borrow to the table at the bottom. The pin IDs below are the top results for each search when they were collected. Open them before relying on them, because results change.

| Search | Use for section | Top pins |
|---|---|---|
| [fintech landing page dark](https://www.pinterest.com/search/pins/?q=fintech%20landing%20page%20dark) | 1 Hero, 9 CTA | [1](https://www.pinterest.com/pin/1078119598320422090/) · [2](https://www.pinterest.com/pin/703406035599780082/) · [3](https://www.pinterest.com/pin/1134062749951073941/) · [4](https://www.pinterest.com/pin/1136384918500943783/) |
| [scrollytelling website parallax](https://www.pinterest.com/search/pins/?q=scrollytelling%20website%20parallax) | 2 Word reveal, 3–6 pinned stages | [1](https://www.pinterest.com/pin/186829084537134644/) · [2](https://www.pinterest.com/pin/228979962296979687/) · [3](https://www.pinterest.com/pin/1107181889670838573/) · [4](https://www.pinterest.com/pin/914019686865063560/) |
| [phone mockup landing page animation](https://www.pinterest.com/search/pins/?q=phone%20mockup%20landing%20page%20animation) | 1 Hero phone, 3 Alert lands | [1](https://www.pinterest.com/pin/234398355598861981/) · [2](https://www.pinterest.com/pin/999025129884487134/) · [3](https://www.pinterest.com/pin/333759022406823529/) |
| [bank notification app ui](https://www.pinterest.com/search/pins/?q=bank%20notification%20app%20ui) | 3 Alert lands, 5 "I don pay" | [1](https://www.pinterest.com/pin/930204498053255580/) · [2](https://www.pinterest.com/pin/932315560384275349/) · [3](https://www.pinterest.com/pin/1101059809022807204/) |
| [electric blue navy website design](https://www.pinterest.com/search/pins/?q=electric%20blue%20navy%20website%20design) | Colour + type system | [1](https://www.pinterest.com/pin/897483032009257323/) · [2](https://www.pinterest.com/pin/1147292073898216928/) · [3](https://www.pinterest.com/pin/961518589377033732/) |
| [brutalist sharp web design blue](https://www.pinterest.com/search/pins/?q=brutalist%20sharp%20web%20design%20blue) | Sharp-corner layout, grids | [1](https://www.pinterest.com/pin/1097330265459344476/) · [2](https://www.pinterest.com/pin/1141169993127162895/) · [3](https://www.pinterest.com/pin/1126462925580460067/) |
| [african fintech app ui](https://www.pinterest.com/search/pins/?q=african%20fintech%20app%20ui) | Tone, people, copy voice | [1](https://www.pinterest.com/pin/880031583456934319/) · [2](https://www.pinterest.com/pin/703687510567644331/) · [3](https://www.pinterest.com/pin/584623595419027947/) |
| [inventory profit dashboard mobile app dark](https://www.pinterest.com/search/pins/?q=inventory%20profit%20dashboard%20mobile%20app%20dark) | 6 Books write themselves; app dashboard | [1](https://www.pinterest.com/pin/350577152266452519/) · [2](https://www.pinterest.com/pin/939211697325600399/) · [3](https://www.pinterest.com/pin/886786982905643692/) · [4](https://www.pinterest.com/pin/1036953882953460237/) |

## Chosen references (light-theme pass, 21 Nov 2026)

Picked from the seven light-theme searches in KICKOFF_PROMPT A1, signed in to Pinterest in Chrome. Screenshots kept timing out, so most picks are from Pinterest's own pin descriptions. **Give each a quick visual check before using it** and delete any that look wrong.

| # | URL | What to borrow | Section |
|---|---|---|---|
| 1 | https://www.pinterest.com/pin/622270873558113007/ | **The model.** Ledger animated hero: camera dives into the phone while payment notifications pop in over 3D coins and cards. Light page, blue grid stage. Layout + motion. | 1 Hero |
| 2 | https://www.pinterest.com/pin/1107181889669418207/ | Polished 3D moment with scroll animation (Flowty). Motion: object turns as you scroll. | 1 Hero exit, 3 |
| 3 | https://www.pinterest.com/pin/1107181889670838573/ | Scrollytelling page with a hero object that travels between sections. Shared-element handoff. | 1 → 3 handoff |
| 4 | https://www.pinterest.com/pin/333759022406823529/ | Phone-mockup landing animation. Phone staging and scale. | 1, 3 |
| 5 | https://www.pinterest.com/pin/1091208184864955406/ | Hand holding a phone, blank screen, white bg. Reference for the Flow "hand + phone" still. | 3 Alert lands |
| 6 | https://www.pinterest.com/pin/1101833865111960768/ | Hand gripping the phone from the top, focus on the screen. Crop for the phone stage. | 3, 5 |
| 7 | https://www.pinterest.com/pin/932315560384275349/ | "Account updates as they happen" notification screen. Notification card layout and hierarchy. | 3 Alert lands |
| 8 | https://www.pinterest.com/pin/902690319089366010/ | Banking exploration (@that.design.life). Card + amount type scale for the Eri dashboard. | App dashboard, 6 |
| 9 | https://www.pinterest.com/pin/1100145015255582944/ | Pay balance app. Big balance number + recent activity list. Type and number styling. | App dashboard, 1 phone screen |
| 10 | https://www.pinterest.com/pin/930204498051248709/ | Zenvest fintech app (balance, income/expense, history). Light fintech colour use. | App, 6 Books |
| 11 | https://www.pinterest.com/pin/666040232440996082/ | Finance app design (@sujon.co). Light card stack and spacing. | App screens |
| 12 | https://www.pinterest.com/pin/1030479958508079999/ | Hand + phone on a solid blue background. Colour blocking for the blue hero stage. | 1 Hero, 9 CTA |
| 13 | https://www.pinterest.com/pin/1126462925580460067/ | Light cyber-brutalism UI (Vercel style). Sharp corners, hairline borders, mono labels on light. | Global layout, grids |
| 14 | https://www.pinterest.com/pin/1150951248551126147/ | Brutalist UI/UX page. Hard grid, oversized type. | 2 Word reveal, section titles |
| 15 | https://www.pinterest.com/pin/1141169993127162895/ | "Code meets character" in blue and white. Electric blue on white with heavy display type. | Colour + type system |
| 16 | https://www.pinterest.com/pin/929148966845556885/ | White and blue page, "great design is a force of nature". Calm white space + one blue accent. | 8 Privacy, 9 CTA |
| 17 | https://www.pinterest.com/pin/586101339050514963/ | African fintech ad: woman holding a phone, "don't wait for confirmation". Tone and people, close to Eri's message. | 2, 5, social |
| 18 | https://www.pinterest.com/pin/880031583456934494/ | African fintech landing page with money coming out of the phone. Like our coins + alerts hero. | 1 Hero |
| 19 | https://www.pinterest.com/pin/1090363759819307659/ | Cross-border Africa app (GHS/ZAR), phone in hand. Copy voice and local feel. | 9 CTA, copy |

## Round 2: futuristic hero + blocky curved logo (21 Nov 2026, built-in browser)

Fuhad asked for a less tidy, more futuristic hero, and a black-and-white logo that is "blocky and curved".

| # | URL | What to borrow | Use |
|---|---|---|---|
| L1 | https://www.pinterest.com/pin/472033604715378560/ | Square block with the "e" cut out as negative space: a half-round counter and a slot. The closest to "blocky curved". | Logo mark |
| L2 | https://www.pinterest.com/pin/470274386112192652/ | Same idea reversed: white block on black, e from a half-circle and a bar. | Logo on dark |
| L3 | https://www.pinterest.com/pin/473792823319120370/ | Rounded pixel blocks snapped to a grid. Proves a mark can be built from one block size. | Logo construction |
| L4 | https://www.pinterest.com/pin/464152305363052359/ | Four quarter-circle blocks making one form. | Logo curves |
| L5 | https://www.pinterest.com/pin/1113655814129467663/ | Chunky curved letters on a cube's faces, B&W. | Wordmark weight |
| L6 | https://www.pinterest.com/pin/611715561928308621/ | Curved strokes inside a hard cube, white on black. | App icon on dark |
| L7 | https://www.pinterest.com/pin/1093319247068779639/ | Heavy rounded "e" with a tiny aperture. | Wordmark "e" |
| H1 | https://www.pinterest.com/pin/965599976383554814/ | Giant faded wordmark behind the subject; the subject overlaps the type. | Hero depth |
| H2 | https://www.pinterest.com/pin/391039180166639485/ | Name set huge at the bottom edge, cropped, person cutting through it. | Hero type scale |
| H3 | https://www.pinterest.com/pin/949204059009354997/ | Full-bleed wordmark + bold stat numbers (1000+, 40+) in a hard grid. | Hero stats row |
| H4 | https://www.pinterest.com/pin/1078471442027698895/ | Headline split left/right with the image wedged between the words. | Hero layout |
| H5 | https://www.pinterest.com/pin/1151936410991794997/ | "BOLD NEW FORMS": loud type on one strong colour field with a figure in front. | Blue stage + type |

**Direction we're taking:** keep it light and keep the blue grid, but break the tidiness. Huge cropped type behind the hand (depth), a live alert ticker band across the stage, HUD-style mono labels at the grid corners, and the new blocky-curved logo.

## Round 3: curves, calm, problem → solution (22 Nov 2026, built-in browser)

Fuhad finds the radius-0 brutalist page too blocky and messy. Read each site's H1 and sampled computed `border-radius` (no screenshots). Cash App, Monzo and Brex blocked the fetch.

| # | URL | H1 (first screen) | Radius sampled | What to borrow |
|---|---|---|---|---|
| R1 | https://mercury.com | "Radically different banking" | CTAs 40px pills, cards 12px, big panels 32px | Two radii only: pill for actions, soft card for content. "Banking's been a headache. Now, it's a head start." Pain named, then answered. |
| R2 | https://linear.app | "The product development system…" | buttons 9999px pills, cards 8–12px | Calm dark-on-light rhythm, one product mockup per section, short labelled chapters. |
| R3 | https://wise.com | "Send money globally for less" | CTAs 9999px pills, cards 24px | Hero shows the real thing working (live calculator). Problem → solution via a plain comparison with numbers. |
| R4 | https://stripe.com | "Financial infrastructure to grow your revenue." | small 4–6px | Bento tiles, each a tiny live UI demo (fraud score, billing). Borrow the "every tile proves one claim" rule, not the small radius. |
| R5 | https://www.ramp.com | "Time is money. Save both." | 6px / 12px | A two-beat headline that states the pain and the promise in five words. |
| R6 | https://moniepoint.com | "Simple solutions to power your business" | 8px controls, 12–20px cards | Nigerian SME tone; soft cards around plain feature lists. |
| R7 | https://paystack.com | "Modern online and offline payments for Africa" | small 2–5px, 60px pill CTA | One clear pill CTA on a calm page; African fintech voice. |
| R8 | https://kuda.com | "The digital bank built for Nigerians" | 4px, cards 21px | Three numbered blocks (Send / Spend / Save), then a "Kuda vs others" table. Numbered steps = our 1-2-3. |

**Direction we're taking:** a radius scale (10 / 16 / 24 / 32px + pill), pill buttons and tags, rounded stage and cards, one surface per section with more white space, and no HUD crosshairs, faint grids or rotated ticker. The first screen names the problem (fake "I've paid" screenshots) next to the answer (the real alert), like Wise and Mercury do.
