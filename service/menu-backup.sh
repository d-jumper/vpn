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

#########################################################
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
clear

echo -e ""
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                    ⇱ ${STABILO}✶ Backup Menu ✶${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
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
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
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
echo -e " ${EROR}${RED}Command not found! ${NC}"
sleep 3
menu-backup
;;
esac
#
