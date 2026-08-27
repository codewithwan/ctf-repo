**Flag:** `athena{sm4ll_r00t_r34}`

# Small Root — Athena CTF 2026 (CRYPTO, 100)

## TL;DR
`pub(2).txt` is 90% deliberate noise (base64 junk blocks, WMD-themed flavor
text like `大量破壊兵器の製造方法` / `如何製作炸彈`, fake ciphertexts
`c_prime/c_double/...`, a bogus `n_shadow`, PEM-looking blobs, etc.). Only two
values matter:

- `epsilon = ٣` — that glyph is the **Arabic-Indic digit 3**, so the public
  exponent is `e = 3`.
- `c_main` (hex) — the real ciphertext.

The weakness (`protocol = RSA-SMALLEXP`, "so weak"): small exponent `e=3` on a
short / un-padded message, so `m^3 < n` and no modular reduction ever happened.
Therefore `c = m^3` over the integers and the plaintext is simply the exact
integer **cube root** of `c`. The modulus `n` is not needed at all.

## Parameters
```
e       = 3
c_main  = e1f809665639ae4384dd4dc31a5aa80bb303deafd4a02fbc69e8f475c26b4702
          b2f497bb56c8ff6ce9d5b24a7f43b18e8b0d72e652351a254526fa1e290e6a04965  (hex)
```

## Attack
Take the integer cube root of the ciphertext; it is exact.

```python
c = int("e1f809665639ae4384dd4dc31a5aa80bb303deafd4a02fbc69e8f475c26b4702"
        "b2f497bb56c8ff6ce9d5b24a7f43b18e8b0d72e652351a254526fa1e290e6a04965", 16)

def iroot(x, n):
    hi = 1
    while hi**n < x: hi *= 2
    lo = hi // 2
    while lo < hi:
        mid = (lo + hi) // 2
        if mid**n < x: lo = mid + 1
        else: hi = mid
    r = lo if lo**n == x else lo - 1
    return r, r**n == x

m, exact = iroot(c, 3)          # exact == True
print(m.to_bytes((m.bit_length()+7)//8, "big"))
# b'athena{sm4ll_r00t_r34}'
```

Result:
```
exact cube root : True
m               : 36462138845162319670706501253563340295825192096314493
flag            : athena{sm4ll_r00t_r34}
```

See `solve.py`.
