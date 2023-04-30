import re
import hashlib
from pwn import *

HOST = args.HOST or "challenges.france-cybersecurity-challenge.fr"
PORT = int(args.PORT or 2108)


def solve_pow(prefix, difficulty):
    i = 0
    while True:
        i += 1
        suffix = f"{i:032d}"
        randstr = prefix + suffix
        m = hashlib.sha256()
        m.update(randstr.encode())
        h = m.digest()
        bits = "{:0256b}".format(int(h.hex(), 16))
        if bits[:difficulty] == "0" * difficulty:
            return suffix


if __name__ == "__main__":
    io = remote(HOST, PORT)

    # Proof-of-Work solver
    r = io.recvline().strip().decode()
    m = re.findall(r".* SHA256\(([a-zA-Z]+) \|\| S\) starts with (\d+) bits .*", r)
    assert len(m), "Error: could not extract the prefix and difficulty."
    prefix, difficulty = m[0]
    log.info(f"Solving PoW with difficulty {difficulty} and prefix {prefix}")
    suffix = solve_pow(prefix, int(difficulty))
    io.sendlineafter(b">>> ", suffix.encode())
    r = io.recvline().strip().decode()
    assert r == "Valid Proof-of-Work!"

    ##
    ## Put your code here
    ##