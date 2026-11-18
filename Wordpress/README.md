# Smilecure — Dental Clinic WordPress Theme

A 1:1 WordPress recreation of the dental-clinic design.

## What's here

| Path | Purpose |
| --- | --- |
| `smilecure/` | Theme source (classic theme, no plugins or page builder required) |
| `smilecure-theme.zip` | Upload-ready build — contains a single top-level `smilecure/` folder |
| `_wptest/` | Local WordPress + SQLite test site (portable PHP, no MySQL, no admin rights) |

## Run the local test site

No PHP on PATH is required — portable PHP 8.3 lives in `_wptest/php/`.

Start the built-in PHP server from the project root:

```bash
cd _wptest && ./php/php.exe -S localhost:8080 -t wordpress
```

Then open:

- Site: <http://localhost:8080/>
- Admin: <http://localhost:8080/wp-admin/> — user `admin`, password `adminpass123`

Keep the terminal open while testing; `Ctrl+C` stops the server.

Restart it later with the same command above, or run it in the background:

```bash
cd _wptest && ./php/php.exe -S localhost:8080 -t wordpress > server.log 2>&1 &
```

To check whether it is already running:

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8080/
```

A `200` means the server is up.

## Theme notes

- Homepage is `front-page.php`, so no page setup is needed after activation.
- The "Latest News" section lists the 3 newest real posts (with bundled fallback images). With no posts it shows unlinked demo cards — no dead links.
- Footer Privacy Policy / Terms links resolve by page slug (`privacy-policy`, `privacy`, `terms-conditions`, `terms-and-conditions`, `terms-of-service`, `terms`) and are omitted when those pages don't exist.
- The appointment form posts to `admin-post.php` (`smilecure_appointment`) and uses `wp_mail()`; no email is delivered locally without an SMTP plugin.

## Local environment limitations

- Permalinks are set to **Plain** (`?p=4`, `?page_id=3`) because PHP's built-in server has no rewrite rules. A real host can use pretty permalinks.
- The site runs on SQLite through the `sqlite-database-integration` drop-in, not MySQL. This is for local testing only — the theme itself has no database dependency beyond WordPress core.

## Delivering to WordPress

Upload `smilecure-theme.zip` via **Appearance → Themes → Add New → Upload Theme**, then activate **Smilecure**.
