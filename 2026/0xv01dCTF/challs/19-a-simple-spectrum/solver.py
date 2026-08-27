#!/usr/bin/env python3
"""A Simple Spectrum — the flag is carved as negative space in a noise band (3.6-5.3 kHz).

Renders the band's column profile so the characters can be read by eye.
"""
import wave
import numpy as np

w = wave.open("spectrum.wav", "rb")
sr = w.getframerate()
sig = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16).astype(float) / 32768

win = 2048
hop = win // 4
frames = [np.abs(np.fft.rfft(sig[i:i + win] * np.hanning(win))) ** 2
          for i in range(0, len(sig) - win, hop)]
S = np.array(frames).T
freqs = np.fft.rfftfreq(win, 1 / sr)
mask = (freqs >= 3600) & (freqs <= 5300)   # the anomalous filled band

prof = np.log1p(S[mask].min(axis=0))
prof = (prof - prof.min()) / (prof.max() - prof.min() + 1e-9)
prof = np.convolve(prof, np.ones(3) / 3, mode="same")[::2]

rows = 24
for r in range(rows):
    thr = 1 - (r + 1) / rows * 1.9   # low energy = carved letters (negative space)
    print("".join("#" if v < thr else " " for v in prof))
print("\nRead the carved characters; flag = 0xV0ID{sp3ctr0gr4m_s3cr3ts}")
