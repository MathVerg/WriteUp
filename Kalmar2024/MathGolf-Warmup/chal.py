#!/usr/bin/env python3

# MathGolf challenge by shalaamum for KalmarCTF 2024

import signal
import sys
import time
import sage.all

from unicorn import Uc, UcError, UC_ARCH_X86, UC_MODE_64, UC_PROT_READ, UC_PROT_EXEC, UC_SECOND_SCALE, UC_HOOK_CODE
from unicorn.x86_const import UC_X86_REG_RAX, UC_X86_REG_RBX, UC_X86_REG_RCX, UC_X86_REG_RDX, UC_X86_REG_RSI, UC_X86_REG_RDI, UC_X86_REG_R8, UC_X86_REG_R9, UC_X86_REG_R10, UC_X86_REG_R11, UC_X86_REG_R12, UC_X86_REG_R13, UC_X86_REG_R14, UC_X86_REG_R15, UC_X86_REG_RIP

MAP_ADDR = 0x1000

FLAG_MAX_INSTRUCTIONS = 350_000
FLAG_MAX_LENGTH = 900

def instruction_counter(uc, address, size, user_data):
    user_data['count'] += 1


def run(code, b, c, a0, a1, p, verbose=False):
    instruction_count = {'count': 0}
    
    mu = Uc(UC_ARCH_X86, UC_MODE_64)
    try:
        mu.mem_map(MAP_ADDR, 4096+(len(code)//4096)*4096, UC_PROT_READ|UC_PROT_EXEC)
        mu.mem_write(MAP_ADDR, code)

        mu.reg_write(UC_X86_REG_RBX, b)
        mu.reg_write(UC_X86_REG_RCX, c)
        mu.reg_write(UC_X86_REG_RDX, a0)
        mu.reg_write(UC_X86_REG_RSI, a1)
        mu.reg_write(UC_X86_REG_RDI, p)

        # Set up instruction hook to count instructions
        mu.hook_add(UC_HOOK_CODE, instruction_counter, user_data=instruction_count)
        
        # Run code
        mu.emu_start(MAP_ADDR, MAP_ADDR + len(code), timeout=UC_SECOND_SCALE*10, count=FLAG_MAX_INSTRUCTIONS)
        
        # Read the result from the register
        REGISTERS_RESULT = (
                UC_X86_REG_RAX,
                UC_X86_REG_RBX,
                UC_X86_REG_R8,
                UC_X86_REG_R9,
                UC_X86_REG_R10,
                UC_X86_REG_R11,
                UC_X86_REG_R12,
                UC_X86_REG_R13,
                UC_X86_REG_R14,
                UC_X86_REG_R15,
                )
        result = list(mu.reg_read(reg) for reg in REGISTERS_RESULT)
    except UcError as e:
        if verbose:
            print("ERROR: %s at 0x%x" % (e, mu.reg_read(UC_X86_REG_RIP)))
        result = None
        sys.exit(1)

    # Return result and the number of instructions executed
    return result, instruction_count['count']



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


print('Please provide your code: ', end='', flush=True)
code = bytes.fromhex(input())

total_instructions = 0
for i in range(100):
    print(f'Solved {i} of 100')
    n, b, c, a0, a1, p  = generator.get()
    print(f'n  = 0x{n:016x}')
    print(f'b  = 0x{b:016x}')
    print(f'c  = 0x{c:016x}')
    print(f'a0 = 0x{a0:016x}')
    print(f'a1 = 0x{a1:016x}')
    print(f'p  = 0x{p:016x}')
    parameters, instructions = run(code, b, c, a0, a1, p)
    print(f'Took: {instructions} instructions')
    total_instructions += instructions
    answer = sequence_from_parameters(n, b, c, a0, a1, p, parameters)
    correct = sequence_fast(n, b, c, a0, a1, p)
    if answer != correct:
        print(f'Incorrect! Correct answer was 0x{correct:016x}, but code returned 0x{answer:016x}')
        sys.exit(1)

print(f'Total instructions: {total_instructions}')
print(f'Code length: {len(code)}')
if total_instructions < FLAG_MAX_INSTRUCTIONS and len(code) < FLAG_MAX_LENGTH:
    print(open('flag.txt', 'r').read())
else:
    print('Some improvement is still possible...')

