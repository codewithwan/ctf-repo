# BDSec CTF 2026 — Recon (pre-start)

- **Platform:** CTFd (rebranded: Knights=/users, Squads=/teams, Noble Standings=/scoreboard, Quest=/challenges)
- **URL:** https://2026.bdsec-ctf.com  (behind Cloudflare JS challenge — needs real browser)
- **Login:** codewithwan@gmail.com
- **User:** TahuCryptsi (id 591)
- **Team:** Cyb0x1 (id 277), captain=591, members=[591,1343]
- **Start:** 2026-07-20 22:00 WIB / 15:00 UTC  (ts 1784559600)
- **End:**   2026-07-21 22:00 WIB / 15:00 UTC  (ts 1784646000)
- **Duration:** 24h
- **Flag format:** UNKNOWN — ask user before submitting any flag

## Fetch note
`ctf-fetch` (curl-based) gets Cloudflare 403 `cf-mitigated: challenge`.
Working path = in-app browser fetch() to /api/v1/* (session cookie auto-included).
