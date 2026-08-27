# Two Sides of Midnight

**Status:** solved

**Flag:** `0xV01D{one_sequence_two_realities}` (recovered, unverified — not submitted)

**Technique tags:** forensics, pcapng, dual-tap comparison, payload XOR, TCP sequence alignment

**Signals:** two interfaces tap-ingress/tap-egress; same flow+seq observed at both taps with different payload bytes; three background flows identical on both sides; only the .19->.8:8443 flow differs.

**Failed approaches:** none blocking — initial pass confirmed background flows are byte-identical, isolating the modified flow immediately.

**Verification:** XOR of ingress and egress payloads per (flow, seq) yields a valid ZIP (zipfile parses it) containing incident.txt with the flag and operator_note.txt; reconstructed stream ordered by TCP seq (1, 74, 147, 220, 293, 366).

**Reusable takeaway:** When a pcapng merges two taps bracketing an inline device, keep interface identity (frame.interface_id) and group by (flow, seq): the same segment seen at both taps with different payloads is the tampered one, and XORing the two observations per segment recovers data present on neither side alone.

## Method
- Dump per-frame fields with tshark: interface id, 5-tuple, tcp.seq, tcp.payload.
- Group payloads by flow and interface; find the flow where the same seq has different bytes on tap-ingress vs tap-egress (only `10.42.0.19:49173 -> 10.42.0.8:8443`).
- Reassemble each side's stream in TCP seq order and XOR the two streams byte-wise.
- The XOR blob is a ZIP: `incident.txt` (contains the flag) and `operator_note.txt`.

## Solve
`solver.py` dumps the pcapng, isolates the modified flow, XORs both sides, and prints the ZIP contents.
