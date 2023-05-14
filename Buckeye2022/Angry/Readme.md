# Angry

- Category: Rev
- Difficulty: easy
- Final point value: 216
- Number of solves: 68

A reverse challenge that highly suggested to use symoblic excecution, but it was easily doable without it.

## Challenge description

Fight anger with [angr](https://angr.io/)
Associated file: [angry](./Angry)

## First inspection

```shell
$ file Angry 
Angry: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=722f16df6b8b09063ca2c42ce04d8d1930eba1c8, for GNU/Linux 3.2.0, stripped
$ ./Angry 
Welcome to Angry Frob, not your normal frob.
The special number today is... 42
Enter something for us to frobnicate: 
test
Failure, you didn't send an interesting string.
$ strings Angry
[...]
Welcome to Angry Frob, not your normal frob.
The special number today is... %d
Enter something for us to frobnicate: 
Congratulations, you found the special string to frob.
Failure, you didn't send an interesting string.
[...]
```

Ok, it seems like we have to reach the part where "Congratulations" is printed.

## Decompiling with Ghidra

The code is pretty short, and after some renaming and retyping of the variables, we get the following :
```C
uint encode_char(byte c,byte key)

{
  return (int)(uint)c >> (8 - key % 8 & 0x1f) | (uint)c << key % 8;
}

void encode(char *string_io,char key)

{
  char cVar1;
  size_t len;
  char local_15;
  int i;
  
  len = strlen(string_io);
  local_15 = key;
  for (i = 0; (ulong)(long)i < len; i = i + 1) {
    cVar1 = encode_char(string_io[i],local_15);
    string_io[i] = cVar1;
    local_15 = string_io[i];
  }
  return;
}

int main(void)

{
  int iVar1;
  size_t len;
  size_t lenFlag;
  long in_FS_OFFSET;
  char guess [104];
  long local_20;
  
  local_20 = *(long *)(in_FS_OFFSET + 0x28);
  puts("Welcome to Angry Frob, not your normal frob.");
  printf("The special number today is... %d\n",0x2a);
  puts("Enter something for us to frobnicate: ");
  fgets(guess,99,stdin);
  len = strcspn(guess,"\n");
  guess[len] = '\0';
  encode(guess,0x2a);
  len = strlen(guess);
  lenFlag = strlen(&DAT_00104020);
  if (len == lenFlag) {
    iVar1 = strcmp(guess,&DAT_00104020);
    if (iVar1 == 0) {
      puts("Congratulations, you found the special string to frob.");
      goto LAB_001013d4;
    }
  }
  puts("Failure, you didn\'t send an interesting string.");
LAB_001013d4:
  if (local_20 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
```

So `encode_char` is just a `leftRotate`, that's easy to inverse. Then `encode` has an initialization byte, and then use the previous cipher byte to encode the next plain byte. The resulting encoded string is compared to a string hold in the binary, that we can extract with Ghidra.

## Decoding with Python

We implement the decoding in this [script](./script.py). Running it gives us the flag: `buckeye{st!ll_b3tt3r_th4n_strfry}`