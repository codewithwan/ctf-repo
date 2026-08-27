#!/usr/bin/env python3
"""Self Consistency Vote — per-column majority across the ten samples."""
import re, statistics

lines = [l for l in open("generations.txt") if l.startswith("sample_")]
cols = list(zip(*(l.split(": ", 1)[1].rstrip("\n") for l in lines)))
n = min(map(len, cols))
print("".join(statistics.mode(col[:n]) for col in cols))
