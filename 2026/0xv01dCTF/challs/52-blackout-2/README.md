# BlackOut - 2

- **Category:** Forensics
- **Points:** 425
- **Solves:** 1
- **Source:** same evidence bundle as BlackOut - 1 (`0xV01D_Blackout_player.zip`)

## Description
Identify the defense evasion command and the recovery removal command.

Submit format: 0xV01D{defender_command_shadow_command}

## Files
- `../46-blackout-1/0xV01D_Blackout/` (Sysmon/PowerShell/Prefetch evidence)

## Solve
`solver.py` parses the Sysmon Event 1 command lines and prints the flag.
