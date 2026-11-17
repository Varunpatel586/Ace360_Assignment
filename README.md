# Ace360_Assignment

Five small frontend projects rebuilt as a 1:1 recreation of the **"Ace Assignment"** Figma file, one folder per project. Built for an Ace360degree internship assignment.

## Projects

| Folder | Project | Stack | Summary |
|---|---|---|---|
| `Wordpress/` | Landing page | Custom WordPress theme (PHP) | One-page site: header, hero, services, about/testimonials, contact, footer |
| `Laravel/` | Product Admin Dashboard | Laravel, Blade, MySQL | Product CRUD dashboard with search, filters, sorting, pagination |
| `Next/` | SOFALIVING Sofa Customiser | Next.js (App Router), TypeScript, CSS | Sofa customiser: model/colour/fabric/seating controls, price summary, enquiry form |
| `Flutter/` | SOFALIVING Mobile Shopping App | Flutter + Provider | Mobile shopping app: home, listing, details, wishlist, cart, checkout, confirmation |
| `Shopify/` | URBAN THREADS Fashion Store | Shopify theme (Liquid) | Theme: home, collections (Men, Women, T-Shirts, Jeans, Shirts), product, cart, policy pages |

## How to run each project

See the `README.md` inside each project folder for exact setup and run steps (Windows).

Quick overview:

- **Wordpress:** install WordPress locally (XAMPP/Local with your existing MySQL), copy the theme into `wp-content/themes/`, activate it, set a static front page.
- **Laravel:** `composer install`, create database `ace360_products` in MySQL Workbench, copy `.env.example` to `.env` and fill DB credentials, `php artisan key:generate`, `php artisan migrate --seed`, `php artisan storage:link`, `php artisan serve`.
- **Next:** `npm install` (requires Node.js), `npm run dev`, open `http://localhost:3000`.
- **Flutter:** `flutter pub get`, `flutter run` on an Android emulator/device (requires Flutter SDK).
- **Shopify:** `shopify theme dev` (requires Shopify CLI connected to your dev store); import `Shopify/data/products.csv` into the store.

## Tech used per project

- WordPress: PHP, CSS, HTML5 (no page builder, no paid plugins)
- Laravel: PHP (Blade), MySQL
- Next.js: React, TypeScript, CSS Modules
- Flutter: Dart, Provider
- Shopify: Liquid, HTML/CSS, minimal JS

## Folder layout

```
docs/figma-inventory/   one inventory file per project (written before coding each project)
docs/DISCREPANCIES.md   table of Figma-vs-assignment conflicts and gaps
```

## Git

Initialised at the repo root. First commit: `chore: scaffold Ace360_Assignment`. Do not push. Commit per project in small steps (`feat:`, `fix:`, `docs:`, `style:`).