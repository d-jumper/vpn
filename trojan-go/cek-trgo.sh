#!/bin/bash

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# / letssgoooo

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
clear
arfvpn="/etc/arfvpn"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
ipvps="/var/lib/arfvpn"
source ${ipvps}/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat ${arfvpn}/domain)
else
domain=$IP
fi
clear 

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "               ⇱ \e[32;1m✶ Trojan-GO User Login ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -n > /tmp/other.txt
data=( `cat ${trgo}/akun.conf | grep '^#trgo#' | cut -d ' ' -f 2`);
for akun in "${data[@]}"
do
if [[ -z "${akun}" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat ${logtrgo}/trojan-go.log | grep -w ${akun} | awk '{print $3}' | cut -d: -f1 | grep -w ${ip} | sort | uniq)
if [[ "${jum}" = "${ip}" ]]; then
echo "${jum}" >> /tmp/iptrojango.txt
else
echo "${ip}" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojango.txt)
sed -i "/${jum2}/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojango.txt)
oth=$(cat /tmp/other.txt | sort | uniq | nl)
lastlogin=$(cat ${logtrgo}/trojan-go.log | grep -w "${akun}" | tail -n 500 | cut -d " " -f 2 | tail -1)
if [[ -z "${jum}" ]]; then
echo > /dev/null
#else
jum2=$(cat /tmp/iptrojango.txt | nl)
echo -e "  ${RED}•${NC} ${CYAN}user : ${akun} $NC"
echo -e "${NC} ${CYAN}${oth} | ${lastlogin} $NC";
echo -e "${NC}${CYAN}──────────────────── $NC"
fi
done

rm -rf /tmp/iptrojango.txt
rm -rf /tmp/other.txt

echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
read -n 1 -s -r -p "Press any key to back on menu"
menu
