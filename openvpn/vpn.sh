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
arfvpn="/etc/arfvpn"
MYISP=$(curl -s ipinfo.io/org/);
MYIP=$(curl -s https://ipinfo.io/ip/);
DOMAIN=$(cat $arfvpn/domain);
github="raw.githubusercontent.com/arfprsty810/vpn/main"
MYIP2="s/xxxxxxxxx/$MYIP/g";
source /etc/os-release
export DEBIAN_FRONTEND=noninteractive
ver=$VERSION_ID
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');

vpn_dir () {
cd
mkdir -p /etc/openvpn/server/easy-rsa/
mkdir -p /etc/openvpn/client/
#mkdir -p /etc/arfvpn/cert/
#mkdir -p /etc/arfvpn/cert/client/
#mkdir -p /etc/arfvpn/cert/server/
cd /etc/openvpn/
wget "https://${github}/openvpn/vpn.zip"
unzip vpn.zip
rm -f vpn.zip
chown -R root:root /etc/openvpn/server/easy-rsa/

cd
mkdir -p /usr/lib/openvpn/
cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so

cd /etc/openvpn/server/easy-rsa/
chmod +x ./vars
chmod +x ./easyrsa

#./easyrsa init-pki
#./easyrsa build-ca nopass
#./easyrsa gen-req server nopass
#./easyrsa sign-req server server
#./easyrsa gen-req client01 nopass
#./easyrsa sign-req client client01
#./easyrsa gen-dh
#./easyrsa gen-crl

#cp /etc/openvpn/server/easy-rsa/pki/ca.crt /etc/openvpn/server/ca.crt
#cp /etc/openvpn/server/easy-rsa/pki/dh.pem /etc/openvpn/server/dh.pem
#cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/server/crl.pem
#cp /etc/openvpn/server/easy-rsa/pki/issued/server.crt /etc/openvpn/server/server.crt
#cp /etc/openvpn/server/easy-rsa/pki/private/server.key /etc/openvpn/server/server.key

#cp /etc/openvpn/server/easy-rsa/pki/ca.crt /etc/openvpn/client/ca.crt
#cp /etc/openvpn/server/easy-rsa/pki/dh.pem /etc/openvpn/client/dh.pem
#cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/openvpn/client/crl.pem
#cp /etc/openvpn/server/easy-rsa/pki/issued/client01.crt /etc/openvpn/client/client01.crt
#cp /etc/openvpn/server/easy-rsa/pki/private/client01.key /etc/openvpn/client/client01.key

#cp /etc/openvpn/server/easy-rsa/pki/ca.crt /etc/arfvpn/cert/ca.crt
#cp /etc/openvpn/server/easy-rsa/pki/private/ca.key /etc/arfvpn/cert/ca.key
#cp /etc/openvpn/server/easy-rsa/pki/dh.pem /etc/arfvpn/cert/dhparam.pem
#cp /etc/openvpn/server/easy-rsa/pki/crl.pem /etc/arfvpn/cert/crl.pem
#cp /etc/openvpn/server/easy-rsa/pki/issued/server.crt /etc/arfvpn/cert/server/server.crt
#cp /etc/openvpn/server/easy-rsa/pki/private/server.key /etc/arfvpn/cert/server/server.key
#cp /etc/openvpn/server/easy-rsa/pki/issued/client01.crt /etc/arfvpn/cert/client/client01.crt
#cp /etc/openvpn/server/easy-rsa/pki/private/client01.key /etc/arfvpn/cert/client/client01.key
#cd

# nano /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
# restart openvpn dan cek status openvpn

# aktifkan ip4 forwarding
echo 1 >> /proc/sys/net/ipv4/ip_forward
#sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
sysctl -p
}

config_ovpn () {
# Buat config client TCP 1194
rm -rvf /etc/openvpn/client/tcp.ovpn
cat > /etc/openvpn/client/tcp.ovpn <<-END
client
dev tun
proto tcp
remote $MYIP 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
#sed -i $MYIP2 /etc/openvpn/client/tcp.ovpn;

# Buat config client UDP 2200
rm -rvf /etc/openvpn/client/udp.ovpn
cat > /etc/openvpn/client/udp.ovpn <<-END
client
dev tun
proto udp
remote $MYIP 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
#sed -i $MYIP2 /etc/openvpn/client/udp.ovpn;

# Buat config client SSL
cat > /etc/openvpn/client/ssl.ovpn <<-END
client
dev tun
proto tcp
remote $MYIP 990
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
#sed -i $MYIP2 /etc/openvpn/client/ssl.ovpn;

cd 
/etc/init.d/openvpn restart
systemctl enable --now openvpn-server@server-tcp
systemctl enable --now openvpn-server@server-udp
}

config_copy () {
# masukkan certificatenya ke dalam config client TCP 1194
echo '<ca>' >> /etc/openvpn/client/tcp.ovpn
cat /etc/openvpn/client/ca.crt >> /etc/openvpn/client/tcp.ovpn
echo '</ca>' >> /etc/openvpn/client/tcp.ovpn
# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 1194 )
cp /etc/openvpn/client/tcp.ovpn /home/arfvps/public_html/tcp.ovpn

# masukkan certificatenya ke dalam config client UDP 2200
echo '<ca>' >> /etc/openvpn/client/udp.ovpn
cat /etc/openvpn/client/ca.crt >> /etc/openvpn/client/udp.ovpn
echo '</ca>' >> /etc/openvpn/client/udp.ovpn
# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/client/udp.ovpn /home/arfvps/public_html/udp.ovpn

# masukkan certificatenya ke dalam config client UDP 990
echo '<ca>' >> /etc/openvpn/client/ssl.ovpn
cat /etc/openvpn/client/ca.crt >> /etc/openvpn/client/ssl.ovpn
echo '</ca>' >> /etc/openvpn/client/ssl.ovpn
# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/client/ssl.ovpn /home/arfvps/public_html/ssl.ovpn

#IPTABLES untuk memperbolehkan akses UDP dan akses jalur TCP
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $NET -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $NET -j MASQUERADE
iptables-save >> /etc/iptables.up.rules
chmod +x /etc/iptables.up.rules

iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
}

#########################################################
echo -e " ${INFO} Installing OpenVPN ..."
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Create OpenVPN Directory"
arfvpn_bar 'vpn_dir'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Create Config OpenVPN"
arfvpn_bar 'config_ovpn'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Create Config OpenVPN"
arfvpn_bar 'config_copy'
echo -e ""
sleep 2

echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2