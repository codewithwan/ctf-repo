# Ghost Signal — DFIR (190) [FBBL "Inside Job" series]

**Flag:** `BDSEC{185.220.101.47_13.8703066_100.5928967}` · verified "Correct" (challenge id 24)
**Question:** *C2 server IP address + GPS coordinates of where the suspect fled.*
Format: `BDSEC{C2IP_latitude_longitude}`

## Part 1 — C2 server IP  → `185.220.101.47`
The monitoring-tool ("Ghost") spyware beacons to the C2 over HTTP on `:8443` in
`var/captures/archived/network_capture.pcap`:
```
POST http://185.220.101.47:8443/sync     -> vault_key=F!rstB@ngla#Vault2024   (hex->base64)
POST http://185.220.101.47:8443/confirm  -> transfers_complete=3&total=2045000
```
`185.220.101.47` (a Tor-exit "story" IP — not a live service, probes all time out) is the C2.

## Part 2 — GPS  → `13.8703066, 100.5928967`
NOT in the pcap, webmail, Firefox cache, images (none on disk), or the Signal chat. It's a
**Telegram location message** in `home/arif.khan/AppData/Telegram/telegram_export.json`:
```json
{ "from": "Rajesh Patel", "date": "2024-04-15T20:00:00",
  "text": "Sharing a location for reference.",
  "location": { "latitude": 13.8703066, "longitude": 100.5928967, "live_period": 0 } }
```
Rajesh (the external logistics partner) drops the Bangkok safe-house pin. Grep the export for
`latitude`/`longitude`/`location` — it's buried among ~hundreds of cover-talk crypto messages.

→ `BDSEC{185.220.101.47_13.8703066_100.5928967}`

## What ate the time (avoid next time)
Chased the GPS through: pcap exfil bodies, C2 HTTP responses, all webmail email bodies (761+486,
via `/search`), Firefox cache URLs, EXIF on disk images (there are none), Signal/WhatsApp — all dry.
The coordinates were a **structured `location` object in the Telegram JSON**, not free text. When a
chat app is in scope, parse its export for native `location`/`latitude`/`longitude` fields first,
not just message bodies.

## Reusable takeaway
- Chat exports carry **structured location shares** (Telegram `location{lat,lon}`, WhatsApp `maps.google` links, Signal attachments) — check those fields before assuming EXIF/pcap.
- A C2 IP that appears only in a pcap beacon and refuses all live connections is a "story" IP; take it straight from the beacon `Host`/destination, don't try to reach it.
