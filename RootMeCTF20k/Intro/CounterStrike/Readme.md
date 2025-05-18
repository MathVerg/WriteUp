# Counter Strike

- Category: Intro/Crypto
- Difficulty: Very Easy
- Number of solves: 37

For this challenge, we receive a [python script](./counter-strike.py) performing AES encryption in [CTR mode](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counter_(CTR)) with a random key and IV, and the [output](./output.txt) of this script. The vulnerability resides in the fact that the key and IV are exchanged when calling the encryption function:

```python
def encrypt_message(message:bytes) -> tuple[bytes, bytes, bytes]:
    ...
    return iv, key, ciphertext

if __name__ == "__main__":
    ...
    key, iv, ciphertext = encrypt_message(message)
    ...
```

So, what's called "iv" in the output is actually the key. Let's have a look at the CTR encryption scheme:
![](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/CTR_encryption_2.svg/1920px-CTR_encryption_2.svg.png)
The decryption scheme is exactly the same (also using AES **encryption** and not decryption), and in this block mode actually behaves as a stream cipher: a stream is obtained by encrypting the successive values of the IV (Nonce + Counter), and bot encryption and decryption are performed by XORing this stream with the message.

In our case we have the key and ciphertext, but we are missing the first value of the nonce and counter (aka the IV). Fortunately, we can recover them because we know the beginning of the plaintext: "The flag is: RM{", which is 16 characters, exactly the size of an AES block, what a coincidence!
So we can XOR this known plaintext with the first block of the ciphertext to recover the first "block of stream", then decrypt this block with the key to obtain the IV. We can then perform a normal CTR decryption of the whole message to get the flag. 

We implement this decryption in a [python script](./solve.py), then run it to get the flag:
```
$ python solve.py
b'The flag is: RM{Sorry_no_joke_about_CS_I_never_played_it_a5d643f5e664fcc71e072c71af130d33}'
```
