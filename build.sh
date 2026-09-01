#!/bin/sh
# Wraps src/page.html (title + styles + body content) into a full HTML document.
set -e
cd "$(dirname "$0")"
{
  printf '%s\n' '<!doctype html>'
  printf '%s\n' '<html lang="en">'
  printf '%s\n' '<head>'
  printf '%s\n' '<meta charset="utf-8">'
  printf '%s\n' '<meta name="viewport" content="width=device-width, initial-scale=1">'
  printf '%s\n' '<meta name="color-scheme" content="light">'
  printf '%s\n' '<meta name="description" content="Sofluent Technologies Inc is a small software consultancy building mobile, web, and AI products for founders and teams.">
<link rel="canonical" href="https://sofluent.net/">
<meta property="og:type" content="website">
<meta property="og:url" content="https://sofluent.net/">
<meta property="og:title" content="Sofluent Technologies">
<meta property="og:description" content="A small software consultancy building mobile, web, and AI products for founders and teams.">
<meta name="twitter:card" content="summary">'
  cat src/page.html
  printf '%s\n' '</head>'
  printf '%s\n' '<body>'
  printf '%s\n' '</body>'
  printf '%s\n' '</html>'
} > /tmp/_sofluent_raw.html
# page.html mixes head content (title/style) and body content; split at the first <header
python3 - <<'PY'
src = open('src/page.html').read()
i = src.index('<header')
head, body = src[:i], src[i:]
doc = f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="light">
<meta name="description" content="Sofluent Technologies Inc is a small software consultancy building mobile, web, and AI products for founders and teams.">
<link rel="canonical" href="https://sofluent.net/">
<meta property="og:type" content="website">
<meta property="og:url" content="https://sofluent.net/">
<meta property="og:title" content="Sofluent Technologies">
<meta property="og:description" content="A small software consultancy building mobile, web, and AI products for founders and teams.">
<meta property="og:image" content="https://sofluent.net/img/og.jpg">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Sofluent Technologies - the people who scope your project write the code.">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="https://sofluent.net/img/og.jpg">
<meta name="theme-color" content="#002737">
<link rel="icon" href="favicon.svg" type="image/svg+xml">
{head.strip()}
</head>
<body>
{body.strip()}
</body>
</html>
"""
open('index.html','w').write(doc)
print(f"built index.html ({len(doc)} bytes)")
PY
rm -f /tmp/_sofluent_raw.html
