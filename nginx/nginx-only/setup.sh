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
SUCCESS="[${LIGHT} ✔ SUCCESS ✔ ${NC}]"

#########################################################
source /etc/os-release
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
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}

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
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
ipvps="/var/lib/arfvpn"
start=$(date +%s)
clear

#########################################################
# Installing Server, Domain & Cert SSL
set_host () {
cd
mkdir -p ${arfvpn}/
touch ${arfvpn}/github
echo -e "raw.githubusercontent.com/d-jumper/vpn/main/nginx/nginx-only" > ${arfvpn}/github
github=$(cat ${arfvpn}/github)
apt install wget curl jq -y
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh"
chmod +x /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/hostvps
}
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    NGINX BUILDER V.1.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
date
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Server, Domain & Cert SSL"
arfvpn_bar 'set_host'
echo -e ""
sleep 2
clear
/usr/bin/hostvps

#########################################################
# Installing Requirements Tools
set_apete () {
cd
wget "https://${github}/service/apete.sh"
chmod +x apete.sh
sed -i -e 's/\r$//' apete.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    NGINX BUILDER V.1.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Requirements Tools"
arfvpn_bar 'set_apete'
echo -e ""
sleep 2
clear
/root/apete.sh

#########################################################
# NGINX-SERVER
set_nginx () {
cd
wget "https://${github}/nginx/nginx-server.sh"
chmod +x nginx-server.sh
sed -i -e 's/\r$//' nginx-server.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                  INSTALLING NGINX-SERVER"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#date
echo -e ""
echo -e " ${LIGHT}- ${NC}Installing Nginx-Server"
arfvpn_bar 'set_nginx'
echo -e ""
sleep 2
clear
./nginx-server.sh

#########################################################
# Remove unnecessary files
remove_unnecessary () {
cd
apt autoclean -y
apt autoremove -y
}
clear
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "                    NGINX BUILDER V.1.0"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Removing Unnecessary Files"
arfvpn_bar 'remove_unnecessary'
echo -e ""
sleep 2

#########################################################
# Set Cronjob for VPS
set_cron () {
wget -O /etc/arfvpn/cron-vpn "https://${github}/service/cron-vpn"
chmod +x /etc/arfvpn/cron-vpn
sed -i -e 's/\r$//' /etc/arfvpn/cron-vpn
if ! grep -q '/etc/arfvpn/cron-vpn' /var/spool/cron/crontabs/root;then (crontab -l;echo "0 0 * * * /etc/arfvpn/cron-vpn") | crontab;fi
/etc/init.d/cron start
/etc/init.d/cron restart
/etc/init.d/cron reload
}
echo -e " ${LIGHT}- ${NC}Set Cron to VPS"
arfvpn_bar 'set_cron'
echo -e ""
sleep 2

#########################################################
# Finish
finishing () {
# Finishing
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
history -c
clear
neofetch
END
chmod 644 /root/.profile
echo "unset HISTFILE" >> /etc/profile
echo "1.2" > /home/ver
rm -f /root/*.sh
}
echo -e " ${LIGHT}- ${NC}Finishing Installer"
arfvpn_bar 'finishing'
echo -e ""
sleep 2

#########################################################
echo -e ""
secs_to_human "$(($(date +%s) - ${start}))"
echo -e ""
echo -e " ${OK} Setup Nginx-Server Successfully Installed !!! ${CEKLIST}"
echo -e ""

echo -e "${LIGHT}Please write answer ${NC}[ Y/y ]${LIGHT} to ${NC}${YELLOW}Reboot${NC}${LIGHT} or ${NC}${RED}[ N/n ]${NC} / ${RED}[ CTRL+C ]${NC}${LIGHT} to exit${NC}"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
history -c
clear
exit 0
else
history -c
clear
reboot
fi
