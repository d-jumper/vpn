#!/bin/bash
# ==========================================
# Color
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

# ==========================================
# Getting
arfvpn="/etc/arfvpn"
domain=$(cat $arfvpn/domain)
clear

## make a crt xray $domain
#systemctl stop nginx
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
rm -rvf ${arfvpn}/cert/
rm -rvf /root/.acme.sh
mkdir -p ${arfvpn}/cert/
mkdir -p /root/.acme.sh/
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue --force -d ${domain} --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d ${domain} --fullchainpath ${arfvpn}/cert/ca.crt --keypath ${arfvpn}/cert/ca.key --ecc
sleep 3
sudo openssl dhparam -out ${arfvpn}/cert/dh.pem 2048
echo -e "[ ${green}INFO$NC ] RENEW CERT SSL"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/bin/ssl_renew.sh
chmod +x /usr/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew.sh") | crontab;fi
echo -e "[ ${green}INFO$NC ] SUCCESS INSTALL CERT SSL"