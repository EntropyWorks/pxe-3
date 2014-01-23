#!/bin/bash

#########################
# set yum repo
#########################
mv /etc/yum.conf /tmp
mv /etc/yum.repos.d/* /tmp
wget -O /etc/yum.conf http://192.168.11.9/pxe/saltstack/etc/yum.conf
wget -O /etc/yum.repos.d/CentOS-Base.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/CentOS-Base.repo
wget -O /etc/yum.repos.d/epel.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/epel.repo
wget -O /etc/yum.repos.d/rpmforge.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/rpmforge.repo
yum makecache
#########################
# set xrdp & vncserver
#########################
yum install -y wget sos pixman libXfont tigervnc-server xrdp --nogpgcheck
echo 'VNCSERVERS="2:root"' >> /etc/sysconfig/vncservers

chkconfig xrdp on
chkconfig vncserver on
service xrdp start

#echo "set vncpasswd:"
#vncpasswd 
#service vncserver start

#########################
# set ntp
#########################
wget -O /etc/sysconfig/ntpdate http://192.168.11.9/pxe/saltstack/etc/sysconfig/ntpdate
wget -O /etc/ntp.conf http://192.168.11.9/pxe/saltstack/etc/ntp.conf
wget -O /etc/ntp/step-tickers http://192.168.11.9/pxe/saltstack/etc/ntp/step-tickers
ntpdate -u ${ntp_server} && hwclock -w
#########################
# set ssh
#########################
wget -O /etc/ssh/sshd_config http://192.168.11.9/pxe/saltstack/etc/ssh/sshd_config
service sshd reload
#########################
# set services
#########################
wget -O /etc/sysconfig/selinux http://192.168.11.9/pxe/saltstack/etc/sysconfig/selinux
wget -O /etc/sysconfig/iptables http://192.168.11.9/pxe/saltstack/etc/sysconfig/iptables
setenforce 0
#########################
# set others
#########################
#cmk
#ocsng
#hsflow
#fabric
#hwinfo

#########################
# install xs-tools
#########################
if
  which xe-linux-distribution >/dev/null 2>&1
then
  exit
else
  mount /dev/cdrom /media
  echo y | /media/Linux/install.sh
fi
eject
umount /media
