#!/usr/bin/env python3
"""Fetch GitHub Trending repos and output JSON.
Usage: python3 fetch-github-trending.py
Output: JSON array of trending repos
"""
import urllib.request, json, re, html as html_mod
from datetime import date

req = urllib.request.Request(
    "https://github.com/trending",
    headers={
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
        "Accept": "text/html"
    }
)
page = urllib.request.urlopen(req, timeout=30).read().decode("utf-8", errors="replace")

repos = []
# Split by article tags
articles = page.split('<article class="Box-row')
for i, article in enumerate(articles[1:], 1):
    # Repo name: extract from h2 > a href
    href = re.search(r'<h2[^>]*>.*?<a[^>]*href="(/[^"]+)"', article, re.DOTALL)
    if not href:
        # Newer GitHub structure: class="Link"
        href = re.search(r'href="(/[^"]+)"[^>]*class="[^"]*Link[^"]*"', article)
    if not href:
        continue
    repo = href.group(1).strip().lstrip("/")
    
    # Description
    desc_m = re.search(r'<p class="col-9[^"]*">(.*?)</p>', article, re.DOTALL)
    desc = html_mod.unescape(re.sub(r'<[^>]+>', '', desc_m.group(1))).strip() if desc_m else ""
    
    # Language
    lang_m = re.search(r'itemprop="programmingLanguage">(.*?)</span>', article)
    lang = lang_m.group(1).strip() if lang_m else ""
    
    # Stars this week
    stars_m = re.search(r'([\d,]+)\s*stars?\s*this\s*week', article)
    if not stars_m:
        stars_m = re.search(r'([\d,]+)\s*stars?\b', article)
    stars = stars_m.group(1).replace(",", "") if stars_m else ""

    repos.append({
        "rank": i,
        "repo": repo,
        "url": f"https://github.com/{repo}",
        "description": desc,
        "language": lang,
        "stars_this_week": stars
    })

print(json.dumps(repos, ensure_ascii=False, indent=2))
