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
