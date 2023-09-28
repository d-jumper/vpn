#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
#Getting
arfvpn="/etc/arfvpn"
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

clear
# Link Hosting Kalian
github="raw.githubusercontent.com/arfprsty810/vpn/main"

curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://${github}/backup/rclone.conf"
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user lizsvrbckup@gmail.com
from lizsvrbckup@gmail.com 
password yourpaswordapp
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
cd /usr/bin
#wget -O autobackup "https://${github}/backup/autobackup.sh"
wget -O addemail "https://${github}/backup/addemail.sh"
wget -O changesend "https://${github}/backup/changesend.sh"
wget -O startbackup "https://${github}/backup/startbackup.sh"
wget -O stopbackup "https://${github}/backup/stopbackup.sh"
wget -O testsend "https://${github}/backup/testsend.sh"
wget -O backup "https://${github}/backup/backup.sh"
wget -O restore "https://${github}/backup/restore.sh"
wget -O strt "https://${github}/backup/strt.sh"
wget -O limitspeed "https://${github}/backup/limitspeed.sh"
chmod +x addemail
chmod +x changesend
chmod +x startbackup
chmod +x stopbackup
chmod +x testsend
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x strt
chmod +x limitspeed
cd
rm -f /root/set-br.sh
