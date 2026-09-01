#!/bin/sh
# Wraps each page source in src/ into a full HTML document.
#
# One source file per page. Each mixes head content (<title>, <link>, <style>)
# and body content; the split point is the first <header tag. An optional
# <!--meta ... --> block at the very top sets the output path, canonical URL,
# and social metadata. Files whose names start with "_" are shared includes
# (e.g. _doc.css), not pages.
set -e
cd "$(dirname "$0")"

python3 - <<'PY'
import pathlib
import re

SRC = pathlib.Path('src')
ROOT = pathlib.Path('.')

# Fallbacks for a source file with no <!--meta--> block.
DEFAULTS = {
    'out': 'index.html',
    'canonical': 'https://sofluent.net/',
    'ogtitle': 'Sofluent Technologies',
    'description': '',
    'ogdescription': '',   # falls back to description
    'css': '',
}


def parse_meta(text):
    """Pull the leading <!--meta key: value --> block off a source file."""
    meta = dict(DEFAULTS)
    m = re.match(r'\s*<!--meta\s*\n(.*?)-->\s*\n', text, re.S)
    if m:
        for line in m.group(1).splitlines():
            line = line.strip()
            if not line or ':' not in line:
                continue
            key, value = line.split(':', 1)
            meta[key.strip()] = value.strip()
        text = text[m.end():]
    return meta, text


def build(path):
    meta, text = parse_meta(path.read_text())

    # page.html mixes head content (title/style) and body content;
    # split at the first <header
    i = text.index('<header')
    head, body = text[:i].strip(), text[i:].strip()

    meta['ogdescription'] = meta['ogdescription'] or meta['description']

    if meta['css']:
        shared = (SRC / meta['css']).read_text().strip()
        head = f'<style>\n{shared}\n</style>\n{head}'

    doc = f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="color-scheme" content="light">
<meta name="description" content="{meta['description']}">
<link rel="canonical" href="{meta['canonical']}">
<meta property="og:type" content="website">
<meta property="og:url" content="{meta['canonical']}">
<meta property="og:title" content="{meta['ogtitle']}">
<meta property="og:description" content="{meta['ogdescription']}">
<meta name="twitter:card" content="summary">
{head}
</head>
<body>
{body}
</body>
</html>
"""

    out = ROOT / meta['out']
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(doc)
    print(f"built {meta['out']} ({len(doc)} bytes) from {path}")


for path in sorted(SRC.glob('*.html')):
    if path.name.startswith('_'):
        continue
    build(path)
PY
