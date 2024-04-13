#ifndef _CLIENT_H
#define _CLIENT_H

typedef unsigned char uchar;
typedef unsigned char byte;
typedef unsigned short ushort;

#define IS_ENCRYPTED 1
#define ACK 2
#define SEND_KEY 4
#define HELLO 8
#define FLAG 16
#define PULL 0x20
#define FACE 0x40
#define FACE_ANSWER 0x80

typedef struct prefixed_buf_t {
    uchar len;
    uchar content[];
} prefixed_buf_t;

typedef struct shared_key_t {
    uchar len;
    uchar key[];
} shared_key_t;

typedef struct message_t {
    uchar client_id;
    char _pad;
    ushort seq;
    uchar type;
    uchar len;
    uchar payload[];
} message_t;

typedef struct client_t {
    uchar id;
    char _pad0[2];
    ushort seq;
    char _pad1[3];
    uchar shared_key[16];
    char _pad2[16];
    char terminator;
} client_t;

typedef struct encrypted_payload_t {
    byte iv[12];
    byte tag[16];
    uchar len;
    byte payload[];
} encrypted_payload_t;

typedef struct encrypted_message_t {
    byte client_id;
    char _pad[0];
    ushort seq;
    uchar type;
    uchar len;
    encrypted_payload_t encrypted_payload;
} encrypted_message_t;

#endif // _CLIENT_H