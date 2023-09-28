#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
arfvpn="/etc/arfvpn"
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

clear
email=$(cat /home/email)
sed -i "/^$email/d" /home/email
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
exit 0