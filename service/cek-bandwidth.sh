#!/bin/bash
#########################################################
# Export Color
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGREEN='\033[1;92m'      # GREEN
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICYAN='\033[1;96m'       # CYAN
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGREEN='\033[0;92m'       # GREEN
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICYAN='\033[0;96m'        # CYAN
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
GREEN_mix() { echo -e "\\033[32;1m${*}\\033[0m"; }
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
   echo -e "${TYBLUE}]${NC}"
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
clear
echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e "           ${STABILO}BANDWITH MONITOR ${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e "${GREEN}"
echo -e "    ${CYAN}[${LIGHT}01${CYAN}]${RED} •${NC} ${CYAN}Lihat Total Bandwith Tersisa${NC}"
echo -e "    ${CYAN}[${LIGHT}02${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Setiap 5 Menit${NC}"
echo -e "    ${CYAN}[${LIGHT}03${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Setiap Jam${NC}"
echo -e "    ${CYAN}[${LIGHT}04${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Setiap Hari${NC}"
echo -e "    ${CYAN}[${LIGHT}05${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Setiap Bulan${NC}"
echo -e "    ${CYAN}[${LIGHT}06${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Setiap Tahun${NC}"
echo -e "    ${CYAN}[${LIGHT}07${CYAN}]${RED} •${NC} ${CYAN}Tabel Penggunaan Tertinggi${NC}"
echo -e "    ${CYAN}[${LIGHT}08${CYAN}]${RED} •${NC} ${CYAN}Statistik Penggunaan Setiap Jam${NC}"
echo -e "    ${CYAN}[${LIGHT}09${CYAN}]${RED} •${NC} ${CYAN}Lihat Penggunaan Aktif Saat Ini${NC}"
echo -e "    ${CYAN}[${LIGHT}10${CYAN}]${RED} •${NC} ${CYAN}Lihat Trafik Penggunaan Aktif Saat Ini [5s]${NC}"
echo -e "    ${CYAN}[${LIGHT}xx${CYAN}]${RED} •${NC} ${CYAN}Menu${NC}"
echo -e "${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e "${GREEN}"
read -p "     [#]  Masukkan Nomor :  " noo
echo -e "${NC}"

case $noo in
1)
echo -e "${CYAN}======================================${NC}"
echo -e "    ${STABILO}TOTAL BANDWITH SERVER TERSISA${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

2)
echo -e "${CYAN}======================================${NC}"
echo -e "  ${STABILO}PENGGUNAAN BANDWITH SETIAP 5 MENIT${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -5

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

3)
echo -e "${CYAN}======================================${NC}"
echo -e "    ${STABILO}PENGGUNAAN BANDWITH SETIAP JAM${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -h

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

4)
echo -e "${CYAN}======================================${NC}"
echo -e "   ${STABILO}PENGGUNAAN BANDWITH SETIAP HARI${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -d

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

5)
echo -e "${CYAN}======================================${NC}"
echo -e "   ${STABILO}PENGGUNAAN BANDWITH SETIAP BULAN${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -m

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

6)
echo -e "${CYAN}======================================${NC}"
echo -e "   ${STABILO}PENGGUNAAN BANDWITH SETIAP TAHUN${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -y

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

7)
echo -e "${CYAN}======================================${NC}"
echo -e "    ${STABILO}PENGGUNAAN BANDWITH TERTINGGI${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -t

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

8)
echo -e "${CYAN}======================================${NC}"
echo -e " ${STABILO}GRAFIK BANDWITH TERPAKAI SETIAP JAM${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -hg

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

9)
echo -e "${CYAN}======================================${NC}"
echo -e "  ${STABILO}LIVE PENGGUNAAN BANDWITH SAAT INI${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e " ${RED}CTRL+C Untuk Berhenti!${NC}"
echo -e ""

vnstat -l

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

10)
echo -e "${CYAN}======================================${NC}"
echo -e "   ${STABILO}LIVE TRAFIK PENGGUNAAN BANDWITH${NC}"
echo -e "${CYAN}======================================${NC}"
echo -e ""

vnstat -tr

echo -e ""
echo -e "${CYAN}======================================${NC}"
echo -e ""
;;

x)
sleep 1
menu
;;

*)
sleep 1
echo -e "${RED}Nomor Yang Anda Masukkan Salah!${NC}"
;;
esac
echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
menu