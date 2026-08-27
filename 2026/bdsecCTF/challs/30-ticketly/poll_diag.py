import urllib.request,urllib.parse,http.cookiejar,re,time
U="http://45.33.28.244:3000"
parts=open('.seqmarks').read().split()
M=parts[:5]; PU,PP=parts[5],parts[6]
def taken(user):
    try:
        cj=http.cookiejar.CookieJar(); o=urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
        b=o.open(urllib.request.Request(U+'/register',data=urllib.parse.urlencode({'username':user,'password':'z'}).encode()),timeout=10).read().decode('latin1')
        return 'is taken' in b or 'already' in b.lower()
    except Exception as e:
        return 'taken' in str(e).lower()
def leakticket():
    cj=http.cookiejar.CookieJar(); o=urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
    try:
        o.open(urllib.request.Request(U+'/login',data=urllib.parse.urlencode({'username':PU,'password':PP}).encode()),timeout=10)
        html=o.open(U+'/tickets',timeout=10).read().decode('latin1')
        ids=re.findall(r'/ticket/(\d+)',html)
        if not ids: return None
        b=o.open(U+'/ticket/'+max(ids,key=int),timeout=10).read().decode('latin1')
        m=re.search(r'ticket-body">\s*(.*?)\s*</div>',b,re.S)
        return m.group(1).strip() if m else ''
    except: return None
for i in range(24):
    time.sleep(8)
    st=[taken(m) for m in M]
    depth=sum(st)
    lt=leakticket()
    print(f"[{(i+1)*8}s] markers reached: {depth}/5  {['S%d'%(j+1) for j in range(5) if st[j]]}  leakTicket={'YES:'+lt if lt else 'no'}",flush=True)
    if lt or depth>=5:
        print("=> chain reached depth",depth,"leak ticket:",lt,flush=True); break
    if depth>=1 and i>=6 and depth<5 and all(st[:depth]) and not any(st[depth:]):
        # stabilized break point
        if i>=8: print(f"=> STABILIZED: chain breaks after step {depth} (S{depth} ran, S{depth+1} didn't)",flush=True); break
