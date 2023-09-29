#!/bin/bash
#
# ==========================================

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
# ==========================================
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "               ⇱ \e[32;1m✶ SS - OBFS User Login ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2`);
x=1
echo -e "${NC}${CYAN}──────────────────── $NC"
echo -e "${NC}${CYAN}     User | TLS $NC"
echo -e "${NC}${CYAN}──────────────────── $NC"
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_tls' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w ${port} | awk '{print $2}' | sort | uniq | nl)
if [[ -z "${jum}" ]]; then
echo > /dev/null
else
echo -e "  ${RED}•${NC} ${CYAN}${akun} - ${port} $NC"
echo -e "${NC} ${CYAN}${jum} $NC";
echo -e "${NC}${CYAN}──────────────────── $NC"
fi
x=$(( "$x" + 1 ))
done
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2`);
x=1
echo ""
echo -e "${NC}${CYAN}──────────────────── $NC"
echo -e "${NC}${CYAN}   User | Non-TLS $NC"
echo -e "${NC}${CYAN}──────────────────── $NC"
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_http' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w ${port} | awk '{print $2}' | sort | uniq | nl)
if [[ -z "${jum}" ]]; then
echo > /dev/null
else
echo -e "  ${RED}•${NC} ${CYAN}${akun} - ${port} $NC"
echo -e "${NC} ${CYAN}${jum} $NC";
echo -e "${NC}${CYAN}──────────────────── $NC"
fi
x=$(( "$x" + 1 ))
done
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
read -n 1 -s -r -p "Press any key to back on menu"
menu
