from pwn import *
import time, sys
context.log_level='error'
HOST,PORT='50.116.28.133',48271
def one(lines, eof=True, banner_wait=6, per=2.5, cooldown=0):
    if cooldown: time.sleep(cooldown)
    log=[]
    try:
        io=remote(HOST,PORT)
    except Exception as e:
        return f"CONNECT_FAIL: {e}"
    # banner
    b=b''; t=time.time()
    while time.time()-t<banner_wait:
        try:
            c=io.recv(timeout=1)
            if c: b+=c
        except: pass
    log.append(("BANNER",b))
    for ln in lines:
        io.send(ln+b'\n')
        o=b''; t=time.time()
        while time.time()-t<per:
            try:
                c=io.recv(timeout=1)
                if c: o+=c
            except: pass
        log.append(("SENT:"+ln.decode('latin1'), o))
    if eof:
        try: io.shutdown('send')
        except: pass
        o=b''; t=time.time()
        while time.time()-t<3:
            try:
                c=io.recv(timeout=1)
                if c: o+=c
            except: pass
        log.append(("AFTER_EOF", o))
    io.close()
    return log

if __name__=='__main__':
    res=one([b"print(1337*7)", b"print(31337)"], eof=True, cooldown=int(sys.argv[1]) if len(sys.argv)>1 else 0)
    if isinstance(res,str):
        print(res)
    else:
        for tag,data in res:
            print(f"--- {tag} --- ({len(data)} bytes)")
            print(repr(data[:800]))
