
import hashlib

DEBUG = False

N = 64
omega = CyclotomicField(N).gen()

def load_matrix(f):
    r = eval(f.readline().rstrip())
    return matrix(r, nrows=N, ncols=N)

with open("output.txt", "r") as f:
    Q = load_matrix(f)

    M1 = load_matrix(f)
    M2 = load_matrix(f)
    enc = bytes.fromhex(f.readline().strip())

U = matrix.vandermonde([omega**i for i in range(N)])

#print(list(U))

U_t = U.transpose()
U_star = U_t.conjugate()
U_conj = U.conjugate()

R = U_t*Q*U

A1 = U_t*M1*U

A2 = U_t*M2*U

T = matrix([[(A1[i][j] * A2[i][j]) / R[i][j] for j in range(N)] for i in range(N)])

S = (U_conj * T * U_star)/(N*N)

ss = hashlib.sha256(str(S).encode()).digest()

flag = bytes([x^^y for x, y in zip(enc, ss)])
print(flag)
