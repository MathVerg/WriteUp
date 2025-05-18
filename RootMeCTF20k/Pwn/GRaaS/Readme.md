# GRaaS

- Category: Pwn
- Difficulty: Medium
- Number of solves: 2

This is a pwn challenge I created with [Lukas](https://github.com/hertelukas) for the [Binary Exploitation](https://www.sec.in.tum.de/i20/teaching/ws2022/binary-exploitation) course at TU Munich, and modified for CTF20k. The original challenge was in RISC-V, I made it a traditional x86-64 chall instead, but set up a seccomp profile to force the player to build a ROPchain.

The challenge consists in a web application similar to the one I used in the [Park series](../../MiscPark/). Instead of a GCC command, the application executes a binary called "graas" on the input and sends the output back to the user.
The handouts consist in the [source code](./src/app/) of the web application, including the ["graas" binary](./src/app/graas), and the [source code](./src/graas.c) of this binary.

## Analysis of the source code

A comment in the source code informs us that the program is statically linked against [libgif](https://sourceforge.net/p/giflib/code/ci/5.2.2/tree/), but the library is not supposed to be vulnerable. The `main` function starts with a seccomp profile allowing only basic file operations, `brk` (for heap allocations) and `exit`. The program takes a GIF file as input, rotates every of its frames by 90°, then outputs the result in a new GIF file. The rotation is done inside a buffer on the stack, but there should not be any problem, because the program fist checks that the frames are not too big for this buffer... or does it?

The vulnerability resides in the fact that only the dimensions of the first frame are checked against the maximal frame size. It turns out nothing prevents a GIF from having frames of varying sizes! A [double-free vulnerability in Whatsapp](https://awakened1712.github.io/hacking/hacking-whatsapp-gif-rce/) exploiting this fact gave me the original idea for this challenge. So, if we send a GIF file with a small first frame and a huge second frame, we should be able to trigger a buffer overflow on the stack of `rotate_frame`.

## Crafting a GIF

When developing the exploit, I first tried to use some GIF library in Python to craft a GIF with different frame size, but the lib always resized the frames to make they uniform. So I decided to use the very same library as the vulnerable program. I wrote a [C program](./solve/gifgen.c) that takes a payload of length n as input, and creates a GIF file with a 1x1 frame, followed by a `n`x1 frame. It copies all the GIF parameters from a random example GIF found on the internet, so I do not have to bother finding out how to properly initialize the GIF. Setting the height of the payload frame to 1 spares us the hassle of thinking about what will happen to the payload when it is rotated.

Let's see if it works:
```
$ python -c "print('A'*20000)" | ./gifgen 20000
$ ./graas payload.gif test.gif
Welcome to
  _____                  _____ _
 / ____|                / ____| |
| |  __ _ __ __ _  __ _| (___ | |
| | |_ | '__/ _` |/ _` |\___ \| |
| |__| | | | (_| | (_| |____) |_|
 \_____|_|  \__,_|\__,_|_____/(_)



Canvas size:            20000 * 1
Color resolution:       8
Background color:       128
Aspect Type:            0
Image count:            2
zsh: segmentation fault (core dumped)  ./graas payload.gif test.gif
```

Yes, that's a segfault!

## Building the payload

Now we must exploit this buffer overflow. Let's have a look at the protections first:
```
$ checksec --file=graas
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      Symbols         FORTIFY Fortified       Fortifiable     FILE
Full RELRO      No canary found   NX enabled    No PIE          No RPATH   No RUNPATH   125 Symbols       No    0               5               graas
```
No PIE, and no canary, so we can ROP, and reuse code from the binary.
Good, because in this context, leaking libc won't be an option: we can not directly interact with the binary, we only receive the output gif once the execution is complete. But thanks to the statically linked gif library, we already have everything all the gadgets we need in the binary. We'll be using different POP gadgets for different registers, and a write-what-where primitive using these two gadgets:
```
mov qword ptr [rbx + 0x48], rax ; pop rbx ; ret
mov rax, rbp ; pop rbx ; pop rbp ; ret
```

One of the challenges we have is that the program does not import `read` and `write`, but rather `fread` and `fwrite`, which require a pointer to a FILE structure, usually allocated on the heap, and we do not know the address of the heap because of ASLR. My solution was to craft a fake `GifFileType` structure in the BSS, and use the `DGifExtensionNext` and `EGifPutExtensionBlock` functions from libgif to perform the reads and write. The full payload generation can be found [here](./solve/exploit.py), I tried to comment is as much as possible. Here is a summary of what it does:
1. Craft the fake `GifFileType` structure in the bss
2. Craft the string "/flag.txt" in bss byte by byte using `memcpy`
3. `open` then `fdopen` the flag file, the pointer to its FILE structure is in `rax` after the `fdopen`, so we can store it at the right offset in the `GifFilePrivateType` structure.
4. Call `DGifExtensionNext` to read the flag
5. Call `fdopen` on the file descriptor of the output file to get a FILE struct for it, store it again in the `GifFilePrivateType` structure
6. Use `EGifPutExtensionBlock` to write the flag to the output
7. Call `fclose` on the output file to flush it... but we need its address for that. My solution was to stack pivot in the bss, where it is stored (in the `GifFilePrivateType`)
8. Call `_exit(0)` to terminate the program without errors

We can then upload this payload GIF to the server to get the flag: `RM{Graas_in_der_Luft_Graas_in_meinen_Lungen_3b08825370b1377eb684c10741ee2cba}
`
