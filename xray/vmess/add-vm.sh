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

tls="$(cat /etc/arfvpn/log-install.txt | grep -w "Xray WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat /etc/arfvpn/log-install.txt | grep -w "Xray WS NONE TLS" | cut -d: -f2|sed 's/ //g')"
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
addvm () {
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
}
echo -e " ${LIGHT}- ${NC}Add User Xray Vmess Websocket"
arfvpn_bar 'addvm'
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
#service cron restart > /dev/null 2>&1
history -c
clear

    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "               ⇱ \e[32;1m✶ Result Xray Vmess Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "${NC}${CYAN}             ───✶ Xray - Vmess Account ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Remarks           : ${user} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}IP/Host           : ${IP} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Domain            : ${domain} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Uuid              : ${uuid} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "${NC}${CYAN}            ───✶ Service Running Port ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port WS TLS       : ${tls} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port WS NONE NTLS : ${none} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Port GRPC         : ${tls} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "${NC}${CYAN}           ───✶ Path & Network Setting ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}alterid           : 0 $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Security          : auto $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Network           : ws / grpc $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path WS           : /vmess $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path GRPC         : /vmess-grpc $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Path TSEL         : /worryfree $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "${NC}${CYAN}            ───✶ Example Config & Link ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link WS TLS       ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink1} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link WS NONE TLS ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink2} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link GRPC ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink5} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Link TSEL ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${NC}${CYAN}${vmesslink3} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "${NC}${CYAN}              ───✶ Created - Expired ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Created           : ${hariini} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "  ${RED}•${NC} ${CYAN}Expired On        : ${exp} $NC" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "" | tee -a /etc/arfvpn/log-create-user.log
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
    echo "" | tee -a /etc/arfvpn/log-create-user.log
    echo "" | tee -a /etc/arfvpn/log-create-user.log 
    echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
    read -p ""
    history -c
    clear
    menu