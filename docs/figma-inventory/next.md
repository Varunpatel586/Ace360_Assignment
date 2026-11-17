# Figma Inventory — Next.js (SOFALIVING Sofa Customiser)

**Source file:** Ace Assignment — `RJu5laxqekzhu96jCSj3Cn`
**Page:** Page 3 → Frame `Nextjs` (id `1006:2`, 1280 × 7764)
**Sub-frame:** `Html → Body` (1001:2352) → `Main` (1001:2353, 1280 × 6382.5)
**Design context:** `get_design_context` on `1001:2353` (session `784b4130`)

---

## Frames and Sizes

| Frame | Size | Description |
|---|---|---|
| Html → Body | 1280 × 7338 | Full page shell |
| Main | 1280 × 6382.5 | Page content |
| Section — Header | 1280 × 1290.03 | Hero + CTA top section |
| Container | 1280 × 1138.03 | Hero content container |
| Header Text Editorial Grid | 768 × 391.3 | Hero heading area |
| Heading 1 | 768 × 144.7 | "Bespoke Sofas, Sculpted for Modern Indian Homes." |
| CTAs | 768 × 58.7 | Two CTA buttons |
| Hero Primary Image Frame | 1152 × 638 | Hero sofa image + badge |
| Section — Signature Collections | 1280 × 920.5 | Featured sofa cards |
| Product Cards Grid | 1152 × 618.5 | 3-card grid (Luna, Urban, Cloud) |
| Card 1: Luna | 362.67 × 618.5 | Luna sofa card |
| Card 2: Urban | 362.67 × 618.5 | Urban sofa card |
| Card 3: Cloud | 362.67 × 618.5 | Cloud sofa card |
| Customiser Dual Column Canvas | 1280 × 1459 | Left stage + right customiser |
| Stage Card | ~620 × ~620 | Live preview stage |
| RIGHT COLUMN: Customiser Engine | 6 cols | 4-step customiser |
| STEP 01: Choose Sofa Model | — | Luna / Urban / Cloud pills |
| STEP 02: Choose Colour | — | Beige / Charcoal / Olive / Midnight swatches |
| STEP 03: Fabric Type | — | Linen / Velvet / Leatherette |
| STEP 04: Seating Configuration | — | 2 Seater / 3 Seater / L Shape |
| Price Summary | — | Live quote + itemized breakdown |
| Enquiry Form | — | Name, Phone, Email, Message, swatch kit checkbox |
| Section — Manufacturer / About | — | 4 pillars + metrics ribbon |
| Pillar 1–4 | — | Kiln-Dried Hardwood, 38-Density Cold Foam, Direct from Factory, Zero Distributor Margin |
| Metrics Ribbon | — | 26 Years, 42k+ Homes, 10-Yr Warranty |

---

## Colour Tokens

| Token | Hex | Usage |
|---|---|---|
| --bg-light | #f0eee8 | Card backgrounds, badge backgrounds |
| --text-dark | #1c1c18 | Primary headings |
| --text-medium | #53433f | Body text, labels |
| --text-muted | #85736e | Secondary text, captions |
| --accent-brown | #6f3826 | Prices, accent text, selected borders |
| --button-brown | #8c4f3b | Primary CTA buttons |
| --bg-offwhite | #fcf9f3 | Form inputs, off-white panels |
| --stage-bg | #ebe8e2 | Customiser stage background |
| --color-vignette | #e4d8c5 | Dynamic color tint on stage |
| --border-light | #d8c2bb | Subtle borders |
| --border-focus | rgba(216,194,187,0.6) | Selected state borders |
| --border-strong | rgba(216,194,187,0.8) | Outline buttons |
| --badge-bg | rgba(252,249,243,0.9) | Blurred badge backgrounds |
---

## Typography

| Style | Family | Weight | Size | Line Height | Letter Spacing | Usage |
|---|---|---|---|---|---|---|
| Heading 1 | EB_Garamond | Regular | 64px | 72px | -1.28px | Hero heading |
| Step Label | DM_Sans | Bold | 10px | 14px | 1px | STEP 01/04 |
| Step Sub-label | DM_Sans | SemiBold | 10px | 14px | 0.8px | Base Architecture etc. |
| Step Heading | EB_Garamond | Medium | 24px | 32px | 0 | Choose Sofa Model etc. |
| Model Name | DM_Sans | Bold | 14px | 20px | 0.56px | Luna / Urban / Cloud |
| Model Desc | DM_Sans | Regular | 13px | 20px | 0 | Curved Boucle etc. |
| Model Price | DM_Sans | SemiBold | 12px | 16px | 0.72px | ₹42,999 etc. |
| Card Name | EB_Garamond | Medium | 24px | 32px | 0 | The Luna Curved |
| Card Price | DM_Sans | SemiBold | 14px | 20px | 0.56px | ₹42,999 |
| Card Desc | DM_Sans | Regular | 13px | 21.13px | 0 | Description text |
| CTA Button | DM_Sans | Medium | 14px | 20px | 0.56px | Start Customising, Customise Luna |
| Body Text | DM_Sans | Regular | 18px | 29.25px | 0 | Hero paragraph |
| Pillar Title | EB_Garamond | Medium | 24px | 32px | 0 | Kiln-Dried Hardwood etc. |
| Pillar Body | DM_Sans | Regular | 13px | 21.13px | 0 | Pillar descriptions |
| Metric Number | EB_Garamond | Regular | 64px | 72px | -1.28px | 26, 42k+, 10-Yr |
| Metric Label | DM_Sans | Medium | 12px | 16px | 0.72px | Years of Precision Craft etc. |
| Form Label | DM_Sans | Medium | 12px | 16px | 0.72px | Form field labels |
| Form Input | DM_Sans | Regular | 15px | normal | 0 | Placeholder text |
| Submit Button | DM_Sans | SemiBold | 14px | 20px | 0.56px | Submit Bespoke Enquiry |
| Footer Note | DM_Sans | SemiBold | 10px | 14px | 0.8px | Protected by end-to-end... |

