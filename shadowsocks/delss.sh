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

    NUMBER_OF_CLIENTS=$(grep -c -E "^#ss# " "/etc/shadowsocks-libev/akun.conf")
	    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "            ⇱ \e[32;1m✶ Delete ShadowSocks Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "  ${RED}•${NC} ${CYAN}You have no existing Shadowsocks clients! ${NC}"
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-ss
	    else
	clear
	
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "            ⇱ \e[32;1m✶ Delete ShadowSocks Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}User       Expired ${NC}"
    echo -e "${NC}${CYAN}──────────────────── $NC"
	grep -E "^#ss# " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo -e "${NC}${CYAN}──────────────────── $NC"
    echo -e " "
    read -rp "Input Username : " user
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
        fi
        
    # Username not found
	USERNAME_DOES_NOT_EXIST=$(grep -w ${user} /etc/shadowsocks-libev/akun.conf | wc -l)
		if [[ ${USERNAME_DOES_NOT_EXIST} == '0' ]]; then
	clear
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "            ⇱ \e[32;1m✶ Delete ShadowSocks Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}Username does not exist ! ${NC}"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-ss
	    else
	clear
	
    exp=$(grep -wE "^#ss# ${user}" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
    sed -i "/^#ss# ${user} ${exp}/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
        fi
        
service cron restart
systemctl disable shadowsocks-libev-server@${user}-tls.service
systemctl disable shadowsocks-libev-server@${user}-http.service
systemctl stop shadowsocks-libev-server@${user}-tls.service
systemctl stop shadowsocks-libev-server@${user}-http.service
rm -f "/etc/shadowsocks-libev/${user}-tls.json"
rm -f "/etc/shadowsocks-libev/${user}-http.json"
clear

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "            ⇱ \e[32;1m✶ Delete ShadowSocks Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}Deleted Client ${user} Successfully !!! ${NC}"
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu