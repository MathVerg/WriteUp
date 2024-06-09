# Gift

- Category: pwn
- Final point value: 328
- Number of solves: 9
- Solved by: `mouthon`

The [binary](./gift) we have to pwn is compiled from a simple 30 lines [assembly file](./gift.s), with an obvious buffer overflow: in `read_input`, 330 bytes are read but only 314 bytes were allocated on the stack. So we can overwrite the return adress of `read_input`, and another 8 bytes value. I first though of [SROP](https://en.wikipedia.org/wiki/Sigreturn-oriented_programming), but we would need a larger overflow to place a SROP payload on the stack.

I verified using GDB that, when returning from `read_input`, the registers have the following values:
- `rax` is the number of bytes which have been read, between 1 and 330 (and if we overflow, rather between 315 and 330)
- `rdi` is 0 (stdin file descriptor)
- `rsi` points to what we have just read on the stack
- `rdx` is 330 (size of the read)
- `r10`,`r8` and `r9` were never used and have value 0

Since `rax` is the syscall number, we could execute any syscall with number between 315 and 330 by overwriting the saved return address with the address of a syscall instruction. We open a [syscall table](https://syscalls.mebeim.net/?table=x86/64/x64/latest), and search for a syscall with a signature similar to the values we have in registers. We found that `execveat` has syscall number 322, and takes the following parameters:
- `rdi`: a file descriptor for a working directory, is **ignored** if a full path is given
- `rsi`: a path of a binary to execute
- `rdx`: argv
- `r10`: envp
- `r8`: flags

That looks perfect, we just need to place a full path in `rsi`, and set `rdx` to zero. The latter can be achieved by jumping at the end of `_start`, were `rdx` is conveniently set to 0 before doing a `syscall`

We then just write an [exploit](./exploit.py) with that and get a shell.