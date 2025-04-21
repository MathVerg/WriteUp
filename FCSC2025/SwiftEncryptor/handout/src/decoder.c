#include <string.h>
#include "thread.h"
#include "decoder.h"

#define OKMSG "OK"
#define ERRMSG "Invalid base64"

const char b64_inv[] = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};

int b64decode(char* enc, u_int enc_size, char* dec, u_int dec_size) {
  u_int a = 0;
  u_int c = 0;
  u_int j = 0;
  for (u_int i = 0; i < enc_size; i++) {
    u_char e = enc[i];
    if (e == '=') {
      if (c == 2 && (i+1) == enc_size) {
        return j;
      } else if (c == 4 && (i+2) == enc_size && enc[i+1] == '=') {
        return j;
      } else {
        return -1;
      }
    } else {
      char inv = b64_inv[e];
      if (inv == -1) {
        return -1;
      }
      a <<= 6;
      a |= inv;
      c += 6;
      if (c >= 8) {
        if (j >= dec_size) {
          return -1;
        }
        c -= 8;
        dec[j] = (a >> c) & 0xff;
        a &= ((1 << c) - 1);
        j++;
      }
    }
  }
  if (c != 0) {
    return -1;
  }
  return j;
}


void* decoder_thread(void* arg) {
  u_int enc_size;
  u_int dec_size;

  char* dec;
  struct msg* s_msg;
  struct msg* r_msg;

  struct thread* thread = (struct thread*)arg;

  while (thread->stop == 0) {
    r_msg = recv_msg(thread);
    if (r_msg != NULL) {
      enc_size = strlen(r_msg->data);
      if (enc_size > 0) {
        dec_size = (enc_size * 3) / 4;
        dec = malloc(dec_size);
        int res_size = b64decode(r_msg->data, enc_size, dec, dec_size);

        if (res_size < 0) {
          s_msg = create_msg(TID_DECODER, TID_INTERFACE, sizeof(ERRMSG)+2);
          s_msg->data[0] = 1;
          strncpy(s_msg->data+1, ERRMSG, sizeof(ERRMSG)+1);
          send_msg(s_msg);
        } else {
          s_msg = create_msg(TID_DECODER, TID_INTERFACE, sizeof(OKMSG)+2);
          s_msg->data[0] = 0;
          strncpy(s_msg->data+1, OKMSG, sizeof(OKMSG)+1);
          send_msg(s_msg);

          s_msg = create_msg(TID_DECODER, TID_SPLITTER, res_size+2);
          *((u_short*)s_msg->data) = res_size;
          memcpy(s_msg->data+2, dec, res_size);
          send_msg(s_msg);
        }
        free(dec);
      }
      free(r_msg);
    }
  }
  return NULL;
}
