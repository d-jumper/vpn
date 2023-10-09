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
ipvps="/var/lib/arfvpn"
SUB=$(</dev/urandom tr -dc a-z0-9 | head -c4)
DOMAIN=d-jumper.me
SUB_DOMAIN=${SUB}.arfvpn.${DOMAIN}
CF_ID=arief.prsty@gmail.com
CF_KEY=3a3ac5ccc9e764de9129fbbb177c161b9dfbd
set -euo pipefail
mkdir -p ${arfvpn}
mkdir -p ${ipvps}
echo "IP=" >> ${ipvps}/ipvps.conf
IP=$(cat ${arfvpn}/IP);
clear

#########################################################
domain_cf () {
#echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')

#WILD_DOMAIN="*.$SUB"
#set -euo pipefail
#echo ""
#echo "Updating DNS for ${WILD_DOMAIN}..."
#ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" | jq -r .result[0].id)

#RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILD_DOMAIN}" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" | jq -r .result[0].id)

#if [[ "${#RECORD}" -le 10 ]]; then
#     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" \
#     --data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
#fi

#RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" \
#     --data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
}
echo -e " ${INFO} Generate SUB-DOMAIN via Cloudflare ..."
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Generate Your sub-domain "
arfvpn_bar 'domain_cf'
echo -e ""
sleep 2
echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2
echo "Your SUB-DOMAIN has been created : ${SUB_DOMAIN}"
sleep 5
echo "${SUB_DOMAIN}" > ${arfvpn}/domain
echo "${SUB_DOMAIN}" > ${arfvpn}/scdomain
echo "IP=${SUB_DOMAIN}" > ${ipvps}/ipvps.conf
