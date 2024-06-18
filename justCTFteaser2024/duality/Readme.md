# duality

- Category: crypto
- Final point value: 237
- Number of solves: 36
- Solved by: mouthon

A crypto chall where you had to create collisions on an improperly used HMAC.

## Reading the code

The challenge was made of a single [Python script](./polyhash.py). This script was expecting us to provide two messages and two nonces for which a custom MAC would collide, and to guess what one of the keys used in one of the HMACs was. If we manage to get a collision, we obtain an hint to guess the key.

The `compute_custom_mac` function does the following:
- compute a `poly_hash` of the message, seen as an array of numbers between 0 and P - 1 (P = 22193). This is done by evaluating a unitary polynomial whose coefficients are taken from the message on the secret value `key_2`
- compute a first HMAC, where nonce and `key_1` are inverted (nonce is used as key and key as message), this gives us `k_intermediary`
- compute a second HMAC with `k_intermediary` as key and the `poly_hash` as message, and return it as result

Both HMAC use the SHA256 hash function, for which it is not easy to find collisions.

## Colliding the first HMAC

For the first HMAC, our nonce is used as key:
```python
k_intermediary = hmac.new(nonce, self.key_1, hashlib.sha256).digest()
```

Reading the [Wikipedia page](https://en.wikipedia.org/wiki/HMAC) for HMAC, we see that if a key is larger than the hash function's block size (64 bytes in our case), the hash of the key is used instead of the key. So, we just set one nonce to a value that is large enough (this is actually already enforced in the server program), and set the other nonce to be the hash of the first one:
```python
nonce_1 = b"A"*128
nonce_2 = sha256(nonce_1).digest()
```
Adding a debug print, we see that this is enough to get a collision for `k_intermediary`

## Colliding the second HMAC and guessing the key

To collide the second HMAC, we want to collide `poly_hash`. There are only 22193 possible values for `key2`, and we can try as many times as we want, so we may very well just bruteforce `key2`, and use the knowledge of `key2` to collide the hash. For example we have $h(key2, [0]) = key2$ and for any $a$ and $b$, $h(key2, [a, b]) = key2^2 + a*key2 + b$. To obtain a collision, we must make these two terms equal. This can be achieved by taking $a=1$ and $b = -key2^2$.

This works very well locally, we get our fake hint and fake flag. The remote has a time limit of approximately 2 minutes, so we need to make batches of requests in order to be able to bruteforce the 22193 possibilities. With some trial and error, we find that batches of 100 requests with no processing of the output (just write them in a log file / on stdout as they arrive) works. We thus get a link to a research paper as a hint, but we also receive the flag anyway, so no need to read it ^^. It turned out that the paper may have been used to reduce the amount of bruteforce required to 5000 or so. Full exploit can be found [here](./exploit.py)
