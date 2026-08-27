from pwn import *
context.log_level='error'
import time,sys
HOST,PORT='50.116.28.133',48271
def one(expr, cooldown=7):
    time.sleep(cooldown)
    try:
        io=remote(HOST,PORT,timeout=8)
    except Exception as e:
        return f"CONN_FAIL"
    o=b''; t=time.time()
    sent=False
    while time.time()-t<5:
        try:
            c=io.recv(timeout=1)
            if c:
                o+=c
                if not sent and o.rstrip().endswith(b'>'):
                    io.send(expr.encode()+b'\n'); sent=True; 
        except: pass
    if not sent:
        try: io.send(expr.encode()+b'\n'); time.sleep(1); o+=io.recv(timeout=2)
        except: pass
    io.close()
    # strip banner: take text after last '>'
    s=o.decode('latin1')
    ans=s.split('> ',1)[-1] if '> ' in s else s
    return ans.strip()
probes=['1','"a"','-1','1<2','1==1','[1]','1.5','1 if 2 else 3',
        'flag','open','gate','answer','secret','obsidian','__builtins__','eval']
for p in probes:
    r=one(p)
    print(f"{p!r:20} -> {r!r}", flush=True)
