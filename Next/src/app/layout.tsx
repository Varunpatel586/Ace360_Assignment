import type { Metadata } from "next";
import { EB_Garamond, DM_Sans } from "next/font/google";
import "./globals.css";

const ebGaramond = EB_Garamond({
  subsets: ["latin"],
  weight: ["400", "500"],
  variable: "--font-eb-garamond",
});

const dmSans = DM_Sans({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  variable: "--font-dm-sans",
});

export const metadata: Metadata = {
  title: "SOFALIVING — Bespoke Sofas for Modern Indian Homes",
  description:
    "Precision-tailored seating crafted with kiln-dried teak frames and high-density foams. Customise model, colour, fabric and seating in real time.",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" suppressHydrationWarning className={`${ebGaramond.variable} ${dmSans.variable}`}>
      <body>{children}</body>
    </html>
  );
}
