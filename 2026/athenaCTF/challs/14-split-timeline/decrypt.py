def rc4(key: bytes, ciphertext: bytes) -> bytes:
    # KSA
    S = list(range(256))
    j = 0
    for i in range(256):
        j = (j + S[i] + key[i % len(key)]) % 256
        S[i], S[j] = S[j], S[i]
    
    # PRGA
    i = 0
    j = 0
    plaintext = bytearray()
    for char in ciphertext:
        i = (i + 1) % 256
        j = (j + S[i]) % 256
        S[i], S[j] = S[j], S[i]
        k = S[(S[i] + S[j]) % 256]
        plaintext.append(char ^ k)
    return bytes(plaintext)

# Session 1 (SanDisk Cruzer Blade)
# Serial: 4C530001180529117094
key1 = b"4C530001180529117094"
ct1 = bytes.fromhex(
    "3d02f4f40a" +  # ~dfA31C.tmp
    "738c3400c5" +  # ~df77E2.tmp
    "3b9703e9c3" +  # ~df1B04.tmp
    "1458f1a19a" +  # ~df9C55.tmp
    "fea40f6d24" +  # ~df6D0B.tmp
    "6bca5e56b1" +  # ~dfC418.tmp
    "ccd98719fd" +  # ~df3F9A.tmp
    "bac460fab4"    # ~df90E7.tmp
)

pt1 = rc4(key1, ct1)
print("Session 1 Decrypted:")
print("Hex:", pt1.hex())
print("ASCII:", repr(pt1))
try:
    print("UTF-8:", pt1.decode('utf-8'))
except Exception as e:
    print("UTF-8 decode failed:", e)

print("-" * 50)

# Session 2 (SanDisk Ultra Fit)
# Serial: AA010129180916122757
key2 = b"AA010129180916122757"
ct2 = bytes.fromhex(
    "a70e4a1f41" +  # ~df2E81.tmp
    "d60334687c" +  # ~df4A19.tmp
    "f396e70bf9" +  # ~dfB730.tmp
    "6577babc28" +  # ~df08CD.tmp
    "77a6a83940" +  # ~df5F62.tmp
    "c778f44a21"    # ~dfE394.tmp
)

pt2 = rc4(key2, ct2)
print("Session 2 Decrypted:")
print("Hex:", pt2.hex())
print("ASCII:", repr(pt2))
try:
    print("UTF-8:", pt2.decode('utf-8'))
except Exception as e:
    print("UTF-8 decode failed:", e)
