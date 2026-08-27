# Broken Printer — Rev (435)

**Flag:** `BDSEC{th3_pr1nt3r_d03s_n0t_pr1nt_1n_0rd3r}`  ("the printer does not print in order")
`nc 45.56.67.129 24873` — the server runs the (stripped x86-64 PIE) binary which reads `flag.txt`,
scrambles it, and prints the scrambled "spool" + a **job id**.

## The transform (from the binary)
- Reads `flag.txt` (len = printed **`paper width`**, = 42).
- Derives a 32-bit **key** = `splitmix32( getpid()*0x9e3779b9 ^ (nsec^sec) )` — and **prints it as the
  `job id` (%08X)**. So the key is known for every run.
- Each flag byte → 4 base-4 symbols from `".:+#"` (the 2-bit groups), then a 5th **"foreign ink"**
  symbol is inserted, and odd-index blocks get an extra shuffle. Blocks are **permuted** to output
  position `(start + i*mult) % len`, where `start=(key>>16)%len`, `mult`=first prime in
  `[5,7,11,13,17,19,23,29,31]` coprime to len (=5 for 42). Separators between blocks are only `|/~`
  (disjoint from the block alphabet `.:+#`, so splitting is clean).

## Solve — patched-key oracle + codebook (robust, no need to perfectly model the ink shuffle)
1. Grab a fresh `(key, output)` from the service.
2. **Patch the binary to force that exact key**: overwrite `mov [rsp+4], r8d` at vaddr `0x122e` with
   `mov dword [rsp+4], <key>` → `r2 -w -c 's 0x122e; wx c74424043bd53602' bp_patched`.
3. Run the patched binary (in an amd64 Docker) with `flag.txt = chr(b)*42` for every printable byte b
   → for each index i, `block_at((start+i*5)%42)` = `encode(b, i)`. That's a per-index codebook.
4. Decode: `flag[i] = the byte b whose codebook block at (start+i*5)%42 == server block there`.

```python
# after building cb[byte] = [42 blocks] from codebook.txt and sb = server blocks
start=(key>>16)%42
for i in range(42):
    p=(start+i*5)%42
    flag[i]=next(b for b,bl in cb.items() if bl[p]==sb[p])
```

## Reusable takeaway
When a rev target scrambles a secret with a **per-run key it conveniently leaks** (here the "job id"),
don't fully reverse the transform — **patch the binary to pin that key and use it as an encryption
oracle**, build a codebook, and match. Beats hand-inverting a fiddly symbol/permutation scheme.
