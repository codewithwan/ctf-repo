#!/usr/bin/env python3
"""Embedding Oracle — each query maps to the nearest token by Euclidean distance."""
import csv, math

tokens = {}
queries = []
for row in csv.DictReader(open("embeddings.csv")):
    x, y = float(row["x"]), float(row["y"])
    if row["kind"] == "token":
        tokens[row["label"]] = (x, y)
    else:
        queries.append((row["label"], x, y))

out = []
for label, qx, qy in queries:
    best = min(tokens, key=lambda t: (tokens[t][0] - qx) ** 2 + (tokens[t][1] - qy) ** 2)
    out.append(best)
print("".join(out))
