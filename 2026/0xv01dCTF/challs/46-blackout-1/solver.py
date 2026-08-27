#!/usr/bin/env python3
"""BlackOut - 1 — compromised user, workstation, first payload (Stage 1).

Evidence: Sysmon Event 11 (file created) -> invoice_0814.lnk lands in
C:\\Users\\nova0x\\Downloads\\ at 18:08:42Z; Sysmon Event 1 at 18:09:04Z shows
mshta.exe (LOLBin) executing it; Security_4688 confirms SubjectUserName=nova0x
on host NOVA-FIN-044 (NOVA-FIN-044.thryve.local per <Computer>).
"""
import re
from pathlib import Path

BASE = Path(__file__).resolve().parent / "0xV01D_Blackout" / "evidence"


def main():
    sysmon = (BASE / "Endpoint/Sysmon/Microsoft-Windows-Sysmon_Operational.evtx.xml").read_text()
    sec = (BASE / "Endpoint/Security/Security_4688.csv").read_text()

    computer = re.search(r"<Computer>([^.<]+)\.", sysmon).group(1)
    user = re.search(r"<Data Name=\"User\">THRYVE\\([^<]+)</Data>", sysmon).group(1)
    payload = re.search(
        r'<Data Name="TargetFilename">.*?Downloads\\([^<]+)</Data>', sysmon).group(1)
    line = next(l for l in sec.splitlines() if "mshta" in l)
    _, proc, creator, subj, cmdline = line.split(",", 4)
    print("workstation:", computer)
    print("user       :", user)
    print("first run  :", cmdline.strip())
    print("payload    :", payload)
    print("FLAG: 0xV01D{%s_%s_%s}" % (user, computer, payload))


if __name__ == "__main__":
    main()
