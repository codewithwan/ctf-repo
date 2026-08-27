# Embedding Oracle — SOLVED

**Status:** solved

**Flag:** `0xVoid{nearest_neighbor_knows}`

**Verification:** solver.py maps every query to its nearest token and prints the flag

## Method
- `embeddings.csv`: token embeddings + 30 query points (`q00..q29`).
- For each query, pick the nearest token by Euclidean distance; concatenate labels.

**Technique tags:** AI, embeddings, nearest-neighbor
**Signals:** "embedding space is weirdly precise" → queries are the flag characters displaced by noise.
**Reusable takeaway:** Flag text hidden as noisy 2-D points → nearest token per point recovers the string.
