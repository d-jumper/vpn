#!/bin/bash
#########################################################
# Exporting Language to UTF-8
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LANGUAGE='en_US.UTF-8'
LC_CTYPE='en_US.utf8'

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

# // Exporting URL Host
arfvpn="/etc/arfvpn"
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
 status_nginx="${GREEN}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mInformasi VPS\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "  ❇️ \e[32;1m Sever Uptime\e[0m     : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ \e[32;1m Current Time\e[0m     : $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ \e[32;1m Operating System\e[0m : $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ \e[32;1m Processor\e[0m        : $tipeprosesor"
echo -e "  ❇️ \e[32;1m Current Domain\e[0m   : ${Server_HOST} "
echo -e "  ❇️ \e[32;1m Server IP\e[0m        : ${Server_IP} "
echo -e "  ❇️ \e[32;1m Current Isp Name\e[0m : ${Server_ISP} "
echo -e "  ❇️ \e[32;1m Time Reboot VPS\e[0m  : 00:00 ( Jam 12 Mid-Night ) "
echo -e "  ❇️ \e[32;1m Script Auther\e[0m    : ${Script_AUTHER} "
echo -e "  ❇️ \e[32;1m Script Version\e[0m   : ${Script_Mode}_${Script_Version} "
echo -e ""
echo -e "      🟢🟡🔴  SERVER STATUS     :    ${status_nginx}  🔴🟡🟢"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mTunnel/s Menu\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}SSH/OVPN     $NC  ${CYAN}[${LIGHT}04${CYAN}]${RED} • ${NC}${CYAN}TROJAN-WS/GO $NC"

echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}XRAY - VMESS $NC  ${CYAN}[${LIGHT}05${CYAN}]${RED} • ${NC}${CYAN}SHADOWSOCK-OBFS$NC"

echo -e "    ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}XRAY - VLESS $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mMenu Service/s\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}SETTING/s    $NC  ${CYAN}[${LIGHT}10${CYAN}]${RED} • ${NC}${CYAN}CEK BANDWIDTH $NC"

echo -e "    ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}UPDATE-XRAY  $NC  ${CYAN}[${LIGHT}11${CYAN}]${RED} • ${NC}${CYAN}CEK RUNNING SERVICE $NC"

echo -e "    ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}UPDATE-SCRIPT$NC  ${CYAN}[${LIGHT}12${CYAN}]${RED} • ${NC}${CYAN}RESTART SERVICE$NC"

echo -e "    ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}BACKUP       $NC  ${CYAN}[${LIGHT}13${CYAN}]${RED} • ${NC}${CYAN}INSTALL-WEBMIN$NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                       ⇱ \e[32;1mAbout\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${CYAN}[${LIGHT}14${CYAN}]${RED} •${NC} ${CYAN}INFO-SCRIPT  $NC  ${CYAN}[${LIGHT}xx${CYAN}]${RED} • ${NC}${CYAN}CLOSE MENU   $NC"

echo -e "    ${CYAN}[${LIGHT}15${CYAN}]${RED} •${NC} ${CYAN}REBOOT VPS   $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""

read -p "                    Select Menu : " menu
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

9)
clear
menu-backup
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
read -n 1 -s -r -p "Press any key to back on menu"
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
echo " Command not found! "
sleep 3
menu
;;

esac
