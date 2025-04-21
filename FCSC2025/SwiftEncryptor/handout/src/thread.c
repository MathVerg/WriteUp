#include <stdlib.h>
#include "thread.h"

const char* THREAD_NAMES[] = {
  "interface",
  "decoder",
  "splitter",
  "joiner",
  "encoder"
};

struct thread* MAIN_THREADS[MAIN_THREADS_COUNT];

uint WORKERS_COUNT = 0;
uint WORKERS_SIZE = 0;
struct thread** WORKERS = NULL;

void create_thread(u_int id, void* (*thread_main)(void *)) {
  struct thread* thread = malloc(sizeof(struct thread));
  thread->id = id;
  thread->stop = 0;
  thread->queue = NULL;
  thread->thread_main = thread_main;
  pthread_mutex_init(&thread->mutex, NULL);
  pthread_cond_init(&thread->cond, NULL);
  pthread_create(&thread->pthread, NULL, thread_main, thread);

  if (id < MAIN_THREADS_COUNT) {
    MAIN_THREADS[id] = thread;
  } else {
    id -= MAIN_THREADS_COUNT;
    if (id < WORKERS_COUNT) {
      WORKERS[id] = thread;
    }
  }
}

void destroy_thread(u_int id) {
  struct thread* thread;
  if (id < MAIN_THREADS_COUNT) {
    thread = MAIN_THREADS[id];
    MAIN_THREADS[id] = NULL;
  } else {
    id -= MAIN_THREADS_COUNT;
    if (id < WORKERS_COUNT) {
      thread = WORKERS[id];
      WORKERS[id] = NULL;
    }
  }

  if (thread != NULL) {
    thread->stop = 1;
    pthread_cond_signal(&thread->cond);
    pthread_join(thread->pthread, NULL);
    pthread_mutex_destroy(&thread->mutex);
    free(thread);
  }
}

struct msg* create_msg(u_char src, u_char dst, u_int size) {
  struct msg* msg = calloc(sizeof(struct msg) + size, 1);
  msg->next_msg = NULL;
  msg->src = src;
  msg->dst = dst;
  return msg;
}

struct msg* recv_msg(struct thread* thread) {
  struct msg* msg = NULL;
  pthread_mutex_lock(&thread->mutex);
  if (thread->queue == NULL) {
    pthread_cond_wait(&thread->cond, &thread->mutex);
  }
  if (thread->queue != NULL) {
    msg = thread->queue;
    thread->queue = msg->next_msg;
  }
  pthread_mutex_unlock(&thread->mutex);
  return msg;
}

void send_msg(struct msg* msg) {
  u_char dst = msg->dst;
  struct thread* dst_thread = NULL;
  if (dst < MAIN_THREADS_COUNT) {
    dst_thread = MAIN_THREADS[dst];
  } else {
    dst -= MAIN_THREADS_COUNT;
    if (dst < WORKERS_COUNT) {
      dst_thread = WORKERS[dst];
    }
  }

  if (dst_thread != NULL) {
    pthread_mutex_lock(&dst_thread->mutex);
    struct msg* last = (struct msg*)&dst_thread->queue;
    while (last->next_msg != NULL) {
      last = last->next_msg;
    }
    last->next_msg = msg;
    pthread_cond_signal(&dst_thread->cond);
    pthread_mutex_unlock(&dst_thread->mutex);
  } else {
    free(msg);
  }
}
