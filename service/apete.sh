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
source /etc/os-release
OS=$ID
ver=$VERSION_ID

#########################################################
echo -e " ${INFO} Installing Requirements Tools VPN ..."
echo -e ""
sleep 2

remove_unnecessary () {
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
}
echo -e " ${LIGHT}- ${NC}Update - Upgrade Dist & Remove unnecessary files"
arfvpn_bar 'remove_unnecessary'
echo -e ""
sleep 2

install_xray () {
# Install Requirements Tools XRAY
apt install neofetch -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt -y install vnstat
apt -y install fail2ban
apt -y install cron
apt install bash-completion ntpdate -y
apt -y install chrony
}
echo -e " ${LIGHT}- ${NC}Installing Requirements Tools XRAY"
arfvpn_bar 'install_xray'
echo -e ""
sleep 2

set_time () {
# Set Time GMT +7 WIB
ntpdate 0.id.pool.ntp.org
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
}
echo -e " ${LIGHT}- ${NC}Set Time GMT +7 WIB"
arfvpn_bar 'set_time'
echo -e ""
sleep 2

disable_ipv6 () {
# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
}
echo -e " ${LIGHT}- ${NC}Set Disable IPV6"
arfvpn_bar 'disable_ipv6'
echo -e ""
sleep 2

set_chrony () {
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v
}
echo -e " ${LIGHT}- ${NC}Set Chrony"
arfvpn_bar 'set_chrony'
echo -e ""
sleep 2

install_ss () {
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
}
echo -e " ${LIGHT}- ${NC}Installing Requirements Shadowsocks-libev"
arfvpn_bar 'install_ss'
echo -e ""
sleep 2

install_nginx () {
# Install Requirements Tools Nginx
apt install pwgen openssl socat -y
apt install nginx php php-fpm php-cli php-mysql libxml-parser-perl -y
}
echo -e " ${LIGHT}- ${NC}Installing Requirements Tools Nginx"
arfvpn_bar 'install_nginx'
echo -e ""
sleep 2

install_ssh_ovpn () {
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
# Install Requirements Tools OpenVPN dan Easy-RSA
apt install openvpn easy-rsa unzip -y
apt install iptables iptables-persistent -y
}
echo -e " ${LIGHT}- ${NC}Installing Requirements Tools OpenSSH & OpenVPN"
arfvpn_bar 'install_ssh_ovpn'
echo -e ""
sleep 2

echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2