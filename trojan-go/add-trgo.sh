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
xray="/etc/xray"
trgo="/etc/arfvpn/trojan-go"
uuid=$(cat /proc/sys/kernel/random/uuid)
uuidtrgo=$(cat ${trgo}/uuid)
IP=$(cat ${arfvpn}/IP)
domain=$(cat ${arfvpn}/domain)
clear 

trgo="$(cat ~/log-install.txt | grep -w "Trojan GO " | cut -d: -f2|sed 's/ //g')"
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "               ⇱ \e[32;1m✶ Add Trojan-Go Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
	read -rp "User: " -e user
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
    # Username already exist
	CLIENT_EXISTS=$(grep -w ${user} /etc/arfvpn/trojan-go/akun.conf | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "               ⇱ \e[32;1m✶ Add Trojan-Go Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "  ${RED}•${NC} ${CYAN}A client with the specified name was already created, please choose another name. $NC"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-trojan
	    fi
	    done
	clear
	
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "               ⇱ \e[32;1m✶ Add Trojan-Go Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}User: ${user} $NC"
    read -p "Expired (days): " masaaktif
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "

clear
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "${masaaktif} days" +"%Y-%m-%d"`
sed -i '/"'""${uuidtrgo}""'"$/a\,"'""${user}""'"' /etc/arfvpn/trojan-go/config.json
echo -e "#trgo# ${user} ${exp}" >>  /etc/arfvpn/trojan-go/akun.conf
systemctl restart trojan-go.service
trojangolink="trojan-go://${user}@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/trojan-go&encryption=none#${user}"
clear
        
echo -e "" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
echo -e "               ⇱ \e[32;1m✶ Add Trojan-Go Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "${NC}${CYAN}              ───✶ Trojan-GO Account ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Remarks           : ${user} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}IP/Host           : ${IP} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Domain            : ${domain} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Password          : ${user} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port GO           : ${trgo} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Path GO           : /trojan-go $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "${NC}${CYAN}            ───✶ Example Config & Link ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Link GO           ➣ $NC" | tee -a /etc/log-create-user.log
echo -e "  ${NC}${CYAN}${trojangolink} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "${NC}${CYAN}              ───✶ Created - Expired ✶─── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Created           : ${hariini} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Expired On        : ${exp} $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log 
read -n 1 -s -r -p "Press any key to back on menu"
menu