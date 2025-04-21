#include <string.h>
#include "thread.h"
#include "encoder.h"

#define OKMSG "OK"
#define ERRMSG "Encoding error"

const char b64_chars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

int b64encode(char* dec, u_int dec_size, char* enc, u_int enc_size) {
  u_int a = 0;
  u_int c = 0;
  u_int j = 0;
  u_int i = 0;
  u_char b;
  while (i < dec_size) {
    u_char d = dec[i];
    a <<= 8;
    a |= d;
    c += 8;
    while (c >= 6) {
      if (j >= enc_size) {
        return -1;
      }
      c -= 6;
      b = (a >> c) & 0x7f;
      a &= ((1 << c) - 1);
      enc[j] = b64_chars[b];
      j++;
    }
    i++;
  }
  while (j % 4 != 0) {
    if (j >= enc_size) {
      return -1;
    }
    if (c > 0) {
      b = a << (6-c);
      enc[j] = b64_chars[b];
      a = 0;
      c = 0;
    } else {
      enc[j] = '=';
    }
    j++;
  }
  if (j >= enc_size) {
    return -1;
  }
  enc[j] = 0;
  return j;
}


void* encoder_thread(void* arg) {
  u_int enc_size;
  u_int dec_size;

  char* enc;
  struct msg* s_msg;
  struct msg* r_msg;

  struct thread* thread = (struct thread*)arg;

  while (thread->stop == 0) {
    r_msg = recv_msg(thread);
    if (r_msg != NULL) {
      dec_size = *((u_short*)r_msg->data);
      if (dec_size > 0) {
        enc_size = (((dec_size - 1) / 3) + 1) * 4 + 1;
        enc = malloc(enc_size);
        int res_size = b64encode(r_msg->data+2, dec_size, enc, enc_size);

        if (res_size < 0) {
          s_msg = create_msg(TID_ENCODER, TID_INTERFACE, sizeof(ERRMSG)+2);
          s_msg->data[0] = 1;
          strncpy(s_msg->data+1, ERRMSG, sizeof(ERRMSG)+1);
          send_msg(s_msg);
        } else {
          s_msg = create_msg(TID_ENCODER, TID_INTERFACE, res_size+2);
          s_msg->data[0] = 1;
          memcpy(s_msg->data+1, enc, res_size);
          send_msg(s_msg);
        }
        free(enc);
      }
      free(r_msg);
    }
  }
  return NULL;
}
