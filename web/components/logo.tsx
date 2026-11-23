// Eri logo: blocky + curved, black and white (it draws in currentColor).
// Built on an 8-unit grid from rectangles and quarter-circles only. The "e" is a block with a half-round top,
// a half-dome eye and a slot opening right. The slot carries on through the r and i as one cut: a scan line
// across the whole word, the same line that checks receipts in §4.

// e: 48×48. evenodd: the second subpath (the eye) is a hole.
export const E_PATH = "M0 48V24A24 24 0 0 1 48 24V31H22V36H48V48ZM14 24A10 10 0 0 1 34 24Z";
// r: 34×48, square stem + quarter-circle shoulder
const R_PATH = "M0 0H14A20 20 0 0 1 34 20H14V31H0ZM0 36H14V48H0Z";
// i: 14×48, square dot + stem
const I_PATH = "M0 0H14V12H0ZM0 18H14V31H0ZM0 36H14V48H0Z";

export function Wordmark({ className = "", title = "Eri" }: { className?: string; title?: string }) {
  return (
    <svg viewBox="0 0 112 48" className={className} role="img" aria-label={title} fill="currentColor">
      <path d={E_PATH} fillRule="evenodd" />
      <path d={R_PATH} transform="translate(56 0)" />
      <path d={I_PATH} transform="translate(98 0)" />
    </svg>
  );
}

export function Mark({ className = "", title = "Eri" }: { className?: string; title?: string }) {
  return (
    <svg viewBox="0 0 48 48" className={className} role="img" aria-label={title} fill="currentColor">
      <path d={E_PATH} fillRule="evenodd" />
    </svg>
  );
}
