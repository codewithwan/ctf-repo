# SCADA Firmware Drift

- **Category:** OT
- **Difficulty:** medium
- **Points:** 150
- **Solves:** 0
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/ptmkguk7k0fujt9g7vqf280c

## Description
A baseline audit caught one of ACME Industrial's Modbus RTU controllers running a config no engineer approved -- an intruder folded a rogue 'drift' parameter into the firmware itself. Investigators pulled the image off the compromised HMI. The controller admits drift was detected but won't reveal the value. Reverse the bootloader's config de-obfuscation routine and extract the hidden drift parameter yourself.

## Files (download manual dari halaman challenge)
- `firmware.bin` — 10.0 KB  → taruh di folder ini
- `firmware_notes.txt` — 205 B  → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −40 pts
- Hint 2: −60 pts
