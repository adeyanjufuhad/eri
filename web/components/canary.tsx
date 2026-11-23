"use client";

import { useRef } from "react";
import { gsap, useGSAP } from "@/lib/gsap";
import { SectionTag, h2Class } from "@/components/stage-frame";

// ── map ─────────────────────────────────────────────────────────────────────
// Simplified Nigeria border (lon, lat), good enough for a dotted silhouette. Not for navigation.
const BORDER: [number, number][] = [
  [2.69, 6.37], [2.75, 7.9], [3.1, 9.1], [3.65, 10.2], [3.6, 11.7], [4.1, 13.5], [5.4, 13.9], [6.4, 13.6],
  [7.8, 13.3], [9.0, 12.8], [10.1, 13.3], [11.5, 13.3], [12.3, 13.1], [13.1, 13.6], [14.2, 13.1], [14.6, 12.2],
  [14.2, 11.3], [13.6, 10.6], [13.2, 9.6], [12.9, 8.8], [12.2, 8.3], [11.8, 7.2], [11.1, 6.5], [10.6, 7.0],
  [9.8, 6.8], [9.3, 6.2], [8.8, 5.5], [8.5, 4.7], [7.5, 4.5], [6.7, 4.3], [5.9, 4.3], [5.4, 5.1], [4.6, 6.2],
  [3.5, 6.4],
];
const K = 40; // px per degree
const px = (lon: number, lat: number) => [(lon - 2.4) * K, (14.2 - lat) * K] as const;

function inside(lon: number, lat: number) {
  let hit = false;
  for (let i = 0, j = BORDER.length - 1; i < BORDER.length; j = i++) {
    const [xi, yi] = BORDER[i];
    const [xj, yj] = BORDER[j];
    if (yi > lat !== yj > lat && lon < ((xj - xi) * (lat - yi)) / (yj - yi) + xi) hit = !hit;
  }
  return hit;
}

// the dot matrix, computed once at module load (≈700 dots)
const DOTS: (readonly [number, number])[] = [];
for (let lat = 4.3; lat <= 14; lat += 0.32) {
  for (let lon = 2.7; lon <= 14.7; lon += 0.32) if (inside(lon, lat)) DOTS.push(px(lon, lat));
}

// one path for the whole dot field (700 separate circles cost layout time on phones): two arcs per round dot
const DOTS_PATH = DOTS.map(([x, y]) => `M${(x - 1.7).toFixed(1)} ${y.toFixed(1)}a1.7 1.7 0 1 0 3.4 0a1.7 1.7 0 1 0-3.4 0z`).join("");

type City = { name: string; lon: number; lat: number };
const SOURCE: City = { name: "Lagos", lon: 3.38, lat: 6.52 };
// the vendors the fingerprint reaches, in the order the arcs land
const REACHED: City[] = [
  { name: "Ibadan", lon: 3.9, lat: 7.38 },
  { name: "Port Harcourt", lon: 7.0, lat: 4.82 },
  { name: "Abuja", lon: 7.49, lat: 9.06 },
  { name: "Kano", lon: 8.52, lat: 12.0 },
];
const OTHERS: City[] = [
  { name: "Kaduna", lon: 7.44, lat: 10.52 },
  { name: "Enugu", lon: 7.5, lat: 6.45 },
  { name: "Benin City", lon: 5.62, lat: 6.34 },
  { name: "Jos", lon: 8.89, lat: 9.9 },
  { name: "Maiduguri", lon: 13.15, lat: 11.83 },
  { name: "Onitsha", lon: 6.78, lat: 6.15 },
  { name: "Aba", lon: 7.37, lat: 5.1 },
];

const [sx, sy] = px(SOURCE.lon, SOURCE.lat);
// a gentle arc from Lagos: control point lifted above the midpoint
const arc = (c: City) => {
  const [x, y] = px(c.lon, c.lat);
  const mx = (sx + x) / 2;
  const my = (sy + y) / 2 - Math.hypot(x - sx, y - sy) * 0.28;
  return `M${sx} ${sy}Q${mx} ${my} ${x} ${y}`;
};
const [ax, ay] = px(REACHED[2].lon, REACHED[2].lat); // Abuja, where the warning lands

