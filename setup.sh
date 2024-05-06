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
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}

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
start=$(date +%s)
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
mkdir -p ${arfvpn}/
touch ${arfvpn}/github
echo -e "raw.githubusercontent.com/d-jumper/vpn/main" > ${arfvpn}/github
github=$(cat ${arfvpn}/github)
clear

#########################################################
# Installing Server, Domain & Cert SSL
set_host () {
cd
apt install wget curl jq -y
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh"
chmod +x /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/hostvps
}
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.3.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
date
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Server, Domain & Cert SSL"
arfvpn_bar 'set_host'
echo -e ""
sleep 2
clear
/usr/bin/hostvps

#########################################################
# Installing Requirements Tools
set_apete () {
cd
wget "https://${github}/service/apete.sh"
chmod +x apete.sh
sed -i -e 's/\r$//' apete.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.3.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Requirements Tools"
arfvpn_bar 'set_apete'
echo -e ""
sleep 2
clear
/root/apete.sh

#########################################################
# Installing Xray - Trojan-Go - Shadowsocks-Libev
set_aio () {
cd
wget "https://${github}/xray/ins-xray.sh"
chmod +x ins-xray.sh
sed -i -e 's/\r$//' ins-xray.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.3.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Xray - Trojan-Go - Shadowsocks-Libev"
arfvpn_bar 'set_aio'
echo -e ""
sleep 2
clear
screen -S xray /root/ins-xray.sh

#########################################################
# Installing OpenSSH & OpenVPN
set_ssh () {
cd
wget "https://${github}/ssh/ssh-vpn.sh"
chmod +x ssh-vpn.sh
sed -i -e 's/\r$//' ssh-vpn.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.3.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing OpenSSH & OpenVPN"
arfvpn_bar 'set_ssh'
echo -e ""
sleep 2
clear
screen -S ssh-vpn /root/ssh-vpn.sh

#########################################################
# Installing Websocket
set_websocket () {
cd
wget -O /usr/bin/sshws "https://${github}/ssh/websocket/sshws.sh"
chmod +x /usr/bin/sshws
sed -i -e 's/\r$//' /usr/bin/sshws
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "       INSTALLING WEBSOCKET"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Websocket"
arfvpn_bar 'set_websocket'
echo -e ""
sleep 2
clear
/usr/bin/sshws

#########################################################
# Installing OhpServer
set_ohp () {
cd
wget "https://${github}/openvpn/ohp.sh"
chmod +x ohp.sh
sed -i -e 's/\r$//' ohp.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "       INSTALLING OHP SERVER"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing OhpServer"
arfvpn_bar 'set_ohp'
echo -e ""
sleep 2
clear
/root/ohp.sh

#########################################################
# Installing Setting Backup
#set_br () {
#cd
#wget "https://${github}/backup/set-br.sh"
#chmod +x set-br.sh
#}
#clear
#echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#echo -e "         INSTALLING BACKUP"
#echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#echo -e ""
#echo -e " ${LIGHT}- ${NC}Installing Setting Backup"
#arfvpn_bar 'set_br'
#echo -e ""
#sleep 2
#clear
#/root/set-br.sh

cd
set_wonder () {
#curl https://rclone.org/install.sh | bash
#printf "q\n" | rclone config
#wget -O /root/.config/rclone/rclone.conf "https://${github}/backup/rclone.conf"
git clone https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
}
cd
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "      INSTALLING WONDERSHAPER"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Wondershaper"
arfvpn_bar 'set_wonder'
echo -e ""
sleep 2

#########################################################
# Set rc.local restarting service
set_rclocal () {
cd
wget -O /usr/bin/fixssh "https://${github}/service/rc.local.sh"
chmod +x /usr/bin/fixssh
sed -i -e 's/\r$//' /usr/bin/fixssh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "             RC.LOCAL"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Create New Rc.Local"
arfvpn_bar 'set_rclocal'
echo -e ""
sleep 2
clear
/usr/bin/fixssh

#########################################################
# Installing Script
update_script () {
#wget -O /etc/arfvpn/apete "https://${github}/service/apete.sh" && chmod +x /usr/bin/apete
wget -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
#wget -O /etc/arfvpn/cron-vpn "https://${github}/service/cron-vpn" && chmod +x /etc/arfvpn/cron-vpn
#wget -O /usr/bin/cert "https://${github}/cert/cert.sh" && chmod +x /usr/bin/cert
#wget -O /usr/bin/cf "https://${github}/service/cf.sh" && chmod +x /usr/bin/cf
#wget -O /usr/bin/cfnhost "https://${github}/service/cfnhost.sh" && chmod +x /usr/bin/cfnhost
#wget -O /usr/bin/fixssh "https://${github}/service/rc.local.sh" && chmod +x /usr/bin/fixssh
#wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh" && chmod +x /usr/bin/hostvps
wget -O /usr/bin/limitspeed "https://${github}/service/limitspeed.sh" && chmod +x /usr/bin/limitspeed
wget -O /usr/bin/menu "https://${github}/service/menu.sh" && chmod +x /usr/bin/menu
#wget -O /usr/bin/menu-backup "https://${github}/service/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -O /usr/bin/menu-setting "https://${github}/service/menu-setting.sh" && chmod +x /usr/bin/menu-setting
wget -O /usr/bin/renew-domain "https://${github}/service/renew-domain.sh" && chmod +x /usr/bin/renew-domain
wget -O /usr/bin/restart "https://${github}/service/restart.sh" && chmod +x /usr/bin/restart
wget -O /usr/bin/running "https://${github}/service/running.sh" && chmod +x /usr/bin/running
wget -O /usr/bin/speedtest "https://${github}/service/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/update "https://${github}/service/update.sh" && chmod +x /usr/bin/update
#wget -O /usr/bin/update-xray "https://${github}/service/update-xray.sh" && chmod +x /usr/bin/update-xray
wget -O /etc/arfvpn/Version "https://${github}/service/Version"
wget -O /usr/bin/wbmn "https://${github}/service/webmin.sh" && chmod +x /usr/bin/wbmn
wget -O /usr/bin/xp "https://${github}/service/xp.sh" && chmod +x /usr/bin/xp
#sed -i -e 's/\r$//' /usr/bin/cek-apete
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
#sed -i -e 's/\r$//' /etc/arfvpn/cron-vpn
#sed -i -e 's/\r$//' /usr/bin/cert
#sed -i -e 's/\r$//' /usr/bin/cf
#sed -i -e 's/\r$//' /usr/bin/cfnhost
#sed -i -e 's/\r$//' /usr/bin/fixssh
#sed -i -e 's/\r$//' /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/limitspeed
sed -i -e 's/\r$//' /usr/bin/menu
#sed -i -e 's/\r$//' /usr/bin/menu-backup
sed -i -e 's/\r$//' /usr/bin/menu-setting
sed -i -e 's/\r$//' /usr/bin/renew-domain
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/update
#sed -i -e 's/\r$//' /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/wbmn
sed -i -e 's/\r$//' /usr/bin/xp

#wget -O /usr/bin/sshws "https://${github}/ssh/websocket/sshws.sh"
#chmod +x /usr/bin/sshws
#sed -i -e 's/\r$//' /usr/bin/sshws

wget -O /usr/bin/changeport "https://${github}/service/port/changeport.sh"
wget -O /usr/bin/portovpn "https://${github}/service/port/portovpn.sh"
wget -O /usr/bin/portsshws "https://${github}/service/port/portsshws.sh"
wget -O /usr/bin/portsquid "https://${github}/service/port/portsquid.sh"
wget -O /usr/bin/porttrojango "https://${github}/service/port/porttrojango.sh"
wget -O /usr/bin/portxrayws "https://${github}/service/port/portxrayws.sh"
#wget -O /usr/bin/portsstp "https://${github}/service/port/portsstp.sh"
#wget -O /usr/bin/portwg "https://${github}/service/port/portwg.sh
chmod +x /usr/bin/changeport
chmod +x /usr/bin/portovpn
chmod +x /usr/bin/portsshws
chmod +x /usr/bin/portsquid
chmod +x /usr/bin/porttrojango
chmod +x /usr/bin/portxrayws
#chmod +x /usr/bin/portsstp
#chmod +x /usr/bin/portwg
sed -i -e 's/\r$//' /usr/bin/changeport
sed -i -e 's/\r$//' /usr/bin/portovpn
sed -i -e 's/\r$//' /usr/bin/portsshws
sed -i -e 's/\r$//' /usr/bin/portsquid
sed -i -e 's/\r$//' /usr/bin/porttrojango
sed -i -e 's/\r$//' /usr/bin/portxrayws
#sed -i -e 's/\r$//' /usr/bin/portsstp
#sed -i -e 's/\r$//' /usr/bin/portwg
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.3.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Script VPN"
arfvpn_bar 'update_script'
echo -e ""
sleep 2

#########################################################
# Remove unnecessary files
remove_unnecessary () {
cd
apt autoclean -y
apt autoremove -y
}
echo -e " ${LIGHT}- ${NC}Removing Unnecessary Files"
arfvpn_bar 'remove_unnecessary'
echo -e ""
sleep 2

#########################################################
# Restart Service
set_restart (){
sleep 2
systemctl daemon-reload
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart ws-ovpn
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
}
echo -e " ${LIGHT}- ${NC}Restart-Service"
arfvpn_bar 'set_restart'
echo -e ""
sleep 2

#########################################################
# Set Auto-set.service
auto_set_service (){
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://t.me/arfprsty

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
}
echo -e " ${LIGHT}- ${NC}Installing Auto-Set.Service"
arfvpn_bar 'auto_set_service'
echo -e ""
sleep 2

#########################################################
# Fix Restart Service
fix_restart (){
sleep 15
systemctl stop ws-tls 
pkill python
systemctl stop sslh
systemctl daemon-reload
systemctl disable ws-tls
systemctl disable sslh
systemctl disable squid
systemctl daemon-reload
systemctl enable sslh
systemctl enable squid
systemctl enable ws-tls
systemctl start sslh 
systemctl start squid
/etc/init.d/sslh start 
/etc/init.d/sslh restart 
systemctl start ws-tls
systemctl restart ws-tls
sleep 15
systemctl daemon-reload
systemctl restart ws-tls
systemctl restart ws-nontls
systemctl restart ws-ovpn
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
}
echo -e " ${LIGHT}- ${NC}Fix Restart-Service"
arfvpn_bar 'fix_restart'
echo -e ""
sleep 2

#########################################################
# Set Cronjob for VPS
set_cron () {
wget -O /etc/arfvpn/cron-vpn "https://${github}/service/cron-vpn"
chmod +x /etc/arfvpn/cron-vpn
sed -i -e 's/\r$//' /etc/arfvpn/cron-vpn
if ! grep -q '/etc/arfvpn/cron-vpn' /var/spool/cron/crontabs/root;then (crontab -l;echo "0 0 * * * /etc/arfvpn/cron-vpn") | crontab;fi
/etc/init.d/cron start
/etc/init.d/cron restart
/etc/init.d/cron reload
}
echo -e " ${LIGHT}- ${NC}Set Cron to VPS"
arfvpn_bar 'set_cron'
echo -e ""
sleep 2

#########################################################
# Finish
finishing () {
# Finishing
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
history -c
clear
menu
END
chmod 644 /root/.profile
echo "unset HISTFILE" >> /etc/profile
echo "1.2" > /home/ver
rm -f /root/*.sh
}
echo -e " ${LIGHT}- ${NC}Finishing Installer"
arfvpn_bar 'finishing'
echo -e ""
sleep 2

echo -e ""
echo -e " ${OK} Setup VPN Successfully Installed !!! ${CEKLIST}"
echo -e ""
sleep 2
history -c
clear

#########################################################
# Log-installer
echo -e "" | tee -a /etc/arfvpn/log-install.txt
echo -e " ${OK} ${LIGHT}Installation VPN Successfully !!!${NC} ${CEKLIST}" | tee -a /etc/arfvpn/log-install.txt
echo -e "" | tee -a /etc/arfvpn/log-install.txt
echo -e "${BLUE}┌─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┐${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Service & Port${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} OpenSSH                 ${NC}:${ORANGE} 443, 22${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} OpenVPN                 ${NC}:${ORANGE} TCP 1194, UDP 2200, SSL 990${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket TLS           ${NC}:${ORANGE} 443${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket None TLS      ${NC}:${ORANGE} 8880${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Websocket Ovpn          ${NC}:${ORANGE} 2086${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} OHP SSH                 ${NC}:${ORANGE} 8181${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} OHP Dropbear            ${NC}:${ORANGE} 8282${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} OHP OpenVPN             ${NC}:${ORANGE} 8383${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Stunnel5                ${NC}:${ORANGE} 443, 445, 777${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Dropbear                ${NC}:${ORANGE} 443, 109, 143${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Squid Proxy             ${NC}:${ORANGE} 3128, 8080${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Badvpn                  ${NC}:${ORANGE} 7100, 7200, 7300${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Nginx                   ${NC}:${ORANGE} 89${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS TLS             ${NC}:${ORANGE} 8443${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Xray WS NONE TLS        ${NC}:${ORANGE} 80${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Trojan GO               ${NC}:${ORANGE} 2087${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev TLS   ${NC}:${ORANGE} 2443 - 3442${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Shadowsocks-Libev NTLS  ${NC}:${ORANGE} 3443 - 4442${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e ""| tee -a /etc/arfvpn/log-install.txt
echo -e "   ${TYBLUE}>>>${NC} ⇱ ${CYAN}Server Information & Other Features${NC} ⇲"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Timezone                ${NC}:${GREEN} Asia/Jakarta${NC} ${STABILO}( GMT +7 WIB )${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Fail2Ban                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt
#echo -e "   ${RED}⋗${NC}${LIGHT} Dflate                  ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} IPtables                ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} Auto-Reboot             ${NC}:${GREEN} [ON]${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${LIGHT} IPv6                    ${NC}:${RED} [OFF]${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${ORANGE} Autoreboot ON${NC} ${STABILO}00.00 GMT +7 WIB${NC}" | tee -a /etc/arfvpn/log-install.txt
#echo -e "   ${RED}⋗${NC}${ORANGE} Autobackup Data${NC}" | tee -a /etc/arfvpn/log-install.txt
#echo -e "   ${RED}⋗${NC}${ORANGE} Restore Data${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${ORANGE} Auto Delete Expired Account${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${ORANGE} Full Orders For Various Services${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${ORANGE} White Label${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e "   ${RED}⋗${NC}${ORANGE} Installation Log${NC}${RED} -->${NC} ${CYAN}/etc/arfvpn/log-install.txt${NC}"  | tee -a /etc/arfvpn/log-install.txt
echo -e ""  | tee -a /etc/arfvpn/log-install.txt
echo -e "${BLUE}└─────────────────────${NC} ⇱ ${STABILO}Script Mod By ™D-JumPer™${NC} ⇲ ${BLUE}─────────────────────┘${NC}" | tee -a /etc/arfvpn/log-install.txt
echo -e ""  | tee -a /etc/arfvpn/log-install.txt
secs_to_human "$(($(date +%s) - ${start}))" | tee -a /etc/arfvpn/log-install.txt
echo -e ""  | tee -a /etc/arfvpn/log-install.txt
echo -e "${LIGHT}Please write answer ${NC}[ Y/y ]${LIGHT} to ${NC}${YELLOW}Reboot${NC}${LIGHT} or ${NC}${RED}[ N/n ]${NC} / ${RED}[ CTRL+C ]${NC}${LIGHT} to exit${NC}"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
history -c
clear
exit 0
else
history -c
clear
reboot
fi