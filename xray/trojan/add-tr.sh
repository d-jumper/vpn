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

arfvpn="/etc/arfvpn"
xray="/etc/xray"
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat ${arfvpn}/domain)
IP=$(cat ${arfvpn}/IP)
clear 

tls="$(cat ~/log-install.txt | grep -w "Xray WS TLS " | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Xray WS NONE TLS " | cut -d: -f2|sed 's/ //g')"
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
clear

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Add Xray Trojan Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
	read -rp "User: " -e user
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
    # Username already exist
	CLIENT_EXISTS=$(grep -w ${user} ${xray}/config.json | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Add Xray Trojan Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "  ${RED}•${NC} ${CYAN}A client with the specified name was already created, please choose another name. $NC"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-vm
        fi
	    done
	clear
	
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Add Xray Trojan Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}User: ${user} $NC"
    read -p "Expired (days): " masaaktif
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
clear
exp=`date -d "${masaaktif} days" +"%Y-%m-%d"`
sed -i '/#trojan$/a\#tr# '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' ${xray}/config.json
sed -i '/#trojangrpc$/a\#tr# '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' ${xray}/config.json
#systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:${tls}?path=%2Ftrojan&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
trojanlink2="trojan://${uuid}@${domain}:${none}?path=%2Ftrojan&host=bug.com&type=ws#${user}"
trojanlink3="trojan://${uuid}@${domain}:${tls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
clear
    
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
    echo -e "              ⇱ \e[32;1m✶ Result Xray Trojan Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/log-create-user.log
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Remarks   : ${user} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}IP/Host   : ${IP} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Domain    : ${domain} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Password  : ${uuid} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port TLS  : ${tls} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port NTLS : ${none} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port GRPC : ${tls} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}alterid   : 0 $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Security  : auto $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Network   : ws / grpc $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path WS   : /trojan $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path GRPC : /trojan-grpc $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link TLS  : ${trojanlink1} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link NTLS : ${trojanlink2} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link GRPC : ${trojanlink3} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Expired On : ${exp} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
    echo "" | tee -a /etc/log-create-user.log
    echo "" | tee -a /etc/log-create-user.log 
    read -n 1 -s -r -p "Press any key to back on menu"
    menu