#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

source /etc/os-release
OS=$ID
ver=$VERSION_ID
arfvpn="/etc/arfvpn"
# set random pwd
#openssl rand -base64 16 > ${arfvpn}/passwd
</dev/urandom tr -dc a-z0-9 | head -c16 > ${arfvpn}/passwd
pwd=$(cat ${arfvpn}/passwd)
github="https://raw.githubusercontent.com/arfprsty810/vpn/main"

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING SHADOWSOCKS $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#Server konfigurasi
echo -e "[ ${green}INFO$NC ] MENGINSTALL SAHDOWSOCKS-LIBEV"
sleep 2

apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y

elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y

elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
fi
fi

sleep 1
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"${pwd}",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END

sleep 1
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"${pwd}",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo -e "">>"/etc/shadowsocks-libev/akun.conf"

sleep 1
wget -q -O /usr/bin/menu-ss "${github}/shadowsocks/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/addss "${github}/shadowsocks/addss.sh" && chmod +x /usr/bin/addss
wget -q -O /usr/bin/cekss "${github}/shadowsocks/cekss.sh" && chmod +x /usr/bin/cekss
wget -q -O /usr/bin/delss "${github}/shadowsocks/delss.sh" && chmod +x /usr/bin/delss
wget -q -O /usr/bin/renewss "${github}/shadowsocks/renewss.sh" && chmod +x /usr/bin/renewss
sed -i -e 's/\r$//' /usr/bin/menu-ss
sed -i -e 's/\r$//' /usr/bin/addss
sed -i -e 's/\r$//' /usr/bin/cekss
sed -i -e 's/\r$//' /usr/bin/delss
sed -i -e 's/\r$//' /usr/bin/renewss

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save >> /etc/iptables.up.rules
ip6tables-save >> /etc/ip6tables.up.rules
echo ""
echo -e "[ ${green}INFO$NC ] INSTALLING SHADOWSOCKS-LIBEV SUCCESSFULLY !!!"
sleep 5