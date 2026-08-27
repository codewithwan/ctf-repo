#!/usr/bin/env python3
"""Checkpoint Seed — deterministic mask: XOR with random.Random(seed).randrange(256)."""
import json, random

d = json.load(open("checkpoint.json"))
seed = d["seed"]
ct = bytes.fromhex(d["cipher_hex"])
rng = random.Random(seed)
pt = bytes(c ^ rng.randrange(256) for c in ct)
print(pt.decode())
