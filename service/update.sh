#!/bin/bash
#########################################################
# Export Colour
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
TYBLUE='\e[1;36m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\033[0m'

# Export Banner Status Information
EROR="[${RED} EROR ${NC}]"
INFO="[${YELLOW} INFO ${NC}]"
OK="[${LIGHT} OK ! ${NC}]"
CEKLIST="[${LIGHT}✔${NC}]"
PENDING="[${YELLOW} PENDING ${NC}]"
SEND="[${YELLOW} SEND ${NC}]"
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
echo -ne " Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${TYBLUE}>${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "       Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
github="raw.githubusercontent.com/arfprsty810/vpn/main"
clear

#########################################################
remove_script () {
rm -rvf /etc/arfvpn/Version
rm -rvf /usr/bin/cek-bandwidth
rm -rvf /usr/bin/cert
rm -rvf /usr/bin/cf
rm -rvf /usr/bin/cfnhost
rm -rvf /usr/bin/hostvps
rm -rvf /usr/bin/menu
rm -rvf /usr/bin/menu-backup
rm -rvf /usr/bin/menu-setting
rm -rvf /usr/bin/fixssh
rm -rvf /usr/bin/renew-domain
rm -rvf /usr/bin/restart
rm -rvf /usr/bin/running
rm -rvf /usr/bin/update
rm -rvf /usr/bin/update-xray
rm -rvf /usr/bin/wbmn
rm -rvf /usr/bin/xp

rm -rvf /usr/bin/changeport
rm -rvf /usr/bin/portovpn
rm -rvf /usr/bin/portsquid
rm -rvf /usr/bin/portsstp
rm -rvf /usr/bin/porttrojan
rm -rvf /usr/bin/portvlm
rm -rvf /usr/bin/portwg
rm -rvf /usr/bin/addssh
rm -rvf /usr/bin/autokill
rm -rvf /usr/bin/ceklim
rm -rvf /usr/bin/cekssh
rm -rvf /usr/bin/delssh
rm -rvf /usr/bin/member
rm -rvf /usr/bin/menu-ssh
rm -rvf /usr/bin/renewssh
rm -rvf /usr/bin/tendang
rm -rvf /usr/bin/trialssh
rm -rvf /usr/bin/expssh
rm -rvf /usr/bin/about
#rm -rvf bbr.sh && ./bbr.sh
rm -rvf /usr/bin/clearlog
rm -rvf /etc/issue.net
#rm -rvf /etc/pam.d/common-password
rm -rvf /usr/bin/ram
rm -rvf /etc/set.sh
#rm -rvf /etc/squid/squid.conf
rm -rvf /usr/bin/swapkvm
#rm -rvf /usr/bin/wsedu

rm -rvf /usr/bin/portsshws
rm -rvf /usr/bin/portsshnontls

rm -rvf /usr/bin/menu-vmess
rm -rvf /usr/bin/add-vm
rm -rvf /usr/bin/cek-vm
rm -rvf /usr/bin/del-vm
rm -rvf /usr/bin/renew-vm

rm -rvf /usr/bin/menu-vless
rm -rvf /usr/bin/add-vless
rm -rvf /usr/bin/cek-vless
rm -rvf /usr/bin/del-vless
rm -rvf /usr/bin/renew-vless

rm -rvf /usr/bin/menu-trojan
rm -rvf /usr/bin/add-tr
rm -rvf /usr/bin/cek-tr
rm -rvf /usr/bin/del-tr
rm -rvf /usr/bin/renew-tr

rm -rvf /bin/add-trgo
rm -rvf /bin/cek-trgo
rm -rvf /bin/del-trgo
rm -rvf /bin/renew-trgo

rm -rvf /usr/bin/menu-ss
rm -rvf /usr/bin/addss
rm -rvf /usr/bin/cekss
rm -rvf /usr/bin/delss
rm -rvf /usr/bin/renewss
}

