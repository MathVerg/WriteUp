# PTSD 

A reverse chall where we were given a server binary implementing a "secure" data exchange protocol. We had to understand the protocol and establish a secure connection with the server to get a first flag, then exploit a flaw in the protocol to impersonate another client, which will get us a second flag.

## First overview

We are given a bunch of files: the [server](./server) binary, a [key database](./data/keys.db), and two fake flag files. The `libcrypto` and `libssl` libraries running on the remote are also provided, but we did not need to use them. For the second part of the challenge, we also have a [record](./records.txt) of some messages between the server and another client. Running `strings` on the sever, we see a bunch of OpenSSL symbols, and some paths to a `./data` folder, where we apparently have to store the key and flag files. In the records, we can see that every long message from one side is answered by a short message, so we can guess this short message will be an ACK. We also see that every message starts with 05, which is the id of the client we want to impersonate, and then contains a number which is incremented at every message, so probably a sequence number.
Let's try to replay the message exchange from client 5 against the server, but simply replace the first byte by our client ID (06):
```
$ ./server
INFO -- release -- --- PTSD Server v1.54 ---
INFO -- release -- Loading clients...
INFO -- release -- Initializing secure channels...
INFO -- release -- Secure channel already done for 5
SEND: 0600010441042EF1D6ECE3445EB66C9C0780BE8E632D19EAF4AEFAB061DAACD8CE038171FF258FBA528535F89DACA7F56226724B60B1C23781DE774B49E1C71899AC5FD6B7EE
RECV:
060002020101
RECV:
060003044104CE16547B40B5CDBE7B4211C371B09F3B09C5BB4811CDFB3A787941B5B1E1B487A461928EB2167B7233EA4E61E0F51F580ADF080F7B709F7C0BB857A5B8801654
SEND: 060004020101
SEND: 06000509DB0870CF7DC414B01CD667B8641F69384C7D43C3AFAF3DB8405B9FB4082E0226EBD546CBFA
RECV:
060006020101
RECV:
06000709780E623D3DFA61E9565F58A991D331CC8024D1BB213B34E5BA99AA8D08FAF6AFA9E18935C4
$ 
```
It worked for a few messages, then not anymore... Time to get our hands dirty.

## Reverse engineering the server with Ghidra

