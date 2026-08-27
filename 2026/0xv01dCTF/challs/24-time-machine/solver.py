#!/usr/bin/env python3
"""Time Machine — pull jinx69/timemachine:latest layers via the Docker Registry HTTP API
and read /opt/flag.sh from the image history (daemon-independent)."""
import gzip
import io
import json
import tarfile
import urllib.request

REPO = "jinx69/timemachine"
TAG = "latest"

tok = json.load(urllib.request.urlopen(
    f"https://auth.docker.io/token?service=registry.docker.io&scope=repository:{REPO}:pull"))
auth = {"Authorization": "Bearer " + tok["token"]}

req = urllib.request.Request(
    f"https://registry-1.docker.io/v2/{REPO}/manifests/{TAG}",
    headers={**auth, "Accept": "application/vnd.docker.distribution.manifest.v2+json"})
manifest = json.load(urllib.request.urlopen(req))

found = []
for layer in manifest["layers"]:
    digest = layer["digest"]
    blob = urllib.request.urlopen(urllib.request.Request(
        f"https://registry-1.docker.io/v2/{REPO}/blobs/{digest}", headers=auth)).read()
    raw = gzip.decompress(blob) if digest.startswith("sha256:") else blob
    tf = tarfile.open(fileobj=io.BytesIO(raw))
    for m in tf.getmembers():
        if m.name.rstrip("/").endswith("flag.sh"):
            found.append((digest[:19], tf.extractfile(m).read().decode(errors="replace")))
    tf.close()

for d, content in found:
    print("==", d)
    print(content)
assert found
