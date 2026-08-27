#!/usr/bin/env python3
"""Transmission — hidden spectrogram text in a WAV.

1. Unlock Transmission.zip (ZipCrypto, password cracked via rockyou: `whatever1`).
2. unknown.unknown is a PCM 16-bit mono 44.1 kHz WAV (6 s).
3. Spectrogram band ~5.8-11 kHz, message at t=1.1-4.9 s draws text.
4. Text is mirrored -> FLIP_LEFT_RIGHT to read the flag.
"""
import io
import subprocess
import sys
import wave
from pathlib import Path
from zipfile import ZipFile

import numpy as np
from scipy import signal as sg
from PIL import Image

HERE = Path(__file__).resolve().parent
ZIP = HERE / "Transmission.zip"
PASSWORD = b"whatever1"
FLAG = "0xV01D{h1dd3n_1n_th3_sp3ctr0}"


def extract_wav():
    with ZipFile(ZIP) as z:
        data = z.read("unknown.unknown", pwd=PASSWORD)
    with wave.open(io.BytesIO(data)) as w:
        fs = w.getframerate()
        samples = np.frombuffer(w.readframes(w.getnframes()), dtype="<i2").astype(np.float64)
    return samples, fs


def main():
    samples, fs = extract_wav()
    f, t, Sxx = sg.spectrogram(samples, fs=fs, nperseg=256, noverlap=240, nfft=1024)
    band = (f >= 5800) & (f <= 11000)
    Sdb = 10*np.log10(Sxx[band] + 1e-12)
    bw = Sdb > (Sdb.max() - 20)

    ta, tb = 1.10, 4.90
    j0 = np.searchsorted(t, ta); j1 = np.searchsorted(t, tb)
    sub = bw[:, j0:j1]
    Hpx, Wpx = 300, 7000
    arr = np.zeros((Hpx, Wpx), dtype=np.uint8)
    for i in range(Hpx):
        f0 = i*sub.shape[0]//Hpx; f1 = max(f0+1, (i+1)*sub.shape[0]//Hpx)
        row = sub[f0:f1].max(axis=0)
        arr[i] = row[(np.arange(Wpx) * sub.shape[1] // Wpx)] * 255
    im = Image.fromarray(arr).transpose(Image.FLIP_LEFT_RIGHT)
    out = HERE / "spectrogram_mirrored.png"
    im.resize((Wpx*2, 600), Image.NEAREST).save(out)
    print(f"saved {out}")
    print(f"FLAG: {FLAG}")


if __name__ == "__main__":
    main()
