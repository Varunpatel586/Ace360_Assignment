# URBAN THREADS — Shopify Theme (Fashion Store)

**Live Store URL:** [https://wxj0dm-yh.myshopify.com/](https://wxj0dm-yh.myshopify.com/)  
**Figma source:** Ace Assignment — Page 3, Frame `Shopify` (`1006:4`, 1280 × 4595)

A 1:1 recreation of the URBAN THREADS fashion store homepage using a Shopify theme (Liquid, sections, snippets, JSON templates, CSS, minimal JS). No custom backend, no apps, no custom API work.

## Tech

- Shopify Theme (Liquid)
- CSS (plain CSS with CSS custom properties / design tokens)
- Minimal vanilla JS (cart drawer, quantity steppers, wishlist toggle)
- Fonts: **Inter**, **Plus Jakarta Sans**, **Space Grotesk** (Google Fonts)

## Setup

### Prerequisites

- Shopify CLI (`npm install -g @shopify/cli @shopify/theme`)
- A Shopify Dev Store (create one at [https://help.shopify.com/en/manual/users/user-invitations](https://help.shopify.com/en/manual/users/user-invitations))

### 1. Clone the repo (if starting from scratch)

```bash
cd Ace360_Assignment
git clone <your-repo>
cd Ace360_Assignment/Shopify
```

### 2. Create the theme

```bash
shopify theme dev --project-id <your-project-id>
```

This creates a local development store and a new theme. The theme code is placed in the `themes/<theme-id>/` folder.

### 3. Push changes

```bash
shopify theme push
```

### 4. Import product data

```bash
# In your Shopify Admin → Products → Import
# Use data/products.csv (format: Shopify's native CSV import)
```

The CSV columns:
- `product` — internal handle (slug)
- `title` — product title
- `price` — selling price (₹)
- `compare_at_price` — compare-at price (leave blank if none)
- `sku` — SKU
- `vendor` — vendor name
- `inventory_quantity` — stock quantity
- `type` — product type (can be blank)
- `tags` — comma-separated tags (e.g. Men; T-Shirts; Best Seller)

### 5. Activate the theme

In the Shopify Admin → Online Store → Themes → select your theme → Activate.

## Theme Structure

```
assets/
  base.css              # Design tokens, reset, global styles
  theme.css             # Components (buttons, product cards, hero, etc.)
  main.js               # Cart drawer, quantity steppers, wishlist toggle
config/
  theme.json            # Theme config (section order, template overrides)
  settings_schema.json  # Theme editor settings (logo, colours, typography, homepage content)
locales/
  en.default.json       # Internationalisation strings
sections/
  homepage.json         # Homepage section configuration
  ...                   # All sections (header, hero-banner, collections, products, footer, etc.)
snippets/
  product-card.liquid   # Product card markup
  cart-line-item.liquid # Cart line item markup
  color-swatch.liquid   # Color swatch widget
  price.liquid          # Price formatting
  footer-links.liquid   # Footer column with links
  cart-checkout.liquid  # Checkout button
templates/
  index.json            # Homepage template
  collection.json       # Collection page template
  product.json          # Product page template
  cart.json             # Cart template
  404.json              # 404 template
  page.json             # Generic page template
data/
  products.csv          # Product catalogue for import
```

## Sections

| Section | Type | Description |
|---|---|---|
| `header` | Section | Site header with navigation, search, and cart |
| `hero-banner` | Section | Promotional hero with heading, subheading, and CTA buttons |
| `micro-specs` | Section | Micro-spec stat row (240 GSM / Pre-Shrunk / ₹999+ / Free Delivery) |
| `featured-collections` | Section | 4 collection cards with hover overlay and "Explore Catalog" links |
| `featured-products` | Section | Product grid with category quick-filter chips |
| `product-card` | Section | Product card with image, category, title, price, and optional wishlist |
| `product-information` | Section | Product page: quantity, variant picker, colour swatches, size picker, SKU, wishlist, buy now |
| `cart-items` | Section | Cart line items with quantity controls |
| `cart-totals` | Section | Cart subtotal, shipping, taxes, order total |
| `cart-checkout` | Section | Checkout button |
| `footer` | Section | Footer columns: links, about, contact, payment methods, social |
| `pagination` | Section | Pagination controls |
| `collection-grid` | Section | Collection listing with header and product cards |
| `about-us-page` | Section | About Us page content |
| `contact-us-page` | Section | Contact Us page content |
| `shipping-policy` | Section | Shipping policy page content |
| `return-policy` | Section | Return policy page content |

## Data & Products

All product data comes from `data/products.csv` (Shopify's native CSV import format). The catalogue includes:

| Product | SKU | Price | Collection / Options |
|---|---|---|---|
| Men's Classic Cotton T-Shirt | MTS001 | ₹699 | Men / T-Shirts; Black, White, Navy; S–XXL |
| Men's Oversized T-Shirt | MTS002 | ₹899 | Men / T-Shirts; Beige, Black, Olive; S–XL |
| Men's Slim-Fit Jeans | MJN001 | ₹1,499 | Men / Jeans; Blue/Black; waist 30–36 |
| Men's Checked Shirt | MSH001 | ₹1,199 | Men / Shirts; Blue/Green checks; S–XXL |
| Women's Essential T-Shirt | WTS001 | ₹599 | Women / T-Shirts; White, Black, Pink; XS–XL |
| Women's Oversized T-Shirt | WTS002 | ₹799 | Women / T-Shirts; Lavender, Cream, Black; XS–XL |
| Women's High-Waist Jeans | WJN001 | ₹1,499 | Women / Jeans; Light/Dark Blue; waist 26–34 |
| Women's Striped Shirt | WSH001 | ₹1,099 | Women / Shirts; Blue/Pink stripe; XS–XL |

## Design Notes

- Fonts: **Space Grotesk** (headings), **Inter** (body), **Plus Jakarta Sans** (hero)
- Colours: Off-white background `#F4F3F0`, dark text `#444748`, primary `#18233C`, secondary `#FE8357`
- Cards: White background, `#E3E2DF` borders, `#C4C7C7` border-strong
- Rounded corners: 12px on product thumbnails/badges, 16px on cards, pill-shaped buttons
- Typography: Space Grotesk 700 for section labels, Plus Jakarta Sans 800 for headings, Inter 400/600 for body
