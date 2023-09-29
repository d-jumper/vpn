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
arfvpn="/etc/arfvpn"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
ipvps="/var/lib/arfvpn"
source ${ipvps}/ipvps.conf
if [[ "${IP}" = "" ]]; then
domain=$(cat ${arfvpn}/domain)
else
domain=${IP}
fi
clear 

clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#tr# " "${xray}/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "             ⇱ \e[32;1m✶ Delete Trojan-GO Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "  ${RED}•${NC} ${CYAN}You have no existing clients! ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 2
menu-trojan
	fi

	clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "             ⇱ \e[32;1m✶ Delete Trojan-GO Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}User       Expired ${NC}"
echo -e "${NC}${CYAN}──────────────────── $NC"
grep -E "^#trgo# " "${trgo}/akun.conf" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo -e " "
echo -e "${NC}${CYAN}──────────────────── $NC"
read -rp "Input Username : " user
    if [ -z ${user} ]; then
echo -e "${NC}${CYAN}User Not Found ! ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 2
    menu-trojan
    else
echo -e "${NC}${CYAN}Deleting user : ${user} ! ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 2
    exp=$(grep -wE "^#trgo# ${user}" "${trgo}/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
    sed -i "/^#trgo# ${user} ${exp}/d" ${trgo}/akun.conf
    sed -i '/^,"'"${user}"'"$/d' ${trgo}/config.json
    systemctl restart trojan-go > /dev/null 2>&1
    clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "             ⇱ \e[32;1m✶ Delete Trojan-GO Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "${NC}${CYAN}Client Name : ${user} ${NC}"
echo -e "${NC}${CYAN}Expired On  : ${exp} ${NC}"
echo -e "${NC}${CYAN}Deleted : ${user} Successfully !!! ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""
fi
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu