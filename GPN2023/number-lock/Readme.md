# number-lock

- Category: crypto
- Final point value: 714
- Number of solves: 5

A classical Differential Fault Attack (DFA) on AES. I never had the occasion to study fault attacks before, this one was a great introduction to the topic!

NB: this write-up assumes that the reader is familiar with the inner working of AES. If it is not the case, I can recommend you to have a look at [CryptoHack](https://cryptohack.org/challenges/aes/).

## Challenge description

You're almost in the inside to steal the precious koeri recipe, just a door in your way. But it expects a specific number. Maybe a punch in the correct spot will help you?

## Reconnaissance

We are given a [python program](./number_lock.py), that contains a [classical implementation of AES](https://github.com/bozhu/AES-Python), but with a few changes:
- an additional function, `sub_bytes_defect`, that replace one (randomly chosen) S_box lookup by a random byte
- this function is being called on some rounds of the encryption process, which are called "broken_rounds"

When we launch the program, an AES 128 cipher is initialized with a random 16 byteskey. We can interact 40 times with the program, and perform one of the following actions:
- permanently break one of the 10 AES rounds
- encrypt a given plaintext
- answer a challenge by giving the ciphertext corresponding to a given random plaintext. This one can be done only once, and we receive the flag if we pass the challenge

I found a [similar challenge](https://www.root-me.org/en/Challenges/Cryptanalysis/AES-Fault-attack-1) on Root-me, and a very interesting [article](https://blog.quarkslab.com/differential-fault-analysis-on-white-box-aes-implementations.html) was linked in the related resources.

## DFA on AES-128

Here are the key insights of this attack:
- we inject a fault in the S-box from the 9th round of AES (between the last-but-one and the last MixColumns operations)
- this fault will be propagated to exactly 4 bytes of the state at the end, because ShiftRows, AddRoundKey and SubBytes just change the value of the fault or move it around, MixColumns is the only operation that operates diffusion
- we get pairs of faulty and non-faulty ciphertexts for the same plaintext, and can reduce the search key space for the last round key by comparing them
- if we are lucky, we need only 8 pairs to recover the last round key (2 pairs for each of the 4 sets of 4 bytes in the state)
- the expansion key process being reversible, we can recover the master key from the last round key

In our case we have 40 interactions, we'll use them as follows:
- get the ciphertext corresponding to 19 random plaintexts
- break the S-box in the 9th round
- get 19 faulty ciphertexts for the same plaintexts as before
- use the recovered key to solve the challenge

Ok, but how do we actually obtain information by comparing the faulty and non-faulty ciphertexts? To explain it I'll reuse the formulas and the explanations from the aforementioned [article](https://blog.quarkslab.com/differential-fault-analysis-on-white-box-aes-implementations.html), which I highly recommend you to read.

Assume we injected a fault in the 9th round S-box, after a ShiftRows the authentic and faulty states look like this:
```math
\begin{equation*} \begin{pmatrix} A & E & I & M \\ B & F & J & N \\ C & G & K & O \\ D & H & L & P \end{pmatrix} \text{and} \begin{pmatrix} X & E & I & M \\ B & F & J & N \\ C & G & K & O \\ D & H & L & P \end{pmatrix} \end{equation*}
```

If we now apply the reamining operations (MixColumns, AddRoundKey K9, SubBytes, ShiftRows, AddRoundKey K10), we obtain the following states, with $S$ being the S-box (see the original article for the intermediate steps):

```math
\begin{equation*} \begin{pmatrix} S(2A+3B+C+D+K_{9,0})+K_{10,0} \qquad \cdots \qquad \cdots \qquad \cdots \\ \cdots \qquad \cdots \qquad \cdots \qquad S(A+2B+3C+D+K_{9,1})+K_{10,13}\\ \cdots \qquad \cdots \qquad S(A+B+2C+3D+K_{9,2})+K_{10,10} \qquad \cdots \\ \cdots \qquad S(3A+B+C+2D+K_{9,3})+K_{10,7} \qquad \cdots \qquad \cdots \end{pmatrix} \text{and} \begin{pmatrix} S(2X+3B+C+D+K_{9,0})+K_{10,0} \qquad \cdots \qquad \cdots \qquad \cdots \\ \cdots \qquad \cdots \qquad \cdots \qquad S(X+2B+3C+D+K_{9,1})+K_{10,13}\\ \cdots \qquad \cdots \qquad S(X+B+2C+3D+K_{9,2})+K_{10,10} \qquad \cdots \\ \cdots \qquad S(3X+B+C+2D+K_{9,3})+K_{10,7} \qquad \cdots \qquad \cdots \end{pmatrix} \end{equation*}
```

The multiplications and additions are done in the AES Galois Field, so the addition is just a XOR. Now, if we add the first output byte of the authentic and faulty ciphertext, the bytes of the last round key cancel each other, and we obtain

```math
\begin{equation*} O_0 + O'_0 = S(2A+3B+C+D+K_{9,0}) + S(2X+3B+C+D+K_{9,0}) \end{equation*}```

If we pose:
```math
\begin{equation*} Y_0=2A+3B+C+D+K_{9,0} \end{equation*}
\begin{equation*} Z=A+X \end{equation*}
```

This becomes:
```math
\begin{equation*} O_0 + O'_0 = S(Y_0) + S(2Z+Y_0) \end{equation*} 
```

We obtain similar equations from the three other impacted bytes, with the same $Z$ and a different $Y_i$. These equations can only be satisfied simultaneously for some values of $Z$, and for each value of $Z$ we obtain a set of possible values for the $Y_i$, which gives us some possible values for the $K_{10, i}$, because $O_0 = S(Y_0)+K_{10,0}$ (for instance). If we get another pair with the same set of 4 modified bytes in the final set, we can correlate the sets of values for the $K_{10, i}$ to eliminate some of them. In practice, with two pairs we most of the time can recover the exact value of the  $K_{10, i}$.

In our case we don't know exactly where the fault is injected. We see four modified bytes in the end, but that leaves us with four possible locations for the injected fault: we just have to try the four hypotheses, and recover the candidate sets for the $K_{10, i}$ that correspond to these hypotheses.

## Implementation

This attack is implemented [here](./attack.py), using `pwntools` for the communication with the server, and reusing the AES implementation from the challenge script when needed. Some explanations:
- `inv_key_sched`: recovers the AES master key from the last round key, written thanks to [Wikipedia](https://en.wikipedia.org/wiki/AES_key_schedule)
- `COEFF_FOR_Z`: the coefficients to use in the equations for the four hypotheses for each set of four touched bytes
- `TOUCHED_SETS`: the 4 sets of 4 indexes at which the authentic and faulty ciphertext may differ
- `gmul`: multiplication in the AES Galois Field, implemented only for 1, 2 and 3 because they are the only values that we need in this attack
- `combine correlated`: takes two lists as input, each containing 4 sets of possible values for some $K_{10, i}$ (for instance, for $K_{10, 0}$, $K_{10, 7}$, $K_{10, 10}$ and $K_{10, 13}$), returns a new list of similar structure that result from the combination (intersection) of these sets if they are all non-empty, else None
- the main code then analysis each ciphertext pair, finds the four differing bytes, then compute the possible values of the $K_{10, i}$ for the 4 possible initially affected bytes ($l$), and for all the values of $Z$ that satisfies the four equations simultaneously. The obtained sets are then correlated with the sets that were already found for this differing bytes
- we finally recover the last round key by assuming that we have only one candidate for each byte (this does not work all the times, sometimes a small bruteforce may be necessary, but we can just restart the attack if it is the case), then inverse the key schedule to recover the master key and solve the challenge.

```shell
$ python3 attack.py REMOTE
[+] Opening connection to number-lock-0.chals.kitctf.de on port 1337: Done
[[[{230}, {32}, {120}, {154}]], [[{76}, {175}, {121}, {16}]], [[{192}, {44}, {178}, {134}]], [[{44}, {240}, {82}, {71}]]]
[230, 76, 192, 44, 175, 44, 240, 32, 178, 82, 120, 121, 71, 154, 16, 134]
b'\xe6L\xc0,\xaf,\xf0 \xb2RxyG\x9a\x10\x86'
b'GPNCTF{D0n4_l3t_4hem_h14_y0ur_Hardware_01298356123521}\n'
[*] Closed connection to number-lock-0.chals.kitctf.de port 1337
```