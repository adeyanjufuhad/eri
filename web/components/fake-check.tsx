"use client";

import { useRef, useState } from "react";
import TextType from "@/components/reactbits/TextType";
import { gsap, ScrollTrigger, useGSAP } from "@/lib/gsap";
import { naira } from "@/lib/naira";
import { SectionTag, h2Class } from "@/components/stage-frame";

type Receipt = {
  kobo: number;
  from: string;
  bank: string;
  time: string;
  session: string;
  verdict: "landed" | "not-received";
  stamp: string;
  reasons: string[];
};

// Demo data only: fake names, fake session IDs. Same template on purpose: you can't tell them apart by eye.
const receipts: Receipt[] = [
  {
    kobo: 2_500_000,
    from: "CHIOMA OKAFOR",
    bank: "GTBank",
    time: "21 Nov 2026 · 2:14 PM",
    session: "000013261121141408123456",
    verdict: "landed",
    stamp: "Landed · 2:14 PM",
    reasons: [`Matches a real GTBank credit: ${naira(2_500_000)} from CHIOMA OKAFOR at 2:14 PM.`],
  },
  {
    kobo: 4_500_000,
    from: "TUNDE BAKARE",
    bank: "Moniepoint",
    time: "21 Nov 2026 · 2:14 PM",
    session: "090405261121141402987654",
    verdict: "not-received",
    stamp: "Not received",
    reasons: [
      `No credit of ${naira(4_500_000)} landed in the last 2 hours.`,
      `Closest real credit: ${naira(450_000)} from TUNDE BAKARE at 2:09 PM.`,
      `The amount looks edited: ${naira(450_000)} → ${naira(4_500_000)}.`,
    ],
  },
];

// §4: two receipts that look the same. A scan passes over both, then the verdicts land and the reasons type out.
// The HTML is the finished state (reduced motion / no JS); the timeline rewinds it when motion is allowed.
export function FakeCheck() {
  const root = useRef<HTMLElement>(null);
  // once the verdicts are in, React Bits Text Type types the reasons; scrolling back above that clears them
  const [checked, setChecked] = useState(false); // off until scrolled to; reduced motion turns it on below

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: reduce)", () => setChecked(true)); // no scroll story: show the end state
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        const st = ScrollTrigger.create({
          trigger: root.current,
          start: "top top",
          end: "bottom bottom",
          onUpdate: (self) => setChecked(self.progress > 0.5),
        });
        setChecked(st.progress > 0.5);

        const tl = gsap.timeline({
          scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
          defaults: { ease: "eri-out", duration: 0.06 },
        });

        tl.set(q("[data-scan]"), { yPercent: 0, opacity: 1 }, 0)
          .set(q("[data-stamp]"), { opacity: 0, scale: 0.96 }, 0)
          .set(q("[data-edited]"), { opacity: 0 }, 0);

        // 1. one scan passes over both receipts together: same check, same moment
        tl.to(q("[data-scan]"), { yPercent: 100, duration: 0.3, ease: "none" }, 0.1).to(
          q("[data-scan]"),
          { opacity: 0, duration: 0.05, ease: "none" },
          0.4,
        );

        // 2. verdicts land together as the scan clears; the edited amount gets flagged with the fake's stamp
        tl.to(q("[data-stamp]"), { opacity: 1, scale: 1 }, 0.44).to(q("[data-edited]"), { opacity: 1 }, 0.46);

        tl.to({}, { duration: 0.5 }, 0.5); // 3. reasons type out (Text Type, time-based); hold before unpinning

        return () => {
          st.kill();
          setChecked(false);
        };
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} id="fakes" className="pin h-[420vh]" aria-labelledby="fake-check-title">
      <div className="stage flex items-center px-4 pt-16 sm:px-8">
        <div className="mx-auto w-full max-w-5xl">
          <SectionTag step="Step 2">Catches fake receipts</SectionTag>
          <h2
            id="fake-check-title"
            className={`mt-5 ${h2Class}`}
          >
            Two receipts.
            <br />
            One is lying.
          </h2>
          <p className="mt-3 max-w-xl text-sm text-muted-foreground sm:text-base [@media(max-height:860px)]:hidden">
            Share any receipt into Eri. It checks it against the money that actually landed in your account.
          </p>

          <div className="mt-6 grid grid-cols-2 gap-2.5 sm:gap-6">
            {receipts.map((r) => (
              <div key={r.from}>
                <ReceiptCard r={r} />
                <ul className="mt-3 space-y-1.5 text-[11px] sm:text-sm">
                  {r.reasons.map((text, i) => (
                    <li key={text} className="flex gap-2">
                      <span
                        className={`mt-[0.45em] size-1.5 shrink-0 rounded-full ${r.verdict === "landed" ? "bg-landed" : "bg-not-received"}`}
                        aria-hidden
                      />
                      {/* invisible copy holds the line's final height so typing never reflows the layout */}
                      <span className="relative">
                        <span className="invisible">{text}</span>
                        {checked && (
                          <TextType
                            text={text}
                            loop={false}
                            showCursor={false}
                            typingSpeed={16}
                            initialDelay={r.verdict === "landed" ? 0 : 300 + i * 1100}
                            className="!absolute inset-0"
                          />
                        )}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}

function ReceiptCard({ r }: { r: Receipt }) {
  const bad = r.verdict === "not-received";
  return (
    <div className="relative overflow-hidden rounded-2xl bg-card p-3 shadow-soft sm:rounded-3xl sm:p-6">
      <div className="flex items-center justify-between gap-2 text-[10px] sm:text-xs">
        <span className="whitespace-nowrap font-semibold">Transfer receipt</span>
        <span className="rounded-full bg-landed/10 px-2 py-0.5 font-semibold text-landed">Successful</span>
      </div>

      <p className="mt-3 text-[10px] text-muted-foreground sm:mt-4 sm:text-xs">Amount</p>
      <p className="relative inline-block font-display text-[22px] font-semibold leading-none tracking-[-0.03em] tabular sm:text-[40px]">
        {naira(r.kobo)}
        {bad && <span data-edited className="absolute inset-x-0 -bottom-1 h-[3px] rounded-full bg-not-received" aria-hidden />}
      </p>

      <dl className="mt-3 space-y-1.5 text-[10px] sm:mt-4 sm:space-y-1.5 sm:text-xs">
        {[
          ["From", r.from],
          ["To", "ADAEZE STORES"],
          ["Bank", r.bank],
          ["Date", r.time],
          ["Session ID", r.session],
        ].map(([k, v]) => (
          <div key={k} className="flex justify-between gap-3 border-t border-border pt-1.5 sm:pt-2">
            <dt className="whitespace-nowrap text-muted-foreground">{k}</dt>
            <dd className="truncate text-right font-medium tabular">{v}</dd>
          </div>
        ))}
      </dl>

      <div
        data-stamp
        className={`mt-3 flex w-fit items-center gap-2 rounded-full px-2.5 py-1 text-[11px] font-semibold text-white sm:mt-5 sm:px-3.5 sm:py-1.5 sm:text-sm ${bad ? "bg-not-received" : "bg-landed"}`}
      >
        <span aria-hidden>{bad ? "✕" : "✓"}</span>
        {r.stamp}
      </div>

      {/* the scan: a tinted band whose bottom edge is the scan line, travelling top to bottom */}
      <div
        data-scan
        aria-hidden
        className="motion-only pointer-events-none absolute inset-x-0 -top-full h-full border-b-2 border-primary bg-gradient-to-b from-transparent to-primary/15 opacity-0"
      />
    </div>
  );
}
