#!/usr/bin/env python3
"""LosIlluminados.apk - decrypt assets/illuminados_signal.bin.

Receiver action: com.los.illuminados.RECEIVE
Key = HMAC-SHA256(key=b"com.los.illuminados.RECEIVE",
                  msg=b"los.illuminados|IlluminadosReceiver")
Signal: header 7 bytes (LOSIL + ver), byte[5]==1 -> payload = bytes[7:]
decryptBundle: swap adjacent pairs, then XOR cyclically with the 32-byte key.
"""
import hashlib, hmac

KEYMAT = b"com.los.illuminados.RECEIVE"
MSG = b"los.illuminados|IlluminadosReceiver"

def main():
    signal = open('extracted/assets/illuminados_signal.bin', 'rb').read()
    assert signal[5] == 1
    data = signal[7:]
    key = hmac.new(KEYMAT, MSG, hashlib.sha256).digest()
    swapped = bytearray(len(data))
    for i in range(0, len(data) - 1, 2):
        swapped[i] = data[i+1]
        swapped[i+1] = data[i]
    if len(data) % 2:
        swapped[-1] = data[-1]
    out = bytes(swapped[i] ^ key[i % len(key)] for i in range(len(swapped)))
    print(out.decode())

if __name__ == '__main__':
    main()
