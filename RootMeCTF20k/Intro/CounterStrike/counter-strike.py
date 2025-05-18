from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes


def encrypt_message(message:bytes) -> tuple[bytes, bytes, bytes]:
    key = get_random_bytes(16)
    iv = get_random_bytes(16)
    cipher = AES.new(key, AES.MODE_CTR, nonce=iv[:12], initial_value=iv[12:])
    ciphertext = cipher.encrypt(message)
    return iv, key, ciphertext

if __name__ == "__main__":
    message = b"The flag is: RM{REDACTED}"
    key, iv, ciphertext = encrypt_message(message)
    print(f"iv: {iv.hex()}")
    print(f"c: {ciphertext.hex()}")