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

error1="${RED}[ERROR]${NC}"
success="${GREEN}[SUCCESS]${NC}"
ipvps="/var/lib/arfvpn"
clear

echo -e "========================="
read -rp "Input Domain/Host : " -e domain
echo -e "========================="
echo -e "${success}\nDomain : ${domain} Added.."
# Delete Files
rm $ipvps/cfndomain
# Done
echo "${domain}" > $ipvps/cfndomain
sleep 5

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 