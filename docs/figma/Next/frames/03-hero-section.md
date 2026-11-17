# Figma Spec — Frame 3: Hero Section

Frame ID: 1001:62
Size: 1280 × ~800
Type: Hero banner section

## Description
Hero section with heading, subtitle, promotional badge/pill, and CTA buttons. Features a large background image.

## Verbatim Text Content
- Promotional badge/pill: "Architectural Living · Handcrafted in Bangalore & Mumbai"
- Heading 1: "Bespoke Sofas, Sculpted for Modern Indian Homes."
- Subheading: "Explore precision-tailored seating crafted with kiln-dried teak frames, high-density feather core foams, and over 120 artisan fabrics. Customise dimensions, fabrics, and contours in real-time."

## Layout Structure
- Hero section: full width container with centered content
- Promotional badge/pill: small pill-shaped badge above heading, left-aligned
- Heading 1: Large serif heading (64px, EB Garamond or similar serif)
- Subheading: Body text inside bordered box with outline

## Auto-Layout
- Vertical stack: badge → heading → subheading
- Gap between badge and heading
- Gap between heading and subheading
- Max-width constraint on text content

## Colours
- Badge pill background: light neutral (#f8fafc or similar)
- Badge pill text: dark (#334155 or similar)
- Heading: #1c1c18 (var(--text-dark))
- Subheading: #53433f (var(--text-medium))

## Typography
- Badge pill text: Liberation_Sans Regular 12px
- Heading 1: EB Garamond Bold 64px, line-height 72px, letter-spacing -1.6px
- Subheading: Liberation_Sans Regular 14px, line-height 20px

## Shadows & Radii
- Badge pill: rounded corners (var(--radius-full) or 9999px)
- Subheading box: thin border, slight radius

## Assets
- hero-sofa.png (PNG 2x) - background image if any

## Prototype Interactions
- Hero section is display-only, no interactions

## Responsive Notes
- Stacks vertically on mobile
- Heading size adjusts at breakpoints

## Frame Image Reference
- Frame image reference: images/03-hero-section.png (to be exported at 2x)