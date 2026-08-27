**Flag:** `bushbash{don't-b@sh-the-str4wberry-bUsh}`

## TL;DR

The provided request is AES-CBC encrypted. Flipping bytes in the previous ciphertext block changes the decrypted user ID to `PREMIUM_USER`, giving a huge strawberry count and reaching the flag branch.

## Find

`strawberryserver.py` decrypts fixed 80-byte requests with AES-CBC. The plaintext layout is:

```text
0:8    transaction id
8:16   requested count
16:32  user id
32:64  integrity bytes
```

The bundled `message.ct` decrypts server-side to a valid request with `n = 1` and a non-premium user ID:

```text
000000000345f8d381aa95e4ef70279a
```

Because user ID is in plaintext block 1, changing ciphertext block 0 flips those bytes after decryption without breaking the integrity field in block 2.

## Solve

XOR the first 16 ciphertext bytes by:

```text
known_user ^ PREMIUM_USER
```

The modified request becomes a premium request with a large count, so `strawberry_count > 1 << 32`.

One extra valid request is sent afterward because `displayFlag()` prints without `flush=True`; the next flushed line pushes the flag out over the socket.