// §7: a Lagos vendor catches a fake; its fingerprint (hashes only) travels to other vendors;
// in Abuja the same scammer messages someone and they're warned. HTML is the finished state.
export function Canary() {
  const root = useRef<HTMLElement>(null);

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        const tl = gsap.timeline({
          scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
          defaults: { ease: "eri-out", duration: 0.06 },
        });

        tl.set(q("[data-vendor]"), { opacity: 0.25 }, 0)
          .set(q("[data-catch]"), { opacity: 0 }, 0)
          .set(q("[data-ping]"), { attr: { r: 5 }, opacity: 0 }, 0)
          .set(q("[data-arc]"), { attr: { "stroke-dashoffset": 1 } }, 0)
          .set(q("[data-hit]"), { opacity: 0, scale: 0.6, transformOrigin: "50% 50%" }, 0)
          .set(q("[data-warn]"), { opacity: 0, y: 10 }, 0)
          .set(q("[data-hash]"), { opacity: 0 }, 0);

        // 1. vendors on the network light up (a wave, west to east, not a metronome)
        tl.to(q("[data-vendor]"), { opacity: 1, duration: 0.08, stagger: { each: 0.012, ease: "power1.out" } }, 0.04);

        // 2. Lagos catches a fake: red ping, label
        tl.to(q("[data-catch]"), { opacity: 1 }, 0.22)
          .to(q("[data-ping]"), { opacity: 1, duration: 0.01 }, 0.22)
          .to(q("[data-ping]"), { attr: { r: 26 }, opacity: 0, duration: 0.12, ease: "power1.out" }, 0.23);

        // 3. the fingerprint (hashes only) travels: arcs draw out from Lagos, each vendor marks it on arrival
        tl.to(q("[data-hash]"), { opacity: 1 }, 0.34);
        q("[data-arc]").forEach((el, i) => {
          const at = 0.36 + i * 0.05;
          tl.to(el, { attr: { "stroke-dashoffset": 0 }, duration: 0.1, ease: "power2.inOut" }, at).to(
            q("[data-hit]")[i],
            { opacity: 1, scale: 1, duration: 0.04 },
            at + 0.09,
          );
        });

        // 4. the same scammer tries Abuja: the warning lands there
        tl.to(q("[data-warn]"), { opacity: 1, y: 0, duration: 0.08 }, 0.7).to({}, { duration: 0.2 }, 0.8);
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} id="canary" className="pin h-[320vh]" aria-labelledby="canary-title">
      <div className="stage flex items-center px-5 pt-16 sm:px-8">
        <div className="mx-auto grid w-full max-w-6xl items-center gap-6 md:grid-cols-[1fr_auto] md:gap-12">
          <div>
            <SectionTag step="Step 2">Warns other vendors</SectionTag>
            <h2
              id="canary-title"
              className={`mt-5 ${h2Class}`}
            >
              One catch
              <br />
              warns everyone.
            </h2>
            <p className="mt-4 max-w-md text-sm text-muted-foreground sm:text-base">
              When Eri catches a fake, it shares a fingerprint with other Eri vendors: a hash of the receipt image, the
              sender&rsquo;s name and phone. The next vendor that scammer tries is warned before they ship.
            </p>
            <div className="mt-6 hidden max-w-md grid-cols-3 gap-2 md:grid">
              {[
                ["Hashes", "only, never images"],
                ["0", "names or numbers shared"],
                ["1", "report per vendor, so counts can't be faked"],
              ].map(([k, v]) => (
                <div key={k} className="rounded-2xl bg-card p-3.5 shadow-soft">
                  <p className="font-display text-xl font-semibold tracking-[-0.03em]">{k}</p>
                  <p className="text-xs text-muted-foreground">{v}</p>
                </div>
              ))}
            </div>
          </div>

          <div className="relative mx-auto w-full max-w-[520px] md:w-[520px]">
            <svg viewBox="0 0 500 410" className="w-full" role="img" aria-label="Map of Nigeria with Eri vendors">
              <g fill="var(--foreground)" opacity="0.3">
                <path d={DOTS_PATH} />
              </g>

              {REACHED.map((c) => (
                <path
                  key={c.name}
                  data-arc
                  d={arc(c)}
                  fill="none"
                  stroke="var(--primary)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  pathLength={1}
                  strokeDasharray="1"
                  strokeDashoffset="0"
                />
              ))}

              {[...OTHERS, ...REACHED].map((c) => {
                const [x, y] = px(c.lon, c.lat);
                return <circle key={c.name} data-vendor cx={x} cy={y} r="4.5" fill="var(--foreground)" />;
              })}
              {REACHED.map((c) => {
                const [x, y] = px(c.lon, c.lat);
                return (
                  <circle key={c.name} data-hit cx={x} cy={y} r="9" fill="none" stroke="var(--suspicious)" strokeWidth="2" />
                );
              })}

              {/* Lagos: the catch */}
              <circle data-ping cx={sx} cy={sy} r="26" fill="none" stroke="var(--not-received)" strokeWidth="2" opacity="0" />
              <circle cx={sx} cy={sy} r="6.5" fill="var(--not-received)" />
              <g data-catch>
                <rect x={sx - 6} y={sy + 12} width="140" height="24" rx="12" fill="var(--not-received)" />
                <text x={sx + 5} y={sy + 28} fill="#fff" fontSize="11" fontWeight="600" fontFamily="var(--font-inter)">
                  ✕ Fake caught · Lagos
                </text>
              </g>
              <g data-hash>
                <text x={sx - 6} y={sy + 50} fill="var(--muted-foreground)" fontSize="10" fontFamily="ui-monospace, monospace">
                  sha256 · 9f3c…a71e
                </text>
              </g>
            </svg>

            <div
              data-warn
              className="absolute w-[230px] rounded-2xl border-2 border-suspicious bg-card p-3 shadow-lift max-sm:w-[180px]"
              style={{ left: `${((ax + 16) / 500) * 100}%`, top: `${((ay - 14) / 410) * 100}%` }}
            >
              <p className="text-[11px] text-muted-foreground">Abuja vendor · WhatsApp</p>
              <p className="mt-0.5 text-[12px] font-semibold">Tunde Bakare: “I don pay, check am”</p>
              <p className="mt-2 flex items-center gap-1.5 text-[12px] font-semibold text-suspicious">
                <span aria-hidden>⚠</span> Flagged by 3 Eri vendors this week
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
