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
arfvpn="/etc/arfvpn"
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

clear
data=( `cat /var/lib/arfvpn/data-user-l2tp | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/var/lib/arfvpn/data-user-l2tp" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/d" "/var/lib/arfvpn/data-user-l2tp"
sed -i '/^"'"$user"'" l2tpd/d' /etc/ppp/chap-secrets
sed -i '/^'"$user"':\$1\$/d' /etc/ipsec.d/passwd
chmod 600 /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*
fi
done
data=( `cat /var/lib/arfvpn/data-user-pptp | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/var/lib/arfvpn/data-user-pptp" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/d" "/var/lib/arfvpn/data-user-pptp"
sed -i '/^"'"$user"'" pptpd/d' /etc/ppp/chap-secrets
chmod 600 /etc/ppp/chap-secrets*
fi
done
data=( `cat /var/lib/arfvpn/data-user-sstp | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/var/lib/arfvpn/data-user-sstp" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/d" "/var/lib/arfvpn/data-user-sstp"
sed -i '/^'"$user"'/d' /home/sstp/sstp_account
fi
done
data=( `cat /etc/wireguard/wg0.conf | grep '^### Client' | cut -d ' ' -f 3`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### Client $user" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 4)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### Client $user $exp/,/^AllowedIPs/d" /etc/wireguard/wg0.conf
rm -f "/home/vps/public_html/$user.conf"
fi
done
systemctl restart wg-quick@wg0