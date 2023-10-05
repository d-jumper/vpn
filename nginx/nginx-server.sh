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
apt install pwgen openssl socat -y
apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y
systemctl stop nginx
apt-get remove --purge apache apache* -y
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/nginx.conf "https://${github}/nginx/nginx.conf"
wget -O ${nginx}/conf.d/arfvps.conf "https://${github}/nginx/arfvps.conf"
sed -i "s/listen = \/run\/php\/php-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php/fpm/pool.d/www.conf
useradd -m arfvps;
mkdir -p ${vps}/
echo "<?php phpinfo() ?>" > ${vps}/info.php
chown -R www-data:www-data ${vps}
chmod -R g+rw ${vps}
chmod +x /home/
chmod +x /home/arfvps/
chmod +x ${vps}/
cd ${vps}/
wget -O ${vps}/index.html "https://${github}/nginx/index.html"

cd ${nginx}
wget -O ${nginx}/sites-available/${domain}.conf "https://${github}/nginx/domain.conf"
#sed -i 's/443/8443/g' /etc/nginx/sites-available/${domain}.conf
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled

wget -O /usr/bin/cert "https://${github}/service/cert.sh"
chmod +x /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cert
./cert

systemctl enable nginx
systemctl start nginx
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5