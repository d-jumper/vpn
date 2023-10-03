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

tls="$(cat ~/log-install.txt | grep -w "Xray WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Xray WS NONE TLS" | cut -d: -f2|sed 's/ //g')"
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
clear

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "               ⇱ \e[32;1m✶ Add Xray Vmess Account ✶\e[0m ⇲ ${NC}"
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
    echo -e "               ⇱ \e[32;1m✶ Add Xray Vmess Account ✶\e[0m ⇲ ${NC}"
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
    echo -e "               ⇱ \e[32;1m✶ Add Xray Vmess Account ✶\e[0m ⇲ ${NC}"
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
sed -i '/#vmess$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmessworry$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmesskuota$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmessgrpc$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmesschat$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
vmess1=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess2=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "$none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
worry=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/worryfree",
      "type": "none",
      "host": "tsel.me",
      "tls": "none"
}
EOF`
flex=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/chat",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "/vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
kuota=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/kuota-habis",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< ${vmess_json1})
vmess_base642=$( base64 -w 0 <<< ${vmess_json2})
vmess_base643=$( base64 -w 0 <<< ${vmess_json3})
vmess_base644=$( base64 -w 0 <<< ${vmess_json4})
vmess_base645=$( base64 -w 0 <<< ${vmess_json5})
vmess_base646=$( base64 -w 0 <<< ${vmess_json6})
vmesslink1="vmess://$(echo ${vmess1} | base64 -w 0)"
vmesslink2="vmess://$(echo ${vmess2} | base64 -w 0)"
vmesslink3="vmess://$(echo ${worry} | base64 -w 0)"
vmesslink4="vmess://$(echo ${flex} | base64 -w 0)"
vmesslink5="vmess://$(echo ${grpc} | base64 -w 0)"
vmesslink6="vmess://$(echo ${kuota} | base64 -w 0)"
# systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear

    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
    echo -e "               ⇱ \e[32;1m✶ Result Xray Vmess Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/log-create-user.log
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "${NC}${CYAN}             ───✶ Xray - Vmess Account ✶─── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Remarks           : ${user} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}IP/Host           : ${IP} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Domain            : ${domain} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Uuid              : ${uuid} $NC" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "${NC}${CYAN}            ───✶ Service Running Port ✶─── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port WS TLS       : ${tls} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port WS NONE NTLS : ${none} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port GRPC         : ${tls} $NC" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "${NC}${CYAN}           ───✶ Path & Network Setting ✶─── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}alterid           : 0 $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Security          : auto $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Network           : ws / grpc $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path WS           : /vmess $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path GRPC         : /vmess-grpc $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path TSEL         : /worryfree $NC" | tee -a /etc/log-create-user.log
    echo -e "" | tee -a /etc/log-create-user.log
    echo -e "${NC}${CYAN}            ───✶ Example Config & Link ✶─── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link WS TLS       ➣ $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink1} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link WS NONE TLS ➣ $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink2} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link GRPC ➣ $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink5} $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link TSEL ➣ $NC" | tee -a /etc/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink3} $NC" | tee -a /etc/log-create-user.log
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