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
ws="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
wsntls="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "               ⇱ ${STABILO}Change Port SSH Websocket${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Change Port Websocket TLS $NC"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Change Port Websocket None TLS $NC"
echo -e "    ${CYAN}[${LIGHT}xx${CYAN}]${RED} •${NC} ${CYAN}Back To Menu $NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " ➣  Select Menu [ 1 - 2 ] or [ x ] to Close Menu : " menu
echo -e ""
case $menu in

1)
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${RED} •${NC} ${CYAN}Port SSH Websocket TLS :${NC}${LIGHT} ${ws}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "Change New Port for SSH Websocket TLS : " ws2
sleep 2

if [ -z ${ws2} ]; then
echo -e "${RED} Please Input New Port !${NC}"
sleep 2
exit 0
clear
changeport
fi

clear
cek=$(netstat -nutlp | grep -w ${ws2})
if [[ -z $cek ]]; then
sleep 1
else
echo -e "${RED} Port ${ws2} is used"
sleep 2
clear
exit 0
changeport
fi

set_port () {
sed -i 's/${ws}/${ws2}/g' /etc/default/sslh
sed -i 's/${ws}/${ws2}/g' /etc/stunnel5/stunnel5.conf
sed -i 's/   - Websocket TLS           : ${ws}/   - Websocket TLS           : ${ws2}/g' /etc/arfvpn/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${ws} -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${ws} -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ws2} -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${ws2} -j ACCEPT
iptables-save >> /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
sed -i 's/${ws}/${ws2}/g' /etc/systemd/system/ws-tls.service
systemctl daemon-reload
systemctl restart sslh
systemctl restart ws-tls > /dev/null
}

clear
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${LIGHT}- ${NC}Change Port SSH Websocket TLS"
arfvpn_bar 'set_port'
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
sleep 2
clear

echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port SSH Websocket TLS :${NC}${LIGHT} ${ws2}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
sleep 2
;;

2)
clear
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${RED} •${NC} ${CYAN}Port SSH Websocket None TLS :$NC ${LIGHT}${wsntls}${NC}"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "Change New Port for SSH Websocket None TLS : " wsntls2
sleep 2

if [ -z ${wsntls2} ]; then
echo -e "${RED} Please Input New Port !${NC}"
sleep 2
exit 0
clear
changeport
fi

clear
cek=$(netstat -nutlp | grep -w ${wsntls2})
if [[ -z $cek ]]; then
sleep 1
else
echo -e "${RED} Port ${wsntls2} is used"
sleep 2
clear
exit 0
changeport
fi

set_port () {
sed -i 's/${wsntls}/${wsntls2}/g' /etc/default/sslh
sed -i 's/${wsntls}/${wsntls2}/g' /etc/stunnel5/stunnel5.conf
sed -i 's/   - Websocket None TLS           : ${wsntls}/   - Websocket None TLS           : ${wsntls2}/g' /etc/arfvpn/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${wsntls} -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${wsntls} -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${wsntls2} -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${wsntls2} -j ACCEPT
iptables-save >> /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
sed -i 's/${wsntls}/${wsntls2}/g' /etc/systemd/system/ws-nontls.service
systemctl daemon-reload
systemctl restart sslh
systemctl restart ws-nontls > /dev/null
}

clear
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${LIGHT}- ${NC}Change Port SSH Websocket None TLS"
arfvpn_bar 'set_port'
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
sleep 2
clear

echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port SSH Websocket None TLS :${NC}${LIGHT} ${wsntls2}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
;;
esac

echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Changeport-Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
exit 0
changeport