#!/usr/bin/env python3

# MathGolf-Warmup challenge by shalaamum for KalmarCTF 2024

import signal
import sys
import time
import sage.all

def out_of_time(signum, frame):
    print("\nTime is up!")
    sys.exit(1)

signal.signal(signal.SIGALRM, out_of_time)
signal.alarm(60)


def sequence_slow(n, b, c, a0, a1, p):
    if n == 0:
        return a0
    elif n == 1:
        return a1
    else:
        return (b*sequence(n - 1, b, c, a0, a1, p) + c*sequence(n - 2, b, c, a0, a1, p)) % p

# sequence = sequence_slow
from lib import sequence_fast
sequence = sequence_fast
# sequence_fast has the same return value as sequence_slow, it is just ...
# faster.


#from Crypto.Util.number import getPrime
#from Crypto.Random.random import randrange
#class ProblemGenerator:
#    def get(self):
#        p = getPrime(64)
#        n = randrange(1, 1<<64)
#        b, c, a0, a1 = [randrange(0, p) for _ in range(4)]
#        return n, b, c, a0, a1, p
from lib import ProblemGenerator
generator = ProblemGenerator()
# You can assume that ProblemGenerator acts as the above commented snippet.
# It just makes some tweaks that are intended to reduce the variance of the
# run times. Trying to guess those tweaks is unlikely to be helpful to solve
# the challenge.
# Note: The reason in the comment above are for the non-warmup version of the
# challenge.


def get_number():
    return int(input().strip()[2:], 16)


def sequence_from_parameters(n, b, c, a0, a1, p, parameters):
    poly = parameters[0:2]
    phi = parameters[2:4]
    psi = parameters[4:6]
    const_phi = parameters[6:8]
    const_psi = parameters[8:10]
    
    Fp = sage.all.GF(p)
    RFp = sage.all.PolynomialRing(Fp, ['t'])
    F = sage.all.GF(p**2, name='t', modulus=RFp(poly + [1]))
    phi = F(phi)
    psi = F(psi)
    const_phi = F(const_phi)
    const_psi = F(const_psi)

    answer = list(phi**n * const_phi - psi**n * const_psi)
    if answer[1] != 0:
        print("That can't be right...")
        sys.exit(1)
    return int(answer[0])

for i in range(100):
    print(f'Solved {i} of 100')
    n, b, c, a0, a1, p  = generator.get()
    print(f'b  = 0x{b:016x}')
    print(f'c  = 0x{c:016x}')
    print(f'a0 = 0x{a0:016x}')
    print(f'a1 = 0x{a1:016x}')
    print(f'p  = 0x{p:016x}')

    parameters = []
    print('Polynomial: ')
    parameters.append(get_number())
    parameters.append(get_number())
    print('phi: ')
    parameters.append(get_number())
    parameters.append(get_number())
    print('psi: ')
    parameters.append(get_number())
    parameters.append(get_number())
    print('const_phi: ')
    parameters.append(get_number())
    parameters.append(get_number())
    print('const_psi: ')
    parameters.append(get_number())
    parameters.append(get_number())

    print('Checking...')
    answer = sequence_from_parameters(n, b, c, a0, a1, p, parameters)
    correct = sequence(n, b, c, a0, a1, p)
    if answer != correct:
        print(f'Incorrect! Correct answer was 0x{correct:016x}')
        sys.exit(1)

print(open('flag.txt', 'r').read())
