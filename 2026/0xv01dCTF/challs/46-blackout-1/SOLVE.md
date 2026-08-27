# BlackOut - 1

**Status:** solved

**Flag:** `0xV01D{nova0x_NOVA-FIN-044_invoice_0814.lnk}` (recovered from Sysmon/Security/4688 + Prefetch; not submitted)

**Technique tags:** forensics, DFIR, sysmon, LOLBin, process-creation, windows

**Signals:** case brief names host NOVA-FIN-044 and user THRYVE\nova0x; Stage 1 prompt = initial user, downloaded file, LOLBin used for execution. Sysmon + Security 4688 + Prefetch give the whole entry chain.

**Method**
- Sysmon Event 11 (18:08:42Z): `C:\Users\nova0x\Downloads\invoice_0814.lnk` created, User `THRYVE\nova0x`, Computer `NOVA-FIN-044.thryve.local`.
- Sysmon Event 1 (18:09:04Z): `C:\Windows\System32\mshta.exe` (parent explorer.exe) runs `mshta.exe "C:\Users\nova0x\Downloads\invoice_0814.lnk"` — LOLBin = mshta, payload = the .lnk.
- Security_4688.csv confirms SubjectUserName=nova0x and the same command line.
- Prefetch MSHTA.EXE-42F01D2A.pf lists `invoice_0814.lnk` (run count 1).

**Chain so far:** invoice_0814.lnk (download) -> mshta.exe -> powershell -enc (18:09:26Z) -> C2 198.51.100.42:8080 (18:09:40Z) -> DNS TXT queries `_N.k984.voidcdn.net` (18:09:50Z) -> Defender disable -> vssadmin delete shadows -> persistence reg.exe HKCU CLSID -> svch0st.exe (18:17:43Z) -> RECOVER-0xV01D.txt ransom note.

**Reusable takeaway:** LNK-as-payload attacks show up as a Sysmon Event 11 (file create) followed by Event 1 (process create) with a LOLBin (mshta) — correlate timestamps, parent image, and Prefetch run times to lock the entry vector.

## Solve
`solver.py` parses the Sysmon XML + Security 4688 CSV and prints user, workstation, payload, and flag.
