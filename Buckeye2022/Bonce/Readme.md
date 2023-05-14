# Bonce

- Category: crypto
- Difficulty: easy
- Final point value: 142
- Number of solves: 97

A crypto challenge using somehow highly predictable "nonces"

## Challenge description

nonce without a cipher
Associated files: [bonce.py](./bonce.py), [output.txt](./output.txt)

## Analyzing the ciphering process

The ciphering script takes a sample text, randomly inserts a line with the flag in it, then add some more lines of the sample text to it. Then comes the actual "cipher": each line is encrypted by being xored with a "nonce" that is just the index of the line in the text. The result is then written to the output file.

## Implementing the deciphering process

We implement the deciphering [here](./decode.py). We just read every line, try to convert it back to bytes (some lines were malformed, we just skipped them), then xor it back with the index of the line. The flag can be found among all the lines of plaintext: `buckeye{some_say_somefish:)}`.
