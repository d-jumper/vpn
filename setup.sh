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
apt install wget curl jq -y
#install host
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh"
chmod +x /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/hostvps
/usr/bin/hostvps

# ==========================================
#install Xray
wget "https://${github}/xray/ins-xray.sh" && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh

# =========================================
#install ssh ovpn
wget "https://${github}/ssh/ssh-vpn.sh" && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh

# =========================================
# Websocket
./wsedu

# =========================================
#OhpServer
wget "https://${github}/openvpn/ohp.sh" && chmod +x ohp.sh && ./ohp.sh

# =========================================
#Setting Backup
wget "https://${github}/backup/set-br.sh" && chmod +x set-br.sh && ./set-br.sh

# =========================================
wget -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
#wget -O /usr/bin/cert "https://${github}/service/cert.sh" && chmod +x /usr/bin/cert
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
/etc/set.sh

# =========================================
/usr/bin/fixssh

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
#echo "clear" >> .profile
#echo "neofetch" >> .profile
chmod 644 /root/.profile

history -c
# Set Cron Reboot VPS Every At 00:00 Mid-Night
if ! grep -q '/usr/bin/clearlog && reboot' /var/spool/cron/crontabs/root;then (crontab -l;echo "0 0 * * * /usr/bin/clearlog && reboot") | crontab;fi
# Set Cron Check & Delete Expired User & restart service Every At 00:10
if ! grep -q '/usr/bin/xp && /usr/bin/restart' /var/spool/cron/crontabs/root;then (crontab -l;echo "10 0 * * * /usr/bin/xp && /usr/bin/restart") | crontab;fi
#if ! grep -q '/usr/bin/xpssh' /var/spool/cron/crontabs/root;then (crontab -l;echo "10 3 * * * /usr/bin/xpssh") | crontab;fi
/etc/init.d/cron start
/etc/init.d/cron reload

history -c
echo "unset HISTFILE" >> /etc/profile
echo "1.2" > /home/ver
rm -f /root/*.sh
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
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Xray WS TLS             : 8443"  | tee -a log-install.txt
echo "   - Xray WS NONE TLS        : 80"  | tee -a log-install.txt
echo "   - Trojan GO               : 2087"  | tee -a log-install.txt
echo "   - Shadowsocks-Libev TLS   : 2443 - 3442" | tee -a log-install.txt
echo "   - Shadowsocks-Libev NTLS  : 3443 - 4442" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
#echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 00.00 GMT +7 WIB" | tee -a log-install.txt
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