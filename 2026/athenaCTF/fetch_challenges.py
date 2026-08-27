#!/usr/bin/env python3
"""
Athena CTF 2026 — challenge fetcher.

Login via better-auth, pull the challenge list (and per-challenge files/hints/
instance info) straight from the SSR-dehydrated page data, save to challenges.json,
print a table, and highlight NEW challenges since the last run (wave 2 detection).

Usage:
    python3 fetch_challenges.py                 # fetch + save + diff
    python3 fetch_challenges.py --no-details     # skip per-challenge file/hint fetch (faster)
    python3 fetch_challenges.py --watch 60       # re-run every 60s, alert on new challenges

Creds: env ATHENA_EMAIL / ATHENA_PASS, else the defaults below.
"""
import os, re, json, time, argparse, urllib.request, urllib.error, http.cookiejar

BASE  = os.environ.get("ATHENA_BASE", "https://ctf-2026.ctf-platform.xyz")
EMAIL = os.environ.get("ATHENA_EMAIL", "codewithwan@gmail.com")
PASS  = os.environ.get("ATHENA_PASS",  "!KtEn)5N6Y?tz&:")
UA    = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36"
OUT   = os.path.join(os.path.dirname(os.path.abspath(__file__)), "challenges.json")

_cj  = http.cookiejar.CookieJar()
_op  = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(_cj))

def _req(path, data=None, html=False):
    hdr = {"User-Agent": UA, "Accept": "text/html" if html else "*/*",
           "Origin": BASE, "Referer": BASE + "/",
           "Sec-Fetch-Site": "same-origin",
           "Sec-Fetch-Mode": "navigate" if html else "cors",
           "Sec-Fetch-Dest": "document" if html else "empty"}
    body = None
    if data is not None:
        body = json.dumps(data).encode(); hdr["Content-Type"] = "application/json"
    r = urllib.request.Request(BASE + path, data=body, headers=hdr)
    try:
        with _op.open(r, timeout=25) as f:
            return f.status, f.read().decode("utf-8", "replace")
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")

def login():
    st, txt = _req("/api/auth/sign-in/email", {"email": EMAIL, "password": PASS})
    if st != 200 or '"user"' not in txt:
        raise SystemExit(f"[!] login failed ({st}): {txt[:200]}")
    return json.loads(txt)["user"]

# --- JS-literal helpers -----------------------------------------------------
def _jsstr(raw):
    """Decode a JS double-quoted string body (handles \\xHH, \\uXXXX, \\", \\/, etc.)."""
    out, i = [], 0
    while i < len(raw):
        c = raw[i]
        if c == "\\" and i + 1 < len(raw):
            n = raw[i+1]
            if   n == "x": out.append(chr(int(raw[i+2:i+4], 16))); i += 4; continue
            elif n == "u": out.append(chr(int(raw[i+2:i+6], 16))); i += 6; continue
            elif n == "n": out.append("\n"); i += 2; continue
            elif n == "t": out.append("\t"); i += 2; continue
            else:          out.append(n);    i += 2; continue
        out.append(c); i += 1
    return "".join(out)

_STR   = r'"((?:[^"\\]|\\.)*)"'
def _field(chunk, key, kind="str"):
    if kind == "str":
        m = re.search(rf'\b{key}:{_STR}', chunk)
        return _jsstr(m.group(1)) if m else None
    if kind == "num":
        m = re.search(rf'\b{key}:(-?\d+)', chunk); return int(m.group(1)) if m else None
    if kind == "bool":
        m = re.search(rf'\b{key}:!([01])', chunk); return (m.group(1) == "0") if m else None

def _strip_html(s):
    return re.sub(r"\s+", " ", re.sub(r"<[^>]+>", "", s or "")).strip()

