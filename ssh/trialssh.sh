#!/bin/bash
#########################################################
# Export Color
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
BINC='\e[0m'

RED='\033[0;31m'      # RED 1
RED2='\e[1;31m'       # RED 2
GREEN='\033[0;32m'   # GREEN 1
GREEN2='\e[1;32m'    # GREEN 2
STABILO='\e[32;1m'    # STABILO
ORANGE='\033[0;33m' # ORANGE
PURPLE='\033[0;35m'  # PURPLE
BLUE='\033[0;34m'     # BLUE 1
TYBLUE='\e[1;36m'     # BLUE 2
CYAN='\033[0;36m'     # CYAN
LIGHT='\033[0;37m'    # LIGHT
NC='\033[0m'           # NC

bl='\e[36;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
color1='\e[031;1m'
color2='\e[34;1m'
green_mix() { echo -e "\\033[32;1m${*}\\033[0m"; }
red_mix() { echo -e "\\033[31;1m${*}\\033[0m"; }

# Export Align
BOLD="\e[1m"
WARNING="${RED}\e[5m"
UNDERLINE="\e[4m"

# Export Banner Status Information
EROR="[${RED} EROR ${NC}]"
INFO="[${LIGHT} INFO ${NC}]"
OK="[${LIGHT} OK ! ${NC}]"
CEKLIST="[${LIGHT}✔${NC}]"
PENDING="[${YELLOW} PENDING ${NC}]"
SEND="[${GREEN} SEND ${NC}]"
RECEIVE="[${YELLOW} RECEIVE ${NC}]"
SUCCESS="[${LIGHT} ✔ SUCCESS ✔ ${NC}]"

#########################################################
source /etc/os-release
cd /root
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

#########################################################
arfvpn_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
# Start
echo -ne "     ${ORANGE}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${LIGHT}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${ORANGE}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
arfvpn="/etc/arfvpn"
github=$(cat ${arfvpn}/github)
ipvps="/var/lib/arfvpn"
curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
IP=$(cat ${arfvpn}/IP)
domain=$(cat ${arfvpn}/domain)
MYISP=$(cat ${arfvpn}/ISP)
source ${ipvps}/ipvps.conf
cfn=$(cat ${ipvps}/cfndomain)
error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
clear

ws="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
nginx="$(cat /etc/arfvpn/log-install.txt | grep -w "Nginx" | cut -d: -f2|sed 's/ //g')"
ssl="$(cat /etc/arfvpn/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat /etc/arfvpn/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear

# data trial
user=arfvpn-`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="3"
pass=0987654321
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Add Trial SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}Random username & default password for Trial SSH has been created.$NC"
echo -e "${NC}${CYAN}────────────────────────────────── $NC"
echo -e " "
echo -e "${NC}${CYAN}Username : ${user} $NC"
echo -e "${NC}${CYAN}Password : ${pass} $NC"
echo -e "${NC}${CYAN}Expired (Days): $hari $NC"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 5
clear

#useradd --expiredate `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M ${user}
#exp="$(chage -l ${user} | grep "Account expires" | awk -F": " '{print $2}')"
#hariini=`date -d "0 days" +"%Y-%m-%d"`
#expi=`date -d "$hari days" +"%Y-%m-%d"`
#echo -e "${pass}\n${pass}\n"|passwd ${user} &> /dev/null

hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "${hari} days" +"%Y-%m-%d"`
add_trial () {
useradd -e `date -d "${hari} days" +"%Y-%m-%d"` -s /bin/false -M ${user}
echo -e "${pass}\n${pass}\n" | passwd ${user} &> /dev/null
}
echo -e " ${LIGHT}- ${NC}Add Trial User SSH & OpenVPN"
arfvpn_bar 'add_trial'
echo -e ""
sleep 2
history -c
clear

clear
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "        ⇱ \e[32;1m✶ Result Trial SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e " " | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ SSH & OpenVPN Account ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Remarks       : ${user} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}IP/Host       : ${IP} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Domain        : ${domain} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Cfn           : ${cfn} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Username      : ${user} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Password      : ${pass} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ Service Running Port ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Dropbear      : 109, 143 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}SSL/TLS       :$ssl $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}SSH WS No SSL : $ws2 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Ovpn Ws       : 2086 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port TCP      : $ovpn $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port UDP      : $ovpn2 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port SSL      : 990 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}UDPGW         : 7100-7200-7300 $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ OpenVPN Config ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN TCP      : http://${IP}:${nginx}/tcp.ovpn $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN UDP      : http://${IP}:${nginx}/udp.ovpn $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}OVPN SSL      : http://${IP}:${nginx}/ssl.ovpn $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}───✶ PAYLOAD CONFIG ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}PAYLOAD WS TLS  ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${NC}${CYAN}GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Connection: Upgrade[crlf]Upgrade: websocket[crlf][crlf] \n $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}PAYLOAD WEBSOCKET CLOUDFRONT ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${NC}${CYAN}GET / HTTP/1.1[crlf]Host: [host_port][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf] \n $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Created       : ${hariini} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Expired On    : ${expi} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
history -c
clear
menu