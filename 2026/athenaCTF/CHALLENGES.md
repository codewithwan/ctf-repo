# Athena CTF 2k26 — Challenges

- **Platform:** https://ctf-2026.ctf-platform.xyz
- **Account:** TahuCryptsi (codewithwan@gmail.com) · team `daaahmqapkf1eecy378mn9mm`
- **Window:** 2026-07-18 06:00 → 2026-07-20 06:00 UTC (freeze 07-19 06:00 UTC)
- **Flag format:** `athena{...}`
- **11 challenges** · 1 solved (Welcome)

| # | Challenge | Cat | Diff | Pts | Solves | Files | Instance | Hints |
|---|-----------|-----|------|-----|--------|-------|----------|-------|
| ✅ | Welcome | Welcome | easy | 10 | 180 | — | — | — |
| | Narrow DES | CRYPTO | impossible | 500 | 0 | `narrow_des_server.py` | yes | 1 (−300) |
| | Net MITM TLS | INFRA | easy | 100 | 0 | — | yes | 1 (−60) |
| | Session Slip | WEB | medium | 175 | 36 | — | yes | 1 (−100) |
| | Meridian Ladder | WEB | hard | 350 | 31 | — | yes | 1 (−200) |
| | USBStorage Residue | FORENSICS | medium | 200 | 59 | `usbstorage_rotated.pcap.gz` | — | 4 (−50/−50/−30/−30) |
| | Advance Paper Leak | OSINT | easy | 50 | 9 | — | — | 2 (−40/−10) |
| | Logic Puzzle | REV | easy | 100 | 96 | `logic_puzzle.bin` | — | 3 (−20/−25/−30) |
| | Talib | OSINT | easy | 100 | 8 | — | — | 2 (−50/−50) |
| | Query Mirage | INFRA | medium | 120 | 27 | — | yes | 2 (−30/−40) |
| | Mailroom Echo | FORENSICS | easy | 50 | 122 | `mailroom_echo.eml` | — | — |

## Downloadable files (4)
- `narrow_des_server.py` — 2.7 KB (Narrow DES)
- `usbstorage_rotated.pcap.gz` — 16.5 KB (USBStorage Residue)
- `logic_puzzle.bin` — 14.1 KB (Logic Puzzle)
- `mailroom_echo.eml` — 979 B (Mailroom Echo)

## Need a live instance (spin up "Create Instance")
Narrow DES · Net MITM TLS · Session Slip · Meridian Ladder · Query Mirage

## Self-contained (data is in the prompt)
- **Advance Paper Leak** — leak code `#Athenafl` (OSINT hashtag hunt)
- **Talib** — encoded video blob in the prompt (looks ASCII85-ish); find location + ISO date → `athena{location_YYYY-MM-DD}`

Full structured data: [challenges.json](challenges.json)
