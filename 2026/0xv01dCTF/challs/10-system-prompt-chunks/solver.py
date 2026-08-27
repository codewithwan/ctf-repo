#!/usr/bin/env python3
"""System Prompt Chunks — reorder by chunk_index, base64-decode, concatenate."""
import json, base64

d = json.load(open("context_chunks.json"))
chunks = sorted(d["chunks"], key=lambda c: c["segment_index"])
print("".join(base64.b64decode(c["payload_b64"]).decode() for c in chunks))
