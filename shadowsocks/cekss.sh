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
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
clear
# ==========================================
echo -e "${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "               ⇱ ${STABILO}✶ SS - OBFS User Login ✶${NC} ⇲ "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2`);
x=1
echo -e "${NC}${CYAN}──────────────────── $NC"
echo -e "${NC}${CYAN}     User | TLS $NC"
echo -e "${NC}${CYAN}──────────────────── $NC"
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_tls' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w ${port} | awk '{print $2}' | sort | uniq | nl)
if [[ -z "${jum}" ]]; then
echo > /dev/null
else
echo -e "  ${RED}•${NC} ${CYAN}${akun} - ${port} $NC"
echo -e "${NC} ${CYAN}${jum} $NC";
echo -e "${NC}${CYAN}──────────────────── $NC"
fi
x=$(( "$x" + 1 ))
done
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^#ss#' | cut -d ' ' -f 2`);
x=1
echo ""
echo -e "${NC}${CYAN}──────────────────── $NC"
echo -e "${NC}${CYAN}   User | Non-TLS $NC"
echo -e "${NC}${CYAN}──────────────────── $NC"
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_http' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w ${port} | awk '{print $2}' | sort | uniq | nl)
if [[ -z "${jum}" ]]; then
echo > /dev/null
else
echo -e "  ${RED}•${NC} ${CYAN}${akun} - ${port} $NC"
echo -e "${NC} ${CYAN}${jum} $NC";
echo -e "${NC}${CYAN}──────────────────── $NC"
fi
x=$(( "$x" + 1 ))
done
echo -e " "
echo -e "${BLUE}└─────────────────────────────────────────────────────┘${NC}"
echo -e " "
echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Shadowsocks Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
menu-ss
