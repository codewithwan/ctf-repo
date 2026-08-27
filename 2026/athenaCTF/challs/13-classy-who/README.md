# Classy who?

- **Category:** PWN
- **Difficulty:** hard
- **Points:** 400
- **Solves:** 0
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/i7mfma13mx94jhak6r47qj8h

## Description
Exploit the note-taking service to read the flag from stack memory. Connect to the service on port 1337. Commands: - `C idx size` — create a note at index `idx` with `size` bytes. - `W idx off len` — write `len` raw bytes into note `idx` at offset `off`. - `R idx` — read up to 1024 bytes from note `idx`. - `D idx` — delete note `idx`. - `E` — exit. Use the service to leak a libc address, then a stack address, and read the flag out of the service's stack memory.

## Files (download manual dari halaman challenge)
- `ctf.c` — 4.3 KB  → taruh di folder ini

## Instance
**Required** — klik "Create Instance" untuk dapet host:port oracle-nya.

## Hints
- Hint 1: −75 pts
- Hint 2: −75 pts
- Hint 3: −100 pts
- Hint 4: −125 pts
