**Flag:** `bushbash{to-x0r-or-nOt-To-Xor}!`

## TL;DR

Known plaintext `bushbash{` recovers the 8-byte repeating XOR key, which decrypts the ciphertext cleanly.

## Find

The encryptor XORs the flag with a repeating key:

```python
byte ^ key[i % len(key)]
```

XORing the first bytes of `flag.enc` with the known prefix `bushbash{` gives:

```text
3a3bebb319914818
```

That 8-byte key repeats across the whole ciphertext.

## Solve

Decrypting `flag.enc` with the recovered key prints:

```text
bushbash{to-x0r-or-nOt-To-Xor}!
```
