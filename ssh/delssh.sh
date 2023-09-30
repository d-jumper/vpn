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

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
# ==========================================
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "       ⇱ \e[32;1m✶ Delete Member SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}USERNAME          EXP DATE          STATUS ${NC}"
echo -e "${NC}${CYAN}────────────────────────────────────────── $NC"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "${NC}${CYAN}────────────────────────────────────────── $NC"
echo -e "${NC}${CYAN}Total Client : $JUMLAH user ${NC}"
echo -e "${NC}${CYAN}──────────────────── $NC"
echo -e " "
read -p "Username SSH to Delete : " user
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

if getent passwd $user > /dev/null 2>&1; then
clear
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "       ⇱ \e[32;1m✶ Delete Member SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
userdel $user
echo -e "${NC}${CYAN}Username $user Was removed user ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 3
else
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "       ⇱ \e[32;1m✶ Delete Member SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "${NC}${CYAN}Failure: Username $user does not exist ${NC}"
echo -e " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
sleep 3
clear
menu-ssh
fi

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 