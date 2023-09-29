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

echo -e ""
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                  ⇱ \e[32;1m✶ Xray Vless Menu ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}Add Account Vless $NC"
echo -e "  ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}Delete Account Vless $NC"
echo -e "  ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}Renew Account Vless $NC"
echo -e "  ${BICyan}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}Cek User Login Vless $NC"
echo -e "  ${BICyan}[${BIWhite}05${BICyan}]${RED} •${NC} ${CYAN}Back to Menu $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
read -p " ➣ Select From Options [ 1 - 5 ] : " menu
echo -e ""
case $menu in
1) clear ; add-vless ;;
2) clear ; del-vless ;;
3) clear ; renew-vless ;;
4) clear ; cek-vless ;;
5) clear ; menu ;;
*)
clear
echo " Command not found! "
sleep 3
menu-vless
;;
esac