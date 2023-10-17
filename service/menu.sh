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
IP=$(cat ${arfvpn}/IP)
ISP=$(cat ${arfvpn}/ISP)
DOMAIN=$(cat ${arfvpn}/domain)
VERSION=$(cat ${arfvpn}/Version)
AUTHER="@arf.prsty_"
Mode="Stable"
export Server_HOST="${DOMAIN}"
export Server_IP="${IP}"
export Server_ISP="${ISP}"
export Script_Version=${VERSION}
export Script_Mode="${Mode}"
export Script_AUTHER="${AUTHER}"

tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ ${nginx} == "running" ]]; then
 status_nginx="${STABILO}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi
clear

echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ ${STABILO}Informasi VPS${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "  ❇️ ${STABILO} Sever Uptime${NC}     : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ ${STABILO} Current Time${NC}     : $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ ${STABILO} Operating System${NC} : $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ ${STABILO} Processor${NC}        : $tipeprosesor"
echo -e "  ❇️ ${STABILO} Current Isp Name${NC} : ${Server_ISP} "
echo -e "  ❇️ ${STABILO} Current Domain${NC}   : ${Server_HOST} "
echo -e "  ❇️ ${STABILO} Server IP${NC}        : ${Server_IP} "
echo -e "  ❇️ ${STABILO} Time Reboot VPS${NC}  : 00:00 ( Mid Night GMT +7 WIB) "
echo -e "  ❇️ ${STABILO} Script Auther${NC}    : ${Script_AUTHER} "
echo -e "  ❇️ ${STABILO} Script Version${NC}   : ${Script_Mode}_${Script_Version} "
echo -e ""
echo -e "      🟢🟡🔴  ${ORANGE}SERVER STATUS${NC}     :    ${status_nginx}  🔴🟡🟢"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ ${STABILO}Tunnel/s Menu${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}SSH/OVPN     $NC  ${CYAN}[${LIGHT}04${CYAN}]${RED} • ${NC}${CYAN}TROJAN-WS/GO $NC"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}XRAY - VMESS $NC  ${CYAN}[${LIGHT}05${CYAN}]${RED} • ${NC}${CYAN}SHADOWSOCK-OBFS$NC"
echo -e "    ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}XRAY - VLESS $NC"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ ${STABILO}Menu Service/s${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "    ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}SETTING/s    $NC  ${CYAN}[${LIGHT}10${CYAN}]${RED} • ${NC}${CYAN}CEK BANDWIDTH $NC"
echo -e "    ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}UPDATE-XRAY  $NC  ${CYAN}[${LIGHT}11${CYAN}]${RED} • ${NC}${CYAN}CEK RUNNING SERVICE $NC"
echo -e "    ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}UPDATE-SCRIPT$NC  ${CYAN}[${LIGHT}12${CYAN}]${RED} • ${NC}${CYAN}RESTART SERVICE$NC"
echo -e "    ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}REBOOT VPS   $NC  ${CYAN}[${LIGHT}13${CYAN}]${RED} • ${NC}${CYAN}INSTALL-WEBMIN$NC"
#echo -e "    ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}BACKUP       $NC  ${CYAN}[${LIGHT}13${CYAN}]${RED} • ${NC}${CYAN}INSTALL-WEBMIN$NC"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                       ⇱ ${STABILO}About${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e "    ${CYAN}[${LIGHT}14${CYAN}]${RED} •${NC} ${CYAN}INFO-SCRIPT  $NC  ${CYAN}[${LIGHT}xx${CYAN}]${RED} • ${NC}${CYAN}CLOSE MENU   $NC"
#echo -e "    ${CYAN}[${LIGHT}15${CYAN}]${RED} •${NC} ${CYAN}REBOOT VPS   $NC"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " ➣  Select Menu [ 1 - 14 ] or [ x ] to Close Menu : " menu
echo -e ""
case $menu in

1)
clear
menu-ssh
;;

2)
clear
menu-vmess
;;

3)
clear
menu-vless
;;

4)
clear
menu-trojan
;;

5)
clear
menu-ss
;;

6)
clear
menu-setting
;;

7)
clear
update-xray
;;

8)
clear
update
;;

#9)
#clear
#menu-backup
#;;

9)
reboot
exit
;;

10)
clear
cek-bandwidth
;;

11)
clear
running
;;

12)
clear
restart
;;

13)
clear
wbmn
;;

14)
clear
cat /etc/arfvpn/log-install.txt
echo ""
echo -e "   ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
menu
;;

15)
reboot
exit
;;

x)
clear
neofetch
exit
;;

*)
clear
echo -e " ${EROR}${RED} Command not found! ${NC}"
sleep 3
menu
;;

esac
