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
echo -e "                    ⇱ \e[32;1m✶ Backup Menu ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "  ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Add or Change Email Received $NC"
echo -e "  ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Change Email Sender $NC"
echo -e "  ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}Start Auto Backup $NC"
echo -e "  ${CYAN}[${LIGHT}04${CYAN}]${RED} •${NC} ${CYAN}Stop Auto Backup $NC"
echo -e "  ${CYAN}[${LIGHT}05${CYAN}]${RED} •${NC} ${CYAN}Backup Manualy $NC"
echo -e "  ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}Test Send Mail $NC"
echo -e "  ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}Restore $NC"
echo -e "  ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}Back To Menu $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
read -p " ➣ Select From Options [ 1 - 8 ] : " menu
echo -e ""

case $menu in
1)
addemail
;;
2)
changesend
;;
3)
startbackup
;;
4)
stopbackup
;;
5)
backup
;;
6)
testsend
;;
7)
restore
;;
8)
clear
menu
;;
*)
clear
echo " Command not found! "
sleep 3
menu-backup
;;
esac
#
