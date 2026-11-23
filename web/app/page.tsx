import { Hero } from "@/components/hero";
import { SiteNav } from "@/components/site-nav";
import { SiteFooter } from "@/components/site-footer";
import { WordReveal } from "@/components/word-reveal";
import { AlertLands } from "@/components/alert-lands";
import { FakeCheck } from "@/components/fake-check";
import { PaidClaim } from "@/components/paid-claim";
import { Books } from "@/components/books";
import { Canary } from "@/components/canary";
import { Privacy } from "@/components/privacy";
import { ScoreCta } from "@/components/score-cta";

export default function Home() {
  return (
    <main>
      <SiteNav />
      <Hero />
      <WordReveal />
      <AlertLands />
      <FakeCheck />
      <PaidClaim />
      <Canary />
      <Books />
      <Privacy />
      <ScoreCta />
      <SiteFooter />
    </main>
  );
}
