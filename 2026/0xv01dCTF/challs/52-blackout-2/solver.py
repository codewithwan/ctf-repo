#!/usr/bin/env python3
"""BlackOut - 2 — exact Defender-disabling and shadow-copy destruction commands.

Source: Sysmon Event 1 (process create) in the BlackOut evidence bundle.
- 2026-08-14T18:10:32Z  powershell.exe  Set-MpPreference -DisableRealtimeMonitoring $true -DisableIOAVProtection $true
- 2026-08-14T18:11:16Z  vssadmin.exe    vssadmin delete shadows /all /quiet
Corroborated by PowerShell 4104 (defender cmd) and Prefetch VSSADMIN run time.

Flag format on platform is 0xV01D{defender_command_shadow_command}; CTFd flags in
this event use underscores, so spaces inside each command become underscores.
"""
import re
from pathlib import Path

SYSMON = str(Path(__file__).resolve().parent
             / "../46-blackout-1/0xV01D_Blackout/evidence/Endpoint/Sysmon/"
               "Microsoft-Windows-Sysmon_Operational.evtx.xml")

def find_cmds(xml: str, needles: tuple[str, ...]) -> list[str]:
    out = []
    for block in re.findall(r"<Event>.*?</Event>", xml, re.S):
        if "<EventID>1</EventID>" in block:
            m = re.search(r'<Data Name="CommandLine">([^<]+)</Data>', block)
            if m and m.group(1).lower().startswith(needles):
                out.append(m.group(1))
    return out

def main():
    xml = Path(SYSMON).read_text(encoding="utf-8", errors="replace")
    defender = find_cmds(xml, ("set-mppreference",))
    shadow = find_cmds(xml, ("vssadmin",))
    for c in defender + shadow:
        print(c)

    if defender and shadow:
        flag = "0xV01D{" + "_".join(
            cmd.replace(" ", "_") for cmd in (defender[0], shadow[0])) + "}"
        print()
        print("FLAG CANDIDATE:", flag)

if __name__ == "__main__":
    main()
