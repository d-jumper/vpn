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
systemctl stop nginx
/usr/bin/hostvps
source /etc/os-release
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
vps="/home/vps/public_html"
github="https://raw.githubusercontent.com/arfprsty810/vpn/main"
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
MYHOST="s/xxhostnamexx/$domain/g";
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green        UPDATE / RENEW DOMAIN SERVER $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 3
cd ${nginx}
mkdir -p $arfvpn/backup/
cp ${nginx}/sites-available/*.conf $arfvpn/backup/${domain}.conf
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*

cd ${vps}
chown -R www-data:www-data ${vps}
chmod -R g+rw ${vps}
chmod +x /home/
chmod +x /home/vps/
chmod +x ${vps}/

cd ${nginx}
cp $arfvpn/backup/${domain}.conf ${nginx}/sites-available/${domain}.conf
rm -rvf $arfvpn/backup/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled

/usr/bin/cert

systemctl enable nginx
systemctl start nginx
systemctl restart nginx
sudo nginx -t && sudo systemctl reload nginx
sleep 5
systemctl stop squid
wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf
sed -i $MYHOST /etc/squid/squid.conf
systemctl start squid
wget https://${github}/openvpn/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh
/etc/set.sh
/usr/bin/fixssh

echo -e "[ ${green}INFO$NC ] Update / Renew Domain Successfully!"
echo ""
echo -ne "[ ${yell}WARNING${NC} ] Please Reboot ur VPS !!! (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi