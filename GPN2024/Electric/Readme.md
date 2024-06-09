# Electric

- Category: rev
- Final point value: 286
- Number of solves: 12
- Solved by: `mouthon`

In this reverse challenge, we have a very simple [python script](./justpython.py) which is encrypting the flag using the `enc` function imported from the module `script`, and we know the expected encryption for the real flag.
This `script` module seems to be loaded from a [compiled library](./script.cpython-311-x86_64-linux-gnu.so).

I started by searching the strings present in the binary on the internet, and I understood that this library was compiled from C code, which was itself compiled from Python code using [Cython](https://github.com/cython/cython). I cloned the Cython repository, and started to reverse the library in Ghidra, with the help of the Cython source code, and of [this article](https://www.ptsecurity.com/ww-en/analytics/pt-esc-threat-intelligence/lazystealer-sophisticated-does-not-mean-better/
).

After spending a few hours matching the names from the source code with the Cython identifiers, I had a better idea of what was going on (there were several functions in this module, like `enc`, `expand`, `x`, `y`, `z`), but I was still quite lost. So I decided to play a bit with the module to understand how it worked. I thus created my [local setup](./local/), and added `-i` to python and Docker, to allow interacting with the program:
```
>>> enc("GPNCTF{fake_flag_}")
b'\x03\x98;\x1e\xbf\xad\xdd-\xd5\xd0\x0c[.&yu\x0c\x9d\xda\xcbO\x84\x13^\x927\xb1\x96'
>>> enc("GPNCTF{fake_flagX}")
b'\x03\x98;\x1e\xbf\xad\xdd-\xd5\xd0\x0c[.&yu\x0c\x9d\xda\xcbO\x84\x13^\x8d7\xb1\x96'
>>> enc("GPNCTF{fake_flag_a}")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "script.pyx", line 32, in script.enc
AssertionError
>>> enc("GPNCTF{fake_flag_ab}")
b'\x1d\xe3\xed\xdf\xb6z\xce\xcc\xddT#\xdd-\x05\xa0zD2.\xb3\x0e\x1fWY\xda4\x11\xb5\xd00'
>>> enc("GPNCTF{fake_flag_abab}")
b'\x1d\xe3\xaa\x01\xb6z\xce\xd6\xdd\x14\xcc\xdd-0\xa9x02.,\x12\x1f\xb0\x0f\xda}_(\x159\xb0\x9c'
```
I noticed that the flag had to be of even length, that the encrypted output was always 10 bytes longer than the input, and that changing one byte in the input changes one byte in the output. So we can actually bruteforce the flag byte by byte, without understanding what is happening. I implemented this bruteforce in my [local setup](./local/justpython.py), and quickly obtained a flag: `GPNCTF{wHy_1s_th3re_pyTHon_in_my_c_ahHh1!}`

