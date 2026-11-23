"use client";

import { useRef } from "react";
import { gsap, useGSAP } from "@/lib/gsap";
import { Wordmark } from "@/components/logo";

const columns: { title: string; links: [string, string][] }[] = [
  {
    title: "Product",
    links: [
      ["#how", "The problem"],
      ["#sale", "Real sales, zero taps"],
      ["#fakes", "Fake receipt check"],
      ["#claims", "“I don pay” watch"],
      ["#books", "Books and stock"],
    ],
  },
  {
    title: "Trust",
    links: [
      ["#canary", "Canary network"],
      ["#privacy", "Privacy on the phone"],
      ["#waitlist", "Eri Score (soon)"],
    ],
  },
];
const banks = ["GTBank", "OPay", "Moniepoint", "Kuda"];

// The closing band: the one dark surface on the page (--footer). Last call to action, every section one
// click away, and a giant wordmark that rises into place as the footer scrolls in (scrubbed; static for
// reduced motion).
export function SiteFooter() {
  const root = useRef<HTMLElement>(null);

  useGSAP(
    () => {
      const mm = gsap.matchMedia();
      mm.add("(prefers-reduced-motion: no-preference)", () => {
        gsap.fromTo(
          "[data-bigmark]",
          { yPercent: 45 },
          {
            yPercent: 0,
            ease: "none",
            scrollTrigger: { trigger: root.current, start: "top bottom", end: "bottom bottom", scrub: 0.6 },
          },
        );
      });
      return () => mm.revert();
    },
    { scope: root },
  );

  return (
    <footer ref={root} className="relative isolate overflow-hidden rounded-t-[32px] bg-footer text-white sm:rounded-t-[48px]">
      {/* a soft blue bloom where the light page meets the dark band */}
      <div
        aria-hidden
        className="pointer-events-none absolute inset-x-0 top-0 -z-10 h-[420px] bg-[radial-gradient(60%_100%_at_50%_0%,rgb(59_91_255/0.28),transparent_70%)]"
      />

      <div className="mx-auto max-w-6xl px-4 pt-20 sm:px-8 sm:pt-28">
        {/* last call */}
        <div className="flex flex-col gap-8 border-b border-white/10 pb-14 md:flex-row md:items-end md:justify-between">
          <h2 className="max-w-2xl font-display text-[clamp(2.25rem,5.5vw,4.5rem)] font-semibold leading-[1.02] tracking-[-0.035em]">
            Stop shipping
            <br />
            to <span className="text-[#8a95ff]">screenshots.</span>
          </h2>
          <div className="flex flex-col gap-3 sm:flex-row">
            <a
              href="#waitlist"
              className="rounded-full bg-primary px-6 py-3.5 text-center text-sm font-semibold text-white transition-[background-color,transform] duration-150 ease-out hover:bg-primary-bright active:scale-[0.97]"
            >
              Join the waitlist
            </a>
            <a
              href="#how"
              className="rounded-full border border-white/25 px-6 py-3.5 text-center text-sm font-semibold text-white transition-[border-color,transform] duration-150 ease-out hover:border-white active:scale-[0.97]"
            >
              See how it works
            </a>
          </div>
        </div>

        {/* columns */}
        <div className="grid gap-10 py-14 sm:grid-cols-2 md:grid-cols-[1.4fr_1fr_1fr_1fr]">
          <div>
            <Wordmark className="h-8 w-auto text-white" />
            <p className="mt-4 max-w-xs text-sm text-white/60">
              Proof, not screenshots. Eri reads the bank alerts on your Android phone and keeps your books honest.
            </p>
          </div>
          {columns.map((c) => (
            <div key={c.title}>
              <p className="text-sm font-medium text-white/45">{c.title}</p>
              <ul className="mt-4 space-y-2.5">
                {c.links.map(([href, label]) => (
                  <li key={href}>
                    <a href={href} className="text-sm text-white/75 transition-colors duration-150 ease-out hover:text-white">
                      {label}
                    </a>
                  </li>
                ))}
              </ul>
            </div>
          ))}
          <div>
            <p className="text-sm font-medium text-white/45">Reads alerts from</p>
            <ul className="mt-4 flex flex-wrap gap-2">
              {banks.map((b) => (
                <li key={b} className="rounded-full border border-white/15 px-3 py-1 text-xs text-white/80">
                  {b}
                </li>
              ))}
              <li className="px-1 py-1 text-xs text-white/50">+ more soon</li>
            </ul>
          </div>
        </div>

        {/* status row */}
        <div className="flex flex-col gap-3 border-t border-white/10 py-5 text-xs text-white/50 sm:flex-row sm:items-center sm:justify-between">
          <span className="flex items-center gap-2">
            <span className="size-1.5 rounded-full bg-[#58b575]" aria-hidden /> Raw alerts stay on the phone
          </span>
          <span>Android · Built for Mavuly Hackathon 2026</span>
          <a href="#" className="text-white/70 transition-colors duration-150 ease-out hover:text-white">
            Back to top ↑
          </a>
        </div>
      </div>

      {/* the sign-off: a giant wordmark running edge to edge, cropped by the bottom of the page */}
      {/* cropped at ~81% of the letters' height, just below the scan-line slot, like the hero's "PROOF" */}
      <div aria-hidden className="mt-4 aspect-[112/39] overflow-hidden px-2 sm:px-4">
        <div data-bigmark>
          <Wordmark className="block h-auto w-full text-white" />
        </div>
      </div>
    </footer>
  );
}
