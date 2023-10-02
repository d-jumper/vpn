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

arfvpn="/etc/arfvpn"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat ${arfvpn}/domain)
sleep 1

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING TROJAN-GO $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
# Install Trojan Go
echo -e "[ ${green}INFO$NC ] INSTALLING TROJAN-GO"
sleep 1
latest_version="$(curl -s "https://api.github.com/repos/p4gefau1t/trojan-go/releases" | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
trojango_link="https://github.com/p4gefau1t/trojan-go/releases/download/v${latest_version}/trojan-go-linux-amd64.zip"
mkdir -p "/usr/bin/trojan-go"
#mkdir -p "${trgo}"
cd `mktemp -d`
curl -sL "${trojango_link}" -o trojan-go.zip
unzip -q trojan-go.zip && rm -rf trojan-go.zip
mv trojan-go /usr/local/bin/trojan-go
chmod +x /usr/local/bin/trojan-go
mkdir -p ${logtrgo}
touch ${trgo}/akun.conf
touch ${logtrgo}/trojan-go.log

# Buat Config Trojan Go
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG TROJAN-GO"
sleep 1
cat > ${trgo}/config.json << END
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 2087,
  "remote_addr": "127.0.0.1",
  "remote_port": 89,
  "log_level": 1,
  "log_file": "${logtrgo}/trojan-go.log",
  "password": [
      "${uuid}"
  ],
  "disable_http_check": true,
  "udp_timeout": 60,
  "ssl": {
    "verify": false,
    "verify_hostname": false,
    "cert": "/etc/arfvpn/cert/ca.crt",
    "key": "/etc/arfvpn/cert/ca.key",
    "key_password": "",
    "cipher": "",
    "curves": "",
    "prefer_server_cipher": false,
    "sni": "${domain}",
    "alpn": [
      "http/1.1"
    ],
    "session_ticket": true,
    "reuse_session": true,
    "plain_http_response": "",
    "fallback_addr": "127.0.0.1",
    "fallback_port": 0,
    "fingerprint": "firefox"
  },
  "tcp": {
    "no_delay": true,
    "keep_alive": true,
    "prefer_ipv4": true
  },
  "mux": {
    "enabled": false,
    "concurrency": 8,
    "idle_timeout": 60
  },
  "websocket": {
    "enabled": true,
    "path": "/trojan-go",
    "host": "${domain}"
  },
    "api": {
    "enabled": false,
    "api_addr": "",
    "api_port": 0,
    "ssl": {
      "enabled": false,
      "key": "",
      "cert": "",
      "verify_client": false,
      "client_cert": []
    }
  }
}
END

# Installing Trojan Go Service
cat > /etc/systemd/system/trojan-go.service << END
[Unit]
Description=Trojan-Go Service
Documentation=https://t.me/arfprsty
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/trojan-go -config ${trgo}/config.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# Trojan Go Uuid
cat > ${trgo}/uuid << END
${uuid}
END

echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
wget -q -O /usr/bin/add-trgo "https://${github}/trojan-go/add-trgo.sh" && chmod +x /usr/bin/add-trgo
wget -q -O /usr/bin/cek-trgo "https://${github}/trojan-go/cek-trgo.sh" && chmod +x /usr/bin/cek-trgo
wget -q -O /usr/bin/del-trgo "https://${github}/trojan-go/del-trgo.sh" && chmod +x /usr/bin/del-trgo
wget -q -O /usr/bin/renew-trgo "https://${github}/trojan-go/renew-trgo.sh" && chmod +x /usr/bin/renew-trgo

sed -i -e 's/\r$//' /bin/add-trgo
sed -i -e 's/\r$//' /bin/cek-trgo
sed -i -e 's/\r$//' /bin/del-trgo
sed -i -e 's/\r$//' /bin/renew-trgo

echo -e "[ ${green}INFO$NC ] SETTING TROJAN-GO SUKSES !!!"
sleep 1