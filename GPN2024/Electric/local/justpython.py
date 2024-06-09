
from script import enc

correct_cipher = b"m'7Y\xcaZ\xb4\x06\xbd\x92\xae\xf1B\x15\xd1IP1a\xdcs\xde&\xadWz\xb4\x12\xab\xa5]\x1e\x83\x98\xc6\xa9\x89\t\xa9\tNW\x9c\xe0\n\x9f\x11\x83\xa1\xd1\x03\xad"
print(len(correct_cipher))

best = 0
best_val = 0
prefix = ""
for x in range(42):
    for i in range(32, 127):
        attempt = prefix + chr(i) + (41-len(prefix))*"A"
        attempt_cipher = enc(attempt)
        s = 0
        for j in range(52):
            if correct_cipher[j] == attempt_cipher[j]:
                s += 1
        if s > best_val:
            best_val = s
            best = i
    prefix += chr(best)

print(prefix)

#flag = "GPNCTF{fake_flag_}"
#print(enc(flag))
# with the correct flag I get:
# b"m'7Y\xcaZ\xb4\x06\xbd\x92\xae\xf1B\x15\xd1IP1a\xdcs\xde&\xadWz\xb4\x12\xab\xa5]\x1e\x83\x98\xc6\xa9\x89\t\xa9\tNW\x9c\xe0\n\x9f\x11\x83\xa1\xd1\x03\xad"
