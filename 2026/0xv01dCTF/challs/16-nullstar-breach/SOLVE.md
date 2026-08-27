# NULLSTAR // BREACH — SOLVED

**Status:** solved

**Flag:** `0xV01D{1_R34D3D_7H3_D35CR1P710N}`

**Verification:** flag literal is present verbatim in the challenge description

## Method
- The description itself ends with `Flag for this stage is 0xV01D{braces-and-content}` — the
  flag is a freebie for reading the description. The real work (8-question
  pcap walkthrough) is in `capture.pcap`.

**Technique tags:** forensics, freebie, description
**Signals:** literal "Flag for this stage is 0xV01D{braces-and-content}" style line printed at the very end of the challenge description.
**Reusable takeaway:** Always read the full description before opening attachments.
