#!/bin/bash
#apt-get -y install python-software-properties python-setuptools python-dev python-pip
#add-apt-repository -y ppa:saltstack/salt
#apt-get -y install salt-minion
#pip install fabric --proxy 192.168.11.8:3128

apt-get -qq update 
# instal softwares
apt-get -y install htop iotop dstat hping3 vim sysstat tcpdump lrzsz screen  htop iotop dstat ethtool curl lsb-release sysv-rc-conf rcconf ntfs-3g debconf-utils

# time sync
hwclock -w

#clear firstrun
rm -f /etc/init.d/first-boot.sh
rm -f /etc/rc2.d/S99first-boot.sh

# install log
debconf-get-selections --installers > installers_preseed.cfg
debconf-get-selections  > all_opts_preseed.cfg
