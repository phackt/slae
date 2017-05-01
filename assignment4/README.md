# SLAE
Repository for the SLAE exam  
Student **SLAE-891**  
[http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/](http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/)  
  
## Assignment 4
Encoding/Decoding shellcode  
  
Generate the encoded shellcode:  
```bash
gcc -fno-stack-protector -z execstack -o shellcode_encode shellcode_encode.c && ./shellcode_encode
```  
  
Run the decoding routing and execute shellcode:  
```bash
gcc -fno-stack-protector -z execstack -o shellcode shellcode.c && ./shellcode
```  
  

