# Generated Assets Log

Google Flow project: **"Nov 21 - 10:04"** (rename it to "Eri landing assets"), https://flow.google.com/project/9f2317b9-226c-44f8-993e-afb2404b3b0e
Model: Nano Banana 2.1 (Flow default), 2 takes per prompt. All 8 takes are downloaded to `docs/assets-staging/` as WebP (`eri-hero-light-1/2`, `eri-vendor-packing-1/2`, `eri-naira-coins-1/2`, `eri-phone-dark-1/2`). On Day 1, move the chosen ones into `web/public/media/`. The coins need background removal before use.

| # | Asset | Prompt (short) | Take to use | Size | Used in |
|---|---|---|---|---|---|
| 1 | Light hero still: phone on pale wood table, packed Ankara orders, blue tape dispenser, empty right side for text | "Same scene but light and airy… off-white #e5eaf2 wall… electric blue accents… empty space on the right" | Take 1 | 1376×768 | Hero background option / Section 8 |
| 2 | Vendor packing: young Nigerian woman folding Ankara into nylon bag, blue phone on stand, bright room | "young Nigerian woman online fashion vendor… bright white desk… sunlit room" | Take 1 (smiling, phone in frame) | 1376×768 | Section 2 backdrop / About |
| 3 | 3D gold ₦ coins, isolated on white | "3D render… glossy gold coins embossed with ₦… pure white background" | Either; remove background → PNG/WebP with alpha | 512×512 (upscale in Flow before export) | Hero (right-side coin cluster) |
| 4 | Dark moody version of #1 | "phone… dark wooden table at night… navy shadows, blue rim light" | Not for the light site; keep for social/pitch deck | 1376×768 | Pitch deck only |

Still to generate (Day 0–1):
- Hero background loop (6–8s, seamless): soft off-white with slow electric-blue light trails
- Close-up: hand holding an Android phone, blank glowing screen, bright light (for compositing UI)
- Upscaled 2K versions of #1–#3
