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
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Auto Kill SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}   Status Autokill $sts $NC"
echo -e "${NC}${CYAN}──────────────────────── $NC"
echo -e " "
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}AutoKill After 1 Minutes $NC"
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}AutoKill After 5 Minutes $NC"
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}AutoKill After 10 Minutes $NC"
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}Turn Off AutoKill/MultiLogin $NC"
echo -e "  ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}Back to menu $NC"
echo -e " "
echo -e "${NC}${CYAN}──────────────────────── $NC"
echo -e ""
read -p "Select From Options [1-5] :  " AutoKill
read -p "Multilogin Maximum Number Of Allowed: " max
echo -e ""
case $AutoKill in
1)
echo -e ""
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/1 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Auto Kill SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}      Allowed MultiLogin : $max $NC"
echo -e "${NC}${CYAN}      AutoKill Every     : 1 Minutes $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
exit  
;;
2)
echo -e ""
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Auto Kill SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}      Allowed MultiLogin : $max $NC"
echo -e "${NC}${CYAN}      AutoKill Every     : 5 Minutes $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
exit
;;
3)
echo -e ""
sleep 1
clear
echo > /etc/cron.d/tendang
echo "# Autokill" >>/etc/cron.d/tendang
echo "*/10 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Auto Kill SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}      Allowed MultiLogin : $max $NC"
echo -e "${NC}${CYAN}      AutoKill Every     : 10 Minutes $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
exit
;;
4)
clear
echo > /etc/cron.d/tendang
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "          ⇱ \e[32;1m✶ Auto Kill SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}      Auto Multi Login Turn off $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
exit
;;
5)
clear
menu-ssh
;;
esac