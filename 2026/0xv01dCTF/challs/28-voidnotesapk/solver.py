#!/usr/bin/env python3
"""VoidNotes.apk — recover the secret developer note.

The APK ships a hardcoded XOR "encryption": NoteDecryptor.KEY = 85, applied
byte-wise to assets/secret_note.bin. XOR it back and read the flag.
"""
import zipfile

KEY = 85


def main():
    with zipfile.ZipFile("VoidNotes.apk") as z:
        data = z.read("assets/secret_note.bin")
    plain = bytes(b ^ KEY for b in data)
    print(plain.decode())


if __name__ == "__main__":
    main()
