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
arfvpn="/etc/arfvpn"
xray="/etc/xray"
logxray="/var/log/xray"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
OS=$ID
ver=$VERSION_ID
# set random uuid
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat ${arfvpn}/domain)
IP=$(cat ${arfvpn}/IP)

#apete
#wget https://${github}/service/apete.sh && chmod +x apete.sh && sed -i -e 's/\r$//' apete.sh && ./apete.sh
#
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate 0.id.pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
chronyc sourcestats -v
chronyc tracking -v
date
sleep 5
clear

echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green          INSTALLING XRAY $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 2
# install xray
echo -e "[ ${green}INFO$NC ] INSTALLING XRAY VMESS - VLESS"
sleep 1
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir

# Make Folder XRay
echo -e "[ ${green}INFO$NC ] MEMBUAT FOLDER XRAY"
mkdir -p /usr/bin/xray
mkdir -p ${xray}
mkdir -p ${logxray}
chown www-data.www-data ${logxray}
chmod +x ${logxray}
touch ${logxray}/access.log
touch ${logxray}/error.log
touch ${logxray}/access2.log
touch ${logxray}/error2.log

# Install Xray Core << Every >> Lastest Version
wget https://${github}/service/update-xray.sh && chmod +x update-xray.sh && ./update-xray.sh

## make a crt xray $domain
#systemctl stop nginx
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
mkdir -p ${arfvpn}/cert/
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue --force -d ${domain} --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d ${domain} --fullchainpath ${arfvpn}/cert/ca.crt --keypath ${arfvpn}/cert/ca.key --ecc
sleep 3
sudo openssl dhparam -out ${arfvpn}/cert/dh.pem 2048
echo -e "[ ${green}INFO$NC ] RENEW CERT SSL"
# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/bin/ssl_renew.sh
chmod +x /usr/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/bin/ssl_renew.sh") | crontab;fi

# NGINX-SERVER
wget https://${github}/nginx/nginx-server.sh && chmod +x nginx-server.sh && sed -i -e 's/\r$//' nginx-server.sh && ./nginx-server.sh

# Random Port Xray
trojanws=$((RANDOM + 10000))
vless=$((RANDOM + 10000))
vlessgrpc=$((RANDOM + 10000))
vmess=$((RANDOM + 10000))
worryfree=$((RANDOM + 10000))
kuotahabis=$((RANDOM + 10000))
vmessgrpc=$((RANDOM + 10000))
vmesschat=$((RANDOM + 10000))
trojangrpc=$((RANDOM + 10000))

# xray config
echo -e "[ ${green}INFO$NC ] MEMBUAT CONFIG XRAY"
sleep 1
cat > /etc/xray/config.json << END
{
  "log" : {
    "access": "${logxray}/access.log",
    "error": "${logxray}/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
    },
    {
      "listen": "127.0.0.1",
      "port": "${trojanws}",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",		
           "clients": [
              {
                 "password": "${uuid}"
#trojanws
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/trojan-ws"
            }
         }
     },
     {
        "listen": "127.0.0.1",
        "port": "${trojangrpc}",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
             "clients": [
               {
                 "password": "${uuid}"
#trojangrpc
               }
           ]
        },
         "streamSettings":{
         "network": "grpc",
           "grpcSettings": {
               "serviceName": "/trojan-grpc"
         }
      }
   },
   {
     "listen": "127.0.0.1",
     "port": "${vless}",
     "protocol": "vless",
      "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"
#vless
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vless"
          }
        }
     },
      {
        "listen": "127.0.0.1",
        "port": "${vlessgrpc}",
        "protocol": "vless",
        "settings": {
         "decryption":"none",
           "clients": [
             {
               "id": "${uuid}"
#vlessgrpc
             }
          ]
       },
          "streamSettings":{
             "network": "grpc",
             "grpcSettings": {
                "serviceName": "/vless-grpc"
           }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "${vmess}",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/vmess"
          }
        }
     },
     {
      "listen": "127.0.0.1",
      "port": "${vmessgrpc}",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessgrpc
             }
          ]
       },
       "streamSettings":{
         "network": "grpc",
            "grpcSettings": {
                "serviceName": "/vmess-grpc"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "${worryfree}",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmessworry
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/worryfree"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "${kuotahabis}",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmesskuota
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/kuota-habis"
          }
        }
     },
     {
     "listen": "127.0.0.1",
     "port": "${vmesschat}",
     "protocol": "vmess",
      "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmesschat
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
                "path": "/chat"
          }
        }
     }
