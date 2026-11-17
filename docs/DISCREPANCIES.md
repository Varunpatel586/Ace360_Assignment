# Discrepancies and gaps

| Project | Where | Figma says | Assignment says | What I did |
|---|---|---|---|---|
| Next.js | Signature Collections → Luna colour swatches | Beige, Charcoal, Olive, Midnight | Assignment example listed: Beige, Grey, Blue, Green | Followed Figma (swatches shown in the design); logged here per the brief. |
| Next.js | Port | n/a | n/a | Port 3000 was occupied locally, so production server verified on `localhost:3100` (`next start -p 3100`). No code impact. |
| Next.js | Tooling | n/a | n/a | An initial `next.config.ts` draft contained a `turbopack` rule that unscoped CSS Modules, breaking all page styles. Rule removed; scoped CSS verified. |
