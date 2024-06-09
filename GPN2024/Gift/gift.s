.section .text
    .global _start

read_input:
    # Read 314 bytes + 16 free bytes from stdin to the stack
    sub $314, %rsp                # Make room for the input
    mov $0, %rax                  # System call number for read
    mov $0, %rdi                  # File descriptor for stdin
    mov %rsp, %rsi                # Address of the stack
    mov $330, %rdx                # Number of bytes to read
    syscall                       # Call the kernel
    add $314, %rsp                # Restore the stack pointer
    ret

_start:
    # Print the message to stdout
    mov $1, %rax                  # System call number for write
    mov $1, %rdi                  # File descriptor for stdout
    mov $message, %rsi            # Address of the message string
    mov $message_len, %rdx        # Length of the message string
    syscall                       # Call the kernel

    call read_input

    # Exit the program
    mov $60, %rax                 # System call number for exit
    xor %rdi, %rdi                # Exit status 0
    xor %rsi, %rsi                # I like it clean
    xor %rdx, %rdx                # I like it clean
    syscall                       # Call the kernel

message: .asciz "Today is a nice day so you get 16 bytes for free!\n"
message_len = . - message
