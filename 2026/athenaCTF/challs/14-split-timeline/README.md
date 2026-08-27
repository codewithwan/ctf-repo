# Split Timeline

- **Category:** FORENSICS
- **Difficulty:** hard
- **Points:** 400
- **Solves:** 0
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/xa5a8atqddyq7mb5zdk8mf94

## Description
A finance workstation (WS-0419) is suspected of staging data to a removable drive. It was powered down before anyone could capture it live, so triage handed you three raw artifacts: the volume's `$MFT`, the `$UsnJrnl:$J` change journal, and `setupapi.dev.log`. Nothing has been normalised or pre-parsed — `mft.bin` and `usnjrnl.bin` are byte-for-byte extracts. Chances are more than one removable drive was attached that morning, and only one of them matters. Whoever staged the data hid it, cleaned up after themselves, and made an effort to blend the leftovers into the surrounding file activity. Hoping they did not succeed completely, Reconstruct what left the machine.

## Files (download manual dari halaman challenge)
- `mft.bin` — 37.0 KB  → taruh di folder ini
- `usnjrnl.bin` — 5.3 KB  → taruh di folder ini
- `setupapi.dev.log` — 7.1 KB  → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −75 pts
- Hint 2: −100 pts
- Hint 3: −175 pts
