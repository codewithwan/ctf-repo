# NULLSTAR // BREACH 8 — SOLVED

**Status:** solved

**Flag:** `0xV0ID{c0v3r7_DN5_ch4nn3l_r34553mbl3d_L1k3_4_Gh0st}` (recovered from capture.pcap DNS exfil; unverified on platform)

**Technique tags:** forensics, pcap, DNS exfiltration, base32, repeating-key XOR

**Signals:** "scattered" = chunked DNS labels; "wrapped" = base32 (payload charset
is exclusively `[a-z2-7]`, no `0/1/8/9` → base32, not base64); "locked with
something you already recovered" = BREACH 3 admin password `S3cr3t_P4ss!`.

## Method
- 11 exfil queries `XX<chunk>.t.0xv0id-c2.net` (frames 165–186), `XX` = hex index `00..0a`.
- Concatenate the 8-char base32 chunks in index order, base32-decode → 51 bytes.
- Repeating-key XOR with `S3cr3t_P4ss!` (from Basic-auth brute at `/admin/login`,
  BREACH 3) yields the plaintext flag. Confirmed via known-plaintext: `ct ^ "0xV0ID{"` = `S3cr3t_`.
- Earlier attempt failed because the blob was misread as base64; base32 is the correct wrap.

**Reusable takeaway:** when DNS-exfil labels look like lowercase letters + digits,
check the alphabet — if only `[a-z2-7]` appears, it is base32, and the per-chunk
`idx` prefix gives reassembly order.

## Solve
`solver.py` (end-to-end from pcap).
