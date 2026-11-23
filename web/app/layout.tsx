import type { Metadata } from "next";
import { Inter, Lexend } from "next/font/google";
import { SmoothScroll } from "@/components/smooth-scroll";
import "./globals.css";

const lexend = Lexend({ variable: "--font-lexend", subsets: ["latin"], weight: ["600"] });
const inter = Inter({ variable: "--font-inter", subsets: ["latin"] });

const description =
  "Eri reads the bank alerts on your Android phone, logs every real sale, and catches fake “I’ve paid” claims before the goods leave.";

export const metadata: Metadata = {
  title: "Eri: Proof, not screenshots",
  description,
  openGraph: { title: "Eri: Proof, not screenshots", description, type: "website", locale: "en_NG" },
  twitter: { card: "summary", title: "Eri: Proof, not screenshots", description },
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" className={`${lexend.variable} ${inter.variable} antialiased`} suppressHydrationWarning>
      <head>
        {/* lets CSS hide entrance elements before paint, only when JS will animate them in */}
        <script dangerouslySetInnerHTML={{ __html: "document.documentElement.classList.add('js')" }} />
      </head>
      <body>
        <SmoothScroll />
        {children}
      </body>
    </html>
  );
}
