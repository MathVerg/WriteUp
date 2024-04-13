#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <openssl/evp.h>
#include <openssl/ec.h>
#include <openssl/param_build.h>
#include <openssl/sha.h>
#include <openssl/rand.h>

#include "client.h"

byte generate_ec_key(EVP_PKEY **key) {
    int iVar1;
    byte retval;
    EVP_PKEY *params;
    EVP_PKEY_CTX *pctx;
    EVP_PKEY_CTX *kctx;
    pctx = (EVP_PKEY_CTX *)0x0;
    kctx = (EVP_PKEY_CTX *)0x0;
    params = (EVP_PKEY *)0x0;
    retval = 0;
    if (key != (EVP_PKEY **)0x0) {
        pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_EC,(ENGINE *)0x0);
        if (pctx != (EVP_PKEY_CTX *)0x0) {
            iVar1 = EVP_PKEY_paramgen_init(pctx);
            if (iVar1 == 1) {
                iVar1 = EVP_PKEY_CTX_set_ec_paramgen_curve_nid(pctx,NID_X9_62_prime256v1);
                if (iVar1 == 1) {
                    iVar1 = EVP_PKEY_paramgen(pctx,&params);
                    if (iVar1 == 1) {
                        kctx = EVP_PKEY_CTX_new(params,(ENGINE *)0x0);
                        if (kctx != (EVP_PKEY_CTX *)0x0) {
                            iVar1 = EVP_PKEY_keygen_init(kctx);
                            if (iVar1 == 1) {
                                iVar1 = EVP_PKEY_keygen(kctx,key);
                                if (iVar1 == 1) {
                                retval = 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (params != (EVP_PKEY *)0x0) {
        EVP_PKEY_free(params);
        params = (EVP_PKEY *)0x0;
    }
    if (pctx != (EVP_PKEY_CTX *)0x0) {
        EVP_PKEY_CTX_free(pctx);
        pctx = (EVP_PKEY_CTX *)0x0;
    }
    if (kctx != (EVP_PKEY_CTX *)0x0) {
        EVP_PKEY_CTX_free(kctx);
        kctx = (EVP_PKEY_CTX *)0x0;
    }
    return retval;
}

byte extract_public_key_octet_string(EVP_PKEY *key,void *out,size_t* out_len) {
    byte retval;
    size_t outlen;
    void *buf;

    buf = (void *)0x0;
    outlen = 0;
    if (((key != (EVP_PKEY *)0x0) && (out != (void *)0x0)) && (out_len != (size_t *)0)) {
        retval = EVP_PKEY_get_octet_string_param(key,"pub",0,0,&outlen);
        if (retval == 1) {
            buf = CRYPTO_malloc((int)outlen,"src/ecdh.c",0x80);
            if (buf != (void *)0x0) {
                retval = EVP_PKEY_get_octet_string_param(key,"pub",buf,outlen,&outlen);
                if (retval == 1) {
                    *(char *)out_len = (char)outlen;
                    *(void **)out = buf;
                    retval = 1;
                    return retval;
                }
            }
        }
    }
    retval = 0;
    return retval;
}

byte send_clear_message(message_t *msg) {
  byte retv;
  int i;
  
  if (msg == (message_t *)0x0) {
    retv = 0;
  }
  else {
    printf("SEND: ");
    printf("%02hhX",msg->client_id);
    printf("%04hX",msg->seq);
    printf("%02hhX",msg->type);
    printf("%02hhX", msg->len);
    for (i = 0; i < (int)(uint)msg->len; i = i + 1) {
      printf("%02hhX",msg->payload[i]);
    }
    putchar(10);
    fflush(stdout);
    retv = 1;
  }
  return retv;
}

byte recv_clear_message(client_t *client,message_t **message) {
  int iVar1;
  message_t *msg;
  byte retval;
  int i;
  
  retval = 0;
  if (message != (message_t **)0x0) {
    msg = (message_t *)malloc(8);
    *message = msg;
    if (*message != (message_t *)0x0) {
      puts("RECV:");
      fflush(stdout);
      iVar1 = scanf("%02hhX",&(*message)->client_id);
      if (iVar1 == 1) {
        iVar1 = scanf("%04hX",&(*message)->seq);
        if (iVar1 == 1) {
          iVar1 = scanf("%02hhX",&(*message)->type);
          if (iVar1 == 1) {
            iVar1 = scanf("%02hhX",&(*message)->len);
            if (iVar1 == 1) {
              msg = (message_t *)realloc(*message,(ulong)(*message)->len + 8);
              *message = msg;
              if (*message != (message_t *)0x0) {
                for (i = 0; i < (int)(uint)(*message)->len; i = i + 1) {
                  iVar1 = scanf("%02hhX",(*message)->payload + i);
                  if (iVar1 != 1) return retval;
                }
                if (((*message)->client_id == client->id) && (client->seq < (*message)->seq)) {
                  client->seq = (*message)->seq;
                  retval = 1;
                }
              }
            }
          }
        }
      }
    }
  }
  return retval;
}

byte ack(client_t *client) {
  int iVar1;
  byte retval;
  message_t *msg;
  
  retval = 0;
  msg = (message_t *)0x0;
  if (client != (client_t *)0x0) {
    msg = (message_t *)malloc(7);
    if (msg != (message_t *)0x0) {
      msg->client_id = client->id;
      client->seq = client->seq + 1;
      msg->seq = client->seq;
      msg->type = ACK;
      msg->len = 1;
      msg->payload[0] = 1;
      iVar1 = send_clear_message(msg);
      retval = (byte)iVar1;
    }
  }
  if (msg != (message_t *)0x0) {
    free(msg);
  }
  return retval;
}

byte recv_ack(client_t *client,message_t **message) {
  int iVar1;
  
  if (((message != (message_t **)0x0) &&
      (iVar1 = recv_clear_message(client,message), (char)iVar1 == '\x01')) &&
     ((*message)->type == ACK)) {
    return 1;
  }
  if (*message != (message_t *)0x0) {
    free(*message);
    *message = (message_t *)0x0;
  }
  return 0;
}

byte send_pubkey(client_t *client,void *pubkey,int key_len) {
  byte retval;
  message_t *msg;
  
  retval = 0;
  msg = (message_t *)0x0;
  if ((pubkey != (void *)0x0) && (client != (client_t *)0x0)) {
    msg = (message_t *)malloc((long)key_len + 6);
    if (msg != (message_t *)0x0) {
      msg->client_id = client->id;
      client->seq = client->seq + 1;
      msg->seq = client->seq;
      msg->type = SEND_KEY;
      msg->len = (byte)key_len;
      memcpy(msg->payload,pubkey,(long)key_len);
      retval = send_clear_message(msg);
    }
  }
  if (msg != (message_t *)0x0) {
    free(msg);
  }
  return retval;
}

byte recv_pubkey(client_t *client,message_t **msg) {
  int iVar1;
  
  if (((msg != (message_t **)0x0) && (iVar1 = recv_clear_message(client,msg), (char)iVar1 == '\x01')
      ) && ((*msg)->type == SEND_KEY)) {
    return 1;
  }
  if (*msg != (message_t *)0x0) {
    free(*msg);
    *msg = (message_t *)0x0;
  }
  return 0;
}

byte load_pubkey(uchar *buf,uchar len,EVP_PKEY **key) {
  int iVar1;
  OSSL_PARAM_BLD * bld;
  byte retval;
  OSSL_PARAM  *params;
  EVP_PKEY_CTX *kctx;
  
  retval = 0;
  bld = OSSL_PARAM_BLD_new();
  params = 0;
  kctx = (EVP_PKEY_CTX *)0x0;
  if (((buf != (uchar *)0x0) && (key != (EVP_PKEY **)0x0)) && (bld != 0)) {
    iVar1 = OSSL_PARAM_BLD_push_utf8_string(bld,"group","prime256v1",0);
    if (iVar1 == 1) {
      iVar1 = OSSL_PARAM_BLD_push_octet_string(bld,"pub",buf,len);
      if (iVar1 == 1) {
        params = OSSL_PARAM_BLD_to_param(bld);
        if (params != 0) {
          kctx = (EVP_PKEY_CTX *)EVP_PKEY_CTX_new_from_name(0,"EC",0);
          if (kctx != (EVP_PKEY_CTX *)0x0) {
            iVar1 = EVP_PKEY_fromdata_init(kctx);
            if (iVar1 == 1) {
              iVar1 = EVP_PKEY_fromdata(kctx,key,0x87,params);
              if (iVar1 == 1) {
                retval = 1;
              }
            }
          }
        }
      }
    }
  }
  if (bld != 0) {
    OSSL_PARAM_BLD_free(bld);
  }
  if (params != 0) {
    OSSL_PARAM_free(params);
  }
  if (kctx != (EVP_PKEY_CTX *)0x0) {
    EVP_PKEY_CTX_free(kctx);
  }
  return retval;
}

byte derive_shared_key(EVP_PKEY *my_key,EVP_PKEY *peer_key,shared_key_t **shared_key) {
  int iVar1;
  uchar *puVar2;
  byte retval;
  size_t shared_key_len;
  EVP_PKEY_CTX *ctx;
  shared_key_t *shared_key_;
  byte digest [16];

  retval = 0;
  ctx = (EVP_PKEY_CTX *)0x0;
  shared_key_ = (shared_key_t *)0x0;
  shared_key_len = 0;
  digest[0] = 0;
  digest[1] = 0;
  digest[2] = 0;
  digest[3] = 0;
  digest[4] = 0;
  digest[5] = 0;
  digest[6] = 0;
  digest[7] = 0;
  digest[8] = 0;
  digest[9] = 0;
  digest[10] = 0;
  digest[11] = 0;
  digest[12] = 0;
  digest[13] = 0;
  digest[14] = 0;
  digest[15] = 0;
  if (((my_key != (EVP_PKEY *)0x0) && (peer_key != (EVP_PKEY *)0x0)) &&
     (shared_key != (shared_key_t **)0x0)) {
    shared_key_ = (shared_key_t *)malloc(1);
    if (shared_key_ != (shared_key_t *)0x0) {
      ctx = EVP_PKEY_CTX_new(my_key,(ENGINE *)0x0);
      if (ctx != (EVP_PKEY_CTX *)0x0) {
        iVar1 = EVP_PKEY_derive_init(ctx);
        if (iVar1 == 1) {
          iVar1 = EVP_PKEY_derive_set_peer(ctx,peer_key);
          if (iVar1 == 1) {
            iVar1 = EVP_PKEY_derive(ctx,(uchar *)0x0,&shared_key_len);
            if (iVar1 == 1) {
              shared_key_->len = (byte)shared_key_len;
              shared_key_ = (shared_key_t *)realloc(shared_key_,(ulong)shared_key_->len + 1);
              if (shared_key_ != (shared_key_t *)0x0) {
                iVar1 = EVP_PKEY_derive(ctx,shared_key_->key,&shared_key_len);
                if (iVar1 == 1) {
                  shared_key_->len = (byte)shared_key_len;
                  puVar2 = SHA1(shared_key_->key,(ulong)shared_key_->len,digest);
                  if (puVar2 != (uchar *)0x0) {
                    shared_key_->len = 0x10;
                    shared_key_ = (shared_key_t *)realloc(shared_key_,(ulong)shared_key_->len + 1);
                    if (shared_key_ != (shared_key_t *)0x0) {
                      memcpy(shared_key_->key,digest,(ulong)shared_key_->len);
                      *shared_key = shared_key_;
                      retval = 1;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  if (ctx != (EVP_PKEY_CTX *)0x0) {
    EVP_PKEY_CTX_free(ctx);
  }
  return retval;
}

byte prefix_with_len(void *buf,int len,prefixed_buf_t **output) {
  prefixed_buf_t *buf_;
  
  if ((output != (prefixed_buf_t **)0x0) &&
     (buf_ = (prefixed_buf_t *)malloc((long)len + 1), buf_ != (prefixed_buf_t *)0x0)) {
    if (buf != (void *)0x0) {
      memcpy(buf_->content,buf,(long)len);
    }
    buf_->len = (byte)len;
    *output = buf_;
    return 1;
  }
  return 0;
}

byte encrypt_payload(uchar *shared_key,prefixed_buf_t *payload,prefixed_buf_t *seq, encrypted_payload_t **output) {
  int iVar1;
  const EVP_CIPHER *cipher;
  byte retval;
  int len;
  EVP_CIPHER_CTX *ctx;
  encrypted_payload_t *encrypted;
  
  retval = 0;
  ctx = (EVP_CIPHER_CTX *)0x0;
  encrypted = (encrypted_payload_t *)0x0;
  len = 0;
  if ((((shared_key != (uchar *)0x0) && (payload != (prefixed_buf_t *)0x0)) &&
      (seq != (prefixed_buf_t *)0x0)) && (output != (encrypted_payload_t **)0x0)) {
    encrypted = (encrypted_payload_t *)malloc((ulong)payload->len + 0x1d);
    if (encrypted != (encrypted_payload_t *)0x0) {
      ctx = EVP_CIPHER_CTX_new();
      if (ctx != (EVP_CIPHER_CTX *)0x0) {
        cipher = EVP_aes_128_gcm();
        iVar1 = EVP_EncryptInit_ex(ctx,cipher,(ENGINE *)0x0,(uchar *)0x0,(uchar *)0x0);
        if (iVar1 == 1) {
          iVar1 = RAND_bytes(encrypted->iv,0xc);
          if (iVar1 == 1) {
            iVar1 = EVP_EncryptInit_ex(ctx,(EVP_CIPHER *)0x0,(ENGINE *)0x0,shared_key,encrypted->iv)
            ;
            if (iVar1 == 1) {
              iVar1 = EVP_EncryptUpdate(ctx,(uchar *)0x0,&len,(uchar *)seq->content,(uint)seq->len);
              if (iVar1 == 1) {
                iVar1 = EVP_EncryptUpdate(ctx,encrypted->payload,&len,(uchar *)payload->content,
                                          (uint)payload->len);
                if ((iVar1 == 1) && ((int)(uint)payload->len <= len)) {
                  encrypted->len = (uchar)len;
                  iVar1 = EVP_EncryptFinal_ex(ctx,encrypted->payload + len,&len);
                  if ((iVar1 == 1) && ((int)(uint)payload->len <= (int)(len + (uint)encrypted->len))
                     ) {
                    encrypted->len = (char)len + encrypted->len;
                    iVar1 = EVP_CIPHER_CTX_ctrl(ctx,EVP_CTRL_GCM_GET_TAG,0x10,encrypted->tag);
                    if (iVar1 == 1) {
                      *output = encrypted;
                      retval = 1;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  if ((retval != 1) && (encrypted != (encrypted_payload_t *)0x0)) {
    free(encrypted);
    encrypted = (encrypted_payload_t *)0x0;
  }
  if (ctx != (EVP_CIPHER_CTX *)0x0) {
    EVP_CIPHER_CTX_free(ctx);
    ctx = (EVP_CIPHER_CTX *)0x0;
  }
  return retval;
}

byte send_encrypted(client_t *client,message_t *msg) {
  byte bVar1;

  byte retval;
  uint i;
  uint j;
  int k;
  prefixed_buf_t *seq_prefixed;
  encrypted_payload_t *encrypted_message;
  
  retval = 0;
  seq_prefixed = (prefixed_buf_t *)0x0;
  encrypted_message = (encrypted_payload_t *)0x0;
  if (msg != (message_t *)0x0) {
    bVar1 = prefix_with_len(&msg->seq,2,&seq_prefixed);
    if (bVar1 == 1) {
      bVar1 = encrypt_payload(client->shared_key,(prefixed_buf_t *)&msg->len,seq_prefixed,
                              &encrypted_message);
      if (bVar1 == 1) {
        printf("SEND: ");
        printf("%02hhX",msg->client_id);
        printf("%04hX",msg->seq);
        printf("%02hhX",msg->type | IS_ENCRYPTED);
        for (i = 0; i < 0xc; i = i + 1) {
          printf("%02hhX",encrypted_message->iv[(int)i]);
        }
        for (j = 0; j < 0x10; j = j + 1) {
          printf("%02hhX",encrypted_message->tag[(int)j]);
        }
        printf("%02hhX",encrypted_message->len);
        for (k = 0; k < (int)(uint)encrypted_message->len; k = k + 1) {
          printf("%02hhX",encrypted_message->payload[k]);
        }
        putchar(10);
        fflush(stdout);
        retval = 1;
      }
    }
  }
  if (seq_prefixed != (prefixed_buf_t *)0x0) {
    free(seq_prefixed);
    seq_prefixed = (prefixed_buf_t *)0x0;
  }
  if (encrypted_message != (encrypted_payload_t *)0x0) {
    free(encrypted_message);
    encrypted_message = (encrypted_payload_t *)0x0;
  }
  return retval;
}

byte send_hello(client_t *client) {
  size_t hello_len;
  byte retval;
  message_t *message;
  char hello [9];

  retval = 0;
  message = (message_t *)0x0;
  hello[0] = 'H';
  hello[1] = 'E';
  hello[2] = 'L';
  hello[3] = 'O';
  hello[4] = 'E';
  hello[5] = 'H';
  hello[6] = 'L';
  hello[7] = 'O';
  hello[8] = '\0';
  hello_len = strlen(hello);
  if (client != (client_t *)0x0) {
    message = (message_t *)malloc((long)(int)hello_len + 6);
    if (message != (message_t *)0x0) {
      message->client_id = client->id;
      client->seq = client->seq + 1;
      message->seq = client->seq;
      message->type = HELLO;
      message->len = (byte)hello_len;
      memcpy(message->payload,hello,(long)(int)hello_len);
      retval = send_encrypted(client,message);
    }
  }
  if (message != (message_t *)0x0) {
    free(message);
  }
  return retval;
}

byte decrypt_payload(shared_key_t *shared_key,encrypted_payload_t *encrypted_payload, prefixed_buf_t *prefixed_seq,prefixed_buf_t **output) {
  int iVar1;
  const EVP_CIPHER *cipher;
  byte retval;
  int len;
  EVP_CIPHER_CTX *ctx;
  prefixed_buf_t *decrypted_payload;

  retval = 0;
  ctx = (EVP_CIPHER_CTX *)0x0;
  decrypted_payload = (prefixed_buf_t *)0x0;
  len = 0;
  if ((((shared_key != (shared_key_t *)0x0) && (encrypted_payload != (encrypted_payload_t *)0x0)) &&
      (prefixed_seq != (prefixed_buf_t *)0x0)) && (output != (prefixed_buf_t **)0x0)) {
    decrypted_payload = (prefixed_buf_t *)malloc((ulong)encrypted_payload->len + 1);
    if (decrypted_payload != (prefixed_buf_t *)0x0) {
      ctx = EVP_CIPHER_CTX_new();
      if (ctx != (EVP_CIPHER_CTX *)0x0) {
        cipher = EVP_aes_128_gcm();
        iVar1 = EVP_DecryptInit_ex(ctx,cipher,(ENGINE *)0x0,(uchar *)0x0,(uchar *)0x0);
        if (iVar1 == 1) {
          iVar1 = EVP_DecryptInit_ex(ctx,(EVP_CIPHER *)0x0,(ENGINE *)0x0,&shared_key->len,
                                     encrypted_payload->iv);
          if (iVar1 == 1) {
            iVar1 = EVP_DecryptUpdate(ctx,(uchar *)0x0,&len,(uchar *)prefixed_seq->content,
                                      (uint)prefixed_seq->len);
            if (iVar1 == 1) {
              iVar1 = EVP_DecryptUpdate(ctx,(uchar *)decrypted_payload->content,&len,
                                        encrypted_payload->payload,(uint)encrypted_payload->len);
              if (iVar1 == 1) {
                decrypted_payload->len = (byte)len;
                iVar1 = EVP_CIPHER_CTX_ctrl(ctx,EVP_CTRL_GCM_SET_TAG,0x10,encrypted_payload->tag);
                if (iVar1 == 1) {
                  iVar1 = EVP_DecryptFinal_ex(ctx,(uchar *)(decrypted_payload->content + len),&len);
                  if (0 < iVar1) {
                    decrypted_payload->len = (char)len + decrypted_payload->len;
                    *output = decrypted_payload;
                    retval = 1;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  if ((retval != 1) && (decrypted_payload != (prefixed_buf_t *)0x0)) {
    free(decrypted_payload);
    decrypted_payload = (prefixed_buf_t *)0x0;
  }
  if (ctx != (EVP_CIPHER_CTX *)0x0) {
    EVP_CIPHER_CTX_free(ctx);
  }
  return retval;
}

byte recv_encrypted_msg(client_t *client,message_t **msg) {
  byte bVar1;
  int iVar2;
  byte retval;
  uint i;
  uint j;
  int k;
  prefixed_buf_t *prefixed_seq;
  prefixed_buf_t *decrypted_out;
  encrypted_message_t *encrypted_message;
  message_t *decrypted_message;

  retval = 0;
  encrypted_message = (encrypted_message_t *)0x0;
  decrypted_message = (message_t *)0x0;
  prefixed_seq = (prefixed_buf_t *)0x0;
  decrypted_out = (prefixed_buf_t *)0x0;
  if (msg != (message_t **)0x0) {
    encrypted_message = (encrypted_message_t *)malloc(0x22);
    if (encrypted_message != (encrypted_message_t *)0x0) {
      decrypted_message = (message_t *)malloc(6);
      if (decrypted_message != (message_t *)0x0) {
        bVar1 = prefix_with_len(0,2,&prefixed_seq);
        if (bVar1 == 1) {
          puts("RECV:");
          fflush(stdout);
          iVar2 = scanf("%02hhX",&encrypted_message->client_id);
          if (iVar2 == 1) {
            iVar2 = scanf("%04hX",&encrypted_message->seq);
            if (iVar2 == 1) {
              *(ushort *)prefixed_seq->content = encrypted_message->seq;
              iVar2 = scanf("%02hhX",&encrypted_message->type);
              if (iVar2 == 1) {
                for (i = 0; i < 0xc; i = i + 1) {
                  iVar2 = scanf("%02hhX",(encrypted_message->encrypted_payload).iv +
                                                  (long)(int)i + -1);
                  if (iVar2 != 1) goto LAB_RET;
                }
                for (j = 0; j < 0x10; j = j + 1) {
                  iVar2 = scanf("%02hhX",(encrypted_message->encrypted_payload).iv +
                                                  (long)(int)j + 0xb);
                  if (iVar2 != 1) goto LAB_RET;
                }
                iVar2 = scanf("%02hhX",(encrypted_message->encrypted_payload).tag + 0xf);
                if (iVar2 == 1) {
                  encrypted_message =
                       (encrypted_message_t *)
                       realloc(encrypted_message,
                               (ulong)(encrypted_message->encrypted_payload).tag[0xf] + 0x22);
                  if (encrypted_message != (encrypted_message_t *)0x0) {
                    for (k = 0; k < (int)(uint)(encrypted_message->encrypted_payload).tag[0xf];
                        k = k + 1) {
                      iVar2 = scanf("%02hhX",(encrypted_message->encrypted_payload).payload
                                                      + (long)k + -1);
                      if (iVar2 != 1) goto LAB_RET;
                    }
                    if ((encrypted_message->client_id == client->id) &&
                       (decrypted_message->client_id = encrypted_message->client_id,
                       client->seq < encrypted_message->seq)) {
                      client->seq = encrypted_message->seq;
                      decrypted_message->seq = encrypted_message->seq;
                      if ((encrypted_message->type & 1) != 0) {
                        encrypted_message->type = encrypted_message->type & 0xfe;
                        decrypted_message->type = encrypted_message->type;
                        bVar1 = decrypt_payload((shared_key_t *)client->shared_key,
                                                (encrypted_payload_t *)&encrypted_message->len,
                                                prefixed_seq,&decrypted_out);
                        if (bVar1 == 1) {
                          decrypted_message =
                               (message_t *)realloc(decrypted_message,(ulong)decrypted_out->len + 6)
                          ;
                          if (decrypted_message != (message_t *)0x0) {
                            memcpy(decrypted_message->payload,decrypted_out->content,
                                   (ulong)decrypted_out->len);
                            decrypted_message->len = decrypted_out->len;
                            *msg = decrypted_message;
                            retval = 1;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
LAB_RET:
  if ((retval != 1) && (decrypted_message != (message_t *)0x0)) {
    free(decrypted_message);
    decrypted_message = (message_t *)0x0;
  }
  if (decrypted_out != (prefixed_buf_t *)0x0) {
    free(decrypted_out);
    decrypted_out = (prefixed_buf_t *)0x0;
  }
  if (encrypted_message != (encrypted_message_t *)0x0) {
    free(encrypted_message);
    encrypted_message = (encrypted_message_t *)0x0;
  }
  if (prefixed_seq != (prefixed_buf_t *)0x0) {
    free(prefixed_seq);
    prefixed_seq = (prefixed_buf_t *)0x0;
  }
  return retval;
}


byte recv_hello(client_t *client,message_t **msg) {
  char cVar1;
  byte retval;
  
  retval = 0;
  if ((client != (client_t *)0x0) && (msg != (message_t **)0x0)) {
    cVar1 = recv_encrypted_msg(client,msg);
    if ((cVar1 == '\x01') && ((*msg)->type == HELLO)) {
      retval = 1;
    }
  }
  return retval;
}

byte recv_flag(client_t *client,message_t **message) {
  byte bVar1;
  byte retval;
  
  retval = 0;
  if ((client != (client_t *)0x0) && (message != (message_t **)0x0)) {
    bVar1 = recv_encrypted_msg(client,message);
    if ((bVar1 == 1) && ((*message)->type == FLAG)) {
      retval = 1;
    }
  }
  return retval;
}

byte encrypted_ack(client_t *client) {
  byte retval;
  message_t *message;
  
  retval = 0;
  message = (message_t *)0x0;
  if (client != (client_t *)0x0) {
    message = (message_t *)malloc(7);
    if (message != (message_t *)0x0) {
      message->client_id = client->id;
      client->seq = client->seq + 1;
      message->seq = client->seq;
      message->type = ACK;
      message->len = 1;
      message->payload[0] = 1;
      retval = send_encrypted(client,message);
    }
  }
  if (message != (message_t *)0x0) {
    free(message);
  }
  return retval;
}

byte recv_encrypted_ack(client_t *param_1,message_t **msg) {
  byte bVar1;
  
  if ((((param_1 != (client_t *)0x0) && (msg != (message_t **)0x0)) &&
      (bVar1 = recv_encrypted_msg(param_1,msg), bVar1 == 1)) && ((*msg)->type == ACK)) {
    return 1;
  }
  if (*msg != (message_t *)0x0) {
    free(*msg);
    *msg = (message_t *)0x0;
  }
  return 0;
}

byte recv_pull(client_t *client,message_t **message) {
  byte bVar1;
  
  if ((((client != (client_t *)0x0) && (message != (message_t **)0x0)) &&
      (bVar1 = recv_encrypted_msg(client,message), bVar1 == 1)) && ((*message)->type == PULL)) {
    return 1;
  }
  if (*message != (message_t *)0x0) {
    free(*message);
    *message = (message_t *)0x0;
  }
  return 0;
}

byte recv_face(client_t *client,message_t **message) {
  byte bVar1;
  byte retval;
  
  retval = 0;
  if ((client != (client_t *)0x0) && (message != (message_t **)0x0)) {
    bVar1 = recv_encrypted_msg(client,message);
    if ((bVar1 == 1) && ((*message)->type == FACE)) {
      retval = 1;
    }
  }
  return retval;
}

byte send_face_answer(client_t *client,prefixed_buf_t *message){
  message_t *msg;
  byte retval;
  
  retval = 0;
  if (client != (client_t *)0x0) {
    msg = (message_t *)malloc((ulong)message->len + 6);
    if (msg != (message_t *)0x0) {
      msg->client_id = client->id;
      client->seq = client->seq + 1;
      msg->seq = client->seq;
      msg->type = FACE_ANSWER;
      msg->len = message->len;
      memcpy(msg->payload,message->content,(ulong)message->len);
      retval = send_encrypted(client,msg);
    }
  }
  return retval;
}

int main() {
    client_t *me;
    EVP_PKEY *my_key;
    EVP_PKEY *server_key;
    shared_key_t *shared_key;
    void *pkey_octet_string;
    size_t pkey_octet_string_len;
    message_t *recvd_msg;
    prefixed_buf_t *face_answer;
    byte ret;
    me = (client_t *) malloc(sizeof(client_t));
    me->id = 6;
    me->seq = 0;
    me->terminator = 0;

    ret = generate_ec_key(&my_key);
    if (!ret) {
        fprintf(stderr, "key generation\n");
        exit(EXIT_FAILURE);
    }
    ret = extract_public_key_octet_string(my_key, &pkey_octet_string, &pkey_octet_string_len);
    if (!ret) {
        fprintf(stderr, "public key export\n");
        exit(EXIT_FAILURE);
    }
    ret = recv_pubkey(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "public key reception\n");
        exit(EXIT_FAILURE);
    }
    ret = ack(me);
    if (!ret) {
        fprintf(stderr, "ack public key reception\n");
        exit(EXIT_FAILURE);
    }
    ret = load_pubkey(recvd_msg->payload, recvd_msg->len, &server_key);
    if (!ret) {
        fprintf(stderr, "load public key\n");
        exit(EXIT_FAILURE);
    }
    ret = derive_shared_key(my_key, server_key, &shared_key);
    if (!ret) {
        fprintf(stderr, "shared_key derivation\n");
        exit(EXIT_FAILURE);
    }
    free(recvd_msg);
    memcpy(me->shared_key, shared_key->key, 16);
    ret = send_pubkey(me, pkey_octet_string, pkey_octet_string_len);
    if (!ret) {
        fprintf(stderr, "public key send\n");
        exit(EXIT_FAILURE);
    }
    ret = recv_ack(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "ack publi key send\n");
        exit(EXIT_FAILURE);
    }
    free(recvd_msg);
    ret = recv_hello(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "hello receive\n");
        exit(EXIT_FAILURE);
    }
    printf("Hello received: %s\n", recvd_msg->payload);
    free(recvd_msg);
    ret = ack(me);
    if (!ret) {
        fprintf(stderr, "ack hello recv\n");
        exit(EXIT_FAILURE);
    }
    ret = send_hello(me);
    if (!ret) {
        fprintf(stderr, "send hello\n");
        exit(EXIT_FAILURE);
    }
    ret = recv_ack(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "ack send hello\n");
        exit(EXIT_FAILURE);
    }
    free(recvd_msg);
    ret = recv_flag(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "recv flag 1\n");
        exit(EXIT_FAILURE);
    }
    ret = encrypted_ack(me);
    if (!ret) {
        fprintf(stderr, "ack receive flag 1\n");
        exit(EXIT_FAILURE);
    }
    puts((char *)recvd_msg->payload);
    free(recvd_msg);

    ret = recv_pull(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "receive pull\n");
        exit(EXIT_FAILURE);
    }
    free(recvd_msg);

    ret = encrypted_ack(me);
    if (!ret) {
        fprintf(stderr, "ack pull\n");
        exit(EXIT_FAILURE);
    }

    ret  = recv_face(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "receveive face\n");
        exit(EXIT_FAILURE);
    }
    free(recvd_msg);

    ret = encrypted_ack(me);
    if (!ret) {
        fprintf(stderr, "ack face\n");
        exit(EXIT_FAILURE);
    }

    prefix_with_len("\x40", 1, &face_answer);
    ret = send_face_answer(me, face_answer);
    if (!ret) {
        fprintf(stderr, "face_answer\n");
        exit(EXIT_FAILURE);
    }

    ret = recv_encrypted_ack(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "receive ack face_answer\n");
        exit(EXIT_FAILURE);
    }

    free(recvd_msg);
    ret = recv_flag(me, &recvd_msg);
    if (!ret) {
        fprintf(stderr, "recv flag 2\n");
        exit(EXIT_FAILURE);
    }
    ret = encrypted_ack(me);
    if (!ret) {
        fprintf(stderr, "ack receive flag 2\n");
        exit(EXIT_FAILURE);
    }
    puts((char *)recvd_msg->payload);
    free(recvd_msg);

    return ret;
}   
