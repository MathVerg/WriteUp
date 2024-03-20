#!/usr/bin/python3

from pwn import remote
import sage.all
from tqdm import trange
from Crypto.Util.number import inverse

HOST = "mathgolf.chal-kalmarc.tf"
PORT = 3470

def get_number():
    global io
    return int(io.recvline().strip()[2:], 16)

def send_number(x:int):
    global io
    io.sendline(hex(x).encode())

def solve_sage(b, c, a0, a1, p):
    Fp = sage.all.GF(p)
    RFp = sage.all.PolynomialRing(Fp, ['t'])
    F = sage.all.GF(p**2, name='t')
    poly = F.modulus()
    #print(list(poly))
    M = sage.all.matrix([[F(b), F(c)], [F(1), F(0)]])
    D, P = M.diagonalization()
    #M = PDP^(-1)
    phi = D[0][0]
    psi = D[1][1]
    (x, y) = P.inverse()*sage.all.vector([F(a1), F(a0)])
    const_phi = P[1][0] * x
    const_psi = -P[1][1] * y
    return (poly, phi, psi, const_phi, const_psi)

def sqrt(x, p, z):
    """
    compute quadratic residue of x mod p, p odd prime
    assumes legendre(x) == 1 and x != 0
    z is a non quadratic residue element
    """
    if (p%4 == 3):
        print("Direct computation")
        return pow(x, (p+1)//4, p)
    else:
        print("Tonelli-shanks")
        #Tonelli-shanks
        Q = p - 1
        S = 0
        while (Q % 2 == 0):
            Q //= 2
            S += 1
        c = pow(z, Q, p)
        t = pow(x, Q, p)
        R = pow(x, (Q+1)//2, p)
        while t != 1:
            i = 0
            acc = t
            while acc != 1 and i < S:
                i += 1
                acc = (acc*acc)%p
            B = pow(c, 1<<(S-i-1), p)
            S = i
            c = (B*B)%p
            t = (t*c)%p
            R = (R*B)%p
        return R


def solve_manual(b, c, a0, a1, p):
    print(f"{p=}, {hex(p)=}")
    delta = (b*b + 4*c)%p
    leg_delta = pow(delta, (p-1)//2, p)
    if leg_delta == p-1:
        leg_delta = -1
    print(f"{delta=}, {leg_delta=}")
    inv2 = (p+1)//2
    if (leg_delta == 1) :
        z = 2
        while pow(z, (p-1)//2, p) == 1:
            z += 1
        poly = [p-z, 0]
        sqrt_delta = sqrt(delta, p, z)
        phi = [ ((b + sqrt_delta)*inv2)%p, 0]
        psi = [ ((b + (p - sqrt_delta))*inv2)%p, 0]
        inv_sqrt_delta = inverse(sqrt_delta, p)
        const_phi = [((a1 + (p - (a0*psi[0])%p))*inv_sqrt_delta)%p, 0]
        const_psi = [((a1 + (p - (a0*phi[0])%p))*inv_sqrt_delta)%p, 0]
        return (poly, phi, psi, const_phi, const_psi)
    elif (leg_delta == -1):
        poly = [p-delta, 0]
        phi = [(b*inv2)%p, inv2]
        psi = [(b*inv2)%p, p-inv2]
        half_a0 = (a0*inv2)%p
        im_part = ((a1 + (p - (half_a0*b)%p))*inverse(delta, p))%p
        const_phi = [half_a0, im_part]
        const_psi = [p - half_a0, im_part]
        return (poly, phi, psi, const_phi, const_psi)
    else:
        print("Unexpected value for leg_delta: {leg_delta}")
        exit(1)


io = remote(HOST, PORT)
for i in range(100):
    print(f"Problem {i}")
    io.recvline()
    io.recvuntil(b"b  =")
    b = get_number()
    io.recvuntil(b"c  =")
    c = get_number()
    io.recvuntil(b"a0 =")
    a0 = get_number()
    io.recvuntil(b"a1 =")
    a1 = get_number()
    io.recvuntil(b"p  =")
    p = get_number()

    #(poly, phi, psi, const_phi, const_psi) = solve_sage(b, c, a0, a1, p)
    (poly, phi, psi, const_phi, const_psi) = solve_manual(b, c, a0, a1, p)

    io.recvuntil(b"Polynomial: \n")
    send_number(poly[0])
    send_number(poly[1])
    io.recvuntil(b'phi: \n')
    send_number(phi[0])
    send_number(phi[1])
    io.recvuntil(b'psi: \n')
    send_number(psi[0])
    send_number(psi[1])
    io.recvuntil(b'const_phi: \n')
    send_number(const_phi[0])
    send_number(const_phi[1])
    io.recvuntil(b'const_psi: \n')
    send_number(const_psi[0])
    send_number(const_psi[1])
    


    

print(io.recvall())
    