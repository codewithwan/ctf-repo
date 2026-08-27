#!/usr/bin/env python3
"""Temperature Seven — XOR the cipher bytes with int(0.7*10) = 7."""
import re

txt = open("output.txt").read()
nums = [int(x) for x in re.findall(r"\d+", txt.split("cipher_decimal:", 1)[1])]
print(bytes(n ^ 7 for n in nums).decode())
