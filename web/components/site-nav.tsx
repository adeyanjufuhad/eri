"use client";

import { useEffect, useLayoutEffect, useRef, useState } from "react";
import { Wordmark } from "@/components/logo";

const links = [
  ["how", "The problem"],
  ["sale", "How it works"],
  ["fakes", "Fakes"],
  ["books", "Books"],
  ["privacy", "Privacy"],
] as const;

// Floating liquid-glass bar, fixed at page level so it sits above every pinned section's stacking context.
// The glass: blur + saturation everywhere; in Chromium, an SVG displacement filter also refracts what scrolls
// underneath (see .glass in globals.css). A dot under the links shows which section you're in.
export function SiteNav() {
  const [active, setActive] = useState<string | null>(null);
  const [bar, setBar] = useState({ x: 0, w: 0 });
  const refs = useRef<Record<string, HTMLAnchorElement | null>>({});

  useEffect(() => {
    // a section is "current" while it crosses a thin band in the middle of the screen
    const visible = new Set<string>();
    const io = new IntersectionObserver(
      (entries) => {
        for (const e of entries) {
          if (e.isIntersecting) visible.add(e.target.id);
          else visible.delete(e.target.id);
        }
        setActive(links.find(([id]) => visible.has(id))?.[0] ?? null);
      },
      { rootMargin: "-45% 0px -50% 0px" },
    );
    for (const [id] of links) {
      const el = document.getElementById(id);
      if (el) io.observe(el);
    }
    return () => io.disconnect();
  }, []);

  useLayoutEffect(() => {
    const a = active ? refs.current[active] : null;
    if (a) setBar({ x: a.offsetLeft, w: a.offsetWidth });
  }, [active]);

  return (
    <header className="fixed inset-x-3 top-3 z-50 sm:inset-x-6" data-enter="nav">
      <nav className="glass mx-auto flex h-14 max-w-5xl items-center justify-between gap-4 rounded-full pl-5 pr-2 sm:pl-6">
        <a href="#" aria-label="Eri home" className="relative">
          <Wordmark className="h-6 w-auto sm:h-7" />
        </a>

        <div className="relative hidden items-center gap-1 lg:flex">
          {links.map(([id, label]) => (
            <a
              key={id}
              ref={(el) => {
                refs.current[id] = el;
              }}
              href={`#${id}`}
              aria-current={active === id ? "true" : undefined}
              className="rounded-full px-3 py-2 text-sm font-medium text-foreground/70 transition-colors duration-150 ease-out hover:text-foreground aria-[current]:text-foreground"
            >
              {label}
            </a>
          ))}
          {/* one dot that slides between links: transform only, so it stays smooth */}
          <span
            aria-hidden
            className="pointer-events-none absolute bottom-0.5 left-0 size-1.5 rounded-full bg-primary transition-[transform,opacity] duration-300"
            style={{
              transform: `translateX(${bar.x + bar.w / 2 - 3}px)`,
              opacity: active ? 1 : 0,
              transitionTimingFunction: "cubic-bezier(0.23, 1, 0.32, 1)",
            }}
          />
        </div>

        <a
          href="#waitlist"
          className="relative rounded-full bg-foreground px-5 py-2.5 text-sm font-semibold text-background transition-[background-color,transform] duration-150 ease-out hover:bg-primary active:scale-[0.97]"
        >
          Join the waitlist
        </a>
      </nav>

      {/* refraction map for the glass (Chromium applies it via backdrop-filter: url(#eri-glass)) */}
      <svg aria-hidden width="0" height="0" className="absolute">
        <filter id="eri-glass" x="0" y="0" width="100%" height="100%" colorInterpolationFilters="sRGB">
          <feTurbulence type="fractalNoise" baseFrequency="0.006 0.02" numOctaves="2" seed="7" result="noise" />
          <feGaussianBlur in="noise" stdDeviation="2" result="soft" />
          <feDisplacementMap in="SourceGraphic" in2="soft" scale="26" xChannelSelector="R" yChannelSelector="G" result="bent" />
          <feGaussianBlur in="bent" stdDeviation="5" />
        </filter>
      </svg>
    </header>
  );
}
