# netsec

This is a Linux kernel pwn challenge with a vulnerable kernel module "encrypting" network packets on the fly with netfilter hooks.
However, you do not have direct access to the machine where it is running.

The vulnerability to exploit was a use-after-free in the array of established connections. This use-after-free could rather easily be turned into an arbitrary read/write, but you had to get creative to exfiltrate the flag after that, since you had no shell on the target machine. My strategy involved writing to the physical memory of the userland `nc` service which we were interacting with, in order to make it serve us `sh` instead of `cat`.

Since I do not practice kernel pwning very often, I found myself rather slow at writing the exploit, but I learned a lot on the way, and I am quite satisfied with my data-only exploit. Kudos to [Quanthor-ic](https://github.com/Quanthor-ic) for this nice challenge!

## Analysis

The handouts contain the following files:
- a kernel bzImage
- two rootfs for the "pivot" and "challenge" VMs
- the source code of a "netsec" kernel module
-  an `entrypoint.sh` script that launches two QEMU VMs with the pivot and challenge filesystems connected by a network, and gives us SSH access to the pivot VM
- `Dockerfile` and `docker-compose.yml` to run the challenge. The Dockerfile serves the `entrypoint.sh` script via a `socat` command, so every connection to the exposed port starts a new instance of the challenge, and drops into the SSH of the pivot VM

The filesystems are rather similar, the noteworthy differences are:
- the challenge VM has the `flag.txt` file at its root
- the challenge VM loads the `netsec` module, with a configuration given in `/etc/modules-load.d/netsec.conf`
- the challenge VM starts a netcat listener in its `/etc/inittab`: `null::respawn:nc -knlp 1337 -e /bin/cat`

The filesystem is loaded via the `-drive` argument of Qemu instead of `initramfs`, which means that the flag won't be present in the physical memory, so an arbitrary read won't be enough to exfiltrate it.

The `netsec` kernel module registers two netfilter hooks, for inbound and outbound network traffic.
These hooks ignore everything except TCP traffic on the configured `hook_port` (1337 in our case). 
For the traffic on this port, they keep track of established connections in a `hash_table` with a hash based on the source IP and port.
Every traffic going through this port is "encrypted" (aka XORed) with a key derived from the source port, then forwarded.
So, if we connect to the TCP port 1337 of this machine, the following happens:
- We send a TCP SYN. In `hook_in` a `sec_conn` is created and stored in the `hash_table` at the index corresponding to a hash of our source address (always 192.168.2.1) and our source port. Our `out_key` is derived from our source port. The `in_key` is computed only once at the initialization of the module, because it is derived from the destination port, which is always 1337
- We send some data to the port. In `hook_in`, a buffer is allocated in our `sec_conn`, our data is copied into this buffer, xored in-place with the `in_key`, then forwarded to the listening service.
- The listening service, a `cat` served by an `nc`, simply echoes back what it received.
- In `hook_out`, the data is copied again in our `sec_conn` buffer, XORed with the `out_key`, then forwarded to us.
- We received our initial data back, xored with the `in_key` and the `out_key`.

### The vulnerability

The vulnerability lies in the fact that there are [more possible TCP source ports than entries in the `hash_table`](https://en.wikipedia.org/wiki/Pigeonhole_principle). So if we open enough connections, at some point there will be a collison in the hash function, and the `sec_conn` of the corresponding two connections will occupy the same entry in the `hash_table`. By opening connections until we get a collision, then closing one of the colliding connections, we have a use-after-free.

## Setup

Firstly, I needed debugging capabilities. So, I modified the `entrypoint.sh` script to add the `-s` flag to the Qemu command for the challenge VM to enable the GDB stub, and modified the `docker-compose.yml` to forward port 1234 to my host. Then I could debug it with a GDB running on my host. By the way, I used [bata24's fork of gef](github.com/bata24/gef), whose kernel commands (such as `ktask` and `kvmmap`) proved very useful.

I also looked for a way to see the panic log of the running VM, but did not find one at the beginnig. To be honest, I didn't try for too long, and I should have insisted a bit more, because it helped me a lot once I got it later.

We have an SSH access to the pivot VM, and it has python on it, so we won't have to write the exploit in C and send it byte64-encoded as usual, that's nice. I even first thought that I could run the exploit on my host and forward the 1337 port with `ssh -L`, but then I would not have been able to know what my source port was, a necessary piece of information for the challenge. So I developped the exploit on my host, copied it to the pivot machine with `scp`, and ran it from here. But by default copying the file with `scp` would create a new instance of the challenge and copy the file there, instead of copying it to the already running one, since every new connection spawns a new instance. To avoid this problem, I used [SSH Multiplexing](https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Multiplexing) to reuse the same connection. So I created the following SSH configuration in my `.ssh/config`:

```ssh
Host netsec
    Hostname localhost
    Port 4000
    User ctf
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ControlMaster auto
    ControlPath /tmp/ssh-%r@%h:%p
    
Host netsec_remote
    Hostname challenges.fcsc.fr
    Port 2209
    User ctf
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ControlMaster auto
    ControlPath /tmp/ssh-%r@%h:%p
```

The last details was that `pwntools` was not installed on the pivot machine.
Since I needed only a few simple functions from it, I reimplemented them quickly, and used `socket` directly for network communication:
```python
HOST = "192.168.2.2"
PORT = 1337

def start():
    p = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    p.connect((HOST, PORT))
    return p

def p32(i:int):
    return struct.pack("<I", i)

def p64(i:int):
    return struct.pack("<Q", i)

def u32(b:bytes):
    return struct.unpack("<I", b)[0]

def u64(b:bytes):
    return struct.unpack("<Q", b)[0]

def pause():
    input("[*] Press any key to continue")
```

With all this setup, I was ready to start the exploit.

## Getting Arbitray R/W

To begin with, I reimplemented some code of the module in Python, in order to be able to communicate with the remote service:

```python
HOOK_PORT = 1337
MASK32 = (1<<32) - 1

def kdf(seed:int):
    key = b""
    state = (seed*0xdeadbeef + 0x12345) & MASK32
    for i in range(8):
        state = (state ^ (state << 13)) & MASK32
        state = (state ^ (state >> 17)) & MASK32
        state = (state ^ (state << 5)) & MASK32
        key += p32(state)
    return key

def xor(buf, key):
    l = []
    for i in range(len(buf)):
        l.append(buf[i] ^ key[i%len(key)])
    return bytes(l)

IN_KEY = kdf(HOOK_PORT)

#IP is always 192.168.2.1
def HASH(port:int):
    h = 192 ^ 168 ^ 2 ^ 1 ^ (port & 0xff) ^ (port >> 8)
    assert h < 0x100
    return h

def get_key(io):
    out_port = io.getsockname()[1]
    out_key = kdf(out_port)
    return out_key

def hash_conn(io:socket.socket):
    ip, port = io.getsockname()
    assert ip == "192.168.2.1"
    return HASH(port)

def send_encrypt(io, payload):
    logger.debug(f"Sending: {payload[:0x40]}")
    io.send(xor(payload, IN_KEY))

def recv_decrypt(io, n:int):
    out_key = get_key(io)
    res = xor(io.recv(n), out_key)
    logger.debug(f"Received: {res[:0x40]}")
    return res

def sanity_check():
    p = start()
    hello = b"Hello world"
    send_encrypt(p, hello)
    res = recv_decrypt(p, len(hello))
    if res == hello:
        logger.info("Sanity check passed !")
    else:
        logger.error("Sanity check failed: {res} != {hello}")
```

I then opened connections to 1337, until I obtained a collision on the hash of the source port, at which point I closed one of the two colliding connections, and kept the other as *victim*. The connections are allocated as slabs instead of a common `kmem_cache`, and the buffers of size less than or equal to `0x20` are allocated from the same cache. So, we can hope to have a buffer allocated at the same place that the freed connection.
Slab allocation may be [randomized](https://lwn.net/Articles/938246/) to prevent attacks, but this did not seem to be the case here. So, sending data for the first time to any other opened connections (hte *attacker*) will allocate a buffer for this connection right at the same place as the freed connection. But this spot is still occupied by the victim, so we can manipulate it and change its `in_key`, `out_key`, `buf` and `buf_len` fields.

One thing that caused me some trouble is that slabs are a singly-linked list, and hold the pointer to the next free slab [somewhere](https://elixir.bootlin.com/linux/v6.8.7/source/mm/slub.c#L5035) inside the slab. In our case, this pointer would end up at the location of the `buf` pointer, where I would have expected it to stay `NULL`. So I made sure to override this pointer with `NULL` or a controlled value, to avoid writing to unexpected locations.

To bootstrap my arbitray read and write, I needed to know the address of *something*. I could have done a partial overwrite to leak addresses from the other objetcts, but that would have risked corrupting other stuff because of the freelist pointer at the `buf` position. But there is a better way. Even with KASLR enabled, the [IDT](https://wiki.osdev.org/Interrupt_Descriptor_Table) is always at address `0xfffffe0000000000`, and contains pointers to the kernel `.text`. Inside the IDT, it is also possible to get 8 consecutive bytes with completely known value (`0x00000000ffffffff`). This is everything I needed.

So I sent to the attacker connection a payload made of the address of a pointer to leak (replaces `in_key` of the victim connection), the address of know value in the IDT (replaces `out_key`), and then a `NULL` pointer (replaces `buf`). This payload was XORed with the attacker key (and the victim key through `send_encrypt`):
```
    payload = p64(IDT+4) + p64(IDT+8) + p64(0)
    send_encrypt(attacker, xor(payload, attacker_key))
    recv_decrypt(attacker, 0x18)
```
Then I sent 8 null bytes through the victim connection. They got Xored with the `in_key` (the pointer to leak), echoed back, then XORed with the `out_key` (known), so I was able to retrieve the value of a pointer to the kernel `.text`.
From here I could get two other interesting addresses:
- the address of 0x20 consecutive null bytes in the kernel `.rodata`, to save me some XORing
- an address at the end of the kernel `.data` in unused memory, where I could write anything without destroying anything useful

Then I obtained clean arbitray read/write primitives:

```python
    def arb_read(addr, size=8):
        assert size <= 0x20
        payload = p64(addr) + p64(zero_addr) + p64(dummy_addr)
        send_encrypt(attacker, xor(payload, attacker_key))
        recv_decrypt(attacker, 0x18)
        victim.send(b"\x00"*size)
        res = victim.recv(size)
        logger.debug(f"Read @ {addr:#x}: {res}")
        return res

    def arb_read_ptr(addr):
        ptr = u64(arb_read(addr, 8))
        logger.debug(f"Read ptr @ {addr:#x} : {ptr:#x}")
        return ptr

    def arb_write(addr, payload):
        size = len(payload)
        assert size <= 0x20
        attacker_payload = p64(zero_addr) + p64(zero_addr) + p64(addr)
        send_encrypt(attacker, xor(attacker_payload, attacker_key))
        recv_decrypt(attacker, 0x18)
        victim.send(payload)
        victim.recv(size)
        logger.debug(f"Written @ {addr:#x}: {payload}")
```

- The arbitray read sets `in_key` to the address to leak, `out_key` to the address containing zeroes, and `buf` to the address of unused data. Then it sends null bytes to the victim, which are XORed with the leak, echoed back by `cat`, and XORed with null bytes, thus giving us the leak. During the process, the XORs are operated in the unused memory area, without destroying anything useful.
- The arbitray write sets `in_key` and `out_key` to zero and `buf` to the address at which we want to write, so our next write to the victim goes untouched to the chosen location.

At this point it was 10pm, I had arbitrary read and write, and was confident that I could finish the challenge before going to bed. But things did not really go as expected.

## Exfiltrating the flag

So, with arbitrary read and write, how do I get a flag? I can not just read it from physical memory, because the rootfs is loaded as an external drive by Qemu. I can not use good old tricks like [modprobe_path](https://github.com/smallkirby/kernelpwn/blob/master/technique/modprobe_path.md), because I do not have a shell on the challenge VM (and the modprobe path technique is patched anyway, but there are other similar techniques). I thought about ROPing inside the kernel, but this seemed painful to implement. I then thought about a much cleaner way: we already have a userland service talking with us, so maybe we can modify it to make it give us the flag?
The service is run by `init`, using the following `inittab` configuration:
```
null::respawn:nc -knlp 1337 -e /bin/cat
```
So, my plan was to find the memory of `init`, and there replace `/bin/cat` by `/bin/sh`, so that the service gives us the flag when connecting. Unfortunately at this point I overlooked the flags passed to `nc`, and thought that at every connection the `nc` process would die and be restarted by `init` because of the `respawn` directive. In fact, it was `nc` itself that was spawning a new instance of `cat` at every connection, because of the `-k` flag.

So, how do we find the location of the command to overwrite?

Firstly, I needed to know where the command was stored in the memory space of the `init` process. `init` was actually `busybox`, so by reading the [source code](https://elixir.bootlin.com/busybox/1.37.0/source/init/init.c#L200) of busybox and reversing the busybox binary from the rootfs, I found it to be on the "heap", actually emulated inside the `.bss`. Finding its exact offset in the heap would require following the linked list of `init_action`s, but this was not necessary, since it was deterministically at the same offset inside the `.bss`.

Then, I needed to identify the [`task_struct`](https://elixir.bootlin.com/linux/v6.8.7/source/include/linux/sched.h#L748) of `init`. Here the `ktask` command of gef helped me. All the `task_struct`s in the kernel form a doubly-linked list, rooted somewhere in the kernel `.data` section. The `task_struct` of `init` was the first one in the list, so I juste had to follow one pointer to find it.

From this `task_struct` I needed to get the address of the `.bss` section. This required parsing the memory map ([`mm`](https://elixir.bootlin.com/linux/v6.8.7/source/include/linux/sched.h#L880) field of `task_struct`), which in recent kernels uses a data structure called [Maple Tree](https://docs.kernel.org/core-api/maple_tree.html). Fortunately, bata24 had already done the work for me, so by reading his code and the kernel code I figured it out.

Now the address I obtained is a virtual address for the `init` process, but I need a physical address (see https://wiki.osdev.org/Paging). So I needed to walk the page tables of the process, whose root is [in the `mm_struct`](https://elixir.bootlin.com/linux/v6.8.7/source/include/linux/mm_types.h#L765). It took me a bit of time to understand how to walk the page tables properly, I knew the theory but had never put it into practice before. But once again, with the help of the kernel code and bata24's code, I managed to do it.

Phew! Then, we can overwrite the command, and that's it!

Except that... it did not work.

At that point it was something like 4 AM, and I wasn't able to understand why the strategy would not work. I thought that it might be a TLB or cache issue (yes, it does not make any sense, since we are not modifying the page tables, but I was tired, so don't judge me, okay?).

Desperate, I resignated myself to ROP in the kernel. I leaked the address of the kernel stack of `init` from its `task_struct`, and tried to overwrite its return address, but I was not getting appropriate feedback because I did not have the panic log of the victim, and I was pretty slow, because I was tired. Also, I did not have any plan of what to do once I get code execution. At 5:15 AM I just wanted to go to sleep, so I stopped working on that challenge and got some rest.

I woke up the next morning (aka 4.5 hours later) with some fresh ideas:
- I should definitely get the panic log from the kernel, it must not be that hard
- I should check those `nc` flags, just in case

Regarding the first one, it was indeed not that hard. My solution was to open a shell inside the docker with `docker exec`, and replace `>> /dev/null` by `>> /dev/pts/0` in the Qemu command. Thus, I could confirm that, in my attempt at ROPing yesterday, I was overwriting the right address on the stack, effectively getting a panic with `RIP=0xdeadbeefcafebabe`.

And regarding the second one... I noticed the `-k` flag, and understood that `nc` was doing the respawn and not `init`, which explained why my attack would not work. So, I looked at where the command to run is in `nc`, and found it to be [on the stack](https://elixir.bootlin.com/busybox/1.37.0/source/networking/nc_bloaty.c#L480). Then I needed to find the `task_struct` of `nc`. Rather than following the whole linked list of `task_struct`, I found out that I could instead follow the list of [children](https://elixir.bootlin.com/linux/v6.8.7/source/include/linux/sched.h#L997) of `init`, from the back because `nc` was its last child. Then as before, I found the stack address in the Maple Tree, pagewalked to get the corresponding physical page, then wrote to this address, and it worked! Then I simply needed to open a new connection and send "/bin/cat /flag.txt" to receive a well-deserved flag.

I was quite satisfied with this strategy, because it did not involve custom code execution on the remote. The exploit can be found [here](./exploit.py).