Fonts: **EB Garamond** and **DM Sans** (both Google Fonts).

---

## Spacing / Radius / Shadow

| Token | Value | Usage |
|---|---|---|
| --radius-pill | 9999px | Buttons, pills, badges |
| --radius-card | 16px | Product cards |
| --radius-stage | 24px | Stage card, customiser panel |
| --radius-swatch | 9999px | Colour swatches (44px) |
| --shadow-card | 0 2px 12px -2px rgba(50,42,38,0.04) | Cards, stage |
| --shadow-btn | 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -2px rgba(0,0,0,0.1) | Primary buttons |
| --gap-section | 32px | Section gaps |
| --gap-cta | 16px | CTA button gap |
| --padding-container | 64px | Page horizontal padding |
| --padding-card | 32px | Card inner padding |
| --gap-grid | 32px | Product card grid gap |
| --swatch-size | 44px | Colour swatch diameter |

---

## Exported Assets

| File Name | Source | Type |
|---|---|---|
| hero-sofa.png | Minimalist architectural living room… | PNG 2x |
| luna-sofa.png | The Luna Curved Boucle Sofa | PNG 2x |
| urban-sofa.png | The Urban Mid-Century Velvet Sofa | PNG 2x |
| cloud-sofa.png | The Cloud Deep Lounge Sectional | PNG 2x |
| icon-arrow.svg | Margin / Arrow icon | SVG |
| icon-badge-1.svg | Floating badge icon 1 | SVG |
| icon-badge-2.svg | Floating badge icon 2 | SVG |
| icon-badge-3.svg | Floating badge icon 3 | SVG |
| icon-badge-4.svg | Floating badge icon 4 | SVG |
| icon-badge-5.svg | Floating badge icon 5 | SVG |
| icon-badge-6.svg | Floating badge icon 6 | SVG |
| icon-badge-7.svg | Floating badge icon 7 | SVG |
| icon-badge-8.svg | Floating badge icon 8 | SVG |
| icon-badge-9.svg | Floating badge icon 9 | SVG |
| icon-arrow-sm.svg | Small margin arrow | SVG |
| icon-badge-10.svg | Badge icon 10 | SVG |
| icon-badge-11.svg | Badge icon 11 | SVG |
| icon-badge-12.svg | Badge icon 12 | SVG |
---

## Complete Text Content

### Hero
- Heading: "Bespoke Sofas, Sculpted for Modern Indian Homes."
- Subheading: "Explore precision-tailored seating crafted with kiln-dried teak frames, high-density feather core foams, and over 120 artisan fabrics. Customise dimensions, fabrics, and contours in real-time."
- CTA 1: "Start Customising" (with arrow icon)
- CTA 2: "Explore Signature Models"
- Badge label: "LIVING ROOM SHOWCASE"
- Badge title: "The Nordic Minimalist 3-Seater in Oat Linen"

### Signature Collections Section
- Section heading: "Signature Collections"
- Section subheading: "Explore our foundational silhouettes, engineered for ergonomic posture and architectural presence."

**Card 1 — Luna:**
- Overlay tag: "Curved Artistry"
- Name: "The Luna Curved"
- Price: "₹42,999"
- Description: "Organic curved silhouette enveloped in soft, tactile boucle. Ideal for fluid, conversational open-plan spaces."
- Badges: "Curved Silhouette", "High-Traffic Boucle", "Soft Density"
- CTA: "Customise Luna"

**Card 2 — Urban:**
- Overlay tag: "Mid-Century Clean Lines"
- Name: "The Urban Mid-Century"
- Price: "₹54,999"
- Badges: "Mid-Century Clean Lines", "Solid Walnut Trim", "Firm Ergonomic Support"
- CTA: "Customise Urban"

**Card 3 — Cloud:**
- Overlay tag: "Deep Sanctuary"
- Name: "The Cloud Sectional"
- Price: "₹64,999"
- Badges: "Deep Sanctuary", "Cloud Softness", "L-Shape Ready"
- CTA: "Customise Cloud"

