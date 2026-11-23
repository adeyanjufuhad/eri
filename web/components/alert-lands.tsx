"use client";

import { useRef, useState } from "react";
import { useReducedMotion } from "motion/react";
import CountUp from "@/components/reactbits/CountUp";
import { gsap, ScrollTrigger, useGSAP } from "@/lib/gsap";
import { PhoneShell } from "@/components/phone";
import { naira } from "@/lib/naira";
import { SectionTag, h2Class } from "@/components/stage-frame";

// The demo sale, in kobo: sell ₦25,000, cost ₦17,500 → +₦7,500 profit. Profit today goes ₦12,000 → ₦19,500.
const SELL = 2_500_000;
const COST = 1_750_000;
const PROFIT_BEFORE = 1_200_000;
const PROFIT_AFTER = PROFIT_BEFORE + SELL - COST;

const steps = [
  { title: "A credit alert lands", body: "GTBank, OPay, Moniepoint, Kuda. Any bank on your phone." },
  { title: "Eri reads it, on the phone", body: "Amount, sender and note. The raw text never leaves." },
  { title: "It finds the product", body: "“ankara gown” is your Ankara Gown." },
  { title: "Stock and profit update", body: `4 left becomes 3. Profit goes up ${naira(SELL - COST)}.` },
];

const products = [
  { name: "Ankara Gown", price: SELL, left: [4, 3] as const, hit: true },
  { name: "Adire Two-piece", price: 1_800_000, left: [6] as const },
  { name: "Aso-oke Cap", price: 850_000, left: [9] as const },
];

