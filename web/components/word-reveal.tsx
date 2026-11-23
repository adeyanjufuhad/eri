"use client";

import ScrollReveal from "@/components/reactbits/ScrollReveal";
import { SectionTag } from "@/components/stage-frame";

const lines: { text: string; accent?: boolean }[] = [
  { text: "Customers send screenshots." },
  { text: "Screenshots lie." },
  { text: "Bank alerts don’t.", accent: true },
];

// The three pains, each answered by one step further down the page.
const pains = [
  {
    title: "Fake “paid” screenshots",
    body: "An edited receipt looks exactly like a real one. You ship, and the money never comes.",
    fix: "Step 2 checks it",
    href: "#fakes",
  },
  {
    title: "Checking every bank app",
    body: "“I don pay, check am.” So you open GTBank, OPay, Moniepoint and Kuda between orders, all day.",
    fix: "Step 1 reads every alert",
    href: "#sale",
  },
  {
    title: "Books that don’t add up",
    body: "Sales live in chats, alerts and memory. At month end, nobody knows the real profit.",
    fix: "Step 3 writes them",
    href: "#books",
  },
];

// §2 The problem: React Bits Scroll Reveal lights the words as they scroll past (scrubbed), then the three
// pains sit in plain cards, each pointing at the step that fixes it.
export function WordReveal() {
  return (
    <section id="how" className="relative px-5 py-[22vh] sm:px-8" aria-labelledby="problem-title">
      <div className="mx-auto w-full max-w-5xl">
        <div className="mb-8">
          <SectionTag>The problem</SectionTag>
        </div>
        <h2 id="problem-title" className="sr-only">
          The problem
        </h2>
        {lines.map((l) => (
          <ScrollReveal
            key={l.text}
            baseOpacity={0.15}
            enableBlur={false}
            baseRotation={0}
            containerClassName="!my-0"
            textClassName={`font-display !text-[clamp(2.25rem,6.2vw,5.25rem)] !font-semibold !leading-[1.04] tracking-[-0.035em] ${l.accent ? "text-primary" : ""}`}
          >
            {l.text}
          </ScrollReveal>
        ))}

        <ul className="mt-20 grid gap-4 sm:mt-28 md:grid-cols-3 md:gap-5">
          {pains.map((p, i) => (
            <li key={p.title} className="flex flex-col rounded-3xl bg-card p-6 shadow-soft sm:p-7">
              <span className="grid size-9 place-items-center rounded-full bg-not-received/10 text-sm font-semibold text-not-received tabular">
                {i + 1}
              </span>
              <h3 className="mt-5 font-display text-xl font-semibold tracking-[-0.02em]">{p.title}</h3>
              <p className="mt-2 flex-1 text-[15px] leading-relaxed text-muted-foreground">{p.body}</p>
              <a
                href={p.href}
                className="mt-5 inline-flex w-fit items-center gap-1.5 rounded-full bg-primary/10 px-3 py-1.5 text-[13px] font-semibold text-primary transition-colors duration-150 ease-out hover:bg-primary/15"
              >
                {p.fix} <span aria-hidden>→</span>
              </a>
            </li>
          ))}
        </ul>

        <p className="mx-auto mt-14 max-w-2xl text-center font-display text-[clamp(1.25rem,2.4vw,1.75rem)] font-semibold leading-snug tracking-[-0.02em]">
          Eri fixes all three from one place: <span className="text-primary">the bank alerts already on your phone.</span>
        </p>
      </div>
    </section>
  );
}
