#!/usr/bin/env python3
"""Signal Loss — 550 Hz tone bursts = Morse; decoded text is hex → ASCII flag."""
import wave, numpy as np

MORSE = {
    '.-': 'A', '-...': 'B', '-.-.': 'C', '-..': 'D', '.': 'E', '..-.': 'F',
    '--.': 'G', '....': 'H', '..': 'I', '.---': 'J', '-.-': 'K', '.-..': 'L',
    '--': 'M', '-.': 'N', '---': 'O', '.--.': 'P', '--.-': 'Q', '.-.': 'R',
    '...': 'S', '-': 'T', '..-': 'U', '...-': 'V', '.--': 'W', '-..-': 'X',
    '-.--': 'Y', '--..': 'Z',
    '-----': '0', '.----': '1', '..---': '2', '...--': '3', '....-': '4',
    '.....': '5', '-....': '6', '--...': '7', '---..': '8', '----.': '9',
}

w = wave.open("secret.wav", "rb")
sr = w.getframerate()
data = np.frombuffer(w.readframes(w.getnframes()), dtype=np.uint8).astype(float)
sig = data - 128.0
env = np.convolve(np.abs(sig), np.ones(40) / 40, mode="same")  # smooth 550 Hz ripple
on = env > 15
d = np.diff(on.astype(int))
starts = np.where(d == 1)[0] + 1
ends = np.where(d == -1)[0] + 1
if on[0]: starts = np.concatenate([[0], starts])
if on[-1]: ends = np.concatenate([ends, [len(on)]])
onl = (ends - starts) / sr * 1000
offl = (starts[1:] - ends[:-1]) / sr * 1000

msg, cur = [], ""
for ol, gl in zip(onl, offl):
    cur += "." if ol < 140 else "-"          # dot ~75 ms, dash ~215 ms
    if gl > 200:                              # letter gap ~515 ms
        msg.append(MORSE.get(cur, "?"))
        cur = ""
text = "".join(msg)
print(bytes.fromhex(text[:text.index("7D") + 2]).decode())
