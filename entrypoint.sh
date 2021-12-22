#!/bin/sh
if [ -e /opt/installed ]
then
echo "Installed"
smbd
wsdd
echo done
else
echo "Install"
export TZ=Europe/Budapest
export DEBIAN_FRONTEND=noninteractive
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt update
apt -y upgrade
apt install -y wget
apt install -y gnupg2
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata
wget -qO - https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key | apt-key add -
rm /etc/apt/sources.list.d/wsdd.list
echo "deb https://pkg.ltec.ch/public/ focal main" | sh -c 'cat > /etc/apt/sources.list.d/wsdd.list'
apt update
apt install -y wsdd
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
apt install -y samba
mv /etc/samba/smb.conf.bak /etc/samba/smb.conf
touch /opt/installed
smbd
wsdd
echo done
touch /opt/installed
fi
