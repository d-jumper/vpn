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

# ==========================================
# Getting
arfvpn="/etc/arfvpn"
domain=$(cat $arfvpn/domain)
github="raw.githubusercontent.com/arfprsty810/vpn/main"

# ==========================================
installing_cert () {
## make a cert
cd
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
rm -rvf ${arfvpn}/cert/ca.crt ${arfvpn}/cert/ca.key ${arfvpn}/cert/dh.pem
mkdir -p ${arfvpn}/cert/
rm -rvf /root/.acme.sh
mkdir -p /root/.acme.sh/
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
#wget "https://${github}/cert/acme.sh.zip"
#unzip acme.sh.zip
#rm -rvf /root/acme.sh.zip
chmod +x /root/.acme.sh/acme.sh
~/.acme.sh/acme.sh --upgrade --auto-upgrade
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --issue --force -d ${domain} --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d ${domain} --fullchainpath ${arfvpn}/cert/ca.crt --keypath ${arfvpn}/cert/ca.key --ecc
sudo openssl dhparam -out ${arfvpn}/cert/dh.pem 2048
sleep 3
}

# ==========================================
set_cron () {
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/bin/ssl_renew
chmod +x /usr/bin/ssl_renew
if ! grep -q '/usr/bin/ssl_renew' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew") | crontab;fi
}

# ==========================================
echo -e " ${INFO} Installing SSL CERT ..."
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Make a SSL CERT"
arfvpn_bar 'installing_cert'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Set cron Renew SSL CERT"
arfvpn_bar 'set_cron'
echo -e ""
sleep 2

echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2