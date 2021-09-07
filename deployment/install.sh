#!/bin/bash
set -x;
cat <<EOF > /etc/systemd/system/electrum-scribe.service 
[Unit]
Description=electrum-scribe
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/root/electrum-scribe
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

WORK_DIR=$HOME/electrum-scribe/
mkdir -p $WORK_DIR
cat <<EOF > $WORK_DIR/docker-compose.yml
version: "3.7"
services:
  electrumx:
    image: coindroid42/electrumx:scribe
    environment:
      DAEMON_BIN_URL: https://github.com/scribenetwork/scribe/releases/download/v0.3/scribe-ubuntu-16.04-x64.tar.gz
    restart: always  
    volumes:
      - ./data:/data
    ports:
      - "33001:33001"
      - "34001:34001"
EOF

cd $WORK_DIR
docker-compose pull;

systemctl enable electrum-scribe
systemctl start electrum-scribe
