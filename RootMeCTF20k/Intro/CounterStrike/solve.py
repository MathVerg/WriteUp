from Crypto.Cipher import AES
from pwn import xor

#there is a confusion between key and IV, so what's called "iv" in the output is actually the key

KEY = bytes.fromhex("42cd148996262a187191ac166d273e1b")
CIPHERTEXT = bytes.fromhex("2b2e67563605fca991a402363a3b843fd8ea7b684a741c6828b2df85830f4a78ec18012fb64fa4cededb011efcaf3a087984dae673e300d94f6054f9d9cfc13ea7a5518745ba5641deb49d4041dac278302c2f611b44565eba28")
KNOWN_PLAIN = b"The flag is: RM{"

assert len(KEY) == 16
assert len(KNOWN_PLAIN) == 16
assert len(CIPHERTEXT) > 16

ecb = AES.new(KEY, AES.MODE_ECB)
iv = ecb.decrypt(xor(CIPHERTEXT[:16], KNOWN_PLAIN))
cipher = AES.new(KEY, AES.MODE_CTR, nonce=iv[:12], initial_value=iv[12:])
plain = cipher.decrypt(CIPHERTEXT)
print(plain)