#########################################################
update_script () {
wget -O /etc/arfvpn/Version "https://${github}/service/Version"
wget -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -O /usr/bin/cert "https://${github}/cert/cert.sh" && chmod +x /usr/bin/cert
wget -O /usr/bin/cf "https://${github}/service/cf.sh" && chmod +x /usr/bin/cf
wget -O /usr/bin/cfnhost "https://${github}/service/cfnhost.sh" && chmod +x /usr/bin/cfnhost
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh" && chmod +x /usr/bin/hostvps
wget -O /usr/bin/menu "https://${github}/service/menu.sh" && chmod +x /usr/bin/menu
wget -O /usr/bin/menu-backup "https://${github}/service/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -O /usr/bin/menu-setting "https://${github}/service/menu-setting.sh" && chmod +x /usr/bin/menu-setting
wget -O /usr/bin/fixssh "https://${github}/service/rc.local.sh" && chmod +x /usr/bin/fixssh
wget -O /usr/bin/renew-domain "https://${github}/service/renew-domain.sh" && chmod +x /usr/bin/renew-domain
wget -O /usr/bin/restart "https://${github}/service/restart.sh" && chmod +x /usr/bin/restart
wget -O /usr/bin/running "https://${github}/service/running.sh" && chmod +x /usr/bin/running
wget -O /usr/bin/speedtest "https://${github}/service/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/update "https://${github}/service/update.sh" && chmod +x /usr/bin/update
wget -O /usr/bin/update-xray "https://${github}/service/update-xray.sh" && chmod +x /usr/bin/update-xray
wget -O /usr/bin/wbmn "https://${github}/service/webmin.sh" && chmod +x /usr/bin/wbmn
wget -O /usr/bin/xp "https://${github}/service/xp.sh" && chmod +x /usr/bin/xp
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
sed -i -e 's/\r$//' /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cf
sed -i -e 's/\r$//' /usr/bin/cfnhost
sed -i -e 's/\r$//' /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/menu
sed -i -e 's/\r$//' /usr/bin/menu-backup
sed -i -e 's/\r$//' /usr/bin/menu-setting
sed -i -e 's/\r$//' /usr/bin/fixssh
sed -i -e 's/\r$//' /usr/bin/renew-domain
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/update
sed -i -e 's/\r$//' /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/wbmn
sed -i -e 's/\r$//' /usr/bin/xp

wget -O /usr/bin/changeport "https://${github}/service/port/changeport.sh"
wget -O /usr/bin/portovpn "https://${github}/service/port/portovpn.sh"
wget -O /usr/bin/portsquid "https://${github}/service/port/portsquid.sh"
wget -O /usr/bin/portsstp "https://${github}/service/port/portsstp.sh"
wget -O /usr/bin/porttrojan "https://${github}/service/port/porttrojan.sh"
wget -O /usr/bin/portvlm "https://${github}/service/port/portvlm.sh"
wget -O /usr/bin/portwg "https://${github}/service/port/portwg.sh"
chmod +x /usr/bin/changeport
chmod +x /usr/bin/portovpn
chmod +x /usr/bin/portsquid
chmod +x /usr/bin/portsstp
chmod +x /usr/bin/porttrojan
chmod +x /usr/bin/portvlm
chmod +x /usr/bin/portwg
sed -i -e 's/\r$//' /usr/bin/changeport
sed -i -e 's/\r$//' /usr/bin/portovpn
sed -i -e 's/\r$//' /usr/bin/portsquid
sed -i -e 's/\r$//' /usr/bin/portsstp
sed -i -e 's/\r$//' /usr/bin/porttrojan
sed -i -e 's/\r$//' /usr/bin/portvlm
sed -i -e 's/\r$//' /usr/bin/portwg

wget -O /usr/bin/addssh "https://${github}/ssh/addssh.sh"
wget -O /usr/bin/autokill "https://${github}/ssh/autokill.sh"
wget -O /usr/bin/ceklim "https://${github}/ssh/ceklim.sh"
wget -O /usr/bin/cekssh "https://${github}/ssh/cekssh.sh"
wget -O /usr/bin/delssh "https://${github}/ssh/delssh.sh"
wget -O /usr/bin/member "https://${github}/ssh/member.sh"
wget -O /usr/bin/menu-ssh "https://${github}/ssh/menu-ssh.sh"
wget -O /usr/bin/renewssh "https://${github}/ssh/renewssh.sh"
wget -O /usr/bin/tendang "https://${github}/ssh/tendang.sh"
wget -O /usr/bin/trialssh "https://${github}/ssh/trialssh.sh"
wget -O /usr/bin/xpssh "https://${github}/ssh/xpssh.sh"
chmod +x /usr/bin/addssh
chmod +x /usr/bin/autokill
chmod +x /usr/bin/ceklim
chmod +x /usr/bin/cekssh
chmod +x /usr/bin/delssh
chmod +x /usr/bin/member
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/renewssh
chmod +x /usr/bin/tendang
chmod +x /usr/bin/trialssh
chmod +x /usr/bin/expssh
sed -i -e 's/\r$//' /usr/bin/addssh
sed -i -e 's/\r$//' /usr/bin/autokill
sed -i -e 's/\r$//' /usr/bin/ceklim
sed -i -e 's/\r$//' /usr/bin/cekssh
sed -i -e 's/\r$//' /usr/bin/delssh
sed -i -e 's/\r$//' /usr/bin/member
sed -i -e 's/\r$//' /usr/bin/menu-ssh
sed -i -e 's/\r$//' /usr/bin/renewssh
sed -i -e 's/\r$//' /usr/bin/tendang
sed -i -e 's/\r$//' /usr/bin/trialssh
sed -i -e 's/\r$//' /usr/bin/expssh

wget -O /usr/bin/about "https://${github}/ssh/archive/about.sh"
wget -O /usr/bin/badvpn-udpgw64 "https://${github}/ssh/archive/newudpgw"
#wget -O /usr/bin/bbr "https://${github}/ssh/archive/bbr.sh"
wget -O /usr/bin/clearlog "https://${github}/ssh/archive/clearlog.sh"
wget -O /etc/issue.net "https://${github}/ssh/archive/issue.net"
#wget -O /etc/pam.d/common-password "https://${github}/ssh/archive/password"
wget -O /usr/bin/ram "https://${github}/ssh/archive/ram.sh"
wget -O /etc/set.sh "https://${github}/ssh/archive/set.sh"
#wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
wget -O /usr/bin/swapkvm "https://${github}/ssh/archive/swapkvm.sh"
chmod +x /usr/bin/about
chmod +x /usr/bin/badvpn-udpgw64
#chmod +x bbr.sh && ./bbr.sh
chmod +x /usr/bin/clearlog
chmod +x /etc/issue.net
#chmod +x /etc/pam.d/common-password
chmod +x /usr/bin/ram
chmod +x /etc/set.sh
#chmod +x /etc/squid/squid.conf
chmod +x /usr/bin/swapkvm
sed -i -e 's/\r$//' /usr/bin/about
#sed -i -e 's/\r$//' bbr.sh && ./bbr.sh
sed -i -e 's/\r$//' /usr/bin/clearlog
sed -i -e 's/\r$//' /usr/bin/issue.net
#sed -i -e 's/\r$//' /etc/pam.d/common-password
sed -i -e 's/\r$//' /usr/bin/ram
sed -i -e 's/\r$//' /etc/set.sh
#sed -i -e 's/\r$//' /etc/squid/squid.conf
sed -i -e 's/\r$//' /usr/bin/swapkvm

#wget -O stunnel5.zip "https://${github}/ssh/stunnel5/stunnel5.zip"
#wget -O /etc/init.d/stunnel5 "https://${github}/ssh/archive/stunnel5.init"
#chmod +x /etc/init.d/stunnel5

#wget -O /usr/bin/wsedu "https://${github}/ssh/websocket/edu.sh"
wget -O /usr/bin/portsshws "https://${github}/ssh/websocket/portsshws.sh"
wget -O /usr/bin/portsshnontls "https://${github}/ssh/websocket/portsshnontls.sh"
#chmod +x /usr/bin/wsedu
chmod +x /usr/bin/portsshws
chmod +x /usr/bin/portsshnontls
#sed -i -e 's/\r$//' /usr/bin/wsedu
sed -i -e 's/\r$//' /usr/bin/portsshws
sed -i -e 's/\r$//' /usr/bin/portsshnontls

wget -q -O /usr/bin/menu-vmess "https://${github}/xray/vmess/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/add-vm "https://${github}/xray/vmess/add-vm.sh" && chmod +x /usr/bin/add-vm
wget -q -O /usr/bin/cek-vm "https://${github}/xray/vmess/cek-vm.sh" && chmod +x /usr/bin/cek-vm
wget -q -O /usr/bin/del-vm "https://${github}/xray/vmess/del-vm.sh" && chmod +x /usr/bin/del-vm
wget -q -O /usr/bin/renew-vm "https://${github}/xray/vmess/renew-vm.sh" && chmod +x /usr/bin/renew-vm

#vless
wget -q -O /usr/bin/menu-vless "https://${github}/xray/vless/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/add-vless "https://${github}/xray/vless/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "https://${github}/xray/vless/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "https://${github}/xray/vless/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "https://${github}/xray/vless/renew-vless.sh" && chmod +x /usr/bin/renew-vless

#trojan
wget -q -O /usr/bin/menu-trojan "https://${github}/xray/trojan/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/add-tr "https://${github}/xray/trojan/add-tr.sh" && chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/cek-tr "https://${github}/xray/trojan/cek-tr.sh" && chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/del-tr "https://${github}/xray/trojan/del-tr.sh" && chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/renew-tr "https://${github}/xray/trojan/renew-tr.sh" && chmod +x /usr/bin/renew-tr

sed -i -e 's/\r$//' /usr/bin/menu-vmess
sed -i -e 's/\r$//' /usr/bin/add-vm
sed -i -e 's/\r$//' /usr/bin/cek-vm
sed -i -e 's/\r$//' /usr/bin/del-vm
sed -i -e 's/\r$//' /usr/bin/renew-vm

sed -i -e 's/\r$//' /usr/bin/menu-vless
sed -i -e 's/\r$//' /usr/bin/add-vless
sed -i -e 's/\r$//' /usr/bin/cek-vless
sed -i -e 's/\r$//' /usr/bin/del-vless
sed -i -e 's/\r$//' /usr/bin/renew-vless

sed -i -e 's/\r$//' /usr/bin/menu-trojan
sed -i -e 's/\r$//' /usr/bin/add-tr
sed -i -e 's/\r$//' /usr/bin/cek-tr
sed -i -e 's/\r$//' /usr/bin/del-tr
sed -i -e 's/\r$//' /usr/bin/renew-tr

wget -q -O /usr/bin/menu-ss "https://${github}/shadowsocks/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/addss "https://${github}/shadowsocks/addss.sh" && chmod +x /usr/bin/addss
wget -q -O /usr/bin/cekss "https://${github}/shadowsocks/cekss.sh" && chmod +x /usr/bin/cekss
wget -q -O /usr/bin/delss "https://${github}/shadowsocks/delss.sh" && chmod +x /usr/bin/delss
wget -q -O /usr/bin/renewss "https://${github}/shadowsocks/renewss.sh" && chmod +x /usr/bin/renewss
sed -i -e 's/\r$//' /usr/bin/menu-ss
sed -i -e 's/\r$//' /usr/bin/addss
sed -i -e 's/\r$//' /usr/bin/cekss
sed -i -e 's/\r$//' /usr/bin/delss
sed -i -e 's/\r$//' /usr/bin/renewss

wget -q -O /usr/bin/add-trgo "https://${github}/trojan-go/add-trgo.sh" && chmod +x /usr/bin/add-trgo
wget -q -O /usr/bin/cek-trgo "https://${github}/trojan-go/cek-trgo.sh" && chmod +x /usr/bin/cek-trgo
wget -q -O /usr/bin/del-trgo "https://${github}/trojan-go/del-trgo.sh" && chmod +x /usr/bin/del-trgo
wget -q -O /usr/bin/renew-trgo "https://${github}/trojan-go/renew-trgo.sh" && chmod +x /usr/bin/renew-trgo

sed -i -e 's/\r$//' /bin/add-trgo
sed -i -e 's/\r$//' /bin/cek-trgo
sed -i -e 's/\r$//' /bin/del-trgo
sed -i -e 's/\r$//' /bin/renew-trgo
}

#########################################################
echo -e " ${INFO} Update Script VPS ..."
echo -e ""
sleep 2

echo -e "Removing Old Script"
arfvpn_bar 'remove_script'
echo -e ""
sleep 2

echo -e "Update New Script"
arfvpn_bar 'update_script'
echo -e ""
sleep 2

echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2

#read -p "Press [Enter] to return to the menu or CTRL+C to exit"
read -p "Press [Enter] to Restart-Service or CTRL+C to exit"
restart
