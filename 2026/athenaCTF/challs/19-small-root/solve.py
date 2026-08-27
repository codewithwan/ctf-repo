#!/usr/bin/env python3
"""
Athena CTF 2026 - "Small Root" (CRYPTO, 100)

pub(2).txt is deliberately stuffed with decoy/noise blocks (base64 junk,
WMD-themed flavor text, fake ciphertexts, a fake "n_shadow", etc.).
The only load-bearing parameters are:

    epsilon = ٣            -> Arabic-Indic digit 3, so public exponent e = 3
    protocol = RSA-SMALLEXP
    c_main  = e1f8...4965  (hex)  -> the real ciphertext

Weakness: small exponent e=3 with an un-padded / short message, so the
message m never wrapped around the modulus n. That means c = m^3 exactly
(no mod reduction happened), so the plaintext is just the integer cube
root of c. The modulus n is not even needed.
"""

def iroot(x, n):
    """Return (r, exact) where r = floor(x**(1/n))."""
    if x < 0:
        return None
    hi = 1
    while hi ** n < x:
        hi *= 2
    lo = hi // 2
    while lo < hi:
        mid = (lo + hi) // 2
        if mid ** n < x:
            lo = mid + 1
        else:
            hi = mid
    # lo is the smallest integer with lo**n >= x
    r = lo if lo ** n == x else lo - 1
    return r, (r ** n == x)


def main():
    e = 3
    c_hex = ("e1f809665639ae4384dd4dc31a5aa80bb303deafd4a02fbc69e8f475c26b4702"
             "b2f497bb56c8ff6ce9d5b24a7f43b18e8b0d72e652351a254526fa1e290e6a04965")
    c = int(c_hex, 16)

    m, exact = iroot(c, e)
    assert exact, "cube root was not exact -- message was reduced mod n?"

    flag = m.to_bytes((m.bit_length() + 7) // 8, "big")
    print("exact cube root :", exact)
    print("m (int)         :", m)
    print("flag            :", flag.decode())


if __name__ == "__main__":
    main()
