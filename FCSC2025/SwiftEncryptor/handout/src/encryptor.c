#include <string.h>
#include "thread.h"
#include "encryptor.h"

// TODO: implémenter la crypto post-quantique

void encrypt(char* dec, char* enc) {
  char secret_key[] = "\x5e\x5f\xc3\x3d\xb9\x27\x6f\x6e\xd8\xd5\xce\xeb\x1e\x0e\x75\x8d";
  for (u_int i = 0; i < BLOCK_SIZE; i++) {
    enc[i] = dec[i] ^ secret_key[i];
  }
}

void* encryptor_thread(void* arg) {
  char enc[BLOCK_SIZE] = "";
  struct msg* s_msg;
  struct msg* r_msg;

  struct thread* thread = (struct thread*)arg;

  while (thread->stop == 0) {
    r_msg = recv_msg(thread);
    if (r_msg != NULL) {
      encrypt(r_msg->data, enc);

      s_msg = create_msg(thread->id, TID_JOINER, BLOCK_SIZE+2);
      *((u_short*)s_msg->data) = thread->id - MAIN_THREADS_COUNT;
      memcpy(s_msg->data+2, enc, BLOCK_SIZE);
      send_msg(s_msg);

      free(r_msg);
      return NULL;
    }
  }
  return NULL;
}
