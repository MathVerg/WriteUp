# MIKE

- Category: crypto
- Final point value: 244
- Number of solves: 12

A crypto challenge using [circulant matrices](https://en.wikipedia.org/wiki/Circulant_matrix) to perform a Key Exchange. The solution that we found uses actually weaker assumptions than the one provided by the challenge, which leads us to think that we have found a somehow unintended solve. In this write-up, we assume that the reader is familiar with the [Diffie-Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange).

## Challenge description

Meet my new friend Mike, a non Interactive Key Exchange from Matrices!
Associated files: [MIKE.sage](./MIKE.sage), [output.txt](./output.txt)

## Analyzing the Key Exchange

Reading the [MIKE.sage](./MIKE.sage) file, we can draw a list of all the parameters being used in this key exchange. All of them are square matrices of size `N=64`
- `B`: a random matrix, only used to generate Q as a symmetric random matrix
- `Q` (*public*): a symmetric random matrix, used as the "public generator" in the key exchange. Our solution **does not use the fact that it is symmetric** though.
- `U1` and `U2`: two *private* circulant matrices, supposed to be each owned by one participant of the key exchange. They are generated using a weird process involving cyclotomic polynomials, but **in our solution, we only use the fact that they are circulant**, which makes our solution more generic.
- `M1` and `M2`: the *public* matrices generated from `U1` and `U2`, using $M_k = U_k^{\textsf{T}} Q U_k$
- `S1` and `S2` are the recomputed shared secret, they should be equal (we will prove this later): $S_1 = U_1^{\textsf{T}} M_2 U_1 = U_1^{\textsf{T}} U_2^{\textsf{T}} Q U_2 U_1$

The hash of the shared secret is then XORed with the flag.

## Circulant matrices

Let's read a bit about circulant matrices on [Wikipedia](https://en.wikipedia.org/wiki/Circulant_matrix). They seem to have very interesting property, notably they are closely related to the [Discrete Fourier Transform](https://en.wikipedia.org/wiki/Discrete_Fourier_transform#The_unitary_DFT), they can all be expressed as a polynomial of a given cyclic permutation matrix, and are thus all diagonalizable in the same basis. The basis change can be operated using the matrix $ U={\frac {1}{\sqrt {n}}}{\begin{pmatrix}1&1&\dots &1\\1&\omega &\dots &\omega ^{n-1}\\\vdots &\vdots &&\vdots \\1&\omega ^{n-1}&\dots &\omega ^{(n-1)^{2}}\end{pmatrix}}$ where $\omega =e^{\frac {2i\pi }{n}}$ is the primitive $n$-th root of unity. Note that $U$ is [unitary](https://en.wikipedia.org/wiki/Unitary_matrix), which means that its inverse is its conjugate transpose: $U^{-1} = U^*$.

## Diagonalizing

Now that we know that `U1` and `U2` are diagonalizable in the same basis, we can operate the basis change. We have
$$M_k = U_k^{\textsf{T}} Q U_k = (UD_kU^*)^{\textsf{T}} Q UD_kU^* = \overline{U}D_kU^{\textsf{T}}QUD_kU^*$$
Where $D_k$ is diagonal. Let $R = U^{\textsf{T}}QU$, we then have
$$A_k = U^{\textsf{T}}M_kU = D_k R D_k$$

and this is very interesting, because we know $R$, and since $D_k$ is diagonal, we have
$$(A_k)_{i, j} = (D_k)_{i,i} (R)_{i,j}(D_k)_{j, j}$$

We can then easily compute $T = D_1D_2RD_2D_1$ by 

$$(T)_{i, j} = (D_1)_{i,i}(D_2)_{i,i} (R)_{i,j}(D_2)_{j, j}(D_1)_{j, j} = ((A_1)_{i, j} (A_2)_{i, j})/(R)_{i,j} $$

And then we have

$$\overline{U}TU^* = \overline{U}D_1U^{\textsf{T}}\overline{U}D_2U^{\textsf{T}}QUD_2U^*UD_1U^* = U_1^{\textsf{T}} U_2^{\textsf{T}} Q U_2 U_1 = S_1$$

And since $D_1$ and $D_2$ are diagonal, they commute, and we also have $T = S_2$, which proved that we indeed have a common shared secret. Now, we managed to find a way to recover this shared secret from the public parameters

## Implementation

Being not familiar with sage, I first tried to implement this using `numpy`.But the number were too big for the complex/float precision, and it didn't work. So I changed my mind and did it with sage, which was a good thing because it allowed me to learn a bit how to use it. Especially, while reading the sage documentation I found that sage can work directly with [cyclotomic fields](https://doc.sagemath.org/html/en/reference/number_fields/sage/rings/number_field/number_field.html#sage.rings.number_field.number_field.CyclotomicFieldFactory), and thus do exact computation when manipulating our roots of unit. The implementation can be found [here](./solve.sage), it uses the same notations as this write-up, except for $U$, which I choose to not normalize by $\sqrt{N}$ to speed up computation. The normalization is then postponed to the end, in the computation of $S$. On my personal computer which is already getting a bit old (Intel Core i5 7th gen, 8GB of RAM), this script gives us the solution in a bit more than one minute:
```shell
$ time sage solve.sage
b'ptm{1s_7h15_l1n34r_0r_qu4dr4t1c}'

real    1m10,921s
user    1m9,955s
sys     0m0,494s
```

## Conclusion

A very interesting challenge, which made me go back to my older linear algebra courses and taught me a bit how to use Sage. I am quite happy to have found a solution that works with weaker assumptions than the one of the original problem, with a very good runtime.