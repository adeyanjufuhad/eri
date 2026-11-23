// Shared look for every section after the hero, so the page reads as one calm system:
// a pill eyebrow that says where you are in the story (the problem, step 1–3, privacy) and one heading style.
// Round 3 (22 Nov) dropped the crosshair frame and faint grid that used to sit behind each section.

export function SectionTag({ step, children }: { step?: string; children: React.ReactNode }) {
  return (
    <p className="inline-flex items-center gap-2 rounded-full border border-border bg-card py-1 pl-1 pr-3 text-xs font-medium text-muted-foreground shadow-soft sm:text-[13px]">
      {step ? (
        <span className="rounded-full bg-primary px-2.5 py-0.5 font-semibold text-primary-foreground">{step}</span>
      ) : (
        <span className="ml-1.5 size-1.5 rounded-full bg-primary" aria-hidden />
      )}
      {children}
    </p>
  );
}

// Section heading: Lexend semibold, sentence case, tight but not cramped.
export const h2Class =
  "font-display text-[clamp(2rem,4.4vw,3.5rem)] font-semibold leading-[1.05] tracking-[-0.03em] text-balance";
