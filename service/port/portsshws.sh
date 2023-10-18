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
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ws="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
wsntls="$(cat /etc/arfvpn/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"
sqd="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | head -n1)"
sqd2="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | tail -n1)"
trgo="$(cat /etc/arfvpn/log-install.txt | grep -w "Trojan GO" | cut -d: -f2|sed 's/ //g')"
tls="$(cat /etc/arfvpn/log-install.txt | grep -w "Xray WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat /etc/arfvpn/log-install.txt | grep -w "Xray WS NONE TLS" | cut -d: -f2|sed 's/ //g')"
setinstall="$(cat /etc/arfvpn/log-install.txt | grep -w "Installation time :" | cut -d: -f2)"
echo -e "Installation time :${setinstall}" > /root/log-install
clear

echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "               ⇱ ${STABILO}Change Port SSH Websocket${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Change Port SSH Websocket TLS $NC"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Change Port SSH Websocket None TLS $NC"
echo -e "    ${CYAN}[${LIGHT}xx${CYAN}]${RED} •${NC} ${CYAN}Back To Change Port Menu $NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " ➣  Select Menu [ 1 - 2 ] or [ x ] to Back to Change-Port Menu : " menu
echo -e ""
case $menu in

1)
clear
echo -e ""
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
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${WARNING} Your nothing Input Port !${NC}"
echo -e "${WARNING} Please Input New Port !${NC}"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
exit
fi

clear
cek=$(netstat -nutlp | grep -w ${ws2})
if [[ -z $cek ]]; then
sleep 1
else
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${WARNING} Port ${ws2} already used !"
echo -e "${WARNING} Are your'e sure?"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Continue${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
fi

set_port () {
/etc/init.d/sslh stop > /dev/null
/etc/init.d/ws-tls stop > /dev/null
systemctl stop stunnel5 > /dev/null
sed -i 's/127.0.0.1:${ws}/127.0.0.1:${ws2}/g' /etc/default/sslh
sed -i 's/connect = 127.0.0.1:${ws}/connect = 127.0.0.1:${ws2}/g' /etc/stunnel5/stunnel5.conf
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${ws} -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${ws} -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ws2} -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${ws2} -j ACCEPT
iptables-save >> /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
sed -i 's/${ws}/${ws2}/g' /etc/systemd/system/ws-tls.service
systemctl daemon-reload > /dev/null
systemctl restart sslh > /dev/null
systemctl restart ws-tls > /dev/null
systemctl restart stunnel5 > /dev/null
}

clear
echo -e ""
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

echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "           ⇱ ${STABILO}Change Port SSH Websocket TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port SSH Websocket TLS :${NC}${LIGHT} ${ws2}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Changeport-Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
rm -rvf /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e " ${OK} ${LIGHT}Installation VPN Successfully !!!${NC} ${CEKLIST}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "${BLUE}┌─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┐${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Service & Port${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OpenSSH                 ${NC}:${ORANGE} ${ws2}, 22${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OpenVPN                 ${NC}:${ORANGE} TCP ${ovpn}, UDP ${ovpn2}, SSL 990${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket TLS           ${NC}:${ORANGE} ${ws2}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket None TLS      ${NC}:${ORANGE} ${wsntls}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket Ovpn          ${NC}:${ORANGE} 2086${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP SSH                 ${NC}:${ORANGE} 8181${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP Dropbear            ${NC}:${ORANGE} 8282${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP OpenVPN             ${NC}:${ORANGE} 8383${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Stunnel5                ${NC}:${ORANGE} ${ws2}, 445, 777${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Dropbear                ${NC}:${ORANGE} ${ws2}, 109, 143${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Squid Proxy             ${NC}:${ORANGE} ${sqd}, ${sqd2}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Badvpn                  ${NC}:${ORANGE} 7100, 7200, 7300${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Nginx                   ${NC}:${ORANGE} 89${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS TLS             ${NC}:${ORANGE} ${tls}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS NONE TLS        ${NC}:${ORANGE} ${none}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Trojan GO               ${NC}:${ORANGE} ${trgo}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev TLS   ${NC}:${ORANGE} 2443 - 3442${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev NTLS  ${NC}:${ORANGE} 3443 - 4442${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""| tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Server Information & Other Features${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Timezone                ${NC}:${GREEN} Asia/Jakarta${NC} ${STABILO}( GMT +7 WIB )${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Fail2Ban                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${LIGHT} Dflate                  ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} IPtables                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Auto-Reboot             ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} IPv6                    ${NC}:${RED} [OFF]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Autoreboot ON${NC} ${STABILO}00.00 GMT +7 WIB${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${ORANGE} Autobackup Data${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${ORANGE} Restore Data${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Auto Delete Expired Account${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Full Orders For Various Services${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} White Label${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Installation Log${NC}${RED} -->${NC} ${CYAN}/etc/arfvpn/log-install.txt${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "${BLUE}└─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┘${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
cat /root/log-install | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
rm /root/log-install > /dev/null 2>&1
clear
changeport
;;

2)
clear
echo -e ""
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
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${WARNING} Your nothing Input Port !${NC}"
echo -e "${WARNING} Please Input New Port !${NC}"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
exit
fi

clear
cek=$(netstat -nutlp | grep -w ${wsntls2})
if [[ -z $cek ]]; then
sleep 1
else
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${WARNING} Port ${wsntls2} already used !"
echo -e "${WARNING} Are your'e sure?"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Continue${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
fi

set_port_ntls () {
/etc/init.d/sslh stop > /dev/null
/etc/init.d/ws-nontls stop > /dev/null
systemctl stop stunnel5 > /dev/null
sed -i 's/127.0.0.1:${wsntls}/127.0.0.1:${wsntls2}/g' /etc/default/sslh
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${wsntls} -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${wsntls} -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${wsntls2} -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${wsntls2} -j ACCEPT
iptables-save >> /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
sed -i 's/${wsntls}/${wsntls2}/g' /etc/systemd/system/ws-nontls.service
systemctl daemon-reload > /dev/null
systemctl restart sslh > /dev/null
systemctl restart ws-nontls > /dev/null
systemctl restart stunnel5 > /dev/null
}
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${LIGHT}- ${NC}Change Port SSH Websocket None TLS"
arfvpn_bar 'set_port_ntls'
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
sleep 2
clear

echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "        ⇱ ${STABILO}Change Port SSH Websocket None TLS${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port SSH Websocket None TLS :${NC}${LIGHT} ${wsntls2}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Changeport-Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
rm -rvf /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e " ${OK} ${LIGHT}Installation VPN Successfully !!!${NC} ${CEKLIST}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "${BLUE}┌─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┐${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Service & Port${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OpenSSH                 ${NC}:${ORANGE} ${ws}, 22${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OpenVPN                 ${NC}:${ORANGE} TCP ${ovpn}, UDP ${ovpn2}, SSL 990${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket TLS           ${NC}:${ORANGE} ${ws}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket None TLS      ${NC}:${ORANGE} ${wsntls2}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket Ovpn          ${NC}:${ORANGE} 2086${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP SSH                 ${NC}:${ORANGE} 8181${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP Dropbear            ${NC}:${ORANGE} 8282${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} OHP OpenVPN             ${NC}:${ORANGE} 8383${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Stunnel5                ${NC}:${ORANGE} ${ws}, 445, 777${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Dropbear                ${NC}:${ORANGE} ${ws}, 109, 143${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Squid Proxy             ${NC}:${ORANGE} ${sqd}, ${sqd2}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Badvpn                  ${NC}:${ORANGE} 7100, 7200, 7300${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Nginx                   ${NC}:${ORANGE} 89${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS TLS             ${NC}:${ORANGE} ${tls}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS NONE TLS        ${NC}:${ORANGE} ${none}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Trojan GO               ${NC}:${ORANGE} ${trgo}${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev TLS   ${NC}:${ORANGE} 2443 - 3442${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev NTLS  ${NC}:${ORANGE} 3443 - 4442${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""| tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Server Information & Other Features${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Timezone                ${NC}:${GREEN} Asia/Jakarta${NC} ${STABILO}( GMT +7 WIB )${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Fail2Ban                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${LIGHT} Dflate                  ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} IPtables                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} Auto-Reboot             ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${LIGHT} IPv6                    ${NC}:${RED} [OFF]${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Autoreboot ON${NC} ${STABILO}00.00 GMT +7 WIB${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${ORANGE} Autobackup Data${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
#echo -e "   ${RED}⋗${NC}${ORANGE} Restore Data${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Auto Delete Expired Account${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Full Orders For Various Services${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} White Label${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "   ${RED}⋗${NC}${ORANGE} Installation Log${NC}${RED} -->${NC} ${CYAN}/etc/arfvpn/log-install.txt${NC}"  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e "${BLUE}└─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┘${NC}" | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
cat /root/log-install | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
echo -e ""  | tee -a /etc/arfvpn/log-install.txt > /dev/null 2>&1
rm /root/log-install > /dev/null 2>&1
clear
changeport
;;

x)
clear
changeport
;;

*)
clear
echo -e " ${EROR}${RED} Command not found! ${NC}"
sleep 3
portsshws
;;
esac