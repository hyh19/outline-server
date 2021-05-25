#!/usr/bin/env bash

# 安装 Docker
curl -fsSL https://get.docker.com -o get-docker.sh \
&& sudo sh get-docker.sh

# 安装 Outline Server
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"

# 设置 2G 流量限制
API_URL=$(sudo grep -Eo 'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)' /opt/outline/access.txt) \
&& curl -v --insecure -X PUT -H "Content-Type: application/json" -d '{"limit": {"bytes": 2000000000}}' $API_URL/access-keys/0/data-limit \
&& curl --insecure $API_URL/access-keys/ | egrep -o 'ss://.*\?outline=1'
