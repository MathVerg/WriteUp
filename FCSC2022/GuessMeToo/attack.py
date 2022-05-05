from pwn import *


N = 128
C = 136
K =  32

PROMPT = b">>> "

def send_sample(l):
    assert len(l) == C
    for n in l:
        conn.recvuntil(PROMPT)
        conn.sendline(str(n).encode())

def mask_sample():
    l = [1 << k for k in range(C)] #avoid repetitions
    full = (1 << N) - 1
    for i in range(N):
        l[i] = full ^ (1 << i)
    l[N] = full
    return l

def interpret_mask_sample(l):
    assert len(l) == C
    parity = l[N]
    number = 0
    for k in range(N):
        number |= ((l[k] ^ parity)  << k)
    return number

def attack_no_fault():
    l = mask_sample()
    print("Sample ready")
    send_sample(l)
    print("Sample sent")
    res = eval(conn.recvline().strip().decode()) ##yeah, I know that's bad, sorry
    n = interpret_mask_sample(res)
    print(conn.recvline())
    conn.recvuntil(PROMPT)
    conn.sendline(str(n).encode())
    print(conn.recvline())

def w(x):
	return bin(x).count("1") & 1

def half_masks():
    """
    Compute dichotomy masks, see spreadsheet for visual explanation
    """
    halfs = []
    for k in range(7):
        interval = (1 << (1 << (7 - k - 1))) - 1
        res = 0
        for i in range(1 << k):
            res <<= (1 << (7 - k))
            res |= interval
        halfs.append(res)
    return halfs

def sample_ec():
    #start with the one_bit masks
    one_bits = []
    for k in range(N):
        one_bits.append(1 << k)

    #then the half_masks
    halfs = half_masks()
        
    #and finally the halfs's checksum
    checksum = 0
    for mask in halfs :
        checksum ^= mask

    sample = one_bits + halfs + [checksum]

    return sample

def interpret_ec(l):
    assert len(l) == C

    # split input
    one_bits = l[:N]
    halfs = l[N:N + 7]
    checksum = l[N + 7]

    # build number from one_bits
    n = 0
    for k in range(N):
        n |= (one_bits[k] << k)

    # verifiy checksum
    check = 0
    for b in halfs:
        check ^= b
    
    if check != checksum :
        print("Error found in the maks, so the number should be right")
        return n

    print("No error found in the masks, searching for error in the number")

    h_masks = half_masks()
    error_index = 0
    for k in range(7):
        diff = w(h_masks[k] & n) ^ halfs[k]
        #if diff, the error is located in the mask, and else we have to go in the other half
        error_index += ((1 ^ diff) << ( 7 - k - 1))
    
    #correct the bit
    n ^= (1 << error_index)
    return n
        

def attack():
    l = sample_ec()
    print("Sample ready")
    send_sample(l)
    print("Sample sent")
    res = eval(conn.recvline().strip().decode()) #I said I'm sorry, ok ?
    n = interpret_ec(res)
    print(conn.recvline())
    conn.recvuntil(PROMPT)
    conn.sendline(str(n).encode())
    print(conn.recvline())


#conn = process("./guessmetoo.py")
conn = remote("challenges.france-cybersecurity-challenge.fr", 2003)

for _ in range(K):
    print(K)
    attack()

print(conn.recvall())
