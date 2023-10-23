#!/bin/bash
#########################################################
# Export Color
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
BINC='\e[0m'

RED='\033[0;31m'      # RED 1
RED2='\e[1;31m'       # RED 2
GREEN='\033[0;32m'   # GREEN 1
GREEN2='\e[1;32m'    # GREEN 2
STABILO='\e[32;1m'    # STABILO
ORANGE='\033[0;33m' # ORANGE
PURPLE='\033[0;35m'  # PURPLE
BLUE='\033[0;34m'     # BLUE 1
TYBLUE='\e[1;36m'     # BLUE 2
CYAN='\033[0;36m'     # CYAN
LIGHT='\033[0;37m'    # LIGHT
NC='\033[0m'           # NC

bl='\e[36;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
color1='\e[031;1m'
color2='\e[34;1m'
green_mix() { echo -e "\\033[32;1m${*}\\033[0m"; }
red_mix() { echo -e "\\033[31;1m${*}\\033[0m"; }

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
source /etc/os-release
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
echo -ne "     ${ORANGE}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${LIGHT}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${ORANGE}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
arfvpn="/etc/arfvpn"
github=$(cat $arfvpn/github)
nginx="/etc/nginx"
arfvps="/home/arfvps/public_html"
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
IP=$(cat ${arfvpn}/IP)
MYIP2="s/ipxxx/${IP}/g";
phpv=$(cat /root/phpversion)
cd /root/
clear

#########################################################
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "      INSTALLING NGINX-SERVER"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
set_install () {
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
sleep 0.5
apt update > /dev/null 2>&1
apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
rm -f /root/jcameron-key.asc
}
echo -e " ${LIGHT}- ${NC}Installing Webmin"
arfvpn_bar 'set_install'
echo -e ""
sleep 2
installing_nginx () {
systemctl stop nginx
cd ${nginx}
rm ${nginx}/nginx.conf
wget -O ${nginx}/nginx.conf "https://${github}/nginx/nginx.conf"
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/sites-available/${domain}.conf "https://${github}/nginx/arfvps.conf"
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled
}
echo -e " ${LIGHT}- ${NC}Set Nginx-Server"
arfvpn_bar 'installing_nginx'
echo -e ""
sleep 2

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
echo -e " ${LIGHT}- ${NC}Create Root user"
arfvpn_bar 'user_root'
echo -e ""
sleep 2

php_v () {
cd
ls /etc/php > phpversion
sed -i "s/listen = \/run\/php\/php${phpv}-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php/${phpv}/fpm/pool.d/www.conf
rm /root/phpversion
}
echo -e " ${LIGHT}- ${NC}Set PHP-FPM"
arfvpn_bar 'php_v'
echo -e ""
sleep 2

echo -e " ${OK} Installing Nginx-Server Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2

set_ssl () {
wget -O /usr/bin/cert "https://${github}/cert/cert.sh"
chmod +x /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cert
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "       INSTALLING SSL CERT"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Make a SSL CERT"
arfvpn_bar 'set_ssl'
echo -e ""
sleep 2
clear
/usr/bin/cert
