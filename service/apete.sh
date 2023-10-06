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
OS=$ID
ver=$VERSION_ID

# Update, Upgrade dist & Remove unnecessary files
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt-get remove --purge apache apache* -y
apt-get remove --purge unscd -y
apt-get remove --purge samba* -y
apt-get remove --purge bind9* -y
apt-get remove --purge sendmail* -y

# Install Requirements Tools XRAY
apt install neofetch -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt -y install vnstat
apt -y install fail2ban
apt -y install cron
apt install bash-completion ntpdate -y
ntpdate 0.id.pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Manila
chronyc sourcestats -v
chronyc tracking -v
date
sleep 5

# Install Requirements Shadowsocks-libev 
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y

elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y

elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
fi
fi

# Install Requirements Tools Nginx
apt install pwgen openssl socat -y
apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y

# Install Requirements Tools SSHVPN
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install bc -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y
apt-get --reinstall --fix-missing install bzip2 gzip screen iftop htop -y

apt -y install dropbear
apt -y install squid3
apt -y install sslh

# Install Requirements Tools OpenVPN dan Easy-RSA
apt install openvpn easy-rsa unzip -y
apt install iptables iptables-persistent -y

clear