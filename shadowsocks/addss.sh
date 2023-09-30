#!/bin/bash
#
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
# ==========================================
arfvpn="/etc/arfvpn"
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

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ \e[32;1m✶ Add Shadowsocks OBFS Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
	read -rp "User: " -e user
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
    # Username already exist
	CLIENT_EXISTS=$(grep -w ${user} /etc/shadowsocks-libev/akun.conf | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ \e[32;1m✶ Add Shadowsocks OBFS Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "  ${RED}•${NC} ${CYAN}A client with the specified name was already created, please choose another name. $NC"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-ss
	    fi
	    done
	clear
	
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "           ⇱ \e[32;1m✶ Add Shadowsocks OBFS Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    echo -e "${NC}${CYAN}User: ${user} $NC"
    read -p "Expired (days): " masaaktif
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
    
clear
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
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
clear

systemctl enable shadowsocks-libev-server@${user}-tls.service
systemctl start shadowsocks-libev-server@${user}-tls.service
systemctl enable shadowsocks-libev-server@${user}-http.service
systemctl start shadowsocks-libev-server@${user}-http.service
clear

tmp1=$(echo -n "${method}:${user}@${IP}:${tls}" | base64 -w0)
tmp2=$(echo -n "${method}:${user}@${IP}:${http}" | base64 -w0)
linkss1="ss://${tmp1}?plugin=obfs-local;obfs=tls;obfs-host=bing.com"
linkss2="ss://${tmp2}?plugin=obfs-local;obfs=http;obfs-host=bing.com"
clear

echo -e "#ss# ${user} ${exp}
port_tls ${tls}
port_http ${http}">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
clear

echo -e "" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}" | tee -a /etc/log-create-user.log
echo -e "            ⇱ \e[32;1m✶ Shadowsocks Result Account ✶\e[0m ⇲ ${NC}" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Remarks   : ${user} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}IP/Host   : ${IP} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Domain    : ${DOMAIN} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port TLS  : ${tls} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Port NTLS : ${http} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Method    : ${method} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Link TLS : ${linkss1} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Link none TLS : ${linkss2} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}Expired On : ${exp} $NC" | tee -a /etc/log-create-user.log
echo -e "  ${RED}•${NC} ${CYAN}────────────────────────────────── $NC" | tee -a /etc/log-create-user.log
echo -e "" | tee -a /etc/log-create-user.log
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log 
read -n 1 -s -r -p "Press any key to back on menu"
menu