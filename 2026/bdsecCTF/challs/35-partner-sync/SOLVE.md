# Partner Sync — Web (340/360)

**Flag:** `BDSEC{Y0U_D0nE_4ll_st3ps}` · verified (server: "Correct but you already solved this", challenge id 32)

A pure logic-bug chain across three services (`web` → `internal-api` → `dind-gate`).
No brute force / fuzzing — every step is derived by reading what the app returns.

## Stage 1 — SSRF allowlist bypass (userinfo)
`POST /sync-partner` with `partner_url=...` validates
`url.startswith("http://partners.bdsec.local")` then fetches it with `requests`.
`partners.bdsec.local` doesn't resolve — it's bait. Bypass the string check with a URL
**userinfo** segment so the client actually dials the host after `@`:

```
http://partners.bdsec.local@internal-api:9000/...
http://partners.bdsec.local@dind-gate:7000/rpc
```

The prefix check passes; `requests` connects to `internal-api` / `dind-gate`.

## Stage 1.5 — the GET→POST logic bug (the crux)
The fetcher is GET-only, but `internal-api` needs a POST **binary body** and `dind-gate`
needs a POST **JSON body**. `requests.get` can't do that. The tell: adding a stray
`method=POST` form field flipped `dind-gate/rpc` from **405** (GET not allowed) to **403
`invalid or missing token`** — i.e. `/sync-partner` honors a `method` param.

Then the body. Field name discovery by watching internal-api's `struct.unpack_from`
error (`buffer size is 0` = body not forwarded). Sending 8 non-null bytes under each
candidate name isolated it: `body_b64` changed the error (`utf-8 codec can't decode…`) —
so `/sync-partner` does roughly:

```python
requests.request(request.form["method"], url, data=base64.b64decode(request.form["body_b64"]))
```

→ arbitrary method + arbitrary raw bytes to any internal host. (Nulls in the wire
protocol are why it's base64, not a raw form field.)

## Stage 2 — custom-protocol RCE on internal-api
`POST internal-api:9000/job` reads its **raw body** as a binary job:

```
[u32be handler_len][handler ascii][u32be arg_len][arg utf8]
```

`handler` is resolved by `split(".")` + repeated `getattr()` over
`HANDLERS = {"report": builtins, "system": SystemNS}` — **no attribute allowlist**:

- `system.run`  → `SystemNS.run` → `subprocess.run(cmd, shell=True)`  → **shell RCE**
- `report.eval` → `builtins.eval(arg)`                                → **python RCE**

(`system.uptime` / `report.ping` are red herrings.) On the first successful job the
service writes a per-instance token to `TOKEN_SHARE_PATH=/app_shared/.internal_token`
(world-readable on purpose — dind-gate runs `cap_drop: ALL`, so restrictive bits would
block it). Read it: `008c3be4a04b2d0c8334b3bc1f6ffd78`.

## Stage 3 — dind-gate privileged container escape
`internal-api` is on the backend network, so drive `dind-gate:7000/rpc` **directly** from
the RCE (curl/python is present) — no SSRF needed for this hop. It only checks the token:

```json
{"token":"008c…","op":"run","image":"alpine","privileged":true,
 "binds":["/:/host"],"cmd":["sh","-c","cat /host/vault/flag.txt"]}
```

Only `alpine` is present locally (no registry egress). Run it privileged, bind-mount host
`/`, and read `/host/vault/flag.txt` — it's `0600` owned by uid 1500, but the container's
privileged root has `CAP_DAC_OVERRIDE`, so it reads anyway.

→ `BDSEC{Y0U_D0nE_4ll_st3ps}`

## Reusable takeaways
- `startswith()` allowlists on URLs die to a `@userinfo` host-swap.
- A "GET-only" SSRF may still expose `method` / `body_b64`-style forwarding params — probe
  the method first (405→other status is the tell), then diff error messages to find the
  body param and its encoding.
- `getattr()`-walked dispatch tables with no attribute allowlist = RCE (`system.run`,
  `builtins.eval`) regardless of how "purpose-built" the namespace class looks.
- dind/docker RPC that only checks a shared-volume token → privileged container + host
  bind-mount → arbitrary host read.

Run: `python3 exploit.py`
