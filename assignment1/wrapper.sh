#! /bin/bash

#####################################
# Displays help
#####################################
function help(){
    echo "Usage: $0 <port_number> <pattern> <template_file>"
    exit 1
}

#####################################
# Checking is root
#####################################

if [ $# -ne 3 ]; then
    help
fi

PORT=$1
PATTERN=$2
FILE=$3

##############################
# Checking the port number
##############################
if [ ${PORT} -ge 1 ] && [ ${PORT} -le 1023 ] && [ $(id -u) -ne 0 ]; then
    echo "[*] You'd better be root for listening on this port! Exiting..."
    exit
fi

if [ ${PORT} -lt 1 ] || [ ${PORT} -gt 65535 ]; then
	echo "[*] Port number should be between 1 and 65535! Exiting..."
	exit
fi

# Converting in hex and little endian representation
HEXFMT=0x`python -c "import struct; print struct.pack('<L',${PORT}).encode('hex')[:4]"`

# Generating a new file source and compiling
sed "s/${PATTERN}/${HEXFMT}/g" ${FILE} > ${FILE%.*}.nasm && \
./compile.sh ${FILE%.*} && \
objdump -d ${FILE%.*}|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'