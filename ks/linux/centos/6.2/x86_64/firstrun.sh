#!/bin/bash

#########################
# set yum repo
#########################
mv /etc/yum.conf /tmp
mv /etc/yum.repos.d/* /tmp
curl -o /etc/yum.conf http://192.168.11.9/pxe/saltstack/etc/yum.conf
curl -o /etc/yum.repos.d/CentOS-Base.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/CentOS-Base.repo
curl -o /etc/yum.repos.d/epel.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/epel.repo
curl -o /etc/yum.repos.d/rpmforge.repo http://192.168.11.9/pxe/saltstack/etc/yum.repos.d/rpmforge.repo
yum makecache
#########################
yum install -y wget sos nfs-utils samba proftpd httpd --nogpgcheck
chkconfig nfs on
chkconfig smb on
chkconfig httpd on
chkconfig proftpd on
#########################
# set ntp
#########################
curl -o /etc/sysconfig/ntpdate http://192.168.11.9/pxe/saltstack/etc/sysconfig/ntpdate
curl -o /etc/ntp.conf http://192.168.11.9/pxe/saltstack/etc/ntp.conf
curl -o /etc/ntp/step-tickers http://192.168.11.9/pxe/saltstack/etc/ntp/step-tickers
ntpdate -u ${ntp_server} && hwclock -w
#########################
# set ssh
#########################
curl -o /etc/ssh/sshd_config http://192.168.11.9/pxe/saltstack/etc/ssh/sshd_config
service sshd reload
#########################
# set services
#########################
curl -o /etc/sysconfig/selinux http://192.168.11.9/pxe/saltstack/etc/sysconfig/selinux
curl -o /etc/sysconfig/iptables http://192.168.11.9/pxe/saltstack/etc/sysconfig/iptables
setenforce 0
#########################
# set others
#########################
curl -o check_mk-agent-1.2.3i7p2-1.noarch.rpm http://10.24.4.4/software/nagios/cmk/agent/check_mk-agent-1.2.3i7p2-1.noarch.rpm
yum install -y ./check_mk-agent-1.2.3i7p2-1.noarch.rpm
chkconfig xinetd on
#ocsng
#hsflow
#fabric
#hwinfo
#nxlog

#########################
# install xs-tools
#########################
#sed -i '/^sh/d' /etc/rc.local
#if
#  which xe-linux-distribution >/dev/null 2>&1
#then
#  cd / && umount -f ${mnt}
#  exit
#else
#  nfs_server="192.168.31.245"
#  exports="/mnt/autofs/xs-tools-602"
#  mnt="/mnt"
#  mount -t nfs ${nfs_server}:${exports} ${mnt}
#  echo y | ${mnt}/xstools/Linux/install.sh
#fi
