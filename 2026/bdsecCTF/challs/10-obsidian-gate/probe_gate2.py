from pwn import *
context.log_level='error'
import time
HOST,PORT='50.116.28.133',48271
def one(expr, cooldown=7):
    time.sleep(cooldown)
    try: io=remote(HOST,PORT,timeout=8)
    except Exception: return "CONN_FAIL"
    o=b''; t=time.time(); sent=False
    while time.time()-t<5:
        try:
            c=io.recv(timeout=1)
            if c:
                o+=c
                if not sent and o.rstrip().endswith(b'>'):
                    io.send(expr.encode()+b'\n'); sent=True
        except: pass
    io.close()
    s=o.decode('latin1')
    # everything after the LAST "> " (the prompt)
    idx=s.rfind('> ')
    return s[idx+2:] if idx>=0 else s
probes=['open','eval','answer','exec','globals','getattr','"abc"[0]','"a".upper','"a".upper()',
        'open("flag.txt")','[1,2]','{}','().__class__','answer()','help']
for p in probes:
    r=one(p)
    print(f"{p!r:22} -> {r!r}", flush=True)
