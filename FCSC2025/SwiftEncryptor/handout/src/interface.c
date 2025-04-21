#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "thread.h"
#include "interface.h"

#define MAX_INPUT_SIZE 0x4000
#define OKMSG "OK"
#define ERRMSG "Empty input"

void* interface_thread(void* arg) {
  int size;
  char input[MAX_INPUT_SIZE] = "";
  struct msg* s_msg;
  struct msg* r_msg;

  struct thread* thread = (struct thread*)arg;

  while (thread->stop == 0) {
    fputs("> ", stdout);
    if (fgets(input, MAX_INPUT_SIZE, stdin)) {
      if (input[0] == '\n') {
        printf("[%s] %s\n", THREAD_NAMES[TID_INTERFACE], ERRMSG);
        continue;
      }

      size = strlen(input);
      if (input[size-1] == '\n') {
        input[size-1] = 0;
      } else {
        size ++;
      }

      printf("[%s] %s\n", THREAD_NAMES[TID_INTERFACE], OKMSG);

      s_msg = create_msg(TID_INTERFACE, TID_DECODER, size);
      memcpy(s_msg->data, input, size);
      send_msg(s_msg);

      bool wait = true;
      while (wait) {
        r_msg = recv_msg(thread);
        if (r_msg != NULL) {
          if (r_msg->data[0] == 1) {
            wait = false;
          }
          printf("[%s] %s\n", THREAD_NAMES[r_msg->src], r_msg->data+1);
          free(r_msg);
        }
      }
    } else {
      break;
    }
  }
  return NULL;
}
