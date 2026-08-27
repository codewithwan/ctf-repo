from pwn import *
context.log_level='error'
import time
HOST,PORT='50.116.28.133',48271
def one(expr, cooldown=14, tries=2):
    for _ in range(tries):
        time.sleep(cooldown)
        try: io=remote(HOST,PORT,timeout=8)
        except Exception: continue
        o=b''; t=time.time(); sent=False
        while time.time()-t<6:
            try:
                c=io.recv(timeout=1)
                if c:
                    o+=c
                    if not sent and o.rstrip().endswith(b'>'):
                        io.send(expr.encode()+b'\n'); sent=True
            except: pass
        io.close()
        s=o.decode('latin1'); idx=s.rfind('> ')
        ans=(s[idx+2:] if idx>=0 else s).strip()
        if ans: return ans
    return "(empty/throttled)"
probes=['answer','answer()','flag()','read()','unlock()','gate()','open("flag.txt")',
        'len("ab")','chr(65)','[1,2]']
for p in probes:
    print(f"{p!r:20} -> {one(p)!r}", flush=True)
