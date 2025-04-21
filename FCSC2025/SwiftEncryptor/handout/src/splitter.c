#include <string.h>
#include "thread.h"
#include "joiner.h"
#include "encryptor.h"
#include "splitter.h"

#define OKMSG "OK"
#define ERRMSG "No data to encrypt"

void* splitter_thread(void* arg) {
  struct msg* s_msg;
  struct msg* r_msg;
  u_short data_size;
  u_int worker_id;

  struct thread* thread = (struct thread*)arg;

  while (thread->stop == 0) {
    r_msg = recv_msg(thread);
    if (r_msg != NULL) {
      data_size = *((u_short*)r_msg->data);
      if (data_size != 0) {

        for (u_int i = 0; i < WORKERS_COUNT; i++) {
          worker_id = MAIN_THREADS_COUNT+i;
          destroy_thread(worker_id);
        }

        WORKERS_COUNT = 0;
        if (WORKERS != NULL) {
          free(WORKERS);
        }

        destroy_thread(TID_JOINER);

        WORKERS_COUNT = (data_size-1)/BLOCK_SIZE + 1;
        WORKERS = malloc(WORKERS_COUNT * sizeof(struct thread*));

        create_thread(TID_JOINER, &joiner_thread);

        for (u_int i = 0; i < WORKERS_COUNT; i++) {
          worker_id = MAIN_THREADS_COUNT+i;
          create_thread(worker_id, &encryptor_thread);
        }

        for (u_int i = 0; i < WORKERS_COUNT; i++) {
          worker_id = MAIN_THREADS_COUNT+i;
          s_msg = create_msg(TID_SPLITTER, worker_id, BLOCK_SIZE);
          if (BLOCK_SIZE <= data_size) {
            memcpy(s_msg->data, r_msg->data + 2 + i*BLOCK_SIZE, BLOCK_SIZE);
          } else {
            memcpy(s_msg->data, r_msg->data + 2 + i*BLOCK_SIZE, data_size);
          }
          data_size -= BLOCK_SIZE;
          send_msg(s_msg);
        }

        s_msg = create_msg(TID_SPLITTER, TID_INTERFACE, sizeof(OKMSG)+2);
        s_msg->data[0] = 0;
        strncpy(s_msg->data+1, OKMSG, sizeof(OKMSG)+1);
        send_msg(s_msg);

        free(r_msg);
      }
    }
  }

  for (u_int i = 0; i < WORKERS_COUNT; i++) {
    worker_id = MAIN_THREADS_COUNT+i;
    destroy_thread(worker_id);
  }

  WORKERS_COUNT = 0;
  if (WORKERS != NULL) {
    free(WORKERS);
  }

  destroy_thread(TID_JOINER);
  return NULL;
}
