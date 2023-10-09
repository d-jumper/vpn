#!/bin/bash
#########################################################
# Export Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
TYBLUE='\e[1;36m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0m'

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
echo -ne "     ${YELLOW}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${TYBLUE}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${YELLOW}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
clear
cat /etc/arfvpn/log-install.txt
echo ""
restart_service () {
sleep 15
systemctl stop ws-tls >/dev/null 2>&1
pkill python >/dev/null 2>&1
systemctl stop sslh >/dev/null 2>&1
systemctl daemon-reload >/dev/null 2>&1
systemctl disable ws-tls >/dev/null 2>&1
systemctl disable sslh >/dev/null 2>&1
systemctl disable squid >/dev/null 2>&1
systemctl daemon-reload >/dev/null 2>&1
systemctl enable sslh >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
systemctl enable ws-tls >/dev/null 2>&1
systemctl start sslh >/dev/null 2>&1
systemctl start squid >/dev/null 2>&1
/etc/init.d/sslh start >/dev/null 2>&1
/etc/init.d/sslh restart >/dev/null 2>&1
systemctl start ws-tls >/dev/null 2>&1
systemctl restart ws-tls >/dev/null 2>&1
sleep 15
systemctl daemon-reload >/dev/null 2>&1
systemctl restart ws-tls >/dev/null 2>&1
systemctl restart ws-nontls >/dev/null 2>&1
systemctl restart ws-ovpn >/dev/null 2>&1
systemctl restart ssh-ohp >/dev/null 2>&1
systemctl restart dropbear-ohp >/dev/null 2>&1
systemctl restart openvpn-ohp >/dev/null 2>&1
/etc/init.d/ssh restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1
/etc/init.d/sslh restart >/dev/null 2>&1
/etc/init.d/stunnel5 restart >/dev/null 2>&1
/etc/init.d/openvpn restart >/dev/null 2>&1
/etc/init.d/fail2ban restart >/dev/null 2>&1
/etc/init.d/cron restart >/dev/null 2>&1
/etc/init.d/nginx restart >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 >/dev/null 2>&1
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 >/dev/null 2>&1
}
echo -e " ${INFO} Restart All Service ..."
arfvpn_bar 'restart_service'
echo ""
echo -e "${OK} All Service/s Successfully Restarted ${CEKLIST}"
echo ""
echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${YELLOW}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
running