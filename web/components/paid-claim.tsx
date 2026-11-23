"use client";

import { useRef } from "react";
import { gsap, useGSAP } from "@/lib/gsap";
import { PhoneShell } from "@/components/phone";
import { naira } from "@/lib/naira";
import { SectionTag, h2Class } from "@/components/stage-frame";

const CLAIM = 4_500_000; // ₦45,000, in kobo
const WAIT_SECONDS = 600; // the default 10-minute window (payment_claims.expires_at)
const R = 34;
const C = 2 * Math.PI * R;

const mmss = (s: number) => `${Math.floor(s / 60)}:${String(Math.floor(s % 60)).padStart(2, "0")}`;

// §5: a chat says "I don pay". Eri starts a 10-minute wait that drains as you scroll; other money arrives but
// isn't Tunde's; the window runs out and the warning lands. HTML is the finished state (reduced motion / no JS).
export function PaidClaim() {
  const root = useRef<HTMLElement>(null);

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        const clock = q("[data-clock]")[0];
        const left = { s: WAIT_SECONDS };
        const tick = () => (clock.textContent = mmss(left.s));

        const tl = gsap.timeline({
          scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
          defaults: { ease: "eri-out", duration: 0.06 },
        });

        tl.set(q("[data-chat]"), { yPercent: -130, opacity: 0 }, 0)
          .set(q("[data-wait]"), { opacity: 0, y: -8 }, 0)
          .set(q("[data-ring]"), { strokeDashoffset: 0 }, 0)
          .set(left, { s: WAIT_SECONDS, onUpdate: tick }, 0)
          .set(q("[data-other]"), { opacity: 0, y: -6 }, 0)
          .set(q("[data-warn]"), { opacity: 0, y: 8, scale: 0.98 }, 0);

        // 1. the chat preview drops in; 2. Eri starts waiting for that money (cause → effect, slight overlap)
        tl.to(q("[data-chat]"), { yPercent: 0, opacity: 1, duration: 0.1 }, 0.08)
          .to(q("[data-wait]"), { opacity: 1, y: 0 }, 0.17);

        // 3. the window drains with scroll: ring and clock are one object, so they move together
        tl.to(q("[data-ring]"), { strokeDashoffset: C, duration: 0.56, ease: "none" }, 0.24).to(
          left,
          { s: 0, duration: 0.56, ease: "none", onUpdate: tick },
          0.24,
        );

        // other money lands mid-wait, but it isn't Tunde's, so the wait goes on
        tl.to(q("[data-other]"), { opacity: 1, y: 0 }, 0.46);

        // 4. time's up: the warning lands
        tl.to(q("[data-warn]"), { opacity: 1, y: 0, scale: 1 }, 0.82).to({}, { duration: 0.1 }, 0.9);

        return () => {
          clock.textContent = mmss(0);
        };
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} id="claims" className="pin h-[360vh]" aria-labelledby="paid-claim-title">
      <div className="stage flex items-center px-5 pt-16 sm:px-8">
        <div className="mx-auto grid w-full max-w-6xl items-center gap-8 md:grid-cols-[1fr_auto] md:gap-16">
          <div>
            <SectionTag step="Step 2">Watches “I don pay”</SectionTag>
            <h2
              id="paid-claim-title"
              className={`mt-5 ${h2Class}`}
            >
              A promise
              <br />
              isn&rsquo;t a payment.
            </h2>
            <p className="mt-4 max-w-md text-sm text-muted-foreground sm:text-base">
              Turn on chat checks and Eri spots “I&rsquo;ve paid” in your WhatsApp and Instagram previews. If no
              money follows, you hear about it before the goods leave.
            </p>
            <p className="mt-6 hidden max-w-md rounded-2xl bg-card px-5 py-4 text-sm text-muted-foreground shadow-soft md:block">
              Chat checks are opt-in. Previews are read on your phone, never uploaded, and deleted after 24 hours.
            </p>
          </div>

          <div className="relative mx-auto max-md:-mb-[120px] max-md:origin-top max-md:scale-[0.78]">
            <PhoneShell>
              <div
                data-chat
                className="absolute inset-x-2 top-9 z-10 rounded-2xl border border-border bg-card p-3 shadow-[0_12px_30px_-14px_rgb(15_20_29/0.45)]"
              >
                <div className="flex items-center gap-2 text-[10px] text-muted-foreground">
                  <span className="grid size-4 place-items-center rounded-full bg-landed text-[9px] font-bold text-white" aria-hidden>
                    W
                  </span>
                  <span className="font-medium text-foreground">WhatsApp</span>
                  <span>· now</span>
                </div>
                <p className="mt-1.5 text-[12px] font-semibold">Tunde Bakare</p>
                <p className="text-[12px]">I don pay, check am 🙏</p>
              </div>

              <div className="min-h-[470px] px-4 pb-5 pt-4">
                <div className="flex items-center justify-between">
                  <span className="font-display text-lg font-semibold tracking-[-0.03em]">eri</span>
                  <span className="text-[10px] font-medium text-muted-foreground">Chat checks on</span>
                </div>

                <div className="mt-[92px] space-y-3">
                  <div data-wait className="flex items-center gap-4 rounded-2xl bg-card p-4 shadow-soft">
                    <div className="relative size-[84px] shrink-0">
                      <svg viewBox="0 0 84 84" className="size-full -rotate-90" aria-hidden>
                        <circle cx="42" cy="42" r={R} fill="none" stroke="var(--muted)" strokeWidth="6" />
                        <circle
                          data-ring
                          cx="42"
                          cy="42"
                          r={R}
                          fill="none"
                          stroke="var(--primary)"
                          strokeWidth="6"
                          strokeLinecap="round"
                          strokeDasharray={C}
                          strokeDashoffset={C}
                        />
                      </svg>
                      <span
                        data-clock
                        className="absolute inset-0 grid place-items-center font-display text-[15px] font-semibold tabular"
                      >
                        {mmss(0)}
                      </span>
                    </div>
                    <div className="min-w-0">
                      <p className="text-[11px] text-muted-foreground">Waiting for</p>
                      <p className="font-display text-[20px] font-semibold leading-tight tracking-[-0.03em] tabular">
                        {naira(CLAIM)}
                      </p>
                      <p className="text-[11px] text-muted-foreground">from Tunde B.</p>
                    </div>
                  </div>

                  <div data-other className="flex items-center justify-between rounded-xl border border-border bg-card px-3 py-2">
                    <div>
                      <p className="text-[11px] font-semibold">
                        Credit <span className="text-landed tabular">{naira(1_800_000)}</span>
                      </p>
                      <p className="text-[10px] text-muted-foreground">GTBank · AMAKA EZE</p>
                    </div>
                    <span className="text-[10px] font-medium text-muted-foreground">Not Tunde</span>
                  </div>

                  <div data-warn className="rounded-2xl border-2 border-suspicious bg-card p-3">
                    <p className="flex items-center gap-2 text-[12px] font-semibold text-suspicious">
                      <span aria-hidden>⚠</span> No money has arrived
                    </p>
                    <p className="mt-1 text-[12px]">
                      Tunde said “I don pay” 10 minutes ago. Nothing from Tunde has landed in any of your banks.
                    </p>
                    <div className="mt-3 flex gap-2">
                      <span className="rounded-full bg-foreground px-3 py-1.5 text-[11px] font-semibold text-background">
                        Don&rsquo;t ship yet
                      </span>
                      <span className="rounded-full border border-border px-3 py-1.5 text-[11px] font-semibold">Ask Tunde</span>
                    </div>
                  </div>
                </div>
              </div>
            </PhoneShell>
          </div>
        </div>
      </div>
    </section>
  );
}
