# Time Machine — SOLVED

**Status:** solved

**Flag:** `0xVO1D{h1st0ry_n3v3r_li35}`

**Verification:** solver.py pulls both image layers via the Registry API; both flag.sh echo the same flag

## Method
- `docker pull jinx69/timemachine:latest`; daemon unavailable → pulled image layers directly via Docker Registry HTTP API.
- Extracted all OCI layers; `/opt/flag.sh` (present in two layers) echoes the flag.
- `notes.txt`: "The answers aren't in the present." → history layers matter; both flag.sh copies confirm the same flag.

**Technique tags:** misc, docker, image history, registry API
**Signals:** container image challenge, hint about history.
**Reusable takeaway:** When Docker daemon is unavailable, fetch manifests/blobs from the registry API and extract layers manually to inspect files and history.
