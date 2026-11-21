# Generated Assets Log

Google Flow project: **"Nov 21 - 10:04"** (rename it to "Eri landing assets"; I didn't rename it, because clicking the title opened the image editor), https://flow.google.com/project/9f2317b9-226c-44f8-993e-afb2404b3b0e
Model: Nano Banana 2.1 (Flow default), 2 takes per prompt. All 8 takes are downloaded to `docs/assets-staging/` as WebP (`eri-hero-light-1/2`, `eri-vendor-packing-1/2`, `eri-naira-coins-1/2`, `eri-phone-dark-1/2`). On Day 1, move the chosen ones into `web/public/media/`. The coins need background removal before use.

| # | Asset | Prompt (short) | Take to use | Size | Used in |
|---|---|---|---|---|---|
| 1 | Light hero still: phone on pale wood table, packed Ankara orders, blue tape dispenser, empty right side for text | "Same scene but light and airy… off-white #e5eaf2 wall… electric blue accents… empty space on the right" | Take 1 | 1376×768 | Hero background option / Section 8 |
| 2 | Vendor packing: young Nigerian woman folding Ankara into nylon bag, blue phone on stand, bright room | "young Nigerian woman online fashion vendor… bright white desk… sunlit room" | Take 1 (smiling, phone in frame) | 1376×768 | Section 2 backdrop / About |
| 3 | 3D gold ₦ coins, isolated on white | "3D render… glossy gold coins embossed with ₦… pure white background" | Either; remove background → PNG/WebP with alpha | 512×512 (upscale in Flow before export) | Hero (right-side coin cluster) |
| 4 | Dark moody version of #1 | "phone… dark wooden table at night… navy shadows, blue rim light" | Not for the light site; keep for social/pitch deck | 1376×768 | Pitch deck only |

| 5 | Hand holding a phone, blank white screen, off-white studio bg, blue rim on the phone edge | "photorealistic product shot in bright daylight: a hand holding a modern Android smartphone upright… plain soft off-white (#e5eaf2) studio background… screen plain white… electric blue (#3b5bff) rim light… No text, no logos." The first version named "a Nigerian woman's hand" and was blocked by Flow's policy filter, so this take's hand isn't specifically Nigerian. | Take 2 (bluer bg, closer to `#e5eaf2`), `eri-hand-phone-2.webp`; take 1 also kept | 2752×1536 (2K upscale) | §3 Alert lands stage, §5 |
| 6 | Hero loop A: blue light trails on off-white | Veo 3.1 Lite, 16:9, 8s: "abstract soft off-white (#e5eaf2) background with thin electric blue (#3b5bff) light trails drifting slowly… left to right… Static camera. No text… no audio." | `eri-hero-loop-trails.mp4` | 1280×720, 15.8s, 1.4 MB | §1 Hero background |
| 7 | Hero loop B: blue streaks rising over a faint square grid | Veo 3.1 Lite, 16:9, 8s: "bright soft off-white (#e5eaf2) background with a faint white square grid, and a few soft electric blue (#3b5bff) light streaks rising slowly on a gentle diagonal…" | `eri-hero-loop-grid.mp4` | 1280×720, 15.8s, 0.9 MB | §1 Hero (matches the grid stage), §9 CTA |
| 8 | Parcel being taped: nylon bag of Ankara, brown tape, wooden table | Veo 3.1 Lite, 16:9, 8s: "close-up of two hands taping shut a clear nylon parcel bag holding neatly folded colourful Ankara fabric on a light wooden table, then pressing a plain white blank shipping label onto it…" | `eri-parcel-taping-loop.mp4` | 1280×720, 7.9s, 2.3 MB | §2 / About, social |

All generated 21 Nov 2026. Videos cost 10 credits each (30 total) and were downloaded at 720p; 1080p needs a paid Flow upgrade.

**Notes on the video takes**
- Neither hero loop was seamless as generated: both start nearly empty and end full of light. I re-encoded each as forward + reversed (ffmpeg `reverse` + `concat`, x264 CRF 24, no audio), so they now loop cleanly at 15.8s.
- The parcel loop doesn't fit the brief well: the background is dark, not bright daylight, and it has blurry blue glowing text that looks like a sign. Use it cropped tight on the table, or regenerate on Day 5 if there are credits.

Still to do (Day 1, when moving to `web/public/media/`): remove the coin background, and upscale #1–#3 to 2K.
