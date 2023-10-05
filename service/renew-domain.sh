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

source /etc/os-release
cd /root
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
domain=$(cat ${arfvpn}/domain)
DOMAIN3="s/${domain}/domainxxx/g";
vps="/home/arfvps/public_html"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
DOMAIN2="s/domainxxx/${domain}/g";
MYIP=$(cat $arfvpn/IP)
MYIP2="s/xxxxxxxxx/$MYIP/g";
MYHOST="s/xxhostnamexx/$domain/g";
MYISP=$(cat $arfvpn/ISP)
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green        UPDATE / RENEW DOMAIN SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 5
sed -i $DOMAIN3 ${nginx}/sites-available/${domain}.conf
/usr/bin/hostvps
cd ${nginx}
systemctl stop nginx
mkdir -p $arfvpn/backup/
cp ${nginx}/sites-available/*.conf $arfvpn/backup/${domain}.conf
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
mkdir -p ${vps}/
cd ${vps}
chown -R www-data:www-data ${vps}
chmod -R g+rw ${vps}
chmod +x /home/
chmod +x /home/arfvps/
chmod +x ${vps}/
wget -O ${vps}/index.html "${github}/nginx/index.html"

cd ${nginx}
cp $arfvpn/backup/${domain}.conf ${nginx}/sites-available/${domain}.conf
sed -i $DOMAIN2 ${nginx}/sites-available/${domain}.conf
rm -rvf $arfvpn/backup/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled

/usr/bin/cert

systemctl enable nginx
systemctl start nginx
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5
echo " Re-installing Squid ..."
systemctl stop squid
rm -rvf /etc/squid/squid.conf
wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf
sed -i $MYHOST /etc/squid/squid.conf
systemctl start squid
/usr/bin/fixssh

echo -e "[ ${green}INFO$NC ] Update / Renew Domain Server Successfully!"
echo ""
echo -ne "[ ${yell}WARNING${NC} ] Please Reboot ur VPS !!! (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi