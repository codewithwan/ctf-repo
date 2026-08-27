#!/usr/bin/env python3
"""Quiet Note — first character of every line."""
lines = open("letter.txt").read().splitlines()
print("".join(l[0] for l in lines if l))
