#!/usr/bin/python3

from pwn import *
from binascii import unhexlify
from random import randbytes
#import itertools as it
from number_lock import s_box, r_con, AES

LOCAL = not args.REMOTE

HOST = "number-lock-0.chals.kitctf.de"
PORT = 1337

NUM_CHIF = 19

def break_box(n):
    global p
    p.recvuntil(b">> ")
    p.sendline(b"1")
    p.recvuntil(b">> ")
    p.sendline(str(n).encode())
    assert p.recvline(keepends=False) == b"The box cracks"

def encrypt(m):
    global p
    p.recvuntil(b">> ")
    p.sendline(b"2")
    p.recvuntil(b">> ")
    p.sendline(m.hex().encode())
    resp = unhexlify(p.recvline(keepends=False).decode())
    return resp

def rotword(word):
    return word[1:4] + p8(word[0])

def subword(word):
    return [s_box[b] for b in word]

def inv_key_sched(last_round_key):
    R = 11
    N = 4
    W = [None for _ in range(4*(R - 1))] + [last_round_key[4*i:4*(i+1)] for i in range(4)]
    for i in range(4*R - 1, 4-1, -1):
        if i % N == 0:
            W[i-N] = xor(xor(W[i], p32(r_con[i//N])), subword(rotword(W[i-1])))
        else:
            W[i-N] = xor(W[i], W[i-1])
    return W[0] + W[1] + W[2] + W[3]

COEFF_FOR_Z = [
    [2, 3, 1, 1],
    [1, 2, 3, 1],
    [1, 1, 2, 3],
    [3, 1, 1, 2]
]

        
TOUCHED_SETS = [[0, 7, 10, 13], [1, 4, 11, 14], [2, 5, 8, 15], [3, 6, 9, 12]]

xtime = lambda a: (((a << 1) ^ 0x1B) & 0xFF) if (a & 0x80) else (a << 1)

def gmul(elt, coef):
    if coef == 1:
        return elt
    elif coef == 2:
        return xtime(elt)
    elif coef == 3:
        return xtime(elt) ^ elt
    assert False

#print(inv_key_sched(b'\x0ei\xcc)'+ b'\n\xa4p\xe4'+ b'O\x1e\xf4\xea'+ b'\x168\xe8\x13'))

def combine_correlated(l1, l2):
    res = []
    for i in range(4):
        s = l1[i].intersection(l2[i])
        if s == set():
            return None
        res.append(s)
    return res

if LOCAL:
    p = process(["python3", "number_lock.py"])
else:
    p = remote(HOST, PORT, ssl=True)

clairs = [randbytes(16) for _ in range(NUM_CHIF)]

ciphers = [encrypt(c) for c in clairs]

break_box(9)

broken_ciphers = [encrypt(c) for c in clairs]

#lastrkey_bytes = [set(range(256)) for _ in range(16)]
correlated = [[] for _ in range(4)]

for i in range(NUM_CHIF):
    correlated_this_pair = []
    cipher = ciphers[i]
    broken = broken_ciphers[i]
    touched_set = None
    for k in range(4):
        if cipher[k] != broken[k]:
            touched_set = TOUCHED_SETS[k]
            touched_set_idx = k
    for i in range(16):
        if i in touched_set:
            assert cipher[i] != broken[i]
        else:
            assert cipher[i] == broken[i]
    #K_sets = [set() for _ in range(4)]
    for l in range(4):
        #Y_sets = [set() for _ in range(4)]
        for z in range(256):
            z_valid = True
            local_Y_sets = [set() for _ in range(4)]
            for k in range(4):
                j = touched_set[k]
                target = cipher[j] ^ broken[j]
                local_z_valid = False
                for y in range(256):
                    if s_box[y] ^ s_box[gmul(z, COEFF_FOR_Z[l][k]) ^ y] == target:
                        local_z_valid = True
                        local_Y_sets[k].add(y)
                z_valid = z_valid and local_z_valid
            if z_valid:
                """
                for k in range(4):
                    Y_sets[k] = Y_sets[k].union(local_Y_sets[k])
                """
                correlated_this_pair.append([{s_box[y] ^ cipher[touched_set[k]] for y in local_Y_sets[k]}for k in range(4)])
        """
        for k in range(4):
            j = touched_set[k]
            for y in Y_sets[k]:
                K_sets[k].add(s_box[y] ^ cipher[j])
        """
        
    for k in range(4):
        j = touched_set[k]
        #lastrkey_bytes[j] = lastrkey_bytes[j].intersection(K_sets[k])
    if correlated[touched_set_idx] == []:
        correlated[touched_set_idx] = correlated_this_pair
    else:
        #print(correlated[touched_set_idx])
        #print(correlated_this_pair)
        correlated_filtered = []
        for l1 in correlated[touched_set_idx]:
            for l2 in correlated_this_pair:
                combo = combine_correlated(l1, l2)
                if combo is not None:
                    correlated_filtered.append(combo)
        #print(len(correlated[touched_set_idx]), len(correlated_filtered))
        #exit()
        correlated[touched_set_idx] = correlated_filtered


""""
prod = 1
for i in range(16):
    print(i, lastrkey_bytes[i])
    prod *= len(lastrkey_bytes[i])
"""

print(correlated)

key_possibilities = [None for _ in range(16)]
for i in range(4):
    for j in range(4):
        key_possibilities[TOUCHED_SETS[i][j]] = correlated[i][0][j].pop()

print(key_possibilities)

lrkey = bytes(key_possibilities)
print(lrkey)

master_key = inv_key_sched(lrkey)

aes = AES(master_key)

"""
for key_bytes in it.product(*lastrkey_bytes):
    lastrkey = bytes(key_bytes)
    master_key = inv_key_sched(lastrkey)
    #exit()

"""

p.recvuntil(b">> ")
p.sendline(b"3")
p.recvline()
p.recvline()
m = unhexlify(p.recvline(keepends=False))
p.recvuntil(b">> ")
p.sendline(aes.encrypt_block(m).hex().encode())
print(p.recvline())
#p.recvline()
p.close()