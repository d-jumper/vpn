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

clear
arfvpn="/etc/arfvpn"
xray="/etc/xray"
ipvps="/var/lib/arfvpn"
source ${ipvps}/ipvps.conf
if [[ "${IP}" = "" ]]; then
domain=$(cat ${xray}/domain)
else
domain=${IP}
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;36m      Add Xray/Vmess Account      \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w ${user} ${xray}/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\\E[0;41;36m      Add Xray/Vmess Account      \E[0m"
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
add-ws
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "${masaaktif} days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmessworry$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmesskuota$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmessgrpc$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
sed -i '/#vmesschat$/a\#vm# '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"0"',"email": "'""${user}""'"' ${xray}/config.json
vmess1=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess2=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "$none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
worry=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/worryfree",
      "type": "none",
      "host": "tsel.me",
      "tls": "none"
}
EOF`
flex=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/chat",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "bug.com",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "/vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
kuota=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/kuota-habis",
      "type": "none",
      "host": "bug.com",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< ${vmess_json1})
vmess_base642=$( base64 -w 0 <<< ${vmess_json2})
vmess_base643=$( base64 -w 0 <<< ${vmess_json3})
vmess_base644=$( base64 -w 0 <<< ${vmess_json4})
vmess_base645=$( base64 -w 0 <<< ${vmess_json5})
vmess_base646=$( base64 -w 0 <<< ${vmess_json6})
vmesslink1="vmess://$(echo ${vmess1} | base64 -w 0)"
vmesslink2="vmess://$(echo ${vmess2} | base64 -w 0)"
vmesslink3="vmess://$(echo ${worry} | base64 -w 0)"
vmesslink4="vmess://$(echo ${flex} | base64 -w 0)"
vmesslink5="vmess://$(echo ${grpc} | base64 -w 0)"
vmesslink6="vmess://$(echo ${kuota} | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
clear

echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "\\E[0;41;36m        Xray/Vmess Account        \E[0m" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Remarks   : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain    : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port NTLS : ${none}" | tee -a /etc/log-create-user.log
echo -e "Port TLS  : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Port GRPC : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Id        : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "alterId   : 0" | tee -a /etc/log-create-user.log
echo -e "Security  : auto" | tee -a /etc/log-create-user.log
echo -e "Network   : ws/grpc" | tee -a /etc/log-create-user.log
echo -e "Path WS   : /vmess" | tee -a /etc/log-create-user.log
echo -e "Path GRPC : /vmess-grpc" | tee -a /etc/log-create-user.log
echo -e "Path TSEL : /worryfree" | tee -a /etc/log-create-user.log
echo -e "Path FLEX : /chat" | tee -a /etc/log-create-user.log
echo -e "Path OPOK : /kuota-habis" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link TLS       : ${vmesslink1}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link none TLS  : ${vmesslink2}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link GRPC      : ${vmesslink5}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link TSEL OPOK : ${vmesslink3}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link FLEX      : ${vmesslink4}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link OPOK      : ${vmesslink6}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Expired On : ${exp}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
read -n 1 -s -r -p "Press any key to back on menu"

menu
