# MathGolf-Warmup

- Category: crypto
- Final point value: 347
- Number of solves: 32

A second order [constant-recursive sequence](https://en.wikipedia.org/wiki/Constant-recursive_sequence) (Fibonacci-like), but in $GF(p)$. You had to compute the eigenvalues of the sequence and send them to the server, who would then use them to compute the $n$-th term of the sequence. This challenge was a Warmup for the actual "MathGolf" challenge, where you had to provide x86_64 machine code that would compute the eigenvalues using only registers (no memory)... Only two teams solved the actual challenge, and I was unfortunately not in one of them ^^'.

This write-up assumes that the reader has some knowledge of modular arithmetic and finite fields. Such knowledge can for instance be acquired [here](https://cryptohack.org/courses/modular). It also assumes some knowledge of linear algebra, which you can find in a Mathematics Bachelor textbook, or on Wikipedia.

## Challenge description

> I wanted to calculate this sequence, but my first implemenation was a bit slow. Can you find me a nice formula for it?

> `nc mathgolf.chal-kalmarc.tf 3470`

We were given a handout containing some Docker files, and the [challenge](./chal-warmup.py) file.

## Reconaissance

The challenge file is generating 100 "problems" that we have to solve. These problems consist in a 64 bits prime number $p$, a number of iterations $n$ and four elements of $GF(p)$: $b$, $c$, $a_0$ and $a_1$. The `sequence_slow` function uses these parameters to compute, in a very inefficient way, the $n$-th term of the [constant-recursive sequence](https://en.wikipedia.org/wiki/Constant-recursive_sequence) defined by
```math
u_0 = a_0, ~u_1 = a_1, \forall n \geq 0~u_{n+2} = b u_{n+1} + c u_n
```
The code in `sequence_slow` is a direct implementation of this formula, but has exponential complexity. To compute $u_{n+2}$, it will compute $u_{n+1}$ and $u_n$, but will then compute $u_n$ again in the computation of $u_{n+1}$, and so on. So we'll probably have to compute it more efficiently. But the program does not ask us for the $n$-th term, rather for some parameters: a polynomial `poly`, then some $\phi$ and $\psi$, and associated constants $C_\phi$ and $C_\psi$. And they all seem to be made of two numbers, not one. In `sequence_from_parameters`, we can see how they are used: `poly` is used as a modulus to construct $GF(p^2)$, and the $n$-th term of the sequence is computed with the following formula:
```math
u_n = \phi^n \times C_\phi - \psi^n \times C_\psi
```
Where does this formula come from? We'll see that by forgetting the additional difficulty brought by the finite field for a moment, and consider a classical constant-recurring sequence of integers.


## Example: the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence)

The most famous constant-recursive sequence is defined by
```math
F_0=0, ~F_1 =1, ~\forall n \geq 0, F_{n+2} = F_{n+1} + F_n
```
It means that every term is the sum of the two previous ones. It then goes like 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...
We can represent it as a matrix relation:
```math
\left ( \begin{matrix} F_{n+2} \\ F_{n+1} \end{matrix} \right)
=
\left ( \begin{matrix} 1 & 1 \\ 1 & 0 \end{matrix}\right )
\left ( \begin{matrix} F_{n+1} \\ F_{n} \end{matrix} \right)
=  M \left ( \begin{matrix} F_{n+1} \\ F_{n} \end{matrix} \right)
```
Computing successive terms of the sequence corresponds to multiplying several times on the left by the matrix, so a general expression of $F_n$ can be obtained:
```math
\left ( \begin{matrix} F_{n+1} \\ F_{n} \end{matrix} \right)
=
M^n
\left ( \begin{matrix} F_1 \\ F_0 \end{matrix} \right)
```
This already gives us a much more efficient way to compute the $n$-th term of the sequence, in linear complexity, or even logarithmic complexity if we use [Square and multiply](https://en.wikipedia.org/wiki/Exponentiation_by_squaring). But there is still an annoying constant factor coming from to the matrix product, and we can do better by [diagonalizing](https://en.wikipedia.org/wiki/Diagonalizable_matrix) $M$.

To do so, we first need to compute its [characteristic polynomial](https://en.wikipedia.org/wiki/Characteristic_polynomial):
```math
p_M(X) = det(XI_2-M) = det \left ( \begin{matrix} X - 1 & -1 \\ -1 & X \end{matrix}\right ) = (X-1)X - (-1)\times(-1) = X^2-X-1
```
The [eigenvalues](https://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors) of $M$ are the roots of this polynomial, so let's first compute it's discriminant:
```math
\Delta = (-1)^2 - 4\times 1 \times (-1) = 5
```
$\Delta > 0$, so this polynomial has two real roots, and $M$ is thus diagonalizable. The roots are $\phi = \frac{1 + \sqrt{\Delta}}{2}$ and $\psi = \frac{1 - \sqrt{\Delta}}{2}$. Note that $\phi$ is known as the [Golden ratio](https://en.wikipedia.org/wiki/Golden_ratio).

We can then search for the eigenvectors:
```math
M \left (\begin{matrix} x \\ y \end{matrix} \right) = \phi \left (\begin{matrix} x \\ y \end{matrix} \right)  \iff  x + y= \phi x ,~x=\phi y \iff \phi^2y-\phi y-y=0, ~x=\phi y
```
We can identify the characteristic polynomial there, and thus take $x=\phi,y=1$. Similarly, an eigenvector for $\psi$ is $`\left(\begin{matrix} \psi \\ 1 \end{matrix} \right)`$.

If we then constitute a matrix $`P = \left (\begin{matrix} \phi & \psi \\ 1 &1 \end{matrix} \right)`$ with these vectors, the magic of linear algebra tells us that $M = PDP^{-1}$, with $`D = \left (\begin{matrix} \phi & 0 \\ 0 & \psi \end{matrix} \right)`$. Let's verify this:
```math
P^{-1} = \left (\begin{matrix} \phi & \psi \\ 1 &1 \end{matrix} \right)^{-1} = \frac{1}{\phi - \psi}\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right) = \frac{1}{\sqrt{\Delta}}\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)
```
```math
PDP^{-1} = \left (\begin{matrix} \phi & \psi \\ 1 &1 \end{matrix} \right)
\left (\begin{matrix} \phi & 0 \\ 0 & \psi \end{matrix} \right)P^{-1}
= \left (\begin{matrix} \phi^2 & \psi ^ 2 \\ \phi & \psi \end{matrix} \right)
\frac{1}{\sqrt{\Delta}}\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)
\\
= \frac{1}{\sqrt{\Delta}}\left (\begin{matrix} \phi^2 - \psi^2 & \phi(\psi + 1) - \psi(\phi + 1) \\ \phi - \psi & \phi\psi - \psi\phi \end{matrix} \right)= M
```
Where we used the fact that $\phi^2 = \phi + 1$ and $\psi^2 = \psi+ 1$, since they are root of the $X^2-X-1$ polynomial.
So, we have a diagonalization of $M$. How does it help? Well, remember that we wanted to compute $M^n$ efficiently, and it turns out that using this relation, the consecutive $P$ and $P^{-1}$ cancel eachother
```math
M^2 = MM = PDP^{-1}PDP{-1} = PDI_2DP^{-1} = PDDP^{-1} = PD^2P^{-1}
```
And $D$ being diagonal, it is very easy to compute $D^n$! So our matrix realtion for the Fibonacci sequence becomes
```math
\left ( \begin{matrix} F_{n+1} \\ F_{n} \end{matrix} \right)
=
P
\left (\begin{matrix} \phi^n & 0 \\ 0 & \psi^n \end{matrix} \right)
P^{-1}
\left ( \begin{matrix} F_1 \\ F_0 \end{matrix} \right)
```
Developing this product, we get:
```math
\left ( \begin{matrix} F_{n+1} \\ F_{n} \end{matrix} \right)
=\frac{1}{\sqrt{5}}PD^n
\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)
\left ( \begin{matrix} 1 \\ 0 \end{matrix} \right)
= \frac{1}{\sqrt{5}}P\left (\begin{matrix} \phi^n & 0 \\ 0 & \psi^n \end{matrix} \right)
\left ( \begin{matrix} 1 \\ -1 \end{matrix} \right)
= \frac{1}{\sqrt{5}}\left (\begin{matrix} \phi & \psi \\ 1 &1 \end{matrix} \right)\left ( \begin{matrix} \phi^n \\ -\psi^n \end{matrix} \right)
```

We can thus obtain the following formula for $F_n$:
```math
F_n = \frac {1}{\sqrt{\Delta}} \phi^n - \frac {1}{\sqrt{\Delta}} \psi^n =  \frac {1}{\sqrt{5}} \left ( \frac{1 + \sqrt{5}}{2}\right)^n - \frac {1}{\sqrt{5}} \left ( \frac{1 - \sqrt{5}}{2}\right)^n
```
Note that this formula contains the irrational number $\sqrt{5}$, but every term of the Fibonacci sequence is an integer!

## Solving MathGolf-Warmup

Now that we know how to get a general expression of the Fibonacci sequence, we can apply the same principle to our problem in $GF(p)$. We can write
```math
\left ( \begin{matrix} u_{n+1} \\ u_{n} \end{matrix} \right)
=
\left ( \begin{matrix} b & c \\ 1 & 0 \end{matrix}\right )^n
\left ( \begin{matrix} a_1 \\ a_0 \end{matrix} \right)
```
And to get an expression with the right form ($u_n = \phi^n \times C_\phi - \psi^n \times C_\psi$), we must simply diagonalize $M$ to find $\phi$, $\psi$ and the associated constants. But what is `poly` doing here? And why do we have two numbers for each parameters?

Well, it turns out that we were quite lucky to have a positive discriminant $\Delta$ for the characteristic polynomial. But what can we do if $\Delta$ is negative? For example, if $\Delta = -1$? Since the polynomial $X^2+1$ has no roots real roots, we need to extend $\mathbb{R}$ to $\mathbb{C}$, which is, by definition, $\mathbb{R}$ where we added a root of $X^2+1$, and named it $i$. And then we can find two distincts eigenvalues for our matrix again. So, every element of $\mathbb{C}$ can actually be seen as a polynomial in $i$ of degree 1, and a polynomial in $i$ of any degree can be reduced into a complex number by doing a polynomial division it by $i^2 + 1$, i.e. by applying the rule $i^2 := -1$. Hence, we can understand that $\mathbb{C}$ is equivalent to the polynomial ring of $\mathbb{R}$ modulo the irreductible polynomial $X^2 +1$. And the same thing happens in $GF(p)$: the characteristic polynomial of $M$ may have no root in $GF(p)$, in which case we must extend $GF(p)$ to $GF(p^2)$. This explains why we need to provide a polynomial, and why all the parameters have two components: they are the coefficient of a degree 1 polynomial, or a real and an imaginary part, if you prefer.

So, do we have to implement all this process for $GF(p)$ in Python? Not really, we can just be lazy and let Sage do it for us:
```python
def solve_sage(b, c, a0, a1, p):
    Fp = sage.all.GF(p)
    RFp = sage.all.PolynomialRing(Fp, ['t'])
    F = sage.all.GF(p**2, name='t')
    #sage finds a modulus for us
    poly = F.modulus()
    M = sage.all.matrix([[F(b), F(c)], [F(1), F(0)]])
    D, P = M.diagonalization()
    #M = PDP^(-1)
    phi = D[0][0]
    psi = D[1][1]
    (x, y) = P.inverse()*sage.all.vector([F(a1), F(a0)])
    const_phi = P[1][0] * x
    const_psi = -P[1][1] * y
    return (poly, phi, psi, const_phi, const_psi)
```

This [code](./solve-warmup.py) worked and gave me a flag on the first try, I was quite proud of myself (or at least, quite proud of Sage).

## Towards the real MathGolf

The real [MathGolf challenge](./chal.py) uses the same problem, but instead of asking us for the parameters of the general formula, asks us for a x86_64 machine code which, emulated by unicorn without any memory, should compute them. This seemed to be a very painful thing to do. So I decided to try. But did not get very far in the implementation, because I did not know how to properly compute the product of two 64-bits number and reduce it modulo $p$. I spent however some time with a pen a paper, and tried to make the formula as simple as possible, so that we do not have to implement the whole Sage library in assembly, and I think it may be interesting enough to share. In this section, all computations are implicitely in $GF(p)$, unless stated otherwise.

So, let's see how we can simplify that. We have $`M = \left( \begin{matrix} b & c \\ 1 & 0 \end{matrix}\right )`$, its characteristic polynomial is
```math
p_M(X) = det(XI_2-M) = det \left ( \begin{matrix} X - b & -c \\ -1 & X \end{matrix}\right ) = X^2 - bX-c
```
It's discriminant is $\Delta = b^2+4c$. Now, the great question: does it have a square root in $GF(p)$? To answer this question, we must compute it's [Legendre symbol](https://en.wikipedia.org/wiki/Legendre_symbol), $\Delta^{\frac{p-1}2}$. This symboles equals $0$ if $\Delta = 0$, $1$ if it has a square root (we say that $\Delta$ is a [quadratic residue](https://en.wikipedia.org/wiki/Quadratic_residue) modulo $p$), and $-1$ if it does not have a square root. We did not observe any case where $\Delta = 0$ in this challenge, we treat separetely the two other cases.

### $\Delta$ is a quadratic residue

Then $\sqrt{\Delta}$ exists in $GF(p)$. If $p = 3 ~mod ~4$, this modular square root can be computed with $\sqrt{x} = x^{\frac{p+1}{4}}$. Else, we can use the [Tonelli-Shanks algorithm](https://en.wikipedia.org/wiki/Tonelli%E2%80%93Shanks_algorithm) to compute it. All following computations can be done in $GF(p)$, so we do not need to use $GF(p^2)$, and the imaginary part of all the values we are returning will be $0$. We must still provide a polynomial that is valid as a modulus, i.e. we ned to find an irreducible polynomial in $GF(p)$. Since only one half of the elements of $GF(p)$ are quadratic residues, we can just start with $z=2$, and increment $z$ until its Legendre symbol is $-1$, then take $X^2 - z$ as a polynomial.

The eigenvalues will then be $`\phi = \left(b+\sqrt{\Delta}\right)2^{-1}`$ and $`\psi = \left(b-\sqrt{\Delta}\right)2^{-1}`$. Most of the computations we did for Fibonacci are still valid here, we still have $`P = \left (\begin{matrix} \phi & \psi \\ 1 &1 \end{matrix} \right)`$ and $`P^{-1} = \sqrt{\Delta}^{-1}\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)`$. We can then develop the matrix product, and we find that $C_\phi =  (a_1 - a_0\psi)\sqrt{\Delta}^{-1}$ and $C_\psi = (a_1 - a_0\phi )\sqrt{\Delta}^{-1}$.


### $\Delta$ is not a quadratic residue

This case is actually even simpler than the previous one, because we do not even have to compute a modular square root. We just need to take $X^2 - \Delta$ as a modulus polynomial for $GF(p^2)$. If we name $t$ the variable, as done in the challenge, we thus have $t^2 = \Delta$, and $t^{-1} = tt^{-2} = t\Delta^{-1}$. We can reuse the formulas from the previous part, replacing $\sqrt{\Delta}$ by $t$: $\phi = b 2 ^{-1} + 2^{-1}t = [b 2 ^{-1}, 2^{-1}]$ and $\psi = b 2 ^{-1} - 2^{-1}t $. $P$ stays the same, and $`P^{-1} = t^{-1}\left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)= t \Delta^{-1} \left (\begin{matrix} 1 & -\psi \\ -1 &\phi \end{matrix} \right)`$.
We must just be careful when developing the formulas of the constants, because some $t$ may cancel each other. We obtain
```math
C_\phi = a_02^{-1} + (a_1 - a_0b2^{-1})\Delta^{-1}t ~~, ~~
C_\psi = -a_02^{-1} + (a_1 - a_0b2^{-1})\Delta^{-1}t
```

## Conclusion

I implemented these formulas in Python, and was thus able to solve the Warmup chall again without using Sage, cf `solve_manual` in the [solve script](./solve-warmup.py). I used the built-in `pow` function of Python and `Crypto.Util.number.inverse`, but they can be implemented easily using Square-and-Multiply and Extended Euclid's Algorithm respectively. This is left as an exercise to the reader (TM). So there was actually no need to implement operations in $GF(p^2)$ nor matrix multiplications. I was unfortunately not able to implement the operations in $GF(p)$ in assembly, but it was nice to do some math again. Thanks for the chall!
