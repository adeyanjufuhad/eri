// Money is kobo (integer) everywhere; format only at the UI edge. ₦25,000 = 2_500_000 kobo.
const fmt = new Intl.NumberFormat("en-NG", { maximumFractionDigits: 2 });

export function naira(kobo: number): string {
  return "₦" + fmt.format(kobo / 100);
}
