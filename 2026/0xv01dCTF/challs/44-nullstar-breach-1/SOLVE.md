# NULLSTAR // BREACH 1

**Status:** solved

**Flag:** `0xV0ID{10.13.37.101}` (recovered, unverified — not submitted)

**Technique tags:** forensics, pcap, port-scan identification, attacker attribution

**Signals:** BREACH 1 has no own attachment; the sibling NULLSTAR // BREACH challenge ships capture.pcap and promises eight answers, so this is answer #1 (attacker IP) from the same capture.

**Failed approaches:** "non-RFC1918 source" heuristic fails because the attacker IP 10.13.37.101 is itself in 10/8 — use "outside the victim LAN 192.168.10.0/24" instead.

**Verification:** 10.13.37.101 performs the SYN sweep over ports 21/22/23/25/53/80/110/143/443/445/3306/3389/8080/8443 against 192.168.10.50, then exploits the open 8080 (admin login, uploads sh3ll.php, runs commands). Only other IPs are the victim 192.168.10.50 and LAN gateway 192.168.10.1 (DNS relay for the C2 beaconing to 0xv0id-c2.net).

**Reusable takeaway:** In a multi-part pcap walkthrough, the first question usually answers itself: the attacker is the only source outside the victim subnet that initiates the initial SYN scan. Don't assume attacker IPs are globally routable in synthetic challenges.

## Method
- Reuse capture.pcap from the NULLSTAR // BREACH folder (no attachment on BREACH 1).
- Enumerate IP conversations with tshark; the only external-side IP is 10.13.37.101.
- Confirm it originates the SYN sweep and the subsequent HTTP exploitation on port 8080.

## Solve
`solver.py` counts SYN opens per source outside 192.168.10.0/24 and prints the attacker IP.
