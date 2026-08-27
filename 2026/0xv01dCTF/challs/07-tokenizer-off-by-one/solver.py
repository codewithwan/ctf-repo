#!/usr/bin/env python3
"""Tokenizer Off By One — exported ids are shifted by +1; real token = vocab[id-1]."""
import json

d = json.load(open("token_dump.json"))
vocab = d["vocab_zero_indexed"]
print("".join(vocab[i - 1] for i in d["generated_token_ids"]))
