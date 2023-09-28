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
clear
github="raw.githubusercontent.com/arfprsty810/vpn/main"
# change direct
cd /usr/bin
# remove file
rm menu
rm -rf menu
# Download update
wget -O menu-ssh "https://${github}/update/menu-ssh.sh"
wget -O menu-backup "https://${github}/update/menu-backup.sh"
wget -O menu-setting "https://${github}/update/menu-setting.sh"
# change Permission
chmod +x menu-ssh
chmod +x menu-backup
chmod +x menu-setting
#change direct
cd /root
# clear
clear
echo -e "Succes Update Menu"
sleep 3
