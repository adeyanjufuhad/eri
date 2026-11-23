import { naira } from "@/lib/naira";

export type Alert = { bank: string; mark: string; kobo: number; from: string; desc?: string; ago: string };

// A bank credit notification as it shows in the Android shade. Bank names in plain text only, no logos.
// `badge` is an optional verdict pill on the right of the header (the hero puts "Landed" there).
export function AlertCard({ a, badge }: { a: Alert; badge?: React.ReactNode }) {
  return (
    <div className="h-full w-[260px] rounded-2xl border border-border bg-card p-3.5">
      <div className="flex items-center gap-2 text-[11px] text-muted-foreground">
        <span className="grid size-5 place-items-center rounded-md bg-foreground text-[10px] font-bold text-background" aria-hidden>
          {a.mark}
        </span>
        <span className="font-medium text-foreground">{a.bank}</span>
        <span>· {a.ago}</span>
        {badge && <span className="ml-auto">{badge}</span>}
      </div>
      <p className="mt-2 text-[13px] font-semibold">
        Credit <span className="tabular text-landed">{naira(a.kobo)}</span>
      </p>
      <p className="mt-0.5 truncate text-[12px] text-muted-foreground">
        from {a.from}
        {a.desc ? ` · “${a.desc}”` : ""}
      </p>
    </div>
  );
}
