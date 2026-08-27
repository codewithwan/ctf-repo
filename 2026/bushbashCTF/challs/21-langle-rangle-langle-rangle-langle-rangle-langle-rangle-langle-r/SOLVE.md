# langle-rangle-langle-rangle-langle-rangle-langle-rangle-langle-r

Flag: `bushbash{ma5B3_sf1NAe_neXt?}`

The template header implements a tiny interpreter. The useful operations are:

- `JLLV` assigns variables.
- `JWTR` prepends values to a list.
- `IEYF` operations are add, multiply, modulo, xor, and list index.

The encryption processes plaintext two bytes at a time. For each pair it runs a
16-round Feistel-like update using the provided key:

```text
mask = ((right + (key[i] + 1) * wvtf) * 17) % 135
left, right = right, left ^ mask
```

After each pair, `wvtf` is updated with the resulting ciphertext bytes. Since
`wvtf` therefore depends only on already-known ciphertext, each plaintext pair
can be recovered by brute forcing 256*256 possibilities.

`solver.py` recovers `ma5B3_sf1NAe_neXt?`, so the wrapped flag is
`bushbash{ma5B3_sf1NAe_neXt?}`.
