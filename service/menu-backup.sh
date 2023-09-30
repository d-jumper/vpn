#!/bin/bash
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

echo -e ""
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                    ⇱ \e[32;1m✶ Backup Menu ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}Add or Change Email Received $NC"
echo -e "  ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}Change Email Sender $NC"
echo -e "  ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}Start Auto Backup $NC"
echo -e "  ${BICyan}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}Stop Auto Backup $NC"
echo -e "  ${BICyan}[${BIWhite}05${BICyan}]${RED} •${NC} ${CYAN}Backup Manualy $NC"
echo -e "  ${BICyan}[${BIWhite}06${BICyan}]${RED} •${NC} ${CYAN}Test Send Mail $NC"
echo -e "  ${BICyan}[${BIWhite}07${BICyan}]${RED} •${NC} ${CYAN}Restore $NC"
echo -e "  ${BICyan}[${BIWhite}08${BICyan}]${RED} •${NC} ${CYAN}Back To Menu $NC"
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
