#!/usr/bin/env python3
"""Confidence Cipher — confidence_percent is the XOR keystream for cipher column."""
import csv

pt = []
for row in csv.DictReader(open("confidence_log.csv")):
    pt.append(int(row["confidence_percent"]) ^ int(row["cipher"]))
print(bytes(pt).decode())
