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

# ==========================================
#Getting user
arfvpn="/etc/arfvpn"
ipvps="/var/lib/arfvpn"
IP=$(cat $arfvpn/IP)
domain=$(cat $arfvpn/domain)
MYISP=$(cat $arfvpn/ISP)
source ${ipvps}/ipvps.conf
cfn=$(cat ${ipvps}/cfndomain)
error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
clear

ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
nginx="$(cat ~/log-install.txt | grep -w "Nginx" | cut -d: -f2|sed 's/ //g')"
ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear

# data trial
user=arfvpn-`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="7"
Pass=123
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Add Trial SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}Random username & default password for Trial SSH has been created.$NC"
echo -e "${NC}${CYAN}────────────────────────────────── $NC"
echo -e " "
echo -e "${NC}${CYAN}Username : $user $NC"
echo -e "${NC}${CYAN}Password : $pass $NC"
echo -e "${NC}${CYAN}Expired (Days): $hari $NC"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 5
clear

useradd --expiredate `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M $user
exp="$(chage -l $user | grep "Account expires" | awk -F": " '{print $2}')"
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$hari days" +"%Y-%m-%d"`
echo -e "$Pass\n$Pass\n"|passwd $user &> /dev/null
history -c
clear

clear
echo -e "" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
echo -e "        ⇱ \e[32;1m✶ Result Trial SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e " " | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ SSH & OpenVPN Account ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Remarks       : ${user} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}IP/Host       : ${IP} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Domain        : ${domain} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Cfn           : ${cfn} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Username      : ${user} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Password      : ${pass} $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ Service Running Port ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Dropbear      : 109, 143 $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}SSL/TLS       :$ssl $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}SSH WS No SSL : $ws2 $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Ovpn Ws       : 2086 $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port TCP      : $ovpn $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port UDP      : $ovpn2 $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port SSL      : 990 $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}UDPGW         : 7100-7200-7300 $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ OpenVPN Config ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN TCP      : http://${IP}:${nginx}/tcp.ovpn $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN UDP      : http://${IP}:${nginx}/udp.ovpn $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN SSL      : http://${IP}:${nginx}/ssl.ovp $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ PAYLOAD CONFIG ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}PAYLOAD WS TLS  ➣ $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Connection: Upgrade[crlf]Upgrade: websocket[crlf][crlf] \n $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}PAYLOAD WEBSOCKET CLOUDFRONT ➣ $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}GET / HTTP/1.1[crlf]Host: [host_port][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf] \n $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Created       : ${hariini} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Expired On    : ${expi} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"
menu