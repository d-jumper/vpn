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
cd /root
source /etc/os-release
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
arfvps="/home/arfvps/public_html"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
IP=$(cat ${arfvpn}/IP)
MYIP2="s/ipxxx/${IP}/g";
clear

#########################################################
installing_nginx () {
systemctl stop nginx
cd ${nginx}
rm ${nginx}/nginx.conf
wget -O ${nginx}/nginx.conf "https://${github}/nginx/nginx.conf"
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/sites-available/${domain}.conf "https://${github}/nginx/arfvps.conf"
#sed -i 's/443/8443/g' ${nginx}/sites-available/${domain}.conf
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled
}

#########################################################
user_root () {
useradd -m arfvps;
mkdir -p ${arfvps}/
cd ${arfvps}/
wget -O ${arfvps}/index.html "https://${github}/nginx/index.html"
echo "<?php phpinfo() ?>" > ${arfvps}/info.php
chown -R www-data:www-data ${arfvps}
chmod -R g+rw ${arfvps}
chmod +x /home/
chmod +x /home/arfvps/  
chmod +x ${arfvps}/
}

#########################################################
php_v () {
cd
ls /etc/php > phpversion
phpv=$(cat /root/phpversion)
sed -i "s/listen = \/run\/php\/php${phpv}-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php/${phpv}/fpm/pool.d/www.conf
rm /root/phpversion
}

#########################################################
echo -e " ${LIGHT}- ${NC}Installing Nginx Server"
arfvpn_bar 'installing_nginx'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Create Root user"
arfvpn_bar 'user_root'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Set PHP-FPM"
arfvpn_bar 'php_v'
echo -e ""
sleep 2

#########################################################
echo -e " ${LIGHT}- ${NC}Make a SSL CERT"
sleep 2
wget -O /usr/bin/cert "https://${github}/cert/cert.sh"
chmod +x /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cert
/usr/bin/cert