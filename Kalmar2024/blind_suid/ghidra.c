undefined8 main(int argc,char **argv)

{
  int iVar1;
  long lVar2;
  undefined8 retval;
  long in_FS_OFFSET;
  int i;
  int j;
  ulong cmd_hash;
  undefined password_buf [40];
  long canary;
  char *cmd;
  
  canary = *(long *)(in_FS_OFFSET + 0x28);
  plt_printf("Password: ");
  lVar2 = plt_fgets(password_buf,0x20,_stdin);
  if (lVar2 == 0) {
    retval = 0xffffffff;
    goto LAB_RETURN;
  }
  lVar2 = plt_strcspn(password_buf,"\n");
  password_buf[lVar2] = 0;
  iVar1 = plt_strcmp("K33pth15s3Cret",password_buf);
  if (iVar1 != 0) {
    plt_puts("Wrong password!");
    retval = 0xffffffff;
    goto LAB_RETURN;
  }
  plt_puts("Correct!");
  iVar1 = plt_setreuid(0,0);
  if (iVar1 != 0) {
    retval = 0xffffffff;
    goto LAB_RETURN;
  }
  if (argc < 2) {
    retval = 0xffffffff;
    goto LAB_RETURN;
  }
  cmd = argv[1];
  cmd_hash = 1;
  for (i = 0; (i < 0xd && (cmd[i] != '\0')); i = i + 1) {
    cmd_hash = cmd_hash * 0x1a;
    if (('@' < cmd[i]) && (cmd[i] < '[')) {
      cmd_hash = cmd_hash + (long)(cmd[i] + -0x41);
    }
    if (('`' < cmd[i]) && (cmd[i] < '{')) {
      cmd_hash = cmd_hash + (long)(cmd[i] + -0x61);
    }
  }
  cmd_hash = (cmd_hash ^ 0xaaaaaaaaaaaaaaaa) << 0x14 | (cmd_hash ^ 0xaaaaaaaaaaaaaaaa) >> 0x2c;
  for (j = 0; j < 0x10; j = j + 1) {
    cmd_hash = cmd_hash ^ cmd_hash >> 0xc;
    cmd_hash = cmd_hash ^ cmd_hash << 0x19;
    cmd_hash = cmd_hash ^ cmd_hash >> 0x1b;
  }
  if (cmd_hash == 0xefcd7bdd75fb0253) {
    plt_system("/bin/sleep 5");
  }
  else if (cmd_hash < 0xefcd7bdd75fb0254) {
    if (cmd_hash == 0xa6e3b88d6af92999) {
      plt_system("/usr/bin/head -c 7 /flag.txt");
    }
    else {
      if (0xa6e3b88d6af92999 < cmd_hash) goto LAB_INVALID_COMMAND;
      if (cmd_hash == 0x67228216cde438ef) {
        plt_system("/bin/ls");
      }
      else {
        if (0x67228216cde438ef < cmd_hash) goto LAB_INVALID_COMMAND;
        if (cmd_hash == 0x49ae4d04a4b5ea08) {
          plt_system("/usr/bin/id");
        }
        else {
          if (0x49ae4d04a4b5ea08 < cmd_hash) goto LAB_INVALID_COMMAND;
          if (cmd_hash == 0x39eda4a27c0507ab) {
            plt_puts("Run commands as root");
          }
          else {
            if (0x39eda4a27c0507ab < cmd_hash) goto LAB_INVALID_COMMAND;
            if (cmd_hash == 0x39403f5da078c2a) {
              plt_snprintf(password_buf,0x20,"/usr/bin/wc -c \'%s\'",argv[2]);
              plt_system(password_buf);
            }
            else {
              if (cmd_hash != 0x171880b7af5033ec) goto LAB_INVALID_COMMAND;
              plt_system("/bin/sleep infinity");
            }
          }
        }
      }
    }
  }
  else {
LAB_INVALID_COMMAND:
    plt_puts("Invalid command");
  }
  retval = 0;
LAB_RETURN:
  if (canary != *(long *)(in_FS_OFFSET + 0x28)) {
    retval = plt_stack_chk_fail();
  }
  return retval;
}