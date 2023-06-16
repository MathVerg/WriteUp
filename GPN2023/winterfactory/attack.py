#!/usr/bin/python3

from pwn import *
import winternitz.signatures
from binascii import unhexlify

HOST = "winterfactory-0.chals.kitctf.de"
PORT = 1337

LOCAL = not args.REMOTE

factory_id = 831347528
init_message = bytes("surely no secret here"+str(factory_id), "utf-8")
w = 2**16

local_wots = winternitz.signatures.WOTS(w, digestsize=256, hashfunction=winternitz.signatures.openssl_sha256)

init_msghash = winternitz.signatures.openssl_sha256(init_message)
init_bytestosign = local_wots._getSignatureBaseMessage(init_msghash)

lowest_ck = init_bytestosign[16]


#context.log_level = "DEBUG"

if LOCAL:
    p = process(["python3", "winterfactory.py"])
else:
    p = remote(HOST, PORT, ssl=True)


def can_sign(mb):
    for i in range(16):
        if mb[i] < init_bytestosign[i]:
            return False
    if mb[17] < init_bytestosign[i]:
        return False
    """
    if mb[16] < lowest_ck:
        return False
    """
    return True

def signature(mb):
    certif = [None for _ in range(18)]
    for i in range(16):
        certif[i] = local_wots._chain(init_certificate[i], init_bytestosign[i], mb[i])
    certif[17] = local_wots._chain(init_certificate[17], init_bytestosign[17], mb[17])
    certif[16] = local_wots._chain(lowest_ck_sign, lowest_ck, mb[16])
    return "|".join([b.hex() for b in certif]).encode()

p.recvline()
p.recvline()
init_certificate = list(map(unhexlify, p.recvline(keepends=False).decode().split("|")))
lowest_ck_sign = init_certificate[16]
p.recvline()
p.recvline()

while True:
    p.recvline()
    p.recvline()
    p.recvuntil(b"| ")
    p11 = unhexlify(p.recvuntil(b" |", drop=True).decode())
    p.recvline()
    p.recvline()
    p.recvuntil(b"| ")
    p21 = unhexlify(p.recvuntil(b" |", drop=True).decode())
    p.recvuntil(b">> ")
    p11_hash = winternitz.signatures.openssl_sha256(p11)
    p21_hash = winternitz.signatures.openssl_sha256(p21)
    p11_bytes = local_wots._getSignatureBaseMessage(p11_hash)
    p21_bytes = local_wots._getSignatureBaseMessage(p21_hash)
    if (can_sign(p11_bytes) and p11_bytes[16] >= p21_bytes[16]) or (can_sign(p21_bytes) and p21_bytes[16] >= p11_bytes[16]):
        p.sendline(b"yes")
        p.recvuntil(b">> ")
        if p11_bytes[16] >= p21_bytes[16]:
            p.sendline(b"2")
            p.recvline()
            ck_sign = unhexlify(p.recvline(keepends=False).decode())
            lowest_ck = p21_bytes[16]
            lowest_ck_sign = ck_sign
            p.recvuntil(b">> ")
            p.sendline(signature(p11_bytes))
        else:
            p.sendline(b"1")
            p.recvline()
            ck_sign = unhexlify(p.recvline(keepends=False).decode())
            lowest_ck = p11_bytes[16]
            lowest_ck_sign = ck_sign
            p.recvuntil(b">> ")
            p.sendline(signature(p21_bytes))
        print(p.recvline(keepends=False))
        exit()
    else:
        p.sendline(b"no")

