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

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING NGINX SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 3
echo -e "[ ${green}INFO$NC ] INSTALLING NGINX SERVER"
cd

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

cd
ls /etc/php > phpversion
phpv=$(cat /root/phpversion)
sed -i "s/listen = \/run\/php\/php${phpv}-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php/${phpv}/fpm/pool.d/www.conf
rm /root/phpversion

wget -O /usr/bin/cert "https://${github}/service/cert.sh"
chmod +x /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cert
/usr/bin/cert

systemctl enable nginx
systemctl start nginx
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5