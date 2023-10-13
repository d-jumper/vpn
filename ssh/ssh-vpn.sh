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
export DEBIAN_FRONTEND=noninteractive
ver=$VERSION_ID
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
arfvpn="/etc/arfvpn"
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)
MYIP2="s/xxxxxxxxx/$MYIP/g";
MYHOST="s/xxhostnamexx/$DOMAIN/g";
clear

#########################################################
set_pass () {
cd
# simple password minimal
wget -O /etc/pam.d/common-password "https://${github}/ssh/archive/password"
chmod +x /etc/pam.d/common-password
}
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "          INSTALLING SSH"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Set Password"
arfvpn_bar 'set_pass'
echo -e ""
sleep 2

#########################################################
set_rclocal () {
# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
}
echo -e " ${LIGHT}- ${NC}Set Rc.Local"
arfvpn_bar 'set_rclocal'
echo -e ""
sleep 2

#########################################################
# install badvpn
set_badvpn () {
cd
#wget -O /usr/bin/badvpn-udpgw "https://${github}/ssh/archive/badvpn-udpgw64"
wget -O /usr/bin/badvpn-udpgw "https://${github}/ssh/archive/newudpgw"
chmod +x /usr/bin/badvpn-udpgw
tesmatch=`screen -list | awk  '{print $1}' | grep -ow "badvpn" | sort | uniq`
if [ "$tesmatch" = "badvpn" ]; then
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Screen badvpn detected"
rm /root/screenlog > /dev/null 2>&1
    runningscreen=( `screen -list | awk  '{print $1}' | grep -w "badvpn"` ) # sed 's/\.[^ ]*/ /g'
    for actv in "${runningscreen[@]}"
    do
        cek=( `screen -list | awk  '{print $1}' | grep -w "badvpn"` )
        if [ "$cek" = "$actv" ]; then
        for sama in "${cek[@]}"; do
            sleep 1
            screen -XS $sama quit > /dev/null 2>&1
            echo -e "[ ${red}CLOSE$NC ] Closing screen $sama"
        done 
        fi
    done
else
echo -ne
fi
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
}
echo -e " ${LIGHT}- ${NC}Installing BadVpn UDPGW"
arfvpn_bar 'set_badvpn'
echo -e ""
sleep 2

#########################################################
# setting port ssh
set_port () {
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart
}
echo -e " ${LIGHT}- ${NC}Set Port SSH & Dropbear"
arfvpn_bar 'set_port'
echo -e ""
sleep 2

#########################################################
# install squid
set_squid () {
cd
apt -y install squid3
wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf
sed -i $MYHOST /etc/squid/squid.conf
}
echo -e " ${LIGHT}- ${NC}Installing Squid Proxy"
arfvpn_bar 'set_squid'
echo -e ""
sleep 2

#########################################################
# Install SSLH
set_sslh () {
apt -y install sslh
rm -f /etc/default/sslh

# Settings SSLH
cat > /etc/default/sslh <<-END
RUN=yes

DAEMON=/usr/sbin/sslh
DAEMON_OPTS="--user sslh --listen 127.0.0.1:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh.pid -n"
END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart
}
echo -e " ${LIGHT}- ${NC}Installing SSLH"
arfvpn_bar 'set_sslh'
echo -e ""
sleep 2

#########################################################
# setting vnstat
set_vnstat () {
#apt -y install vnstat
/etc/init.d/vnstat restart
#apt -y install libsqlite3-dev
wget https://${github}/ssh/archive/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
}
echo -e " ${LIGHT}- ${NC}Set Vnstat"
arfvpn_bar 'set_vnstat'
echo -e ""
sleep 2

#########################################################
# install stunnel 5 
set_stunnel5 () {
cd /root/
wget -q -O stunnel5.zip "https://${github}/ssh/stunnel5/stunnel5.zip"
unzip -o stunnel5.zip
cd /root/stunnel
chmod +x configure
./configure
make
make install
cd /root
rm -r -f stunnel
rm -f stunnel5.zip
mkdir -p /etc/stunnel5
chmod 644 /etc/stunnel5

# Download Config Stunnel5
cat > /etc/stunnel5/stunnel5.conf <<-END
cert = /etc/arfvpn/cert/ca.crt
key = /etc/arfvpn/cert/ca.key
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 445
connect = 127.0.0.1:109

[openssh]
accept = 777
connect = 127.0.0.1:443

[openvpn]
accept = 990
connect = 127.0.0.1:1194
END

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel5/stunnel5.conf
Type=forking

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget -q -O /etc/init.d/stunnel5 "https://${github}/ssh/stunnel5/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel5/stunnel5.pem
chmod +x /etc/init.d/stunnel5
cp /usr/local/bin/stunnel /usr/local/bin/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4
#rm -f /usr/local/bin/stunnel5

# Restart Stunnel 5
systemctl stop stunnel5
systemctl enable stunnel5
systemctl start stunnel5
systemctl restart stunnel5
/etc/init.d/stunnel5 restart
/etc/init.d/stunnel5 status
/etc/init.d/stunnel5 restart
}
echo -e " ${LIGHT}- ${NC}Installing Stunnel 5"
arfvpn_bar 'set_stunnel5'
echo -e ""
sleep 2

