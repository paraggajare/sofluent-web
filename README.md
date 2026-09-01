# Sofluent Technologies — website

Static pages. No build tooling, no dependencies (fonts load from Google Fonts).

- `src/*.html` — one file per page: an optional `<!--meta-->` block, then `<title>`,
  `<style>`, and the page body. Edit these.
- `src/_*` — shared includes, not pages. `_doc.css` is the stylesheet for the
  document pages, pulled in via the `css:` meta key.
- `build.sh` — wraps every `src/*.html` into a full document at its `out:` path.
- `index.html`, `citizenship/**` — generated. Do not edit by hand.

| Source | URL |
| --- | --- |
| `src/page.html` | https://sofluent.net/ |
| `src/citizenship-privacy.html` | https://sofluent.net/citizenship/privacy |
| `src/citizenship-support.html` | https://sofluent.net/citizenship/support |

The two `citizenship-*` pages are the privacy policy and support page required by
the App Store and Google Play for the Canadian Citizenship Test Prep app. Both
URLs are pasted into the store listings, so **do not change their paths** once
submitted.

## Edit and rebuild

    ./build.sh
    open index.html

## Placeholders to replace before going live

- Contact card location line: "Canada · working remotely with clients worldwide" — confirm province/city
- Footer: "Incorporated in Canada"
- No favicon, OG image, or analytics yet.

The document pages already say "Ontario, Canada" (the address given for the
privacy policy's contact section); keep them consistent if the marketing page's
location line changes.

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
