# Too many cooks

- Category: rev/pwn
- Final point value: 345
- Number of solves: 8
- Solved by: `mouthon`

We are given a [binary](./too_many_cooks) without the source code. Playing with it, we see that it offers us different kind of "meals" and "deserts", which are made of ascii art. It has all the usual protections (RelRO, canaries, NX, PIE, ASLR).

I started reversing it in Ghidra. We notice that `stdin`, `stdout` and `stderr` receive the `FD_CLOEXEC` flag, which means that they will be closed if we `exec` a new binary. We will probably want to just `open` the flag file, `read` the flag and `write` it to stdout.

I reversed the whole binary, and discover several interesting things:
- in `serve_leek`, the "leek soup" (notice the pun) ascii art contains formaters (`%015lu`), and prints out a leak of the PIE, along with some other random values
- in `dinner`, there is an obvious and very large buffer overflow, where 0x1000 bytes are read into a 16 bytes buffer. Strangely enough, this function did not have any stack canary.
- `dinner` and `desert` can mutually call each other indefinitely. This could lead to a stack overflow, and may be used to get some space on the stack for a large ROP payload. It turned out not to be necessary
- there are many unused functions in the binary: `salt`, `pepper`, `heat`, `cool`, `flip` and `serve`. These functions manipulate the content of the `kitchen`, and `serve` executes two bytes from this kitchen, after having set the `rax`, `rdi`, `rsi` and `rdx` registers according to the content of the kitchen.

I thus started to write an [exploit](./exploit.py). First step was to indentify the formatters (`%015lu`) in the leek soup, and parse the leek soup to obtain the adddress of `serve_leek`, and thus the address of the binary. Then, I saw two options:
- get the `libc` and `ld` from the docker, ROP to leak libc by calling `puts@plt(puts@got)`, then ROP using libc's gadgets and functions
- ROP using the unused functions to trigger syscalls with chosen parameters

The second option seemed to be the "intended" one and seemed to be more fun that the first one, so I went for it. Digging a bit more in these unused functions, here is what they do:
- `salt`: increment `dish_index`, then reduce it modulo 48. The modulo operation is not obvious to see because it is quite optimized, but we can figure it out by calling `salt` in GDB (`call (void) salt()`) with different values for `dish_index`
- `pepper`: decrement `dish_index` then reduce it modulo 48
- `heat`: increment the byte at index `dish_index` in `kitchen`
- `cool`: decrement the byte at index `dish_index` in `kitchen`
- `flip`: double the byte at index `dish_index` in `kitchen`
- `serve`: copy two bytes at index `dish_index - 1` in `kitchen` to a memory mapped page, have them followed by a `ret` (`0xc3`), make this page exectuable, then execute it after having filled `rax`, `rdi`, `rsi` and `rdx` with values from `kitchen`

So, we can basically set any byte of `kitchen` to any value by navigating to this byte using `salt` and `pepper`, and then incrementing, decrementing and doubling this byte using `heat`, `cool` and `flip`.

I wrote some helper functions for that, then used it to execute `syscall` with the rigth parameters to perform `open("/flag", 0, 0)`, `read(3, buf, 0x100)`, `write(1, buf, 0x100)`, which gave out the flag. The full exploit can be found [here](./exploit.py).