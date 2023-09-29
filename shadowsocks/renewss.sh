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

NUMBER_OF_CLIENTS=$(grep -c -E "^#ss# " "/etc/shadowsocks-libev/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "             ⇱ \e[32;1m✶ Renew Shadowsocks Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${RED}•${NC} ${CYAN}You have no existing clients! $NC"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
sleep 3
        menu-ss
	fi
clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "         ⇱ \e[32;1m✶ Renew Shadowsocks Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
grep -E "^#ss# " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo -e ""
echo -e "${NC}${CYAN}──────────────────── $NC"
read -rp "Input Username : " user
    if [ -z ${user} ]; then
echo -e "${NC}${CYAN}User Not Found ! ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 2
    menu-ss
    else
echo -e "${NC}${CYAN}Renewed user : ${user} ! ${NC}"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 2
    exp=$(grep -wE "^#ss# ${user}" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "${exp}" +%s)
    d2=$(date -d "${now}" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$((${exp2} + ${masaaktif}))
    exp4=`date -d "${exp3} days" +"%Y-%m-%d"`
    sed -i "s/#ss# ${user} ${exp}/#ss# ${user} ${exp4}/g" /etc/shadowsocks-libev/akun.conf
    systemctl restart xray > /dev/null 2>&1
    clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "         ⇱ \e[32;1m✶ Renew Shadowsocks Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${NC}${CYAN}Client Name : ${user} $NC" 
echo -e "${NC}${CYAN}Expired On  : ${exp4} $NC"
echo -e "${NC}${CYAN}Renew : ${user} Successfully !!!$NC" 
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""
    fi
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu