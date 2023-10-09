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

#########################################################
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
trgo="/etc/arfvpn/trojan-go"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
success="${GREEN}[SUCCESS]${NC}"


#########################################################
hostvps_server () {
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

#########################################################
github="raw.githubusercontent.com/arfprsty810/vpn/main"

#########################################################
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

#########################################################
curl -s ipinfo.io/org/ > ${arfvpn}/ISP
curl -s https://ipinfo.io/ip/ > ${arfvpn}/IP
}
clear
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "     Add Domain for Server VPN"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
echo -e " ${LIGHT}- ${NC}Creating Directory VPN Server"
arfvpn_bar 'hostvps_server'
echo -e ""
sleep 2
echo -e "${INFO}${LIGHT}* ${NC} ${RED}Blank Input For Random Sub-domain ! ${NC}"
read -rp "Input ur domain / sub-domain : " -e domain
    if [ -z ${domain} ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    rm /usr/bin/cf
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

#########################################################