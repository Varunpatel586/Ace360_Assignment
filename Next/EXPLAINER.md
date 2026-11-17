# EXPLAINER — Next.js (SOFALIVING)

## What this is
A 1:1 recreation of the `Nextjs` Figma frame (SOFALIVING landing page + sofa customiser), built with Next.js App Router, TypeScript, and hand-written CSS Modules. No component/UI library was used; every colour, radius, shadow and font came from the Figma inventory (`docs/figma-inventory/next.md`).

## Key implementation decisions

### Design tokens
All Figma colour/type/radius values live as CSS custom properties in `src/app/globals.css` (`--bg-light`, `--accent-brown`, `--radius-pill`, `--shadow-card`, …). Components reference only these variables, so the palette matches Figma exactly and stays consistent across sections.

### Fonts
Loaded with `next/font/google` and exposed as CSS variables (`--font-eb-garamond`, `--font-dm-sans`). EB Garamond is used for headings/prices, DM Sans for UI text, matching Figma's 64px serif headings + 10–15px sans labels.

### Data-driven catalogue
`src/data/catalogue.ts` holds the sofa models (Luna/Urban/Cloud), colourways, fabrics and seating options with pricing. Components render from this data — no content is hardcoded in JSX — so Figma text stays verbatim in one place.

### Customiser
A client component (`SofaCustomiser`) implements the 4-step flow (Model → Colour → Fabric → Seating). Selecting an option updates a live quote panel showing the price breakdown, mirroring the Figma panels. The three `SofaCard`s on the landing page scroll/jump the user into the customiser with the chosen model pre-selected.

### CSS issue encountered (fixed)
An initial `next.config.ts` contained a `turbopack` rule that transformed CSS Modules into unscoped plain CSS, so no styles reached the page. Removing the rule restored scoped CSS Modules (verified via rendered class names like `cJzEcG_header` and stylesheet chunks loading with 0 console errors).

## Verification
- `npm run build` passes (production build).
- Page served at 1280px and compared section-by-section against the Figma frame; screenshots in `screenshots/`.
- Headless Chromium check: 0 console errors, 0 failed requests, styled class names present on elements.

## Known limitations
- The enquiry form performs client-side validation only; no submission backend exists (out of scope of the design).
- Fonts fall back to system serif/sans if the Google Fonts fetch fails at build time.
