# winterfactory

- Category: crypto
- Final point value: 588
- Number of solves: 8

A cryto challenge using the post quantum "Winternitz One-Time Signature" scheme. The same key is actually used on three different messages on this challenge (twice for signing and once for verifying), and we use this fact to generate a valid signature for a given message.

## Challenge description

This factory is perfect to buy your new number. Now you just have to sign the order.

## Winternitz OTS

We are provided with a [python script](./winterfactory.py) that uses the [winternitz](https://pypi.org/project/winternitz/) package. The code for this package is not that long (257 LOC + 263 lines of comments), so we can quickly read it. It is said in the code that it is an implementation of [this paper](https://eprint.iacr.org/2011/191.pdf). By reading the paper and the code, I understood how the signature scheme work, and I'll explain it here.

We want to sign a message `m`. We'll first get its hash `h` with any hash function `H` (in our case: SHA256), as with any other signature scheme. We will then choose a block size `w` (in our case : `2**16` bits), and decompose `h` in blocs of size `log2(w)`bits. We'll then generate one private key $p_i$ **for each block** $b_i$, the size of a private key being equal to the output size of the chosen hash function. From each of these private keys, we obtain a public key $P_i$ by hashing the private key `w` times ($P_i = H^{(w)}(p_i)$). Now, to sign our hash, we produce one signature for each block $b_i$, by taking this block as a `log2(w)`-bits unsigned integer (call it $v_i$), and hashing the private key $v_i$ times: $s_i = H^{(v_i)}(p_i)$. The authenticity of the block can then be verified by hashing its signature $w - v_i$ times, this should give the public key for this block: $H^{(w-v_i)}(s_i) = H^{(w-v_i)}(H^{(v_i)}(p_i)) = H^{(w)}(p_i) = P_i$.

Now, imagine you intercept a message and its signature, can you tamper with them? Yes! For example, you can increment the value $v_i$ of a given block, then obtain a new valid signature by hashing the former signature one more time! Okay, you can't actually do that, because the thing being signed is the hash of the message, so you can't just "increment the value of a block". BUT, you can find a completely different message, for which every block of the hash has a value $v_i'$ being greater than or equal to the corresponding $v_i$ the original message, and then compute a valid signature for this message by hashing the signature $v_i' - v_i$ times. We can observe here the importance of the choice of `w`: the higher `w` is, the easier it is to find hashes with higher block values than a given hash. But of course, if `w` is lower, we need to decompose our message into more blocks, which requires more keys and signatures.

To prevent this problem, some checksum blocks are signed along with the message. The checksum is computed by $c = \sum_i (w - v_i)$, so if the value of a block increase, the value of the checksum decrease. It is thus impossible to get a message such that all the hash blocks AND the checksum blocks are greater than the original message. The number of checksum blocks depends on `w` and on the length of the output of `H`, in our case there are 16 blocks of 16 bits for the hash, and 2 blocks for the checksum, the most significant checksum block being stored first. It seems now impossible to tamper with a message, **as long as the keys are used only once**.

## Exploiting the key reuse

In the code from the `winternitz` package, we can see that the private key of a `WOTS` object is initialized once during the first signature operation, but if we use the same object to sign several messages, the same private key will be reused.
In the vulnerable program, we are first **provided with a signature for one message**. Then we receive pairs of numbers, and we can either choose one of the two numbers and attempt to sign it, or discard the numbers and receive another pair. We can discard as many times as we want, but attempt to sign only once. If we attempt to sign, we first receive the signature of one block of the other number (`print(product_certification["signature"][-2].hex())`). This block is the penultimate one, which means that it is the most significant of the two signature blocks! So, we will be able to sign one of the numbers if and only if the following conditions are verified:
- every block of the hash of the number has a greater or equal value than the corresponding block in the signature we were given at the beginning
- the least significant block of the checksum has a greater or equal value than the same block in the signature that we possess
- the most significant block of the checksum has a greater or equal value than the same block in the other number (the one whose signature is being leaked)

And we can just discard the numbers until these conditions are all met.
Now we just have to [script this idea](./attack.py), using `pwntools` for the communication with the remote and reusing the functions from the `winternitz` package:

```shell
$ python3 attack.py REMOTE
[+] Opening connection to winterfactory-0.chals.kitctf.de on port 1337: Done
b'GPNCTF{1t_is_a_0n4_T1me_S1gnature_01856312904836215}'
[*] Closed connection to winterfactory-0.chals.kitctf.de port 1337
```