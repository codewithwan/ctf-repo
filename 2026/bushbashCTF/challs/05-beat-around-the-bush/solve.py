#!/usr/bin/env python3

with open("README.md", "r", encoding="utf-8") as f:
    text = f.read()

# Extract emoji lines
lines = text.splitlines()[13:16]
s = "".join(lines).replace("\ufe0f", "")

# Emoji substitution map
emoji_map = {
    "🌳": "t",
    "🌲": "h",
    "🌴": "e",
    "🌵": " ",  # Space between words
    "🎄": "j",
    "🌿": "u",
    "☘": "n",
    "🍀": "g",
    "🍃": "l",
    "🍂": "s",
    "🍁": "a",
    "🪴": "r",
    "🌱": "d",
    "🌾": "m",
    "🎋": "b",
    "🎍": "i",
    "🪵": "g",
    "🪨": "p",
    "⛰": "o",
    "🏕": "k",
    "🌺": "{",
    "🌻": "-",  # Hyphen inside flag
    "🌼": "m",
    "🌸": "y",
    "🪻": "}",
    "🦌": "w",
    "🦘": "'",
}

decoded = "".join(emoji_map.get(c, c) for c in s)

print("Decrypted passage:")
print(decoded)

# Extract flag
import re

match = re.search(r"bushbash\{[^\}]+\}", decoded)
if match:
    print(f"\nFlag: {match.group(0)}")
