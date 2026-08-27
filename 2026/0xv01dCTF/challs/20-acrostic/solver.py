#!/usr/bin/env python3
"""Acrostic — first character of each line spells the flag body (CANDIDATE)."""
lines = open("message.txt").read().splitlines()
print("acrostic:", "".join(l[0] for l in lines))
print("CANDIDATE: 0xV0ID{FIRSTSTEP} (verify prefix before submitting)")
