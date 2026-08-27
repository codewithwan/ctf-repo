import ssl, socket
ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ctx.load_cert_chain('/tmp/cert.pem','/tmp/key.pem')
srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
srv.bind(('0.0.0.0', 4443)); srv.listen(5)
while True:
    try:
        c,a = srv.accept()
        ss = ctx.wrap_socket(c, server_side=True)
        ss.settimeout(3)
        data=b''
        try:
            while True:
                ch=ss.recv(4096)
                if not ch: break
                data+=ch
        except Exception: pass
        open('/tmp/loot.txt','ab').write(data+b'\n====\n')
        try: ss.close()
        except: pass
    except Exception as e:
        open('/tmp/loot.txt','ab').write(b'ACCEPT_ERR '+str(e).encode()+b'\n')