#tambahconfig
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END


rm -rf /etc/systemd/system/xray.service.d
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE                                 AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF


cat > /etc/systemd/system/runn.service <<EOF
[Unit]
Description=xxxXxXrayXxXxxx
After=network.target

[Service]
Type=simple
ExecStartPre=-/usr/bin/mkdir -p /var/run/xray
ExecStart=/usr/bin/chown www-data:www-data /var/run/xray
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

sed -i '$ ilocation /' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ itry_files $uri $uri/ /index.html;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /vless' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${vless}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /vmess' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${vmess}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /worryfree' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${worryfree}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /kuota-habis' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${kuotahabis}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /chat' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${vmesschat}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation = /trojan-ws' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${trojanws}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"${vlessgrpc}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"${vmessgrpc}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:'"${trojangrpc}"';' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i}' /etc/nginx/sites-available/${domain}.conf

echo -e "[ ${green}INFO$NC ] DOWNLOAD SCRIPT ..."
sleep 1
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

#--
wget -q -O /usr/bin/xp "https://${github}/xray/xp.sh" && chmod +x /usr/bin/xp
sleep 1


echo -e "[ ${green}INFO$NC ] INSTALL SCRIPT ..."
sleep 1
sed -i -e 's/\r$//' /usr/bin/xp

sed -i -e 's/\r$//' /usr/bin/menu-vmess
sed -i -e 's/\r$//' /usr/bin/add-ws
sed -i -e 's/\r$//' /usr/bin/cek-ws
sed -i -e 's/\r$//' /usr/bin/del-vmess
sed -i -e 's/\r$//' /usr/bin/renew-ws

sed -i -e 's/\r$//' /usr/bin/menu-vless
sed -i -e 's/\r$//' /usr/bin/add-vless
sed -i -e 's/\r$//' /usr/bin/cek-vless
sed -i -e 's/\r$//' /usr/bin/del-vless
sed -i -e 's/\r$//' /usr/bin/renew-ws

sed -i -e 's/\r$//' /usr/bin/menu-trojan
sed -i -e 's/\r$//' /usr/bin/add-tr
sed -i -e 's/\r$//' /usr/bin/cek-tr
sed -i -e 's/\r$//' /usr/bin/del-tr
sed -i -e 's/\r$//' /usr/bin/renew-tr


#Instal Trojan-GO
wget https://${github}/xray/trojan/trojan-go.sh && chmod +x trojan-go.sh && sed -i -e 's/\r$//' trojan-go.sh && ./trojan-go.sh

sleep 2

#Instal Shadowsocks
wget https://${github}/shadowsocks/shadowsocks.sh && chmod +x shadowsocks.sh && sed -i -e 's/\r$//' shadowsocks.sh && ./shadowsocks.sh

sleep 2

systemctl daemon-reload
systemctl enable runn
systemctl enable xray
systemctl enable trojan-go
systemctl enable shadowsocks-libev.service
systemctl start runn
systemctl start xray
systemctl start trojan-go
systemctl start shadowsocks-libev.service
systemctl restart runn
systemctl restart xray
systemctl restart trojan-go
systemctl restart shadowsocks-libev.service

echo -e "[ ${green}INFO$NC ] SETTING XRAY VMESS & VLESS  SUKSES !!!"
