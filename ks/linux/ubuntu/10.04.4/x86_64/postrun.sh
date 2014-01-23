#!/bin/bash

# config files
wget -P /etc/apt/apt.conf.d/ http://192.168.11.9/saltstack/etc/apt/apt.conf.d/00proxy
wget -O /etc/apt/sources.list http://192.168.11.9/saltstack/etc/apt/sources.list-lucid
wget -O /etc/init.d/first-boot.sh http://192.168.11.9/pxe/ks/linux/ubuntu/10.04.4/x86_64/first-boot.sh

apt-get update
apt-get install -y xinetd build-essential ethtool dmidecode ntp
chmod a+x /etc/init.d/first-boot.sh
ln -s /etc/init.d/first-boot.sh /etc/rc2.d/S99first-boot.sh
