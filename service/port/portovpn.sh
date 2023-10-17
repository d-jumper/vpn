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
github=$(cat $arfvpn/github)
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                ⇱ ${STABILO}Change Port OpenVPN${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Change Port TCP $NC"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Change Port UDP $NC"
echo -e "    ${CYAN}[${LIGHT}xx${CYAN}]${RED} •${NC} ${CYAN}Back To Menu $NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p " ➣  Select Menu [ 1 - 2 ] or [ x ] to Close Menu : " menu
echo -e ""
case $menu in

1)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN TCP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${RED} •${NC} ${CYAN}Port OpenVPN TCP :${NC}${LIGHT} ${ovpn}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "Change New Port for OpenVPN TCP : " vpn
sleep 2

if [ -z $vpn ]; then
echo -e "${RED} Please Input New Port !${NC}"
sleep 2
clear
changeport
fi

clear
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
sleep 1
else
echo -e "${RED} Port ${vpn} is used"
sleep 2
clear
changeport
fi

set_ovpn_tcp () {
rm -f /etc/openvpn/server/server-tcp.conf
rm -f /etc/openvpn/client/tcp.ovpn
rm -f /home/arfvps/public_html/tcp.ovpn
cat > /etc/openvpn/server/server-tcp.conf<<END
port $vpn
proto tcp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/server.crt
key /etc/openvpn/server/server.key
dh /etc/openvpn/server/dh.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
verify-client-cert none
username-as-common-name
server 10.6.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status openvpn-tcp.log
verb 3
END
cat > /etc/openvpn/client/tcp.ovpn <<-END
client
dev tun
proto tcp
remote $MYIP $vpn
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
echo '<ca>' >> /etc/openvpn/client/tcp.ovpn
cat /etc/openvpn/client/ca.crt >> /etc/openvpn/client/tcp.ovpn
echo '</ca>' >> /etc/openvpn/client/tcp.ovpn
cp /etc/openvpn/client/tcp.ovpn /home/arfvps/public_html/tcp.ovpn
systemctl disable --now openvpn-server@server-tcp > /dev/null
systemctl enable --now openvpn-server@server-tcp > /dev/null
sed -i 's/   - OpenVPN                 : TCP $ovpn, UDP $ovpn2, SSL 990/   - OpenVPN                 : TCP $vpn, UDP $ovpn2, SSL 990/g' /etc/arfvpn/log-install.txt
sed -i 's/$ovpn/$vpn/g" /etc/stunnel/stunnel.conf
}

clear
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN TCP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${LIGHT}- ${NC}Change Port OpenVPN TCP"
arfvpn_bar 'set_ovpn_tcp'
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
sleep 2
clear

echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN TCP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port OpenVPN TCP :${NC}${LIGHT} ${vpn}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
;;

2)
clear
echo -e ""
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN UDP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${RED} •${NC} ${CYAN}Port OpenVPN UDP :${NC}${LIGHT} ${ovpn2}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
read -p "Change New Port for OpenVPN UDP: " vpn
sleep 2

if [ -z $vpn ]; then
echo -e "${RED} Please Input New Port !${NC}"
sleep 2
clear
changeport
fi

clear
cek=$(netstat -nutlp | grep -w $vpn)
if [[ -z $cek ]]; then
sleep 1
else
echo -e "${RED} Port ${vpn} is used"
sleep 2
clear
changeport
fi

set_ovpn_udp () {
rm -f /etc/openvpn/server/server-udp.conf
rm -f /etc/openvpn/udp.ovpn
rm -f /home/arfvps/public_html/udp.ovpn
cat > /etc/openvpn/server/server-udp.conf<<END
port $vpn
proto udp
dev tun
ca /etc/openvpn/server/ca.crt
cert /etc/openvpn/server/server.crt
key /etc/openvpn/server/server.key
dh /etc/openvpn/server/dh.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
verify-client-cert none
username-as-common-name
server 10.7.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status openvpn-udp.log
verb 3
explicit-exit-notify
END
cat > /etc/openvpn/client/udp.ovpn <<-END
client
dev tun
proto udp
remote $MYIP $vpn
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
echo '<ca>' >> /etc/openvpn/client/udp.ovpn
cat /etc/openvpn/client/ca.crt >> /etc/openvpn/client/udp.ovpn
echo '</ca>' >> /etc/openvpn/client/udp.ovpn
cp /etc/openvpn/client/udp.ovpn /home/arfvps/public_html/udp.ovpn
systemctl disable --now openvpn-server@server-udp > /dev/null
systemctl enable --now openvpn-server@server-udp > /dev/null
sed -i 's/   - OpenVPN                 : TCP $ovpn, UDP $ovpn2, SSL 990/   - OpenVPN                 : TCP $ovpn, UDP $vpn, SSL 990/g' /etc/arfvpn/log-install.txt
}

clear
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN UDP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e " ${LIGHT}- ${NC}Change Port OpenVPN UDP"
arfvpn_bar 'set_ovpn_udp'
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
sleep 2
clear

echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "            ⇱ ${STABILO}Change Port OpenVPN UDP${NC} ⇲"
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "  ${SUCCESS}${NC}${LIGHT}Port Successfully Changed !$NC"
echo -e "  ${RED} •${NC} ${CYAN}New Port OpenVPN UDP :${NC}${LIGHT} ${vpn}$NC"
echo -e ""
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
;;

3)
clear
menu
;;

*)
clear
echo -e " ${EROR}${RED} Command not found! ${NC}"
sleep 3
changeport
;;

esac
echo -e ""
sleep 2
echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Changeport-Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
changeport
