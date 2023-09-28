#!/bin/bash
#########################
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

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"


red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# ==========================================
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
MYISP=$(curl -s ipinfo.io/org/);
MYIP=$(curl -s https://ipinfo.io/ip/);
success="${GREEN}[SUCCESS]${NC}"
start=$(date +%s)

# ==========================================
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
# ==========================================
github="raw.githubusercontent.com/arfprsty810/vpn/main"

# ==========================================
mkdir -p $arfvpn
touch $arfvpn/IP
touch $arfvpn/ISP
touch $arfvpn/domain
touch $arfvpn/scdomain
mkdir -p $ipvps
touch ${ipvps}/ipvps.conf
touch ${ipvps}/cfndomain
mkdir -p $xray
mkdir -p $trgo
mkdir -p $nginx

# ==========================================
apt install curl jq -y
clear
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Add Domain for Server VPN $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
echo -e "[ ${green}INFO$NC ]* BLANK INPUT FOR RANDOM SUB-DOMAIN ! "
read -rp "Input ur domain / sub-domain : " -e domain
    if [ -z ${domain} ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    
    wget -O /usr/bin/cf "https://${github}/service/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    cf
    else
    echo -e "${success} Please wait..."
	echo "${domain}" > ${arfvpn}/domain
	echo "${domain}" > ${arfvpn}/scdomain
    echo "IP=${domain}" > ${ipvps}/ipvps.conf
    echo "none" > ${ipvps}/cfndomain
    curl -s ipinfo.io/org/ > ${arfvpn}/ISP
    curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
    fi
    sleep 1

# ==========================================
#install Xray
wget "https://${github}/xray/ins-xray.sh" && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh

# =========================================
#install ssh ovpn
wget "https://${github}/ssh/ssh-vpn.sh" && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

# =========================================
# Websocket
wget "https://${github}/ssh/websocket/edu.sh" && chmod +x edu.sh && ./edu.sh

# =========================================
# OphvServer
wget "https://${github}/openvpn/ohp.sh" && chmod +x ohp.sh && ./ohp.sh

# =========================================
#Setting Backup
wget "https://${github}/backup/set-br.sh" && chmod +x set-br.sh && ./set-br.sh

# =========================================
# Update Menu
wget "https://${github}/update/getupdate.sh" && chmod +x getupdate.sh && ./getupdate.sh

# =========================================
# sslh fix
wget "https://${github}/sslh-fix/sslh-fix.sh" && chmod +x sslh-fix.sh && ./sslh-fix.sh

# =========================================
#restart service
clear
echo -e ""
echo -e "Starting Restart All Service"
sleep 2
#systemctl restart ssrmu
systemctl daemon-reload
systemctl restart ws-tls
systemctl restart ws-nontls
#systemctl restart xray.service
#systemctl restart shadowsocks-libev
#systemctl restart xl2tpd
#systemctl restart pptpd
#systemctl restart ipsec
#systemctl restart accel-ppp
systemctl restart ws-ovpn
#systemctl restart wg-quick@wg0
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
#systemctl restart trojan-go
#/etc/init.d/ssrmu restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
#/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo -e "Restart All Service Berhasil"
sleep 2
clear

# =========================================
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

# =========================================
wget -O /etc/set.sh "https://${github}/ssh/archive/set.sh"
chmod +x /etc/set.sh

# =========================================
echo -e "Restarting All Service Please Wait..."
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
clear
echo -e ""
echo -e "Starting Restart All Service"
sleep 2
#systemctl restart ssrmu
systemctl daemon-reload
systemctl restart ws-tls
systemctl restart ws-nontls
#systemctl restart xray.service
#systemctl restart shadowsocks-libev
#systemctl restart xl2tpd
#systemctl restart pptpd
#systemctl restart ipsec
#systemctl restart accel-ppp
systemctl restart ws-ovpn
#systemctl restart wg-quick@wg0
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
#systemctl restart trojan-go
#/etc/init.d/ssrmu restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
#/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo -e "Restart All Service Berhasil"
sleep 2
clear

wget -q -O /usr/bin/restart "https://${github}/service/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/running "https://${github}/service/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/update-xray "https://${github}/service/update-xray.sh" && chmod +x /usr/bin/update-xray
wget -q -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -q -O /usr/bin/menu "https://${github}/service/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/speedtest "https://${github}/service/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -q -O /usr/bin/update "https://${github}/service/update.sh" && chmod +x /usr/bin/update
wget -q -O /usr/bin/wbmn "https://${github}/service/webmin.sh" && chmod +x /usr/bin/wbmn
wget -q -O /usr/bin/cf "https://${github}/service/cf.sh" && chmod +x /usr/bin/cf
sed -i -e 's/\r$//' /usr/bin/menu
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
sed -i -e 's/\r$//' /usr/bin/wbmn
sed -i -e 's/\r$//' /usr/bin/update
sed -i -e 's/\r$//' /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/cf
clear
# =========================================
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true

menu
END
chmod 644 /root/.profile


history -c
# Reboot VPS Every At 00:00 Mid-Night
if ! grep -q 'reboot' /var/spool/cron/crontabs/root;then (crontab -l;echo "0 0 * * * reboot") | crontab;fi
# Restart Service Every At 00:05 Mid-Night
if ! grep -q '/usr/bin/restart' /var/spool/cron/crontabs/root;then (crontab -l;echo "5 0 * * * /usr/bin/restart") | crontab;fi
# Check & Delete Expired User Every At 00:10 Mid-Night
if ! grep -q '/usr/bin/xp' /var/spool/cron/crontabs/root;then (crontab -l;echo "10 0 * * * /usr/bin/xp") | crontab;fi

history -c
echo "1.2" > /home/ver
rm -f /root/*.sh
rm -f /root/newhost.sh
rm -rvf /root/domain
clear

# =========================================

echo " "
echo "Installation has been completed!!"
echo " "
echo "=================================-™D-JumPer™ Project-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2083"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Tr Go                   : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 00.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "---------------------- Script Mod By ™D-JumPer™ ----------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo ""

echo -ne "[ ${yell}WARNING${NC} ] Reboot ur VPS ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi