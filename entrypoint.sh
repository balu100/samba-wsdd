#!/bin/sh
if [ -e /opt/installed ]
then
echo "Installed"
smbd &
wsdd &
echo done
else
echo "Install"
apt update
apt -y upgrade
apt install -y wget
apt install -y gnupg2
wget -qO - https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key | apt-key add -
echo "deb https://pkg.ltec.ch/public/ focal main" | sh -c 'cat >> /etc/apt/sources.list'
apt update
apt install -y wsdd
apt install -y samba
smbd &
wsdd &
echo done
touch /opt/installed
fi
