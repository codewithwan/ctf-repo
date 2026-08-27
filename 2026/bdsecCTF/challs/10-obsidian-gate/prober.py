from pwn import *
context.log_level='error'
import threading, queue, time
SERVERS=['50.116.28.133','66.228.50.16']; PORT=48271; COOLDOWN=13
def one(host, expr):
    try: io=remote(host,PORT,timeout=8)
    except Exception: return "CONN_FAIL"
    o=b''; t=time.time(); sent=False
    while time.time()-t<5:
        try:
            c=io.recv(timeout=1)
            if c:
                o+=c
                if not sent and o.rstrip().endswith(b'>'): io.send(expr.encode()+b'\n'); sent=True
        except: pass
    io.close()
    s=o.decode('latin1'); i=s.rfind('> ')
    return (s[i+2:] if i>=0 else s).strip() or "(empty)"
results={}
q=queue.Queue()
def worker(host):
    while True:
        try: expr=q.get_nowait()
        except queue.Empty: return
        r=one(host,expr); results[expr]=r
        print(f"[{host[:6]}] {expr!r:24} -> {r!r}",flush=True)
        time.sleep(COOLDOWN); q.task_done()
if __name__=='__main__':
    import sys
    exprs=sys.argv[1].split('|')
    for e in exprs: q.put(e)
    ths=[threading.Thread(target=worker,args=(s,),daemon=True) for s in SERVERS]
    for t in ths: t.start()
    q.join()
