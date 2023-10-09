#!/bin/bash
#########################################################
# Export Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
TYBLUE='\e[1;36m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0m'

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
echo -ne "     ${YELLOW}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${TYBLUE}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${YELLOW}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
source /etc/os-release
cd /root
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
arfvps="/home/arfvps/public_html"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
DOMAIN3="s/${domain}/domainxxx/g";
MYIP=$(cat $arfvpn/IP)
MYIP2="s/xxxxxxxxx/$MYIP/g";
MYHOST="s/xxhostnamexx/$domain/g";
MYISP=$(cat $arfvpn/ISP)

#########################################################
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "    UPDATE / RENEW DOMAIN SERVER"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 5

systemctl stop nginx
systemctl stop squid
cd
sed -i $DOMAIN3 ${nginx}/sites-available/${domain}.conf
sed -i $DOMAIN3 /etc/squid/squid.conf
/usr/bin/hostvps

renew_nginx () {
mkdir -p $arfvpn/backup/
cp ${nginx}/sites-available/*.conf $arfvpn/backup/${domain}.conf
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
cp $arfvpn/backup/${domain}.conf ${nginx}/sites-available/${domain}.conf
sed -i $DOMAIN2 ${nginx}/sites-available/${domain}.conf
rm -rvf $arfvpn/backup/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled

mkdir -p ${arfvps}/
cd ${arfvps}
wget -O ${arfvps}/index.html "https://${github}/nginx/index.html"
chown -R www-data:www-data ${arfvps}
chmod -R g+rw ${arfvps}
chmod +x /home/
chmod +x /home/arfvps/
chmod +x ${arfvps}/
}
clear
echo -e " ${LIGHT}- ${NC}Renew Server"
arfvpn_bar 'renew_nginx'
echo -e ""
sleep 2
/usr/bin/cert

renew_squid () {
#systemctl stop squid
#cp /etc/squid/squid.conf $arfvpn/backup/squid.conf
#rm /etc/squid/squid.conf
#cp $arfvpn/backup/squid.conf /etc/squid/squid.conf
#wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
sed -i $DOMAIN2 /etc/squid/squid.conf
#rm $arfvpn/backup/squid.conf
systemctl start squid
}
clear
echo -e " ${LIGHT}- ${NC}Renew Squid"
arfvpn_bar 'renew_squid'
echo -e ""
sleep 2
/usr/bin/fixssh

echo -e " ${OK} Renew Domain Successfully !!! ${CEKLIST}"
echo -e ""
echo -e "     ${LIGHT}Please write answer ${NC}[ Y/y ]${LIGHT} to ${NC}${YELLOW}Reboot-Server${NC}${LIGHT} or ${NC}${RED}[ N/n ]${NC} / ${RED}[ CTRL+C ]${NC}${LIGHT} to exit${NC}"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi