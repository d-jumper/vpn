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
github=$(cat $arfvpn/github)

#########################################################
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                 ⇱ ${STABILO}Bandwidth Monitor${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${GREEN}"
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Total Remaining Server Bandwidth${NC}"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Usage Every 5 Minutes${NC}"
echo -e "    ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Usage Every Hours${NC}"
echo -e "    ${CYAN}[${LIGHT}04${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Usage Everyday${NC}"
echo -e "    ${CYAN}[${LIGHT}05${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Usage Every Month${NC}"
echo -e "    ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Usage Every Years${NC}"
echo -e "    ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Live Highest${NC}"
echo -e "    ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Graphic Every Hour${NC}"
echo -e "    ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Live Usage${NC}"
echo -e "    ${CYAN}[${LIGHT}10${CYAN}]${RED} •${NC} ${CYAN}Bandwidth Live Usage Trafic [ 5s ]${NC}"
echo -e "    ${CYAN}[${LIGHT}xx${CYAN}]${RED} •${NC} ${CYAN}Back To Menu${NC}"
echo -e "${NC}"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " ➣ Select Menu [ 1 - 10 ] or [ x ] to Back to Menu : " menu
echo -e ""
case $menu in
1)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                       ⇱ ${STABILO}Total Remaining Server Bandwidth${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

2)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ ${STABILO}Bandwidth Usage Every 5 Minutes${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -5

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

3)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                          ⇱ ${STABILO}Bandwidth Usage Every Hours${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -h

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

4)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                           ⇱ ${STABILO}Bandwidth Usage Everyday${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -d

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

5)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                          ⇱ ${STABILO}Bandwidth Usage Every Month${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -m

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

6)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                     ⇱ ${STABILO}Bandwidth Usage Every Years${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -y

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

7)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                            ⇱ ${STABILO}Bandwidth Live Highest${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -t

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

8)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                         ⇱ ${STABILO}Bandwidth Graphic Every Hour${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -hg

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

9)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                             ⇱ ${STABILO}Bandwidth Live Usage${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -l

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

10)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ ${STABILO}Bandwidth Live Usage Trafic [ 5s ]${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""

vnstat -tr

echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e ""
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Cek-Bandwidth Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
cek-bandwidth
;;

x)
clear
history -c
menu
;;

*)
clear
echo -e " ${EROR}${RED} Command not found! ${NC}"
sleep 3
cek-bandwidth
;;
esac
