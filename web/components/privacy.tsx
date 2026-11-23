import { SectionTag, h2Class } from "@/components/stage-frame";

// §8: what stays on the phone vs what syncs. Mirrors docs/DATA_MODEL.md: bank_events sync parsed fields
// + raw_hash; raw_notifications and chat_previews are on-device only. Static: nothing here needs motion.
const stays = [
  "The full alert text, word for word",
  "Your balance and account numbers",
  "WhatsApp and Instagram previews (deleted after 24h)",
  "Receipt screenshots you share in",
];
const syncs: [string, string][] = [
  ["amount", "₦25,000 · credit"],
  ["from", "CHIOMA OKAFOR"],
  ["note", "ankara gown"],
  ["time", "21 Nov · 2:14 PM"],
  ["raw_hash", "9f3c…a71e"],
];

export function Privacy() {
  return (
    <section id="privacy" className="relative px-5 py-28 sm:px-8 sm:py-40" aria-labelledby="privacy-title">
      <div className="mx-auto w-full max-w-6xl">
        <SectionTag>Privacy</SectionTag>
        <h2
          id="privacy-title"
          className={`mt-5 max-w-3xl ${h2Class}`}
        >
          Your alerts never leave your phone.
        </h2>
        <p className="mt-4 max-w-xl text-sm text-muted-foreground sm:text-base">
          Eri reads and matches on the device. Only the few fields it needs for your books cross the line, plus a
          one-way hash so the same alert is never counted twice.
        </p>

        <div className="mt-12 grid items-stretch gap-4 md:grid-cols-[1fr_auto_1fr] md:gap-0">
          {/* inside the phone */}
          <div className="rounded-3xl bg-card p-6 shadow-soft sm:p-8">
            <p className="text-sm font-semibold">On your phone, never uploaded</p>
            <pre className="mt-4 whitespace-pre-wrap break-words rounded-2xl bg-muted p-4 font-mono text-[11px] leading-relaxed text-muted-foreground">
              {`GTBank: Acct 01******89 Cr NGN25,000.00
from CHIOMA OKAFOR Desc: ankara gown
Avail Bal: NGN412,300.00  21-Nov-26 14:14`}
            </pre>
            <ul className="mt-4 space-y-2 text-sm">
              {stays.map((s) => (
                <li key={s} className="flex gap-2">
                  <span className="mt-[0.4em] size-1.5 shrink-0 rounded-full bg-foreground" aria-hidden />
                  {s}
                </li>
              ))}
            </ul>
          </div>

          {/* the line */}
          <div className="flex items-center justify-center py-3 md:w-24 md:py-0" aria-hidden>
            <div className="relative h-px w-full border-t-2 border-dashed border-primary/60 md:h-full md:w-px md:border-l-2 md:border-t-0">
              <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 rounded-full bg-primary px-3 py-1 text-[11px] font-semibold text-primary-foreground whitespace-nowrap">only this</span>
            </div>
          </div>

          {/* what syncs */}
          <div className="rounded-3xl border border-border bg-card/60 p-6 sm:p-8">
            <p className="text-sm font-semibold text-primary">Synced to your Eri account</p>
            <dl className="mt-4 divide-y divide-border rounded-2xl bg-card px-4 font-mono text-[12px]">
              {syncs.map(([k, v]) => (
                <div key={k} className="flex justify-between gap-4 py-2">
                  <dt className="text-muted-foreground">{k}</dt>
                  <dd className="truncate text-right">{v}</dd>
                </div>
              ))}
            </dl>
            <p className="mt-4 text-sm text-muted-foreground">
              That&rsquo;s it. No balance, no account number, no chat text. Eri never asks for your bank login, and
              its service keys live on the server, never in the app.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
