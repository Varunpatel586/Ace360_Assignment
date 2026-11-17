# SOFALIVING — Next.js Sofa Customiser

A 1:1 recreation of the `Nextjs` frame from the Ace Assignment Figma file (Page 3, frame `1006:2`, 1280 × 7764) — the SOFALIVING bespoke seating website with an interactive 4-step sofa customiser.

## Tech

- Next.js (App Router, TypeScript)
- CSS Modules + plain CSS custom properties (design tokens from Figma) — no UI library
- Fonts via `next/font/google`: EB Garamond (headings) + DM Sans (UI)

## Run

```bash
cd Next
npm install
npm run dev      # http://localhost:3000
# or production:
npm run build && npm run start -- -p 3100
```

> Note: during development, port 3000 was occupied on my machine, so production was verified on `localhost:3100`.

## Structure

- `src/app/layout.tsx` — fonts + metadata
- `src/app/page.tsx` — section composition
- `src/app/globals.css` — Figma design tokens (`--bg-light`, `--accent-brown`, radii, shadows…)
- `src/components/` — `Navbar`, `Hero`, `SofaCard`, `SofaCustomiser`, `Craftsmanship`, `EnquiryForm`, `Footer` (each with its own `.module.css`)
- `src/data/catalogue.ts` — sofa models, fabrics, seating options, pricing, formatters
- `public/images/` — sofa renders and icon SVGs exported from Figma

## Features

- Signature Collections: Luna ₹42,999 / Urban ₹54,999 / Cloud ₹64,999 cards
- Interactive customiser: Model → Colour → Fabric → Seating, with a live quote summary
- Enquiry form (name, phone, email, delivery date, message) with validation states
- Manufacturer section with 4 pillars + 3 metrics

## Screenshots

Full-page renders of the built site are in `screenshots/` (`desktop-1280.png` is taken at the Figma frame width).

See `EXPLAINER.md` for implementation notes and `../docs/figma-inventory/next.md` for the full design inventory.
