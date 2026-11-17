# EXPLAINER — Shopify (URBAN THREADS Fashion Store)

## What this is
A Shopify theme that recreates the `Shopify` Figma frame from the Ace Assignment file (Page 3, frame `1006:4`, 1280 × 4595). It uses standard theme structure (`layout/`, `config/`, `locales/`, `sections/`, `snippets/`, `templates/`, `assets/`, `data/`) with Liquid markup, CSS design tokens, and minimal vanilla JS. All product data comes from Shopify objects (`product`, `collection`, `cart`) via JSON templates — no hardcoded store data except the homepage banner and static copy.

## Key implementation decisions

### Theme structure
Standard Shopify theme layout following Shopify conventions. `templates/*.json` map template types to sections via `settings_schema.json`. Each section config (`sections/*.json`) defines its blocks, settings, and defaults. Sections read settings through Liquid templates referenced by the theme's layout.

### Design tokens
All Figma colours (off-white background `#F4F3F0`, dark text `#444748`, primary `#18233C`, secondary `#FE8357`, badge `#A23E18`), typography (Space Grotesk headings, Inter body, Plus Jakarta Sans hero), spacing, radii, shadows, and borders live as CSS custom properties in `assets/base.css`. Component styles live in `assets/theme.css`.

### Components
- `product-card.liquid` — Product card: image, category, title, price, colour swatches, wishlist toggle
- `cart-line-item.liquid` — Cart item with image, title, variant, price, quantity stepper, remove button
- `color-swatch.liquid` — Radio-based colour swatch selector for product variants
- `price.liquid` — Price rendering with optional compare-at price
- `footer-links.liquid` — Footer column with heading + link list
- `cart-checkout.liquid` — Checkout button (demo/test mode only)

### Cart behaviour
The JS in `assets/main.js` handles: cart drawer open/close, wishlist heart toggle (outline ↔ filled), quantity increase/decrease steppers, mobile menu toggle. Cart persistence and actual checkout happen through Shopify's native cart (not a custom backend).

### Data-driven catalogue
`data/products.csv` is in Shopify's native CSV import format. The theme renders products, collections, variants, prices, and the cart from Shopify's Liquid objects — the homepage banner and static copy come from section settings with Figma text as defaults.

## How data flows

1. `shopify theme dev` starts a local dev server connected to a dev store
2. Shopify renders Liquid templates with data from the store (products, collections, cart)
3. Sections render within templates using settings from `config/settings_schema.json` and `templates/*.json`
4. JS in `assets/main.js` enhances cart/wishlist interactivity on the client

## Likely interview questions & answers

**Q: What tech stack did you use and why?**
A: Shopify Liquid theme with plain CSS and vanilla JS. I chose this because Shopify themes are the standard way to build ecommerce storefronts, and plain CSS keeps full control over the 1:1 Figma fidelity without a framework adding boilerplate.

**Q: How does the theme get product data?**
A: From Shopify's Liquid objects (`product`, `collection`, `cart`). The JSON templates reference sections which use Liquid markup to render data from the store. The `data/products.csv` is for importing the catalogue into a dev store.

**Q: How do you handle colour variants?**
A: Through `color-swatch.liquid`, which reads `product.options` and renders radio-based colour swatches. Selecting a swatch updates the variant via Shopify's native variant picker.

**Q: How does the cart work without a backend?**
A: Shopify's native cart handles adding items, quantities, removal, and checkout. The theme only adds UI enhancements (drawer, steppers, wishlist toggle) via vanilla JS.

**Q: How did you match Figma exactly?**
A: I extracted all visual values from Figma via the MCP — colours, fonts, spacing, radii, shadows — and put them in CSS custom properties. Components reference only these variables so the palette matches Figma exactly.

## Known limitations

- No real payment processing; checkout is tested in Shopify's test mode only
- Cart persistence is handled by Shopify's native cart (no custom backend)
- Wishlist is client-side only; items do not persist across sessions without a customer account
- Screenshots not yet captured against Figma (pending visual verification)

## Assignment requirements covered

| Requirement | Where |
|---|---|
| Shopify theme structure (`assets/ config/ layout/ locales/ sections/ snippets/ templates/`) | All present |
| Theme settings for logo, colours, typography | `config/settings_schema.json` |
| Products/collections rendered from Shopify objects | Liquid templates + sections |
| Homepage banner + static copy from section settings | `templates/index.json`, `sections/homepage.json` |
| `data/products.csv` for catalogue import | `data/products.csv` |
| Collection pages: Men, Women, T-Shirts, Jeans, Shirts | `templates/collection.json` |
| Product page with variant selectors + add-to-cart | `templates/product.json` |
| Cart page with quantity update + remove | `templates/cart.json` |
| Pages: About Us, Contact Us, Shipping Policy, Return Policy | `templates/page.json` |
