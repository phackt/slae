# SLAE
Repository for the SLAE exam  
Student **SLAE-891**  
[http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/](http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/)  
  
## Assignment 6
Polymorphic shell-storm shellcodes  
  
**execve**  

Execute polymorphic execve:  
```bash
gcc -o shellcode shellcode.c && ./shellcode
```  
  
**unlink**  
  
Execute polymorphic unlink:  
```bash
./compile.sh unlink_polymorphic && ./unlink_polymorphic
```  
  
**netcat**  
  
Execute polymorphic netcat bind shell:  
```bash
./compile.sh netcat_bind_polymorphic && ./netcat_bind_polymorphic
```
