"use client";

import { useRef, useState } from "react";
import { gsap, useGSAP } from "@/lib/gsap";
import { SectionTag, h2Class } from "@/components/stage-frame";
import { Wordmark } from "@/components/logo";

// §9: a bio link morphs into the verified Eri Score page (scrubbed), next to the waitlist form.
// Eri Score is a stretch feature, so it's labelled "coming soon".
export function ScoreCta() {
  const root = useRef<HTMLElement>(null);
  const [sent, setSent] = useState(false);

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        const q = gsap.utils.selector(root);
        gsap
          .timeline({
            scrollTrigger: { trigger: root.current, start: "top top", end: "bottom bottom", scrub: 0.6 },
            defaults: { ease: "eri-out", duration: 0.1 },
          })
          .set(q("[data-bio]"), { opacity: 1, scale: 1 }, 0)
          .set(q("[data-score]"), { opacity: 0, scale: 0.3, transformOrigin: "50% 74%" }, 0)
          .set(q("[data-link]"), { outlineColor: "rgb(59 91 255 / 0)" }, 0)
          // 1. the link in the bio is what gets tapped
          .to(q("[data-link]"), { outlineColor: "rgb(59 91 255 / 1)", scale: 1.04, duration: 0.08 }, 0.15)
          // 2. the profile steps back while the score page grows out of the link (one object, crossfaded)
          .to(q("[data-bio]"), { opacity: 0, scale: 0.96, duration: 0.22, ease: "power2.inOut" }, 0.36)
          .to(q("[data-score]"), { opacity: 1, scale: 1, duration: 0.26, ease: "power2.inOut" }, 0.36)
          .to({}, { duration: 0.3 }, 0.7);
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <section ref={root} id="waitlist" className="pin h-[220vh]" aria-labelledby="score-title">
      <div className="stage flex items-center px-5 pt-16 sm:px-8">
        <div className="mx-auto grid w-full max-w-6xl items-center gap-8 md:grid-cols-[1fr_auto] md:gap-16">
          <div>
            <SectionTag>Eri Score · coming soon</SectionTag>
            <h2
              id="score-title"
              className={`mt-5 ${h2Class}`}
            >
              Show buyers
              <br />
              your proof.
            </h2>
            <p className="mt-4 max-w-md text-sm text-muted-foreground sm:text-base">
              Put your Eri link in your bio. Buyers see a sales record built from real bank alerts and real
              deliveries, not screenshots. It&rsquo;s the start of credit for vendors who were never on paper.
            </p>

            <form
              className="mt-6 flex max-w-md flex-col gap-2 sm:flex-row"
              onSubmit={(e) => {
                e.preventDefault();
                setSent(true);
              }}
            >
              <label htmlFor="waitlist-email" className="sr-only">
                Email
              </label>
              <input
                id="waitlist-email"
                type="email"
                required
                placeholder="you@yourstore.com"
                className="min-w-0 flex-1 rounded-full border border-input bg-card px-5 py-3 text-sm outline-none transition-[border-color,box-shadow] duration-150 placeholder:text-muted-foreground focus:border-primary focus:ring-4 focus:ring-primary/15"
              />
              <button
                type="submit"
                className="rounded-full bg-primary px-6 py-3 text-sm font-semibold text-primary-foreground shadow-soft transition-[background-color,transform] duration-150 ease-out hover:bg-primary-bright active:scale-[0.97]"
              >
                Join the waitlist
              </button>
            </form>
            {/* shortcut: the form isn't wired to a backend yet; connect it to Supabase once the project exists (Day 2) */}
            <p className="mt-2 min-h-5 pl-5 text-xs text-muted-foreground" aria-live="polite">
              {sent ? "Sign-ups open on launch day. This form doesn’t save anything yet." : "Android only for now. No spam."}
            </p>
          </div>

          <div className="relative mx-auto h-[420px] w-[300px] max-md:-mb-[118px] max-md:origin-top max-md:scale-[0.72] sm:w-[320px] [@media(prefers-reduced-motion:reduce)]:h-auto">
            {/* the bio */}
            <div
              data-bio
              className="absolute inset-0 rounded-3xl bg-card p-5 shadow-soft [@media(prefers-reduced-motion:reduce)]:hidden"
            >
              <p className="text-[11px] font-medium text-muted-foreground">Instagram profile</p>
              <div className="mt-4 flex items-center gap-4">
                <span className="grid size-16 shrink-0 place-items-center rounded-full bg-foreground font-display text-lg font-semibold text-background">
                  AS
                </span>
                <div className="grid flex-1 grid-cols-3 text-center text-[12px]">
                  {[
                    ["318", "posts"],
                    ["12.4k", "followers"],
                    ["210", "following"],
                  ].map(([n, l]) => (
                    <div key={l}>
                      <p className="font-semibold tabular">{n}</p>
                      <p className="text-muted-foreground">{l}</p>
                    </div>
                  ))}
                </div>
              </div>
              <p className="mt-4 text-[13px] font-semibold">adaeze.stores</p>
              <p className="mt-1 text-[13px] leading-relaxed">
                Ankara &amp; Adire, made in Lagos
                <br />
                DM to order · pay by transfer
                <br />
                Nationwide delivery 📦
              </p>
              <span
                data-link
                className="mt-3 inline-block rounded-full px-2 py-0.5 text-[13px] font-semibold text-primary outline-2 outline-offset-2 outline-primary [outline-style:solid]"
              >
                🔗 eri.app/@adaeze
              </span>
              <div className="mt-6 grid grid-cols-3 gap-1">
                {Array.from({ length: 6 }).map((_, i) => (
                  <span key={i} className="aspect-square rounded-lg bg-muted" aria-hidden />
                ))}
              </div>
            </div>

            {/* the Eri Score page */}
            <div data-score className="absolute inset-0 flex flex-col rounded-3xl bg-card p-5 shadow-lift ring-1 ring-primary/20 [@media(prefers-reduced-motion:reduce)]:static">
              <div className="flex items-center justify-between">
                <Wordmark className="h-5 w-auto" />
                <span className="rounded-full bg-landed px-2.5 py-0.5 text-[11px] font-semibold text-white">✓ Verified seller</span>
              </div>
              <p className="mt-6 font-display text-2xl font-semibold tracking-[-0.03em]">Adaeze Stores</p>
              <p className="text-[12px] text-muted-foreground">eri.app/@adaeze · Lagos</p>
              <dl className="mt-5 grid grid-cols-2 gap-1.5">
                {[
                  ["412", "paid orders, proven by bank alerts"],
                  ["398", "delivered and confirmed"],
                  ["0", "disputes"],
                  ["Mar 2025", "selling since"],
                ].map(([n, l]) => (
                  <div key={l} className="rounded-xl bg-muted/70 p-3">
                    <dt className="font-display text-2xl font-semibold tracking-[-0.03em] tabular">{n}</dt>
                    <dd className="mt-0.5 text-[11px] leading-snug text-muted-foreground">{l}</dd>
                  </div>
                ))}
              </dl>
              <p className="mt-auto pt-5 text-[11px] font-medium text-muted-foreground">
                Proof, not screenshots.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
