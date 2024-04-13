#!/usr/bin/python3

from pwn import *
from tqdm import trange

HOST = "challenges.france-cybersecurity-challenge.fr"
PORT = 2251

if args.REMOTE:
    server = remote(HOST, PORT)
else:
    server = process("./server")

client = process("./client")

def msg_exchange(p1, p2):
    p1.recvuntil(b"SEND: ")
    msg = p1.recvline(keepends=False)
    p2.recvuntil(b"RECV:\n")
    p2.sendline(msg)
    p2.recvuntil(b"SEND: ")
    ack = p2.recvline(keepends=False)
    p1.recvuntil(b"RECV:\n")
    p1.sendline(ack)

info("server pubkey")
msg_exchange(server, client)

info("client pubkey")
msg_exchange(client, server)

info("server hello")
msg_exchange(server, client)

info("client hello")
msg_exchange(client, server)

info("server flag 1")
msg_exchange(server, client)

flag1 = client.recvline(keepends=False).decode()
info(f"First flag: {flag1}")

info("client 5 pull")
server.recvuntil(b"SEND: ")
server_msg = server.recvline()
server.recvuntil(b"RECV:\n")
#rollover seqnum
server.sendline(b"05FFFF033A16B0CF2CA0DFA9C3F856365BC41DE3DFAB62E8FCA6D51A69226A2901FA")
server.recvuntil(b"SEND: ")
server_msg = server.recvline()
server.recvuntil(b"RECV:\n")
#replay valid ACK
server.sendline(b"05000A033A16B0CF2CA0DFA9C3F856365BC41DE3DFAB62E8FCA6D51A69226A2901FA")

info("client 6 pull")
msg_exchange(server, client)

info("client 5 face")
server.recvuntil(b"SEND: ")
server_msg = server.recvline()
server.recvuntil(b"RECV:\n")
server.sendline(b"05000C036C4D63FC7F5FE25094D84F86157D7F1783EEAD297538B97C9F1C31BC0194")

info("client 5 face answer")
server.recvuntil(b"RECV:\n")
server.sendline(b"05000F81EA7140C5616837D0698F733A801FC4CB08180703E17AE332FB4997F4105FEA343BCB979948100C387DF2A1A070")
server.recvuntil(b"SEND: ")
server_msg = server.recvline()

info("client 6 face")
msg_exchange(server, client)

info("client 6 face answer")
msg_exchange(client, server)

info("server flag 2")
msg_exchange(server, client)
flag2 = client.recvline(keepends=False).decode()
info(f"Second flag: {flag2}")

client.close()
server.close()