# --- challenge list ---------------------------------------------------------
def fetch_list():
    st, html = _req("/challenges", html=True)
    if st != 200:
        raise SystemExit(f"[!] /challenges failed: {st}")
    chals = []
    # each challenge object is `{id:"..",title:"..",...,isLockedForCurrentUser:!x}`
    for m in re.finditer(r'\{id:"([a-z0-9]{16,})"(.*?isLockedForCurrentUser:![01])', html):
        c = "{id:\"" + m.group(1) + '"' + m.group(2)
        desc = _field(c, "description") or ""
        chals.append({
            "id": m.group(1),
            "title": _field(c, "title"),
            "category": _field(c, "category"),
            "difficulty": _field(c, "difficultyName"),
            "points": _field(c, "displayPoints", "num") or _field(c, "points", "num"),
            "solveCount": _field(c, "solveCount", "num"),
            "hasBlood": _field(c, "hasBlood", "bool"),
            "locked": _field(c, "isLockedForCurrentUser", "bool"),
            "description": _strip_html(desc),
        })
    # de-dupe by id, keep first
    seen, uniq = set(), []
    for c in chals:
        if c["id"] not in seen and c["title"]:
            seen.add(c["id"]); uniq.append(c)
    return uniq

# --- per-challenge details (files / hints / instance) -----------------------
def fetch_detail(cid):
    st, html = _req(f"/challenges/{cid}", html=True)
    if st != 200:
        return {}
    m = re.search(rf'\{{id:"{cid}"(.*?)(?:hasContainerSpec:![01]|,files:|,hints:)', html, re.S)
    blob = html[html.find(f'id:"{cid}"'): html.find(f'id:"{cid}"') + 4000] if f'id:"{cid}"' in html else ""
    files = re.findall(r'filename:"([^"]+)"', blob)
    sizes = re.findall(r'size:(\d+)', blob)
    hints = re.findall(r'penaltyPoints:(\d+)', blob)
    hc    = re.search(r'hasContainerSpec:!([01])', blob)
    return {
        "files": [{"filename": f, "size": (int(sizes[i]) if i < len(sizes) else None)}
                  for i, f in enumerate(files)],
        "hints": [int(h) for h in hints],
        "needsInstance": (hc.group(1) == "0") if hc else None,
    }

# --- main -------------------------------------------------------------------
def run(details=True):
    user = login()
    chals = fetch_list()
    if details:
        for c in chals:
            c.update(fetch_detail(c["id"]))
            time.sleep(0.25)
    data = {"fetchedAt": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            "account": user.get("username"), "count": len(chals), "challenges": chals}
    # diff vs previous
    prev_ids = set()
    if os.path.exists(OUT):
        try: prev_ids = {c["id"] for c in json.load(open(OUT)).get("challenges", [])}
        except Exception: pass
    new = [c for c in chals if c["id"] not in prev_ids]
    json.dump(data, open(OUT, "w"), indent=2, ensure_ascii=False)
    # print
    print(f"\n=== {data['count']} challenges  (as {data['account']})  {data['fetchedAt']} ===")
    for c in sorted(chals, key=lambda x: (x["category"] or "", -(x["points"] or 0))):
        star = "🩸" if c.get("hasBlood") else "  "
        fl = ("📎" + str(len(c["files"]))) if c.get("files") else "  "
        ins = "🖥️" if c.get("needsInstance") else "  "
        flag = " 🆕" if c["id"] in {x['id'] for x in new} else ""
        print(f"  [{(c['category'] or '?')[:9]:9}] {(c['title'] or '?')[:24]:24} "
              f"{str(c['points']):>4}p  {str(c['solveCount']):>4} solv {fl} {ins} {star}{flag}")
    if new and prev_ids:
        print(f"\n🆕🆕 {len(new)} NEW challenge(s): " + ", ".join(c["title"] for c in new))
    print(f"\nsaved -> {OUT}")
    return new

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--no-details", action="store_true", help="skip file/hint/instance fetch")
    ap.add_argument("--watch", type=int, metavar="SEC", help="poll every SEC seconds; alert on new")
    a = ap.parse_args()
    if a.watch:
        print(f"[watch] polling every {a.watch}s — Ctrl-C to stop")
        while True:
            try:
                new = run(details=not a.no_details)
                if new: print("\a")  # terminal bell on new challenge
            except Exception as e:
                print("[err]", e)
            time.sleep(a.watch)
    else:
        run(details=not a.no_details)
