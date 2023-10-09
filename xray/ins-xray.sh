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
YELLOW='\e[32;1m'    # YELLOW
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

#########################################################
clear
echo ""
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "          INSTALLING XRAY"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
date
sleep 2
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir

# Make Folder XRay
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
wget -O /usr/bin/update-xray "https://${github}/service/update-xray.sh"
chmod +x /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/update-xray
/usr/bin/update-xray

# NGINX-SERVER
cd
wget https://${github}/nginx/nginx-server.sh
chmod +x nginx-server.sh
sed -i -e 's/\r$//' nginx-server.sh
./nginx-server.sh

xray_onfig () {
# Random Port Xray
trojan=$((RANDOM + 10000))
vless=$((RANDOM + 10000))
vlessgrpc=$((RANDOM + 10000))
vmess=$((RANDOM + 10000))
worryfree=$((RANDOM + 10000))
kuotahabis=$((RANDOM + 10000))
vmessgrpc=$((RANDOM + 10000))
vmesschat=$((RANDOM + 10000))
trojangrpc=$((RANDOM + 10000))

# xray config
echo -e "${INFO} MEMBUAT CONFIG XRAY"
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
      "port": "${trojan}",
      "protocol": "trojan",
      "settings": {
          "decryption":"none",		
           "clients": [
              {
                 "password": "${uuid}"
#trojan
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
               "path": "/trojan"
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

}

set_ws () {
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

sed -i '$ ilocation = /trojan' /etc/nginx/sites-available/${domain}.conf
sed -i '$ i{' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/sites-available/${domain}.conf
sed -i '$ iproxy_pass http://127.0.0.1:'"${trojan}"';' /etc/nginx/sites-available/${domain}.conf
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
}

update_script () {
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
}

#########################################################
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "          INSTALLING XRAY$NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
sleep 

echo -e " ${LIGHT}- ${NC}Make Xray Config"
arfvpn_bar 'xray_onfig'
echo -e ""
sleep 2

echo -e " ${LIGHT}- ${NC}Set Xray Websocket"
arfvpn_bar 'set_ws'
echo -e ""
sleep 2
2

echo -e " ${LIGHT}- ${NC}Updating New Script"
arfvpn_bar 'update_script'
echo -e ""
sleep 2

echo -e " ${OK} Successfully !!! ${CEKLIST}"
echo -e ""
sleep 2

#Instal Trojan-GO
wget https://${github}/trojan-go/trojan-go.sh && chmod +x trojan-go.sh && sed -i -e 's/\r$//' trojan-go.sh && ./trojan-go.sh

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

echo -e "${INFO} INSTALLING XRAY SUCCESSFULLY !!!"