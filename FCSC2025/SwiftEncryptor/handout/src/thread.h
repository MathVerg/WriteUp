#ifndef THREAD_H
#define THREAD_H

#include <stdlib.h>
#include <pthread.h>

#define MAIN_THREADS_COUNT 5
#define TID_INTERFACE 0
#define TID_DECODER 1
#define TID_SPLITTER 2
#define TID_JOINER 3
#define TID_ENCODER 4
#define BLOCK_SIZE 0x10

struct msg {
  struct msg* next_msg;
  u_char src;
  u_char dst;
  char data[];
};

struct thread {
  u_int id;
  u_char stop;
  void* thread_main;
  pthread_t pthread;
  pthread_mutex_t mutex;
  pthread_cond_t cond;
  struct msg* queue;
};

extern const char* THREAD_NAMES[MAIN_THREADS_COUNT];
extern struct thread* MAIN_THREADS[MAIN_THREADS_COUNT];

extern uint WORKERS_COUNT;
extern struct thread** WORKERS;

extern void create_thread(u_int id, void* (*thread_main)(void *));
extern void destroy_thread(u_int id);

extern struct msg* create_msg(u_char src, u_char dst, u_int size);
extern struct msg* recv_msg(struct thread* thread);
extern void send_msg(struct msg* msg);

#endif
