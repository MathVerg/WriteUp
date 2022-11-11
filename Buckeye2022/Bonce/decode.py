#!/usr/bin/python3
from pwn import xor

cipher_lines = []
with open("output.txt") as f:
    for _ in range(4):
        f.readline()
        cipher_lines.append(f.readline().rstrip()[8:])
    f.readline()
    f.readline()
    for _ in range(36):
        f.readline()
        cipher_lines.append(f.readline().rstrip()[8:])

plaintext_lines = []
for i in range(len(cipher_lines)):
    try:
        line = bytes(map(int, cipher_lines[i].split(' ')))
    except ValueError:
        continue
    if i < 10:
        key = str(i) * 28
    else :
        key = str(i) * 14
    key = key.encode()
    plain = xor(key, line)
    print(plain)
    plaintext_lines.append(plain)

print(plaintext_lines[0:4])
