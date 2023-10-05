#!/bin/bash
#########################
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"


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
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
trgo="/etc/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
success="${GREEN}[SUCCESS]${NC}"

# ==========================================
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
# ==========================================
github="raw.githubusercontent.com/arfprsty810/vpn/main"

# ==========================================
rm -rvf $arfvpn/IP
rm -rvf $arfvpn/ISP
rm -rvf $arfvpn/domain
rm -rvf $arfvpn/scdomain
rm -rvf ${ipvps}/ipvps.conf
rm -rvf ${ipvps}/cfndomain

mkdir -p $arfvpn
touch $arfvpn/IP
touch $arfvpn/ISP
touch $arfvpn/domain
touch $arfvpn/scdomain
mkdir -p $ipvps
touch ${ipvps}/ipvps.conf
touch ${ipvps}/cfndomain
echo "none" > ${ipvps}/cfndomain
mkdir -p $xray
mkdir -p $trgo
mkdir -p $nginx

# ==========================================
curl -s ipinfo.io/org/ > ${arfvpn}/ISP
curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
clear
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Add Domain for Server VPN $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
echo -e "[ ${green}INFO$NC ]* BLANK INPUT FOR RANDOM SUB-DOMAIN ! "
read -rp "Input ur domain / sub-domain : " -e domain
    if [ -z ${domain} ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    
    wget -O /usr/bin/cf "https://${github}/service/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    /usr/bin/cf
    else
    echo -e "${success} Please wait..."
	echo "${domain}" > ${arfvpn}/domain
	echo "${domain}" > ${arfvpn}/scdomain
    echo "IP=${domain}" > ${ipvps}/ipvps.conf
    fi
    sleep 1

# ==========================================