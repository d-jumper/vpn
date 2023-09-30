#!/bin/bash
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
clear

if [ -e "/var/log/auth.log" ]; then
LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
LOG="/var/log/secure";
fi

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "       ⇱ \e[32;1m✶ Cek User Login SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "${NC}${CYAN}✶ ─── Dropbear User Login ─── ✶$NC"
echo -e "${NC}${CYAN}ID  |  Username  |  IP Address$sts $NC"
echo -e "${NC}${CYAN}────────────────────────────── $NC"
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
NUM=`cat /tmp/login-db-pid.txt | wc -l`;
USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
if [ $NUM -eq 1 ]; then
echo "$PID - $USER - $IP";
echo -e ""
echo -e "${NC}${CYAN}────────────────────────────── $NC"
fi

done
echo " "
echo -e "${NC}${CYAN}✶ ─── OpenSSH User Login ─── ✶$NC"
echo -e "${NC}${CYAN}ID  |  Username  |  IP Address$sts $NC"
echo -e "${NC}${CYAN}────────────────────────────── $NC"
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

for PID in "${data[@]}"
do
cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
NUM=`cat /tmp/login-db-pid.txt | wc -l`;
USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
if [ $NUM -eq 1 ]; then
echo "$PID - $USER - $IP";
echo -e ""
echo -e "${NC}${CYAN}────────────────────────────── $NC"
fi
done
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
echo " "
echo -e "${NC}${CYAN}✶ ─── OpenVPN TCP User Login ─── ✶$NC"
echo -e "${NC}${CYAN}ID  |  Username  |  IP Address$sts $NC"
echo -e "${NC}${CYAN}────────────────────────────── $NC"
cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
cat /tmp/vpn-login-tcp.txt
echo -e ""
echo -e "${NC}${CYAN}────────────────────────────── $NC"
fi

if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
echo " "
echo -e "${NC}${CYAN}✶ ─── OpenVPN UDP User Login ─── ✶$NC"
echo -e "${NC}${CYAN}ID  |  Username  |  IP Address$sts $NC"
echo -e "${NC}${CYAN}────────────────────────────── $NC"
cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
cat /tmp/vpn-login-udp.txt
echo -e ""
echo -e "${NC}${CYAN}────────────────────────────── $NC"
fi

echo -e "'
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu -ssh