The binary is stripped, but makes many calls to OpenSSL functions, which will probably help us understand what it does.
We will be using notably the [OpenSSL wiki](https://wiki.openssl.org/index.php) and the [OpenSSL manual](https://www.openssl.org/docs/man3.0/man3/) to figure out how the OpenSSL functions are used. During the whole reverse process, knowing that we will need to implement our own client, we will do our best to properly type everything and set usable variable names, so that we can just copy our decompiled code and run it with minor modifications.

Let's start with the `main` function. We can find it because it should be the first argument to `__libc_start_main`, close to the program entry point. It is mostly made of a `switch` whose cases represent the different steps of the protocol. Regular calls to a logging function help us understand what each of these steps mean. The switch is a bit broken in ghidra, only cases `0`, `2` and `default` are displayed, but we can find the other ones in the code that follows case `2`. The steps are:

2. load clients
3. initialize secure channels
4. check clients health
5. get clients info

Each of them contains one function call, we will study what happens in them one by one.

### Load clients

This function takes two (probably out) parameters. It opens the "keys.db" file, and stores the number of lines of this file in the second parameter, which is probably the number of clients.
Then for each client it allocates a buffer of size 0x29, reads the whole line of the key db in it, and parses it *in place* (which may be confusing at the beginning). The three column-separated fields of the key are hex decoded to different offsets of the buffer, so we can create a `client_t` struct in ghidra for holding these informations. The first field seems to be the ID, and we do not know the meaning of the two others yet, so let's just call them "small_field" and "big_field":
```C
int parse_key(client_t *client)

{
  int iVar1;
  uint i;
  int j;
  
  if (client != (client_t *)0x0) {
    client->terminator = '\0';
    iVar1 = __isoc99_sscanf(client,"%02hhX",client);
    if ((-1 < iVar1) && (iVar1 = __isoc99_sscanf(&client->small_field,"%04hX",&client->small_field), -1 < iVar1)) {
      i = 0;
      j = 0;
      while( true ) {
        if (0xf < i) {
          return 1;
        }
        iVar1 = __isoc99_sscanf(client->big_field + j,"%02hhX",client->big_field + (int)i);
        if (iVar1 < 0) break;
        j = j + 2;
        i = i + 1;
      }
    }
  }
  return 0;
}
```
The `load_clients` function returns the client array in its first parameter. All the upcoming functions will then take the client array and client count as parameters.

### Initialize secure channels

This is the first tough bit. Understanding it and implementing the client side should give us the first flag. Let's take the different function calls that are made there in order. All of them being reusable bricks for the client, I decompiled them as best as I could, and copied them to my [client implementation](./client.c).

#### `generate_ec_key`

This function returns an elliptic curve key pair in its first argument. It is the same as the one featured in the [OpenSSL wiki page](https://wiki.openssl.org/index.php/EVP_Key_and_Parameter_Generation).

#### `extract_public_key_octet_string`

This function serializes the public key into a buffer. More info [here](https://www.openssl.org/docs/man3.0/man3/EVP_PKEY_get_octet_string_param.html).

The following functions are called once for each client whose `big_field` is FFFF... . For the others, the server only prints that a secure channel is already initialized.

#### `send_pubkey`

This starts to be interesting. It takes as parameter a `client_t` pointer, the serialized server public key and its length. It then allocs a `struct` which we identified as a `message_t`, and calls a function on this message, which we called `send_clear_message`. Seeing how the different fields of the message are intialized, we were able to understand the full message format:
```
client ID (1B) | sequence number (2B) | type (1B) | length (1B) | payload (length*1B)
```
We can also identify the `small_field` of the client as the current sequence number used with this client (incremented by one when sending a message).
So, this firt message sent by the server contains its public key. So we can expect that the client will then send its public key too.

#### `recv_ack`

This function first calls the function I named `recv_clear_message`, which parses an incoming message in place. It logically updates the client sequence number, by setting it to the message sequence number if it is greater than the current sequence number. The `recv_ack` function then checks that the received message is of type `ACK`. This function is called in `initialize_secure_channels` (and other functions) everytime a message is sent by the server, and after it's called the server checks that the first byte of the payload is `01`.

#### `recv_pubkey`

Opposite function of `send_pubkey`: receives a message and check that its type is `SEND_PUBKEY`.

#### `ack`

Send a length one message of type `ACK`, containing only the byte `01`. It is called by the server after each message received from the client.

#### `load_pubkey`

Opposite function of `extract_public_key_octet_string`, it uses OpenSSL functions to deserialize the client's public key.

#### `derive_shared_key`

Uses the server key pair and the client public key to derive a shared secret. Same code as [this wiki page](https://wiki.openssl.org/index.php/EVP_Key_Agreement).
After the call to this function, the shared key is copied to the `big_field` of the client struct. We now know all the details of the `client_t` and `message_t` structs, you can find them in [client.h](./client.h).

#### `send_hello`

The server prepares a message with type `HELLO` and content "HELLO", but does not send it with `send_clear_message`. It uses a function which we named `send_encrypted`. This function encrypts an authenticates the payload and the sequence number with AES-GCM, through a function which we called `encrypt_payload` and is the same as [here](https://wiki.openssl.org/index.php/EVP_Authenticated_Encryption_and_Decryption). The shared key associated with the client is used there. The encrypted payload includes the IV and tag.
The server stills expects a normal (not encrypted) ACK for this hello.

#### `recv_hello`

Opposite of `send_hello`: calls `recv_encrypted_msg`, and checks that the message has type `HELLO`. In `recv_encrypted_msg`, the payload is decrypted with `decrypt_payload`,but **the encrypted and authenticated sequence number is not used**.
The server also sends a normal ACK after receiving this hello.

At this point the secure channel is initialized, all the following messages will be ACKed with an encrypted ACK.

#### `send_flag`

The server reads the first flag and sends it to the client as an encrypted message. So, if we managed to get to this point, we receive an encrypted flag and only have to decrypt and print it. But before we try that, we'll study the rest of the protocol.

#### `recv_encrypted_ack`

Same as `recv_ack`, but with an encrypted payload... This is relevant because we check if the payload starts with 01

### Checking clients health

This step sends an encrypted message ("PULLPULL") of type `PULL` to each client with the `send_pull` function and expects an encrypted ACK within 10 s. The opposite function, `recv_pull`, is implemented in the server binary but never used. We can decompile it and copy it to our client code too.

### Getting clients infos

This steps sends a message with type `FACE` to each client (`send_face`), and expects an encrypted ACK, then expects an message with type `FACE_ANSWER` (`recv_face_answer`) and ACKs it. The decrypted payload of the `FACE` answer must contain only even bytes. As for the previous one, the opposite functions `recv_face` and `send_face_answer` are defined but never used.

Once this step is completed for all clients, the second flag is sent to client 6.

So, we can now summarize the whole protocol for a single client
```
#initialize secure channels
S: pubkey
C: ack
C: pubkey
S: ack
(both C and S compute shared secret)
S: encrypted hello
C: ack
C: encrypted hello
S: ack
#first flag
S: encrypted flag
C: encrypted ack
#checking clients health
S: encrypted pull
C: encrypted ack
#getting clients info
S: encrypted face
C: encrypted ack
C: encrypted face_answer
S: encrypted ack
#second flag
S: encrypted flag
C: encrypted ack
```

## Client implementation

As mentioned before, if we have done the decompilation properly, we can copy the code from ghidra in our [client.c](./client.c) file, and the structs definitions in the [header](./client.h). We add a simple [Makefile](./Makefile) to compile it and link it against the ssl and crypto libraries. We also need to include a few OpenSSL header. We implement the protocol logic in the `main` function, as described in the previous section.

To make the client and server communicate, we wrote a Python [script](./solve.py) with `pwntools`, which for the moment simply exchanges the messages sent by a client and a server. We can try it out locally by temporarily removing the entry corresponding to client 5 in the db, so that the whole protocol is done with client 6 only. We can then debug the client until we get everything right and receive both flags:
```
$ python3 solve.py
[+] Starting local process './server': pid 11738
[+] Starting local process './client': pid 11740
[*] server pubkey
[*] client pubkey
[*] server hello
[*] client hello
[*] server flag 1
[*] First flag: FCSC{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
[*] client 6 pull
[*] client 6 face
[*] client 6 face answer
[*] server flag 2
[*] Process './client' stopped with exit code 1 (pid 11740)
[*] Second flag: FCSC{YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY}
[*] Process './server' stopped with exit code 0 (pid 11738)
```

## Attacking the protocol

If client 5 is participating, the server will expect them to ack the PULL and FACE messages, and to send a valid FACE_ANSWER message. We have a [record](./records.txt) of the first messages exchanged by the server and client 5, with sequence numbers going from `0001` to `0010`. According to the key database, client 5 current sequence number is however `0040`. We will try to do a [replay attack](https://en.wikipedia.org/wiki/Replay_attack) and send old messages of client 5 again to impersonate them. We have some messages, but with a sequence number that is too low compared to the current one. But that's not a problem, since the sequence number is updated by the unauthenticated sequence number, before the payload is decrypted! So we can replay one of the encrypted ACK messages with a sequence number of `FFFF`, which will be greater as the current one, so the server will update the sequence number of client 5 and it will overflow to `0000`. Then all the recorded messages become valid again, and we can replay them to ack the `PULL`, ack the `FACE` and send the `FACE_ANSWER`. We add this to our Python script, and run it against the server:
```
$ python3 solve.py REMOTE
[+] Opening connection to challenges.france-cybersecurity-challenge.fr on port 2251: Done
[+] Starting local process './client': pid 12149
[*] server pubkey
[*] client pubkey
[*] server hello
[*] client hello
[*] server flag 1
[*] First flag: FCSC{13c68c00895af039603fdaeefe36e3c5c4d6a40e76a256193c24391fa76f92d7}
[*] client 5 pull
[*] client 6 pull
[*] client 5 face
[*] client 5 face answer
[*] client 6 face
[*] client 6 face answer
[*] server flag 2
[*] Second flag: FCSC{e22bf8e131d553b7c80a2358f2d52b424d6b349581c893f6904806fe5b379ed6}
[*] Process './client' stopped with exit code 1 (pid 12149)
[*] Closed connection to challenges.france-cybersecurity-challenge.fr port 2251
```

## Conclusion

This was a very interesting challenge, it was quite fun to understand how this protocol works and to break it. Thanks for the challenge!
