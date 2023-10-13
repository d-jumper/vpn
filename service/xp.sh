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
github=$(cat ${arfvpn}/github)
xray="/etc/xray"
trgo="/etc/arfvpn/trojan-go"
rm ${arfvpn}/log-cron.log
touch ${arfvpn}/log-cron.log
echo -e "Start"  | tee -a ${arfvpn}/log-cron.log

#########################################################

#----- Auto Remove SSH
hariini=`date +%d-%m-%Y`
cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
totalaccounts=`cat /tmp/expirelist.txt | wc -l`
for((i=1; i<=$totalaccounts; i++ ))
do
tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
username=`echo $tuserval | cut -f1 -d:`
userexp=`echo $tuserval | cut -f2 -d:`
userexpireinseconds=$(( $userexp * 86400 ))
tglexp=`date -d @$userexpireinseconds`             
tgl=`echo $tglexp |awk -F" " '{print $3}'`
while [ ${#tgl} -lt 2 ]
do
tgl="0"$tgl
done
while [ ${#username} -lt 15 ]
do
username=$username" " 
done
bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
todaystime=`date +%s`
if [ $userexpireinseconds -ge $todaystime ] ;
then
:
else
echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >> /usr/local/bin/deleteduser
echo -e "${NC}${CYAN}Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini $NC"
userdel $username
fi
done
echo -e "${SUCCESS} Auto Delete User Expired SSH & OpenVPN Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log

#----- Auto Remove Vmess
data=( `cat ${xray}/config.json | grep '^#vm#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vm# ${user}" "${xray}/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "${exp}" +%s)
d2=$(date -d "${now}" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "${exp2}" -le "0" ]]; then
sed -i "/^#vm# ${user} ${exp}/,/^},{/d" ${xray}/config.json
rm -f ${xray}/${user}-tls.json ${xray}/${user}-none.json
fi
done
echo -e "${SUCCESS} Auto Delete User Expired Xray Vmess-WS Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log

#----- Auto Remove Vless
data=( `cat ${xray}/config.json | grep '^#vl#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#vl# ${user}" "${xray}/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "${exp}" +%s)
d2=$(date -d "${now}" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "${exp2}" -le "0" ]]; then
sed -i "/^#vl# ${user} ${exp}/,/^},{/d" ${xray}/config.json
fi
done
echo -e "${SUCCESS} Auto Delete User Expired Xray Vless-WS Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log

#----- Auto Remove Trojan
data=( `cat ${xray}/config.json | grep '^#tr#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#tr# ${user}" "${xray}/config.json" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "${exp}" +%s)
d2=$(date -d "${now}" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "${exp2}" -le "0" ]]; then
sed -i "/^#tr# ${user} ${exp}/,/^},{/d" ${xray}/config.json
fi
done
echo -e "${SUCCESS} Auto Delete User Expired Xray Trojan-WS Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log

#----- Auto Remove Trojan-GO
data=( `cat ${trgo}/akun.conf | grep '^#trgo#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#trgo# ${user}" "${trgo}/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "${exp}" +%s)
d2=$(date -d "${now}" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "${exp2}" -le "0" ]]; then
sed -i "/^#trgo# ${user} ${exp}/d" ${trgo}/akun.conf
sed -i '/^,"'"${user}"'"$/d' ${trgo}/config.json
fi
done
echo -e "${SUCCESS} Auto Delete User Expired Trojan-Go Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log

#----- Auto Remove Shadowsocks
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#ss# ${user}" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "${exp}" +%s)
d2=$(date -d "${now}" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "${exp2}" -le "0" ]]; then
sed -i "/^#ss# ${user} ${exp}/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
service cron restart
systemctl disable shadowsocks-libev-server@${user}-http.service
systemctl stop shadowsocks-libev-server@${user}-http.service
rm -f "/etc/shadowsocks-libev/${user}-tls.json"
rm -f "/etc/shadowsocks-libev/${user}-http.json"
fi
done
echo -e "${SUCCESS} Auto Delete User Expired Shadowsocks Successfully ! ${CEKLIST}"  | tee -a /etc/arfvpn/log-cron.log
