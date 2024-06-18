#!/usr/bin/env python3


import json
import hmac
import hashlib
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
import secrets

import sys

from server_config import hint, flag

def integer_to_base(n, base):
    if n == 0:
        return [0]
    digits = []
    while n:
        digits.append(n % base)
        n //= base
    return digits[::-1]

def write(data: dict):
    print(json.dumps(data))

def read():
    try:
        return json.loads(input())
    except EOFError:
        exit(0)

class CustomHMAC:
    def __init__(self):
        self.prime = 22193
        self.key_1, self.key_2 = self.generate_keys()
        
    def generate_keys(self):
        key1 = AESGCM.generate_key(bit_length=128)
        key2 = secrets.randbelow(self.prime)
        return key1, key2

    def poly_hash(self, key, message_array) -> int:
        assert len(message_array) <= 5
        hash = 1
        # Compute the polynomial hash using Horner's method
        for i in range(len(message_array)):
            hash = (hash * key + message_array[i]) % self.prime
        return hash

    def compute_custom_mac(self, nonce, msg_array):
        poly_hash = self.poly_hash(self.key_2, msg_array)
        k_intermediary = hmac.new(nonce, self.key_1, hashlib.sha256).digest()
        hmac_result = hmac.new(k_intermediary, poly_hash.to_bytes((poly_hash.bit_length() + 7) // 8, byteorder='big'), hashlib.sha256).digest()
        return hmac_result
    
    def check_collision(self, nonce_1, msg_1, nonce_2, msg_2, guess_key_2):
        # Enforcing length on one of the nonces
        if len(nonce_1) < 65:
            return 'Invalid'

        msg_array_1 = integer_to_base(int.from_bytes(msg_1, 'big'), self.prime)
        msg_array_2 = integer_to_base(int.from_bytes(msg_2, 'big'), self.prime)
        
        if nonce_1 != nonce_2 and msg_array_1 != msg_array_2:
            mac_1 = self.compute_custom_mac(nonce_1, msg_array_1)
            mac_2 = self.compute_custom_mac(nonce_2, msg_array_2)
            if mac_1 == mac_2:
                if guess_key_2 == self.key_2:
                    return f'flag: {flag}'
                else:
                    return f'hint: {hint}'
        return 'Invalid'

WELCOME="""
Your friend implemented a custom MAC scheme and bets you $100 that it's secure.
You take him up on the bet.
Can you prove him wrong?

The way to prove that you've broken his MAC scheme is by performing a collision attack.
Create two (nonce, msg) pairs that have the same MAC tag.

Oh, and also, recover one of the keys used to generate the MAC tags.
"""

def serve():
    write({'message': WELCOME})
    hmac = CustomHMAC()

    while True:
        try: 
            msg = read()

            if msg['method'] == 'submit':
                msg['nonce_1'] = bytes.fromhex(msg['nonce_1'])
                msg['nonce_2'] = bytes.fromhex(msg['nonce_2'])
                msg['msg_1'] = bytes.fromhex(msg['msg_1'])
                msg['msg_2'] = bytes.fromhex(msg['msg_2'])
                msg['guess_key_2'] = int(msg['guess_key_2'])
                result = hmac.check_collision(msg['nonce_1'], msg['msg_1'], msg['nonce_2'], msg['msg_2'], msg['guess_key_2'])
                write({'message': result})
                
        except Exception as e:
            write({'error': repr(e)})

if __name__ == '__main__':
    serve()
