# Figma Spec — Frame 4: Signature Collections

Frame ID: 1001:2403
Size: 1280 × 920.5
Type: Product showcase section

## Description
Featured sofa cards section showing Luna, Urban, and Cloud models with prices and Customise buttons.

## Verbatim Text Content
- Section heading: "Signature Collections"
- Section subheading: "Explore our foundational silhouettes, engineered for ergonomic posture and architectural presence."

## Card 1 — Luna
- Overlay tag: "Curved Artistry"
- Name: "The Luna Curved"
- Price: "₹42,999"
- Description: "Organic curved silhouette enveloped in soft, tactile boucle. Ideal for fluid, conversational open-plan spaces."
- Badges: "Curved Silhouette", "High-Traffic Boucle", "Soft Density"
- CTA: "Customise Luna"

## Card 2 — Urban
- Overlay tag: "Mid-Century Clean Lines"
- Name: "The Urban Mid-Century"
- Price: "₹54,999"
- Description: "Mid-century clean lines with solid walnut trim and firm ergonomic support."
- Badges: "Mid-Century Clean Lines", "Solid Walnut Trim", "Firm Ergonomic Support"
- CTA: "Customise Urban"

## Card 3 — Cloud
- Overlay tag: "Deep Sanctuary"
- Name: "The Cloud Sectional"
- Price: "₹64,999"
- Description: "Mystery, and seating scale. Observe instant recalculation and seamless synchronization with our craftsmen."
- Badges: "Deep Sanctuary", "Cloud Softness", "L-Shape Ready"
- CTA: "Customise Cloud"

## Layout Structure
- 3-column grid (grid-3) with gap of 32px
- Each card: white background, rounded corners (16px), border
- Image at top (aspect ratio ~4:3), then info section below
- Each card has: overlay tag, name, price, description, badges, CTA button

## Colours
- Card background: #ffffff
- Border: #e3e2df
- Card price text: #6f3826 (accent brown)
- Overlay tags: semi-transparent background

## Fonts
- Card names: EB Garamond Medium 24px
- Card prices: DM_Sans SemiBold 14px
- Card descriptions: DM_Sans Regular 13px
- Badges: DM_Sans SemiBold 10px, uppercase

## Shadows & Radii
- Card shadow: var(--shadow-card)
- Card border-radius: var(--radius-card) (16px)
- Overlay badge: var(--radius-full) (9999px)

## Assets
- luna-sofa.png (PNG 2x)
- urban-sofa.png (PNG 2x)
- cloud-sofa.png (PNG 2x)
- icon-badge-*.svg (badge icons)

## Prototype Interactions
- Customise buttons select that model in customiser and scroll to customiser section

## Responsive Notes
- Grid collapses to 1-2 columns on mobile
- Card aspect ratio maintained

## Frame Image Reference
- Frame image reference: images/04-signature-collections.png (to be exported at 2x)