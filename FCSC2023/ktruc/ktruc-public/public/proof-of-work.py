import os
import random
import string
import hashlib

DIFFICULTY = 23

def check_PoW(prefix, S):
    s = prefix + S
    m = hashlib.sha256()
    m.update(s.encode())
    h = m.digest()
    bits = "{:0256b}".format(int(h.hex(), 16))
    return bits[:DIFFICULTY] == "0" * DIFFICULTY

try:
    prefix = ''.join(random.choice(string.ascii_letters) for _ in range(16))
    print(f"Please provide a string S such that SHA256({prefix} || S) starts with {DIFFICULTY} bits equal to 0 (the string concatenation is denoted ||):")
    S = input(">>> ")

    if check_PoW(prefix, S):
        print("Valid Proof-of-Work!")
        os.execve("/app/run.sh", ["/app/run.sh"], {})
    else:
        print("Wrong Proof-of-Work.")

except:
    print("Please check your inputs.")
