# BlackOut - 2

**Status:** active (commands verified; flag format candidate, not submitted)

**Flag candidate:** `0xV01D{Set-MpPreference_-DisableRealtimeMonitoring_$true_-DisableIOAVProtection_$true_vssadmin_delete_shadows_/all_/quiet}`
(space variant `0xV01D{Set-MpPreference -DisableRealtimeMonitoring $true -DisableIOAVProtection $true_vssadmin delete shadows /all /quiet}` was already rejected on platform)

**Technique tags:** forensics, DFIR, sysmon, defense-evasion, shadow-copy, ransomware

**Signals:** stage prompt asks for the exact Defender-disabling command and the
shadow-copy destruction command; Sysmon Event 1 (process create) records both
command lines verbatim.

## Method
- Sysmon Event 1, 2026-08-14T18:10:32Z, `powershell.exe` (parent `svchost.exe`):
  `Set-MpPreference -DisableRealtimeMonitoring $true -DisableIOAVProtection $true` — the defense-evasion command.
- Sysmon Event 1, 2026-08-14T18:11:16Z, `vssadmin.exe` (parent `powershell.exe`):
  `vssadmin delete shadows /all /quiet` — the recovery-removal command.
- Corroboration: PowerShell 4104 logs the `Set-MpPreference` script block;
  Prefetch `VSSADMIN.EXE-9130FD88.pf.txt` last run 18:11:16Z run count 1;
  Sysmon 11 shows the ransom note dropped at 18:17:15Z right after.
- No other Defender-disable or shadow-delete command exists anywhere in the
  evidence set (rg over Sysmon/PowerShell/Prefetch/Defender MPLog).
- Flag format `0xV01D{defender_command_shadow_command}` joins both commands with
  `_`. Space variant failed, so spaces inside each command become `_` (matches
  every other accepted flag in this event, e.g. BlackOut - 1).

**Reusable takeaway:** for "exact command" DFIR questions, Sysmon Event 1 `CommandLine`
is authoritative; pair it with PowerShell 4104 script-block logging when present.
If a literal-space flag is rejected, check the event's flag convention — most CTF
flags normalize spaces to underscores.

## Solve
`solver.py` prints both commands and the flag candidate.
