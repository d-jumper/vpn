
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
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "       ⇱ \e[32;1m✶ Delete Expired SSH & OpenVPN Account ✶\e[0m ⇲ ${NC}"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
hariini=`date +%d-%m-%Y`
echo -e "${NC}${CYAN}Removing the EXPIRED USERS $NC"
echo -e "${NC}${CYAN}────────────────────────── $NC"
echo -e " "
cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
totalaccounts=`cat /tmp/expirelist.txt | wc -l`
for((i=1; i<=$totalaccounts; i++ ))
do
tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
username=`echo $tuserval | cut -f1 -d:`
userexp=`echo $tuserval | cut -f2 -d:`
userexpireinseconds=$(( $userexp * 86400 ))
tglexp=`date -d @$userexpireinseconds`             
tgl=`echo $tglexp |awk -F" " '{print $3}'`
while [ ${#tgl} -lt 2 ]
do
tgl="0"$tgl
done
while [ ${#username} -lt 15 ]
do
username=$username" " 
done
bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
todaystime=`date +%s`
if [ $userexpireinseconds -ge $todaystime ] ;
then
:
else
echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >> /usr/local/bin/deleteduser
echo -e "${NC}${CYAN}Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini" $NC"
userdel $username
fi
done
echo " "
echo -e "${NC}${CYAN}────────────────────────── $NC"
echo " "
echo -e "${NC}${CYAN}Script are successfully run $NC"
echo " "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu -ssh