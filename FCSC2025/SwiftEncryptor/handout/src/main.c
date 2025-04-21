#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "thread.h"
#include "interface.h"
#include "decoder.h"
#include "splitter.h"
#include "joiner.h"
#include "encoder.h"

int main(void) {
  setvbuf(stdin, NULL, _IONBF, 0);
  setvbuf(stdout, NULL, _IONBF, 0);

  system("BANNER='Swift Encryptor'; command -v toilet > /dev/null && toilet -f emboss -F border $BANNER || echo \"\n$BANNER\n\"");

  create_thread(TID_INTERFACE, &interface_thread);
  create_thread(TID_DECODER, &decoder_thread);
  create_thread(TID_SPLITTER, &splitter_thread);
  create_thread(TID_ENCODER, &encoder_thread);

  pthread_join(MAIN_THREADS[TID_INTERFACE]->pthread, NULL);

  destroy_thread(TID_INTERFACE);
  destroy_thread(TID_DECODER);
  destroy_thread(TID_SPLITTER);
  destroy_thread(TID_ENCODER);

  return 0;
}
