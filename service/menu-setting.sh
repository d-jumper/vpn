#!/bin/bash
#########################################################
# Export Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
TYBLUE='\e[1;36m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0m'

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

#########################################################
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
clear

echo -e ""
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1m✶ Setting Menu ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "  ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Change Domain $NC"
echo -e "  ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Add Cloudfront Domaint $NC"
echo -e "  ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}Change Port SSH WS SSL/TLS $NC"
echo -e "  ${CYAN}[${LIGHT}04${CYAN}]${RED} •${NC} ${CYAN}Change Port SSH WS Non-TLS $NC"
echo -e "  ${CYAN}[${LIGHT}05${CYAN}]${RED} •${NC} ${CYAN}Change Port OVPN $NC"
echo -e "  ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}Set Limit Speed $NC"
echo -e "  ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}Rennew Domain & Cert $NC"
echo -e "  ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}Speed-Test $NC"
echo -e "  ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}Back To Menu $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
read -p " ➣ Select From Options [ 1 - 9 ] : " menu
echo -e ""
case $menu in
1)
hostvps
;;
2)
cfnhost
;;
3)
portsshws
;;
4)
portsshnontls
;;
5)
portopvn
;;
6)
limitspeed
;;
7)
renew-domain
;;
8)
clear
speedtest
sleep 3
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;
9)
clear
menu
;;
*)
clear
echo " Command not found! "
sleep 3
menu-setting
;;
esac
#
