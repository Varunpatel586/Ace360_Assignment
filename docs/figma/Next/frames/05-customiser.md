# Figma Spec — Frame 5: Customiser Dual Column Canvas

Frame ID: 1001:2500
Size: 1280 × 1459
Type: Interactive customiser section

## Description
Dual-column layout with left column showing live preview stage and right column showing 4-step interactive customiser controls.

## Left Column — Stage Card
- Stage card: background #ebe8e2, border-radius 48px
- Stage tag: "Luna Model" (pill badge)
- Stage colour: "Warm Beige" (pill badge)
- Stage seating: "3 Seater Standard" (pill badge)
- Badge: "360° Inspection Ready" (dark pill badge)

## Right Column — Customiser Engine

### STEP 01: Choose Sofa Model
- Model options: Luna (₹42,999), Urban (₹54,999), Cloud (₹64,999)
- Model selection pills with name and short description
- Selected model shows border/accent

### STEP 02: Choose Colour
- Colour swatches: Beige, Charcoal, Olive, Midnight
- Selected swatch has border/accent ring

### STEP 03: Fabric Type
- Fabric options: Natural Linen (+₹0), Matte Velvet (+₹5,000), Matte Vegan Leatherette (+₹8,000)
- Each option: name, description, price adjustment

### STEP 04: Seating Configuration
- Configuration options: 2 Seater (−₹7,000), 3 Seater (₹0), L Shape (+₹18,000)

## Price Summary
- Summary string: "The Luna · Warm Beige · Natural Linen · 3 Seater"
- Live Quote badge
- Itemized breakdown:
  - Base Architecture (Luna): ₹42,999
  - Fabric Tier (Natural Linen): Included (+₹0)
  - Seating Configuration (3 Seater): Included (+₹0)
  - Total: ₹42,999

## Enquiry Form (embedded)
- Fields: Full Name, Phone Number (+91), Email Address, Delivery City & Pincode, Special Dimensions or Room Requirements (Optional)
- Placeholders: "9876543210 (10 digits)", "ananya@architecturestudio.in", "e.g. Bangalore, 560038"
- Checkbox: "Send a complimentary physical fabric swatch box (including the chosen fabric and 3 curated alternatives) to my delivery address at zero cost."
- Submit button: "Submit Bespoke Enquiry"

## Layout Structure
- Dual column: left column (stage) and right column (customiser controls)
- Grid layout with gap between columns

## Colours
- Selected model pill: rgba(111,56,38,0.05) background
- Colour swatches: various hex values
- Fabric options: different background colors

## Fonts
- Step labels: DM_Sans Bold 10px, uppercase, tracking 1px
- Step headings: EB Garamond Medium 24px
- Model names: DM_Sans Bold 14px
- Colours: DM_Sans Regular 11px
- Summary text: EB Garamond Medium 24px
- Itemized breakdown: DM_Sans Medium 14px

## Shadows & Radii
- Stage card: var(--radius-stage) (24px)
- Colour swatches: var(--radius-full) (9999px, 44px diameter)
- Pill badges: var(--radius-full)
- Selection borders: 2px solid

## Assets
- Stage images per model/colour combination

## Prototype Interactions
- Model selection updates base price and available colours
- Colour selection updates swatch and main image
- Price recalculates on every change
- Enquiry form validates on submit

## Responsive Notes
- Stacks columns vertically on mobile
- Customiser steps become vertical stack

## Frame Image Reference
- Frame image reference: images/05-customiser.png (to be exported at 2x)