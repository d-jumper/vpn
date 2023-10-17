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

lastport1=$(grep "port_tls" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
lastport2=$(grep "port_http" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
if [[ ${lastport1} == '' ]]; then
tls=2443
else
tls="$((lastport1+1))"
fi
if [[ ${lastport2} == '' ]]; then
http=3443
else
http="$((lastport2+1))"
fi
method="aes-256-cfb"
clear
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do

    echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ ${STABILO}✶ Add Shadowsocks OBFS Account ✶${NC} ⇲ "
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
	read -rp "User: " -e user
    echo -e " "
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
    # Username already exist
	CLIENT_EXISTS=$(grep -w ${user} /etc/shadowsocks-libev/akun.conf | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ ${STABILO}✶ Add Shadowsocks OBFS Account ✶${NC} ⇲"
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "  ${RED}•${NC} ${CYAN}A client with the specified name was already created, please choose another name. $NC"
    echo -e ""
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-ss
	    fi
	    done
	clear
	
    echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ ${STABILO}✶ Add Shadowsocks OBFS Account ✶${NC} ⇲"
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}User: ${user} $NC"
    read -p "Expired (days): " masaaktif
    echo -e " "
    echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "

hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
add_ss () {
cat > /etc/shadowsocks-libev/${user}-tls.json<<END
{   
    "server":"0.0.0.0",
    "server_port":${tls},
    "password":"${user}",
    "timeout":60,
    "method":"${method}",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
cat > /etc/shadowsocks-libev/${user}-http.json <<-END
{
    "server":"0.0.0.0",
    "server_port":${http},
    "password":"${user}",
    "timeout":60,
    "method":"${method}",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
chmod +x /etc/shadowsocks-libev/${user}-tls.json
chmod +x /etc/shadowsocks-libev/${user}-http.json

systemctl enable shadowsocks-libev-server@${user}-tls.service
systemctl start shadowsocks-libev-server@${user}-tls.service
systemctl enable shadowsocks-libev-server@${user}-http.service
systemctl start shadowsocks-libev-server@${user}-http.service
}

clear
echo -e " ${LIGHT}- ${NC}Add Account Shadowsocks-Libev"
arfvpn_bar 'add_ss'
tmp1=$(echo -n "${method}:${user}@${IP}:${tls}" | base64 -w0)
tmp2=$(echo -n "${method}:${user}@${IP}:${http}" | base64 -w0)
linkss1="ss://${tmp1}?plugin=obfs-local;obfs=tls;obfs-host=bing.com"
linkss2="ss://${tmp2}?plugin=obfs-local;obfs=http;obfs-host=bing.com"
echo -e "#ss# ${user} ${exp}
port_tls $tls
port_http $http">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
sleep 2
history -c
clear

echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "            ⇱ ${STABILO}✶ Shadowsocks Result Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${NC}${CYAN}          ───✶ Shadowsocks-Libev Account ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Remarks           : ${user} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}IP/Host           : ${IP} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Domain            : ${DOMAIN} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Password          : ${user} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port TLS          : ${tls} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port NONE TLS     : ${http} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Method            : ${method} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${NC}${CYAN}            ───✶ Example Config & Link ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Link TLS          ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${NC}${CYAN}${linkss1} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Link NONE TLS     ➣ $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${NC}${CYAN}${linkss2} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${NC}${CYAN}              ───✶ Created - Expired ✶─── $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Created           : ${hariini} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Expired On        : ${exp} $NC" | tee -a /etc/arfvpn/log-create-user.log
echo -e "" | tee -a /etc/arfvpn/log-create-user.log
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/arfvpn/log-create-user.log
echo "" | tee -a /etc/arfvpn/log-create-user.log
echo "" | tee -a /etc/arfvpn/log-create-user.log 
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Shadowsocks Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
history -c
clear
menu-ss