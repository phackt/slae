# SLAE
Repository for the SLAE exam  
Student **SLAE-891**  
[http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/](http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/)  
  
## Assignment 3
Egg Hunter Shellcode  
  
You can run the basic egg hunter with the following command:  
```bash
gcc -fno-stack-protector -z execstack -o shellcode shellcode.c && ./shellcode
```  
  
You can run the more advanced egg hunter with the following command:  
```bash
gcc -fno-stack-protector -z execstack -o shellcode_heap shellcode_heap.c && ./shellcode_heap
```  

