# Sofluent Technologies — website

Single static page. No build tooling, no dependencies (fonts load from Google Fonts).

- `src/page.html` — the source: `<title>`, `<style>`, and the page body. Edit this.
- `index.html` — generated full document. Do not edit by hand.
- `build.sh` — wraps `src/page.html` into `index.html`.

## Edit and rebuild

    ./build.sh
    open index.html

## Placeholders to replace before going live

- Contact card location line: "Canada · working remotely with clients worldwide" — confirm province/city
- Footer: "Incorporated in Canada"
- No favicon, OG image, or analytics yet.

Live details already set: `info@sofluent.net`, canonical + OG URL `https://sofluent.net/`.
Note the spelling split — the wordmark reads **Sofluent**, the domain reads **sofluent**.

## Deploy

Any static host. Drag the folder onto Netlify, or:

    npx vercel --prod        # Vercel
    # GitHub Pages: push to a repo, enable Pages on the root of the default branch

## Hosting

GitHub Pages, served from the `main` branch root.

- `CNAME` — tells Pages the custom domain is `sofluent.net`. Do not delete it.
- `.nojekyll` — skips Jekyll processing; the site is plain HTML.

To publish a change:

    ./build.sh
    git add -A && git commit -m "describe the change"
    git push

Pages redeploys in ~1 minute.

## Images

Photography lives in `img/` and is committed to the repo (no hotlinking, no runtime
dependency on a third-party CDN). All four photographs are from Unsplash and are used
under the [Unsplash License](https://unsplash.com/license), which permits commercial use
without attribution.

| File | Used for | Source |
|---|---|---|
| `hero-datacentre.jpg` (+ `-sm` for ≤1000px) | Hero background under the teal gradient | `images.unsplash.com/photo-1573164713988-8665fc963095` |
| `discovery-sketch.jpg` | Photo cap on the "first email" card in How we work | `images.unsplash.com/photo-1454165804606-c3d57bc86b40` |
| `team-desks.jpg` | Commitments section, paired with the three cards | `images.unsplash.com/photo-1551434678-e076c223a692` |
| `code-dark.jpg` | Texture under the contact CTA band | `images.unsplash.com/photo-1555066931-4365d14bab8c` |
| `og.jpg` | Social share card (1200x630), rendered from a local HTML template | generated |

`favicon.svg` is the wordmark tile, drawn inline — no raster favicon needed.

To re-generate the OG card, render a 1200x630 HTML template with headless Chrome and
convert to JPEG; the template is not committed since it is a one-off.
