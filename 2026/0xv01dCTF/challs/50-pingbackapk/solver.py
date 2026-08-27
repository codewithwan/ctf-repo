#!/usr/bin/env python3
"""PingBack.apk - decrypt assets/signal.enc using the UnlockReceiver logic.

Receiver: com.pingback.ACTION_UNLOCK (exported), requires:
    auth = "SYNC-2026-PING"   (extra string)
    seq  = 12 - 1 = 11        (extra int)
Key  = SHA-1(auth || seq)[:16]
Cipher = AES/CBC/PKCS5Padding, IV = 0f1e2d3c4b5a69788796a5b4c3d2e1f0
Decrypt assets/signal.enc -> logged plaintext.
"""
import hashlib
from Crypto.Cipher import AES

AUTH = "SYNC-2026-PING"
SEQ = 12 - 1
IV = bytes([0x0f,0x1e,0x2d,0x3c,0x4b,0x5a,0x69,0x78,0x87,0x96,0xa5,0xb4,0xc3,0xd2,0xe1,0xf0])

def main():
    signal = open('extracted/assets/signal.enc', 'rb').read()
    key = hashlib.sha1((AUTH + str(SEQ)).encode()).digest()[:16]
    pt = AES.new(key, AES.MODE_CBC, IV).decrypt(signal)
    pad = pt[-1]
    if 1 <= pad <= 16:
        pt = pt[:-pad]
    print(pt.decode())

if __name__ == '__main__':
    main()
