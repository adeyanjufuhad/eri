import { naira } from "@/lib/naira";

type Verdict = "landed" | "not-received" | "suspicious";

const feed: { item: string; who: string; kobo: number; verdict: Verdict; label: string }[] = [
  { item: "Ankara Gown", who: "Chioma O.", kobo: 2_500_000, verdict: "landed", label: "Landed" },
  { item: "Adire Two-piece", who: "Amaka E.", kobo: 1_800_000, verdict: "landed", label: "Landed" },
  { item: "Claim: “I don pay”", who: "Tunde B.", kobo: 4_500_000, verdict: "not-received", label: "No money" },
  { item: "Aso-oke Cap", who: "Femi A.", kobo: 850_000, verdict: "landed", label: "Landed" },
];

const dot: Record<Verdict, string> = {
  landed: "bg-landed",
  "not-received": "bg-not-received",
  suspicious: "bg-suspicious",
};

// The device shell. Concentric corners: outer radius = inner (screen) radius + padding (bezel).
const SCREEN_RADIUS = 34;
const BEZEL = 10;

export function PhoneShell({ children }: { children: React.ReactNode }) {
  return (
    <div
      className="relative w-[280px] bg-foreground shadow-[0_40px_80px_-30px_rgb(15_20_29/0.55)] sm:w-[300px]"
      style={{ padding: BEZEL, borderRadius: SCREEN_RADIUS + BEZEL }}
    >
      <div className="relative overflow-hidden bg-background" style={{ borderRadius: SCREEN_RADIUS }}>
        <StatusBar />
        {children}
      </div>
    </div>
  );
}

function StatusBar() {
  return (
    <div className="flex items-center justify-between px-6 pt-3 text-[11px] font-semibold tabular">
      <span>9:41</span>
      <span className="h-[18px] w-[72px] rounded-full bg-foreground" aria-hidden />
      <span>87%</span>
    </div>
  );
}

// The photo's blank screen, as a fraction of hand-phone.webp (700×1266), measured from the source still.
const SCREEN = { left: "15.71%", top: "2.84%", width: "58.29%", height: "73.30%" };

// A real hand holding the phone (Flow still, cut out), with the live dashboard laid over its blank screen.
// Built at 446px wide so the screen is exactly 260px, the width the dashboard is designed at.
export function HandPhone({ children }: { children?: React.ReactNode }) {
  return (
    <div className="relative w-[446px]">
      {/* eslint-disable-next-line @next/next/no-img-element -- transparent cutout, sized by its container */}
      <img src="/media/hand-phone.webp" alt="" width={700} height={1266} fetchPriority="high" className="block w-full" />
      <div className="absolute overflow-hidden bg-background" style={{ ...SCREEN, borderRadius: 19 }}>
        <StatusBar />
        <Dashboard />
      </div>
      {children}
    </div>
  );
}

function Dashboard() {
  return (
        <div className="px-4 pb-5 pt-4">
          <div className="flex items-center justify-between">
            <span className="font-display text-lg font-semibold tracking-[-0.03em]">eri</span>
            <span className="rounded-full border border-border bg-card px-2.5 py-0.5 text-[10px] font-medium text-muted-foreground">
              This week
            </span>
          </div>

          <div className="mt-4 rounded-2xl bg-card p-4 shadow-soft">
            <p className="text-[11px] text-muted-foreground">Real money in</p>
            <p className="mt-1 font-display text-[32px] font-semibold leading-none tracking-[-0.03em] tabular">
              {naira(41_200_000)}
            </p>
            <div className="mt-3 flex gap-3 text-[11px] font-medium tabular">
              <span>23 sales</span>
              <span className="text-muted-foreground">·</span>
              <span className="text-landed">0 fakes paid out</span>
            </div>
          </div>

          <p className="mt-4 text-[11px] font-semibold uppercase tracking-[0.08em] text-muted-foreground">Today</p>
          <ul className="mt-2 divide-y divide-border overflow-hidden rounded-2xl bg-card shadow-soft">
            {feed.map((f) => (
              <li key={f.item} className="flex items-center gap-3 px-3 py-2.5">
                <span className={`size-2 shrink-0 rounded-full ${dot[f.verdict]}`} aria-hidden />
                <div className="min-w-0 flex-1">
                  <p className="truncate text-[12px] font-semibold">{f.item}</p>
                  <p className="truncate text-[10px] text-muted-foreground">{f.who}</p>
                </div>
                <div className="text-right">
                  <p className="text-[12px] font-semibold tabular">
                    {f.verdict === "landed" ? "+" : ""}
                    {naira(f.kobo)}
                  </p>
                  <p
                    className={`text-[10px] font-medium ${f.verdict === "landed" ? "text-landed" : "text-not-received"}`}
                  >
                    {f.label}
                  </p>
                </div>
              </li>
            ))}
          </ul>

          <div className="mt-3 flex items-center justify-between rounded-full border border-suspicious/40 bg-card px-3.5 py-2">
            <span className="text-[11px] font-medium">Ankara Gown</span>
            <span className="text-[11px] font-semibold text-suspicious tabular">3 left</span>
          </div>
        </div>
  );
}