#########################################################
# Instal DDOS Flate
set_ddos () {
rm -rvf /usr/local/ddos
rm -rvf usr/local/sbin/ddos
mkdir -p /usr/local/ddos/
wget -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
wget -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
wget -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
wget -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
#cd /usr/local/ddos/
#wget http://${github}/ddos/ddos.zip
#unzip -o ddos.zip
#rm -rvf /usr/local/ddos/ddos.zip
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
# Creating cron to run script every minute.....(Default setting)
if ! grep -q '/usr/local/ddos/ddos.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "*/1 * * * * /usr/local/ddos/ddos.sh") | crontab;fi
}
echo -e " ${LIGHT}- ${NC}Installing Ddos"
arfvpn_bar 'set_ddos'
echo -e ""
sleep 2

#########################################################
# banner /etc/issue.net
set_banner () {
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
# Ganti Banner
wget -O /etc/issue.net "https://${github}/ssh/archive/issue.net"
}
echo -e " ${LIGHT}- ${NC}Set Banner"
arfvpn_bar 'set_banner'
echo -e ""
sleep 2

#########################################################
# blockir torrent
set_torrent () {
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save >> /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
}
echo -e " ${LIGHT}- ${NC}Set Block Torrent"
arfvpn_bar 'set_torrent'
echo -e ""
sleep 2

#########################################################
# download script
set_script () {
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

#wget -O /usr/bin/badvpn-udpgw64 "https://${github}/ssh/archive/newudpgw"
#wget -O /usr/bin/bbr "https://${github}/ssh/archive/bbr.sh"
wget -O /usr/bin/clearlog "https://${github}/ssh/archive/clearlog.sh"
#wget -O /etc/issue.net "https://${github}/ssh/archive/issue.net"
#wget -O /etc/pam.d/common-password "https://${github}/ssh/archive/password"
wget -O /usr/bin/ram "https://${github}/ssh/archive/ram.sh"
wget -O /etc/set.sh "https://${github}/ssh/archive/set.sh"
#wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
wget -O /usr/bin/swapkvm "https://${github}/ssh/archive/swapkvm.sh"
#chmod +x /usr/bin/badvpn-udpgw64
#chmod +x bbr.sh && ./bbr.sh
chmod +x /usr/bin/clearlog
#chmod +x /etc/issue.net
#chmod +x /etc/pam.d/common-password
chmod +x /usr/bin/ram
chmod +x /etc/set.sh
#chmod +x /etc/squid/squid.conf
chmod +x /usr/bin/swapkvm
#sed -i -e 's/\r$//' bbr.sh && ./bbr.sh
sed -i -e 's/\r$//' /usr/bin/clearlog
#sed -i -e 's/\r$//' /usr/bin/issue.net
#sed -i -e 's/\r$//' /etc/pam.d/common-password
sed -i -e 's/\r$//' /usr/bin/ram
sed -i -e 's/\r$//' /etc/set.sh
#sed -i -e 's/\r$//' /etc/squid/squid.conf
sed -i -e 's/\r$//' /usr/bin/swapkvm

#wget -O stunnel5.zip "https://${github}/ssh/stunnel5/stunnel5.zip"
#wget -O /etc/init.d/stunnel5 "https://${github}/ssh/archive/stunnel5.init"
#chmod +x /etc/init.d/stunnel5

wget -O /usr/bin/wsedu "https://${github}/ssh/websocket/edu.sh"
wget -O /usr/bin/portsshws "https://${github}/ssh/websocket/portsshws.sh"
wget -O /usr/bin/portsshnontls "https://${github}/ssh/websocket/portsshnontls.sh"
chmod +x /usr/bin/wsedu
chmod +x /usr/bin/portsshws
chmod +x /usr/bin/portsshnontls
sed -i -e 's/\r$//' /usr/bin/wsedu
sed -i -e 's/\r$//' /usr/bin/portsshws
sed -i -e 's/\r$//' /usr/bin/portsshnontls
}
echo -e " ${LIGHT}- ${NC}Installing Script SSH"
arfvpn_bar 'set_script'
echo -e ""
sleep 2

#########################################################
# finishing
set_finishing () {
cd
chown -R www-data:www-data /home/arfvps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/sslh restart
/etc/init.d/stunnel5 restart
/etc/init.d/vnstat restart
/etc/init.d/fail2ban restart
/etc/init.d/squid restart
}
echo -e " ${LIGHT}- ${NC}Finishing Installing SSH"
arfvpn_bar 'set_finishing'
echo -e ""
sleep 2

echo -e ""
echo -e " ${OK} Installing SSH & OVPN Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2

#########################################################
# Install BBR
set_bbr () {
cd
wget https://${github}/ssh/archive/bbr.sh
chmod +x bbr.sh
}
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "          INSTALLING BBR"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Set Bbr"
arfvpn_bar 'set_bbr'
echo -e ""
sleep 2
clear
./bbr.sh
clear

#########################################################