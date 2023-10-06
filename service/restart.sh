#!/bin/bash
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

clear
cat /etc/arfvpn/log-install.txt
echo ""

# ----------------------------------------------------------------------------------------------------------------
# Restart Service
# ----------------------------------------------------------------------------------------------------------------
sleep 1
echo -e "[ ${green}INFO$NC ] Restart All Service ..."
echo ""
sleep 15
systemctl stop ws-tls >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Stopping Websocket "
pkill python >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Stopping Python "
systemctl stop sslh >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Stopping Sslh "
systemctl daemon-reload >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Daemon Reload "
systemctl disable ws-tls >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Disabled Websocket "
systemctl disable sslh >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Disabled Sslh "
systemctl disable squid >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Disabled Squid "
systemctl daemon-reload >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Daemon Reload "
systemctl enable sslh >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Enable Sslh "
systemctl enable squid >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Enable Squid "
systemctl enable ws-tls >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Enable Websocket "
systemctl start sslh >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Starting Sslh "
systemctl start squid >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Starting Squid "
/etc/init.d/sslh start >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Starting Sslh "
/etc/init.d/sslh restart >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Restart Sslh "
systemctl start ws-tls >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Starting Websocket "
systemctl restart ws-tls >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Restart Websocket "
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
echo -e "[ ${GREEN}ok${NC} ] Restarting all.service ..."
echo ""
echo "      All Service/s Successfully Restarted         "
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
running