### Customiser
- Stage tag: "Luna Model"
- Stage colour: "Warm Beige"
- Stage seating: "3 Seater Standard"
- Badge: "360° Inspection Ready"
- STEP 01/04: "Choose Sofa Model" — Luna (₹42,999), Urban (₹54,999), Cloud (₹64,999)
- STEP 02/04: "Choose Colour" — Beige, Charcoal, Olive, Midnight
- STEP 03/04: "Material Tactility" — Natural Linen (+₹0), Matte Velvet (+₹5,000), Matte Vegan Leatherette (+₹8,000)
- STEP 04/04: "Spatial Footprint" — 2 Seater (−₹7,000), 3 Seater (₹0), L Shape (+₹18,000)
- Summary: "The Luna · Warm Beige · Natural Linen · 3 Seater"
- Live Quote badge: "Live Quote"
- Itemized:
  - Base Architecture (Luna): ₹42,999
  - Fabric Tier (Natural Linen): Included (+₹0)
  - Seating Configuration (3 Seater): Included (+₹0)
  - Total: ₹42,999

### Manufacturer / About
- Pillar 1: "Kiln-Dried Hardwood" — "0% moisture seasoned Teak and Sal wood with reinforced mortise-and-tenon corner joints. Termite-proofed for lasting structural peace of mind." — "Grade A Solid Timber"
- Pillar 2: "38-Density Cold Foam" — "Multi-layer cold-cure memory foam cores supported by S-spring suspension bands. Maintains rebound resilience and anatomical contour for 15+ years."
- Pillar 3: "Direct from Factory" — "Direct atelier-to-residence model skips middlemen markups. You invest purely in authentic timber, foam grade, and generational craft." — "Zero Distributor Margin"
- Metric 1: "26" — "Years of Precision Craft"
- Metric 2: "42k+" — "Homes Furnished Across India"
- Metric 3: "10-Yr" — "Frame Warranty Guarantee"

### Enquiry Form
- Fields (all labelled): Full Name, Phone Number (+91), Email Address, Delivery City & Pincode, Special Dimensions or Room Requirements (Optional)
- Placeholders: "9876543210 (10 digits)", "ananya@architecturestudio.in", "e.g. Bangalore, 560038"
- Checkbox: "Send a complimentary physical fabric swatch box (including the chosen fabric and 3 curated alternatives) to my delivery address at zero cost."
- Submit button: "Submit Bespoke Enquiry"
- Footer note: "Protected by end-to-end craft confidentiality. No marketing spam."

---

## Default State (from Figma)
- Model: Luna | Colour: Beige | Fabric: Linen | Seating: 3 Seater
- Price: ₹42,999

---

## Pricing Data (from assignment B1, verified against Figma)

| Model | Base Price | Colours |
|---|---|---|
| Luna | ₹42,999 | Beige, Grey, Blue, Green |
| Urban | ₹54,999 | Beige, Grey, Charcoal, Terracotta |
| Cloud | ₹64,999 | Beige, Blue, Green, Charcoal |

| Option | Choice | Adjustment |
|---|---|---|
| Fabric | Linen | ₹0 |
| Fabric | Velvet | +₹5,000 |
| Fabric | Leatherette | +₹8,000 |
| Configuration | 2 Seater | −₹7,000 |
| Configuration | 3 Seater | ₹0 |
| Configuration | L Shape | +₹18,000 |

**Note:** The assignment lists colours for each model (e.g. Luna: Beige, Grey, Blue, Green) but Figma shows Beige, Charcoal, Olive, Midnight for the customiser colour swatches. Per A5, Figma wins for what is displayed. This will be logged in DISCREPANCIES.md.

---

## Next Steps (awaiting your "go")
1. Download all Figma assets to `Next/public/images/`
2. Scaffold Next.js (App Router, TypeScript, CSS Modules)
3. Build components: Navbar, SofaCard, SofaCustomiser, ColourSelector, PriceSummary, EnquiryForm
4. Implement pricing logic from data file
5. Run, screenshot, compare vs Figma, fix differences
6. Write README.md, EXPLAINER.md, screenshots/
| icon-badge-13.svg | Badge icon 13 | SVG |
| icon-badge-14.svg | Badge icon 14 | SVG |
| icon-badge-15.svg | Badge icon 15 | SVG |
| icon-badge-16.svg | Badge icon 16 | SVG |
| icon-badge-17.svg | Badge icon 17 | SVG |
| icon-submit.svg | Submit arrow icon | SVG |
| icon-check.svg | Image/check icon | SVG |
| icon-image.svg | Image icon | SVG |

All Figma asset URLs expire after 7 days. Must be downloaded and committed.
| --dark-overlay | rgba(28,28,24,0.8) | Dark floating badges |
| --shadow-card | rgba(50,42,38,0.04) | Card shadow |
| --border-base | rgba(36,38,36,0.08) | Base border |
| --swatch-beige | (from Figma export) | Warm Beige swatch |
| --swatch-charcoal | #4e5258 | Slate Charcoal |
| --swatch-olive | #556346 | Olive Moss |
| --swatch-midnight | #283b4b | Midnight Blue |
| --swatch-luna-bg | rgba(111,56,38,0.05) | Selected model pill bg |
