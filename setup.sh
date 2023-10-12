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
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
success="${GREEN}[SUCCESS]${NC}"
start=$(date +%s)
github="raw.githubusercontent.com/arfprsty810/vpn/main"

#########################################################
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

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
date
sleep 3
#########################################################
# Installing Server, Domain & Cert SSL
set_host () {
cd
apt install wget curl jq -y
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh"
chmod +x /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/hostvps
}
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
chmod +x /root/apete.sh
sed -i -e 's/\r$//' /root/apete.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
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
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
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
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
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
apt update
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Websocket"
arfvpn_bar 'set_websocket'
echo -e ""
sleep 2
clear
/usr/bin/wsedu

#########################################################
# Installing OhpServer
set_ohp () {
cd
wget "https://${github}/openvpn/ohp.sh"
chmod +x ohp.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing OhpServer"
arfvpn_bar 'set_ohp'
echo -e ""
sleep 2
clear
/root/ohp.sh

#########################################################
# Installing Setting Backup
set_br () {
cd
wget "https://${github}/backup/set-br.sh"
chmod +x set-br.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Setting Backup"
arfvpn_bar 'set_br'
echo -e ""
sleep 2
clear
/root/set-br.sh

#########################################################
# Set Auto-set.service
set_set (){
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
clear
echo -e " ${LIGHT}- ${NC}Installing Auto-set.service"
arfvpn_bar 'set_set'
echo -e ""
sleep 2
cd
clear
/etc/set.sh

#########################################################
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
update_script () {
# Download file/s script
#wget -O /etc/arfvpn/apete "https://${github}/service/apete.sh" && chmod +x /usr/bin/apete
wget -O /etc/arfvpn/Version "https://${github}/service/Version"
wget -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
#wget -O /usr/bin/cert "https://${github}/cert/cert.sh" && chmod +x /usr/bin/cert
#wget -O /usr/bin/cf "https://${github}/service/cf.sh" && chmod +x /usr/bin/cf
wget -O /usr/bin/cfnhost "https://${github}/service/cfnhost.sh" && chmod +x /usr/bin/cfnhost
#wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh" && chmod +x /usr/bin/hostvps
wget -O /usr/bin/menu "https://${github}/service/menu.sh" && chmod +x /usr/bin/menu
wget -O /usr/bin/menu-backup "https://${github}/service/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -O /usr/bin/menu-setting "https://${github}/service/menu-setting.sh" && chmod +x /usr/bin/menu-setting
wget -O /usr/bin/fixssh "https://${github}/service/rc.local.sh" && chmod +x /usr/bin/fixssh
wget -O /usr/bin/renew-domain "https://${github}/service/renew-domain.sh" && chmod +x /usr/bin/renew-domain
wget -O /usr/bin/restart "https://${github}/service/restart.sh" && chmod +x /usr/bin/restart
wget -O /usr/bin/running "https://${github}/service/running.sh" && chmod +x /usr/bin/running
wget -O /usr/bin/speedtest "https://${github}/service/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/update "https://${github}/service/update.sh" && chmod +x /usr/bin/update
#wget -O /usr/bin/update-xray "https://${github}/service/update-xray.sh" && chmod +x /usr/bin/update-xray
wget -O /usr/bin/wbmn "https://${github}/service/webmin.sh" && chmod +x /usr/bin/wbmn
wget -O /usr/bin/xp "https://${github}/service/xp.sh" && chmod +x /usr/bin/xp
#sed -i -e 's/\r$//' /usr/bin/cek-apete
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
#sed -i -e 's/\r$//' /usr/bin/cert
#sed -i -e 's/\r$//' /usr/bin/cf
sed -i -e 's/\r$//' /usr/bin/cfnhost
#sed -i -e 's/\r$//' /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/menu
sed -i -e 's/\r$//' /usr/bin/menu-backup
sed -i -e 's/\r$//' /usr/bin/menu-setting
sed -i -e 's/\r$//' /usr/bin/fixssh
sed -i -e 's/\r$//' /usr/bin/renew-domain
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/update
#sed -i -e 's/\r$//' /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/wbmn
sed -i -e 's/\r$//' /usr/bin/xp

wget -O /usr/bin/changeport "https://${github}/service/port/changeport.sh"
wget -O /usr/bin/portovpn "https://${github}/service/port/portovpn.sh"
wget -O /usr/bin/portsquid "https://${github}/service/port/portsquid.sh"
wget -O /usr/bin/portsstp "https://${github}/service/port/portsstp.sh"
wget -O /usr/bin/porttrojan "https://${github}/service/port/porttrojan.sh"
wget -O /usr/bin/portvlm "https://${github}/service/port/portvlm.sh"
wget -O /usr/bin/portwg "https://${github}/service/port/portwg.sh"
chmod +x /usr/bin/changeport
chmod +x /usr/bin/portovpn
chmod +x /usr/bin/portsquid
chmod +x /usr/bin/portsstp
chmod +x /usr/bin/porttrojan
chmod +x /usr/bin/portvlm
chmod +x /usr/bin/portwg
sed -i -e 's/\r$//' /usr/bin/changeport
sed -i -e 's/\r$//' /usr/bin/portovpn
sed -i -e 's/\r$//' /usr/bin/portsquid
sed -i -e 's/\r$//' /usr/bin/portsstp
sed -i -e 's/\r$//' /usr/bin/porttrojan
sed -i -e 's/\r$//' /usr/bin/portvlm
sed -i -e 's/\r$//' /usr/bin/portwg
}
echo -e " ${LIGHT}- ${NC}Installing VPN Script"
arfvpn_bar 'update_script'
echo -e ""
sleep 2

#########################################################
remove_unnecessary () {
# Remove unnecessary files
cd
apt autoclean -y
apt autoremove -y
}
echo -e " ${LIGHT}- ${NC}Removing Unnecessary Files"
arfvpn_bar 'remove_unnecessary'
echo -e ""
sleep 2

#########################################################
set_cron () {
cat > /etc/arfvpn/cron-vpn << END
#!/bin/bash
# Set Cron Reboot VPS
# Set Auto Delete User Expired
# Every At 00:00 Mid-Night
/usr/bin/clearlog
sleep 5
/usr/bin/xp
sleep 5
/sbin/reboot
echo -e "${OK} Auto Delete User Expired Successfully${CEKLIS}" >> /etc/arfvpn/log-cron.log
echo -e "${OK} Auto Reboot Server Successfully${CEKLIS}" >> /etc/arfvpn/log-cron.log
date >> /etc/arfvpn/log-cron.log
exit
END
chmod +x /etc/arfvpn/cron-vpn
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
# Set rc.local restarting service
set_rclocal () {
cd
apt update
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Set New rc-local.service"
arfvpn_bar 'set_rclocal'
echo -e ""
sleep 2
clear
/usr/bin/fixssh

#########################################################
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
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    AUTOSCRIPT VPN V.2.3"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
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
echo " " | tee -a /etc/arfvpn/log-install.txt
echo -e " ${OK} Installation VPN Successfully !!! ${CEKLIST}" | tee -a /etc/arfvpn/log-install.txt
echo " " | tee -a /etc/arfvpn/log-install.txt
echo "---------------------- Script Mod By ™D-JumPer™ ----------------------" | tee -a /etc/arfvpn/log-install.txt
echo "" | tee -a /etc/arfvpn/log-install.txt
echo "   >>> Service & Port"  | tee -a /etc/arfvpn/log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a /etc/arfvpn/log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a /etc/arfvpn/log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a /etc/arfvpn/log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a /etc/arfvpn/log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Nginx                   : 89"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Xray WS TLS             : 8443"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Xray WS NONE TLS        : 80"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Trojan GO               : 2087"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Shadowsocks-Libev TLS   : 2443 - 3442" | tee -a /etc/arfvpn/log-install.txt
echo "   - Shadowsocks-Libev NTLS  : 3443 - 4442" | tee -a /etc/arfvpn/log-install.txt
echo ""  | tee -a /etc/arfvpn/log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7 WIB)"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a /etc/arfvpn/log-install.txt
echo "   - IPtables                : [ON]"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a /etc/arfvpn/log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a /etc/arfvpn/log-install.txt
echo "   - Autoreboot On 00.00 GMT +7 WIB" | tee -a /etc/arfvpn/log-install.txt
echo "   - Autobackup Data" | tee -a /etc/arfvpn/log-install.txt
echo "   - Restore Data" | tee -a /etc/arfvpn/log-install.txt
echo "   - Auto Delete Expired Account" | tee -a /etc/arfvpn/log-install.txt
echo "   - Full Orders For Various Services" | tee -a /etc/arfvpn/log-install.txt
echo "   - White Label" | tee -a /etc/arfvpn/log-install.txt
echo "   - Installation Log --> /etc/arfvpn/log-install.txt"  | tee -a /etc/arfvpn/log-install.txt
echo ""  | tee -a /etc/arfvpn/log-install.txt
echo "---------------------- Script Mod By ™D-JumPer™ ----------------------" | tee -a /etc/arfvpn/log-install.txt
echo ""  | tee -a /etc/arfvpn/log-install.txt
secs_to_human "$(($(date +%s) - ${start}))" | tee -a /etc/arfvpn/log-install.txt
echo ""  | tee -a /etc/arfvpn/log-install.txt

echo -e ""
echo -e "  ${LIGHT}Please write answer ${NC}[ Y/y ]${LIGHT} to ${NC}${YELLOW}Reboot-Server${NC}${LIGHT} or ${NC}${RED}[ N/n ]${NC} / ${RED}[ CTRL+C ]${NC}${LIGHT} to exit${NC}"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi