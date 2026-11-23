"use client";

import { useRef, useState } from "react";
import { useReducedMotion } from "motion/react";
import { gsap, ScrollTrigger, useGSAP } from "@/lib/gsap";
import CountUp from "@/components/reactbits/CountUp";
import { StackedBars } from "@/components/bencho/StackedBars";
import { SectionTag, h2Class } from "@/components/stage-frame";

// This week, in kobo (the chart's daily data adds up to the same numbers): sales − cost − expenses = net.
const SALES = 41_200_000;
const COST = 28_840_000;
const EXPENSES = 4_150_000;
const NET = SALES - COST - EXPENSES; // 8,210,000 kobo = ₦82,100

const rows = [
  { label: "Sales", kobo: SALES, note: "23 real payments" },
  { label: "Cost of goods", kobo: COST, note: "from your product costs" },
  { label: "Expenses", kobo: EXPENSES, note: "debit alerts: dispatch, ads, data" },
];

// §6: the week's P&L. Bencho's Stacked bars grows in when seen (hover any day for its breakdown);
// the totals count up (React Bits Count Up) and a low-stock warning lands, all from bank alerts alone.
export function Books() {
  const root = useRef<HTMLElement>(null);
  const [shown, setShown] = useState(false); // off until scrolled to; reduced motion turns it on below
  const reduce = useReducedMotion();

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: reduce)", () => setShown(true)); // no scroll story: show the end state
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        const st = ScrollTrigger.create({
          trigger: root.current,
          start: "top top",
          end: "bottom bottom",
          onUpdate: (self) => setShown(self.progress > 0.15),
        });
        setShown(st.progress > 0.15);

        gsap
          .timeline({
            scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
            defaults: { ease: "eri-out", duration: 0.08 },
          })
          .fromTo(q("[data-low]"), { opacity: 0, y: 8, scale: 0.98 }, { opacity: 1, y: 0, scale: 1 }, 0.55)
          .to({}, { duration: 0.3 }, 0.7); // hold before unpinning

        return () => {
          st.kill();
          setShown(false);
        };
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  const count = (kobo: number) => (
    <CountUp
      key={shown ? "on" : "off"}
      from={0}
      to={kobo / 100}
      startWhen={shown}
      trigger="load"
      separator=","
      prefix="₦"
      duration={reduce ? 0 : 1.2}
    />
  );

  return (
    <section ref={root} id="books" className="pin h-[300vh]" aria-labelledby="books-title">
      <div className="stage flex items-center px-5 pt-16 sm:px-8">
        <div className="mx-auto w-full max-w-6xl">
          <SectionTag step="Step 3">Keeps your books</SectionTag>
          <h2 id="books-title" className={`mt-5 ${h2Class}`}>
            The books <br className="md:hidden" />
            write themselves.
          </h2>

          {/* two surfaces side by side, same height, tops aligned: the week's P&L and the chart */}
          <div className="mt-6 grid gap-4 sm:mt-8 md:grid-cols-[1fr_auto] md:gap-6">
            <div className="flex flex-col justify-between gap-4 rounded-3xl bg-card px-5 py-3 shadow-soft sm:px-7 sm:py-5">
              <dl className="divide-y divide-border">
                {rows.map((r) => (
                  <div key={r.label} className="flex items-baseline justify-between gap-4 py-3">
                    <dt>
                      <span className="text-sm font-semibold">{r.label}</span>
                      <span className="ml-2 hidden text-xs text-muted-foreground sm:inline">{r.note}</span>
                    </dt>
                    <dd className="font-semibold tabular">{count(r.kobo)}</dd>
                  </div>
                ))}
                <div className="flex items-baseline justify-between gap-4 pt-4 pb-1">
                  <dt className="font-display text-lg font-semibold tracking-[-0.02em]">Net profit</dt>
                  <dd className="font-display text-[clamp(1.75rem,3.4vw,2.5rem)] font-semibold leading-none tracking-[-0.03em] text-landed tabular">
                    {count(NET)}
                  </dd>
                </div>
              </dl>

              <div data-low className="mb-2 inline-flex w-fit items-center gap-3 whitespace-nowrap rounded-full border-2 border-suspicious bg-card px-4 py-1.5 text-sm max-sm:gap-2 max-sm:px-3 max-sm:text-xs">
                <span className="font-semibold text-suspicious">Low stock</span>
                <span>Ankara Gown · 3 left</span>
                <span className="text-muted-foreground max-sm:hidden">Aso-oke Cap · 2 left</span>
              </div>
            </div>

            {/* the chart is built at 300×275; on desktop it's shown at 1.2× in a box that reserves 360×330,
                so the transform never spills out of its column */}
            <div className="mx-auto md:h-[330px] md:w-[360px]">
              <div className="rounded-3xl shadow-soft md:origin-top-left md:scale-[1.2]">
                <StackedBars bars={7} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