// §3: one sale, start to finish, scrubbed by scroll. The HTML is the finished state, so reduced motion
// (and no JS) shows the end of the story; the timeline below rewinds it to the start when motion is allowed.
export function AlertLands() {
  const root = useRef<HTMLElement>(null);
  // past step 4 → React Bits Count Up plays (profit count, stock roll); scrolling back above it resets them
  const [sold, setSold] = useState(false); // off until scrolled to; reduced motion turns it on below
  const reduce = useReducedMotion();

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: reduce)", () => setSold(true)); // no scroll story: show the end state
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        const out = "eri-out";
        const st = ScrollTrigger.create({
          trigger: root.current,
          start: "top top",
          end: "bottom bottom",
          onUpdate: (self) => setSold(self.progress > 0.68),
        });
        setSold(st.progress > 0.68);

        const tl = gsap.timeline({
          scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
          defaults: { ease: out, duration: 0.08 },
        });

        // step captions: current one lit, the rest dimmed
        const lit = (i: number, at: number) => {
          tl.to(q("[data-step]"), { opacity: 0.35, duration: 0.04 }, at).to(
            q("[data-step]")[i],
            { opacity: 1, duration: 0.04 },
            at,
          );
        };

        tl.set(q("[data-step]"), { opacity: 0.35 }, 0)
          .set(q("[data-banner]"), { yPercent: -130, opacity: 0 }, 0)
          .set(q("[data-match]"), { opacity: 0, y: -10 }, 0)
          .set(q("[data-field]"), { opacity: 0, y: 6 }, 0)
          .set(q("[data-sold]"), { opacity: 0 }, 0)
          .set(q("[data-hit]"), { opacity: 0 }, 0)
          .set(q("[data-plus]"), { opacity: 0, scale: 0.9 }, 0);

        // 1. the alert drops in from the top of the screen
        lit(0, 0.08);
        tl.to(q("[data-banner]"), { yPercent: 0, opacity: 1, duration: 0.1 }, 0.1);

        // 2. Eri picks it up: the banner leaves, the parsed fields appear one by one in reading order
        lit(1, 0.3);
        tl.to(q("[data-banner]"), { yPercent: -130, opacity: 0, duration: 0.08 }, 0.32)
          .to(q("[data-match]"), { opacity: 1, y: 0 }, 0.34)
          .to(q("[data-field]"), { opacity: 1, y: 0, stagger: { each: 0.035, ease: "power1.out" } }, 0.38);

        // 3. the note matches the product: highlight the row
        lit(2, 0.52);
        tl.to(q("[data-hit]"), { opacity: 1, duration: 0.06 }, 0.54);

        // 4. stock rolls 4 → 3 while profit counts up; the +₦7,500 chip lands with the count
        lit(3, 0.66);
        tl.to(q("[data-plus]"), { opacity: 1, scale: 1, duration: 0.05 }, 0.72)
          .to(q("[data-sold]"), { opacity: 1, duration: 0.06 }, 0.86)
          .to({}, { duration: 0.08 }, 0.92); // hold the finished state before unpinning

        return () => {
          st.kill();
          setSold(false);
        };
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} id="sale" className="pin h-[420vh]" aria-labelledby="alert-lands-title">
      <div className="stage flex items-center px-5 pt-16 sm:px-8">
        <div className="mx-auto grid w-full max-w-6xl items-center gap-8 md:grid-cols-[1fr_auto] md:gap-16">
          <div>
            <SectionTag step="Step 1">Reads real alerts</SectionTag>
            <h2
              id="alert-lands-title"
              className={`mt-5 ${h2Class}`}
            >
              Money lands.
              <br />
              The sale logs itself.
            </h2>

            <ol className="mt-8 hidden space-y-5 md:block">
              {steps.map((s, i) => (
                <li key={s.title} data-step className="flex gap-4">
                  <span className="mt-0.5 grid size-7 shrink-0 place-items-center rounded-full bg-card text-xs font-semibold shadow-soft tabular">
                    {i + 1}
                  </span>
                  <div>
                    <p className="font-semibold">{s.title}</p>
                    <p className="mt-0.5 text-sm text-muted-foreground">{s.body}</p>
                  </div>
                </li>
              ))}
            </ol>

            <div className="mt-8 hidden w-fit items-baseline gap-3 rounded-full bg-card px-5 py-3 shadow-soft md:flex">
              <span className="font-display text-3xl font-semibold leading-none tracking-[-0.03em] tabular">0</span>
              <span className="font-semibold">taps.</span>
              <span className="text-sm text-muted-foreground">You didn&rsquo;t touch the phone.</span>
            </div>
          </div>

          <div className="relative mx-auto max-md:origin-top max-md:scale-[0.9]">
            <PhoneShell>
              {/* the bank notification, overlaid on the top of the screen */}
              <div data-banner className="absolute inset-x-2 top-9 z-10 rounded-2xl border border-border bg-card p-3 shadow-[0_12px_30px_-14px_rgb(15_20_29/0.45)]">
                <div className="flex items-center gap-2 text-[10px] text-muted-foreground">
                  <span className="grid size-4 place-items-center rounded-[5px] bg-foreground text-[9px] font-bold text-background" aria-hidden>
                    G
                  </span>
                  <span className="font-medium text-foreground">GTBank</span>
                  <span>· now</span>
                </div>
                <p className="mt-1.5 text-[12px] font-semibold">
                  Credit <span className="text-landed tabular">{naira(SELL)}</span>
                </p>
                <p className="text-[11px] text-muted-foreground">from CHIOMA OKAFOR · “ankara gown”</p>
              </div>

              <div className="px-4 pb-5 pt-4">
                <div className="flex items-center justify-between">
                  <span className="font-display text-lg font-semibold tracking-[-0.03em]">eri</span>
                  <span className="text-[10px] font-medium text-muted-foreground">Today</span>
                </div>

                <div className="relative mt-3 rounded-2xl bg-card p-4 shadow-soft">
                  <p className="text-[11px] text-muted-foreground">Profit today</p>
                  <p className="mt-1 font-display text-[30px] font-semibold leading-none tracking-[-0.03em] tabular">
                    <CountUp
                      key={sold ? "sold" : "before"}
                      from={PROFIT_BEFORE / 100}
                      to={PROFIT_AFTER / 100}
                      startWhen={sold}
                      trigger="load"
                      separator=","
                      prefix="₦"
                      duration={reduce ? 0 : 1.1}
                    />
                  </p>
                  <span data-plus className="absolute right-3 top-3 rounded-full bg-landed px-2.5 py-1 text-[11px] font-semibold text-white tabular">
                    +{naira(SELL - COST)}
                  </span>
                </div>

                <div data-match className="mt-3 rounded-2xl border border-landed/40 bg-card p-3">
                  <p className="flex items-center gap-2 text-[11px] font-semibold">
                    <span className="size-2 rounded-full bg-landed" aria-hidden />
                    Payment read from your GTBank alert
                  </p>
                  <dl className="mt-2 grid grid-cols-3 gap-1.5 text-[10px]">
                    {[
                      ["Amount", naira(SELL)],
                      ["From", "Chioma O."],
                      ["Note", "ankara gown"],
                    ].map(([k, v]) => (
                      <div key={k} data-field className="rounded-lg bg-muted px-2 py-1.5">
                        <dt className="text-muted-foreground">{k}</dt>
                        <dd className="truncate font-semibold tabular">{v}</dd>
                      </div>
                    ))}
                  </dl>
                  <p data-sold className="mt-2 text-[11px] font-semibold text-landed tabular">
                    Sold: Ankara Gown · +{naira(SELL - COST)} · 3 left
                  </p>
                </div>

                <p className="mt-4 text-[11px] font-semibold uppercase tracking-[0.08em] text-muted-foreground">Stock</p>
                <ul className="mt-2 divide-y divide-border overflow-hidden rounded-2xl bg-card shadow-soft">
                  {products.map((p) => (
                    <li key={p.name} className="relative flex items-center justify-between px-3 py-2.5">
                      {p.hit && <span data-hit className="absolute inset-0.5 rounded-xl border-2 border-primary bg-primary/5" aria-hidden />}
                      <div className="relative">
                        <p className="text-[12px] font-semibold">{p.name}</p>
                        <p className="text-[10px] text-muted-foreground tabular">{naira(p.price)}</p>
                      </div>
                      <p className="relative flex items-center gap-1 text-[12px] font-semibold tabular">
                        {p.left.length === 2 ? (
                          <CountUp
                            key={sold ? "sold" : "before"}
                            from={p.left[1]}
                            to={p.left[0]}
                            direction="down"
                            mode="roll"
                            startWhen={sold}
                            trigger="load"
                            duration={reduce ? 0 : 0.6}
                          />
                        ) : (
                          <span>{p.left[0]}</span>
                        )}
                        <span className="font-medium text-muted-foreground">left</span>
                      </p>
                    </li>
                  ))}
                </ul>
              </div>
            </PhoneShell>
            <span className="absolute -bottom-2 left-1/2 -translate-x-1/2 rounded-full bg-foreground px-3.5 py-1.5 text-xs font-semibold text-background md:hidden">
              0 taps
            </span>
          </div>
        </div>
      </div>
    </section>
  );
}
