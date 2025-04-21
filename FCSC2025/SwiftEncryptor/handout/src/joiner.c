#include <string.h>
#include <alloca.h>
#include "thread.h"
#include "joiner.h"

#define OKMSG "OK"

void* joiner_thread(void* arg) {
  struct msg* s_msg;
  struct msg* r_msg;

  struct thread* thread = (struct thread*)arg;

  u_int joined_count = 0;
  u_int total_size = WORKERS_COUNT * BLOCK_SIZE;
  u_char* join_buf = alloca(total_size);
  memset(join_buf, 0, total_size);

  while (thread->stop == 0) {
    r_msg = recv_msg(thread);
    if (r_msg != NULL) {
      u_short offset = *((u_short*)r_msg->data);
      memcpy(join_buf + offset * BLOCK_SIZE, r_msg->data+2, BLOCK_SIZE);
      joined_count++;

      free(r_msg);

      if (joined_count == WORKERS_COUNT) {
        s_msg = create_msg(TID_JOINER, TID_INTERFACE, sizeof(OKMSG)+2);
        s_msg->data[0] = 0;
        strncpy(s_msg->data+1, OKMSG, sizeof(OKMSG)+1);
        send_msg(s_msg);

        total_size = WORKERS_COUNT * BLOCK_SIZE;
        s_msg = create_msg(TID_JOINER, TID_ENCODER, total_size+2);
        *((u_short*)s_msg->data) = total_size;
        memcpy(s_msg->data+2, join_buf, total_size);
        send_msg(s_msg);
        return NULL;
      }
    }
  }
  return NULL;
}
