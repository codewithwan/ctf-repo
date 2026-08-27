# Unauthorized Access — DFIR (100) [part of the "Inside Job" FBBL series]

**Flag:** `BDSEC{45.33.32.156}` · verified ("Correct", challenge id 20)
**Question:** *What is the unauthorized IP address used to brute force the bank account access?*

## The scenario
FirstBangla Bank, $2,045,000 crypto theft (May 10 2024). Insider (`arif.khan`) colluded
with an external attacker ("R Consultant" / Rajesh, Mumbai). We're given a 9.4 GB forensic
image of the investigator's workstation (`FBBL-FORENSICS-WS01`).

## Getting into the image (the real work)
```bash
# 1. archive holds a single OVA (tar of OVF + streamOptimized VMDK)
unzip -p FBBL-FORENSICS-WS01.zip FBBL-FORENSICS-WS01.ova | tar -xf - <disk>.vmdk
# 2. streamOptimized VMDK -> raw (7z sees the container but won't browse the FS)
qemu-img convert -f vmdk -O raw <disk>.vmdk raw.img
# 3. GPT -> ext4 root at sector 1054720
mmls raw.img
fls -r -p -o 1054720 raw.img > filelist.txt          # Sleuth Kit, no mount needed
icat -o 1054720 raw.img <inode> > file                # extract by inode
```

## The trap (pcap) vs the real evidence (auth log)
`var/captures/archived/network_capture.pcap` looks like the answer but is a **decoy for
this question**: it shows the insider workstation `10.0.0.12` doing HTTP dashboard polling,
908 tiny SSH probes to the bank server `10.0.0.1`, and C2/exfil to Tor `185.220.101.47`
(`/sync` = `vault_key=F!rstB@ngla#Vault2024`, `/confirm` = `transfers_complete=3&total=2045000`,
both hex→base64) plus Bangkok-travel DNS (fleeing). **No external brute force is in the pcap.**
Guessing `10.0.0.12` / `10.0.0.1` from the pcap is wrong (cost us 2 attempts).

The brute force is in the bank's **`/var/log/firstbangla/treasury_access.log`** (45 000 lines):
```
2024-05-03 03:12–03:14   26× FAILED_LOGIN | AUTH_SERVICE | DENIED | 45.33.32.156
   usernames cycled: treasury, finance, arif.khan, support, karim.hassan, sysadmin,
                     administrator, guest, demo, operator, info, test  ← credential brute force
2024-05-03 03:14:29  security.monitor | ALERT_RAISED | AUTH_SERVICE |
                     BLOCKED_source=45.33.32.156_reason=brute_force_threshold | 10.0.1.2
```
The security monitor literally logs `BLOCKED source=45.33.32.156 reason=brute_force_threshold`.
`45.33.32.156` is a **public** IP (Linode) — matches the `BDSEC{192.16.0.1}` format — and was
disguised as a benign *"Secondary test node"* in `it.admin/.../connectivity_test.log`
(and `185.220.101.47` disguised as a "firewall test node") to misdirect.

→ `BDSEC{45.33.32.156}`

## Reusable takeaways
- OVA → `tar -x`; streamOptimized VMDK → `qemu-img convert -O raw`; then Sleuth Kit
  `mmls`/`fls -r`/`icat` reads ext4 by offset+inode with no mounting (great on macOS).
- Don't fixate on the pcap: a DFIR "brute force IP" question is usually answered by an
  **auth/access log** (`FAILED_LOGIN`, `brute_force_threshold`), not packet timing. The pcap
  here was deliberate misdirection.
- Watch for planted decoys: a "connectivity/firewall test" log that name-drops the malicious
  IPs as benign "test nodes" is the author waving a flag at them.
