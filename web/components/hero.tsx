"use client";

import { useEffect, useRef } from "react";
import { gsap, useGSAP } from "@/lib/gsap";
import { HandPhone } from "@/components/phone";
import { AlertCard, type Alert } from "@/components/alert-card";
import TiltedCard from "@/components/reactbits/TiltedCard";
import { naira } from "@/lib/naira";

// The problem and the answer, either side of the phone: a "paid" screenshot from chat that never turned into
// money, and a real bank alert that did. Demo data only (same people as §4 and §5).
const FAKE_KOBO = 4_500_000;
const real: Alert = { bank: "GTBank", mark: "G", kobo: 2_500_000, from: "CHIOMA OKAFOR", desc: "ankara gown", ago: "now" };

const pill = "inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-semibold text-white";

export function Hero() {
  const root = useRef<HTMLElement>(null);
  const video = useRef<HTMLVideoElement>(null);

  // the background loop is decoration: desktop only, motion allowed, and only after the page has loaded
  useEffect(() => {
    const v = video.current;
    if (!v || !matchMedia("(min-width: 768px) and (prefers-reduced-motion: no-preference)").matches) return;
    const start = () => {
      v.src = "/media/hero-trails.mp4";
      v.play().catch(() => {});
    };
    if (document.readyState === "complete") start();
    else window.addEventListener("load", start, { once: true });
    return () => window.removeEventListener("load", start);
  }, []);

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        // (the load entrance is CSS, see [data-enter] in globals.css: it plays before this script loads)

        // Scroll: gentle depth. The two cards leave first, the stage barely moves, and the phone rises
        // to show its whole dashboard.
        const st = { trigger: root.current, start: "top top", end: "bottom bottom", scrub: true };
        gsap.timeline({ scrollTrigger: st, defaults: { ease: "none" } })
          .to(q("[data-layer=copy]"), { y: -140, opacity: 0, duration: 0.5 }, 0)
          .to(q("[data-layer=video]"), { opacity: 0, duration: 0.5 }, 0)
          .to(q("[data-layer=grid]"), { yPercent: -6, duration: 1 }, 0)
          .to(q("[data-layer=phone]"), { y: () => -0.4 * window.innerHeight, duration: 1 }, 0)
          .to(q("[data-layer=cards]"), { y: () => -0.7 * window.innerHeight, duration: 0.8 }, 0);
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} className="pin h-[230vh]" aria-label="Eri">
      <div className="stage flex flex-col">
        <div data-layer="video" className="motion-only pointer-events-none absolute inset-x-0 top-0 h-[70%] max-md:hidden">
          <video
            ref={video}
            data-enter="video"
            className="h-full w-full object-cover opacity-30 mix-blend-multiply [mask-image:linear-gradient(to_bottom,black_30%,transparent_85%)]"
            preload="none"
            muted
            loop
            playsInline
            aria-hidden
          />
        </div>

        {/* spacer for the fixed site nav (components/site-nav.tsx) */}
        <div className="h-16 shrink-0" aria-hidden />

        <div data-layer="copy" className="relative z-10 px-5 pt-8 text-center sm:pt-12">
          <h1
            data-enter="headline"
            className="font-display text-[clamp(2.6rem,6.4vw,5.5rem)] font-semibold leading-[1] tracking-[-0.035em]"
          >
            Proof, not screenshots.
          </h1>
          <p data-enter="sub" className="mx-auto mt-5 max-w-[36rem] text-[15px] leading-relaxed text-muted-foreground sm:text-[17px]">
            Customers send fake “I’ve paid” screenshots. Eri reads the real bank alerts on your Android phone, logs
            every sale on its own, and tells you when the money never came.
          </p>
          <div data-enter="ctas" className="mt-7 flex justify-center gap-3">
            <a
              href="#waitlist"
              className="rounded-full bg-primary px-6 py-3 text-sm font-semibold text-primary-foreground shadow-soft transition-[background-color,transform] duration-150 ease-out hover:bg-primary-bright active:scale-[0.97]"
            >
              Join the waitlist
            </a>
            <a
              href="#how"
              className="glass rounded-full px-6 py-3 text-sm font-semibold transition-transform duration-150 ease-out active:scale-[0.97]"
            >
              See how it works
            </a>
          </div>
        </div>

        <div className="relative mt-10 flex-1 sm:mt-12">
          {/* the stage: one rounded blue surface */}
          <div data-layer="grid" className="absolute inset-x-3 -bottom-[30vh] top-[72px] overflow-hidden rounded-[28px] sm:inset-x-8 sm:rounded-[40px]">
            <div className="grid-stage absolute inset-0" />
          </div>

          {/* centred on the phone screen, not the image: the wrist sits off to the right and runs out of the stage */}
          <div data-layer="phone" className="absolute left-1/2 top-0 -translate-x-[44.86%]">
            <div data-enter="phone" className="origin-top max-md:scale-[0.8]">
              <HandPhone>
                <div
                  data-enter="chip"
                  className="absolute left-[64%] top-[14%] rounded-full bg-landed px-3.5 py-1.5 text-[12px] font-semibold text-white shadow-[0_12px_24px_-12px_rgb(15_20_29/0.6)] tabular"
                >
                  Credit {naira(real.kobo)}
                </div>
              </HandPhone>
            </div>
          </div>

          <div data-layer="cards" className="pointer-events-none absolute inset-0">
            {/* the problem: a screenshot from chat */}
            <div className="pointer-events-auto absolute left-[calc(50%-430px)] top-[92px] origin-top-left -rotate-[4deg] max-md:left-2 max-md:top-[196px] max-md:scale-[0.72]">
              <div data-enter="card">
                <Tilt label="A payment screenshot from chat, not received" h={128}>
                  <div className="h-full w-[260px] rounded-2xl border border-border bg-card p-3.5">
                    <div className="flex items-center gap-2 text-[11px] text-muted-foreground">
                      <span className="grid size-5 place-items-center rounded-full bg-landed text-[10px] font-bold text-white" aria-hidden>
                        W
                      </span>
                      <span className="whitespace-nowrap font-medium text-foreground">Tunde B. · photo</span>
                      <span className={`ml-auto whitespace-nowrap bg-not-received ${pill}`}>✕ Not received</span>
                    </div>
                    <div className="mt-2.5 rounded-xl bg-muted px-3 py-2">
                      <p className="text-[10px] font-semibold text-landed">Transfer successful</p>
                      <p className="font-display text-[20px] font-semibold leading-tight tracking-[-0.03em] tabular">
                        {naira(FAKE_KOBO)}
                      </p>
                      <p className="text-[10px] text-muted-foreground">to ADAEZE STORES · 2:14 PM</p>
                    </div>
                  </div>
                </Tilt>
              </div>
            </div>

            {/* the answer: the real alert, read on the phone */}
            <div className="pointer-events-auto absolute left-[calc(50%+170px)] top-[196px] origin-top-right rotate-[3deg] max-md:left-auto max-md:right-2 max-md:top-[326px] max-md:scale-[0.72]">
              <div data-enter="card-r">
                <Tilt label="GTBank credit alert, landed" h={100}>
                  <AlertCard a={real} badge={<span className={`whitespace-nowrap bg-landed ${pill}`}>✓ Landed</span>} />
                </Tilt>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

function Tilt({ label, h, children }: { label: string; h: number; children: React.ReactNode }) {
  return (
    <TiltedCard
      containerWidth={260}
      containerHeight={h}
      imageWidth={260}
      imageHeight={h}
      radius={16}
      rotateAmplitude={8}
      scaleOnHover={1.03}
      showTooltip={false}
      flipOnClick={false}
      intro={false} // our CSS entrance already slides the cards in; skip its own rAF intro
      glare={0.2}
      shadow={0.3}
      altText={label}
    >
      {children}
    </TiltedCard>
  );
}
