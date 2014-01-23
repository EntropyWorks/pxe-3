#!/bin/bash

XSLIC="xs602-2015-1.xslic"
NTP1="10.24.4.10"
NTP2="ntp.fudan.edu.cn"
IPT_FILE="iptables-xs602"
IQN_PREFIX="iqn.2013-07.com.gdcloud"
DOWNLOAD_SERVER="10.24.4.84"
CMK_AGENT="check_mk-agent-1.2.3i7p2-1.noarch.rpm"
host_id=`xe host-list params=uuid | head -1 | cut -d ' ' -f8`
host_name=`hostname | cut -d. -f1`
####################################################################################
ntpdate -u ${NTP1}
hwclock -w
wget -O /etc/ntp.conf http://10.24.4.84/pxe/saltstack/etc/ntp.conf
service ntpd reload
#
`xe host-param-set other-config:iscsi_iqn=${IQN_PREFIX}:${host_name} uuid=${host_id}`
xe host-param-get param-name=other-config uuid=${host_id}
#
wget -P /tmp/ http://10.24.4.4/isos/tools/xenserver-cloud-supp.iso
xe-install-supplemental-pack /tmp/xenserver-cloud-supp.iso
wget -P /tmp/ http://10.24.4.4/isos/hypervisor/${XSLIC}
xe host-license-add license-file=/tmp/${XSLIC} host-uuid=${host_id}
#
sed -i '/enabled/s/1/0/' /etc/yum.repos.d/Citrix.repo
mv /etc/yum.repos.d/CentOS-Base.repo /tmp
wget -P /etc/yum.repos.d/ http://${DOWNLOAD_SERVER}/pxe/saltstack/etc/yum.repos.d/CentOS-Base.repo
yum --noplugins makecache --nogpgcheck
#
umount /var/xen/xc-install
sed -i '/xc-install/d' /etc/fstab
#
modprobe ipmi_si
modprobe ipmi_msghandler
modprobe ipmi_watchdog
modprobe ipmi_poweroff
modprobe ipmi_devintf
echo "modprobe ipmi_msghandler" >> /etc/rc.local
echo "modprobe ipmi_si" >> /etc/rc.local
echo "modprobe ipmi_watchdog" >> /etc/rc.local
echo "modprobe ipmi_poweroff" >> /etc/rc.local
echo "modprobe ipmi_devintf" >> /etc/rc.local
#
mv /etc/sysconfig/iptables /etc/syconfig/iptables.old
wget -O /etc/sysconfig/iptables http://${DOWNLOAD_SERVER}/pxe/saltstack/etc/sysconfig/${IPT_FILE}
iptables-restore < /etc/sysconfig/iptables
#
wget http://10.24.4.4/software/nagios/cmk/agent/${CMK_AGENT}
yum install -y --nogpgcheck ${CMK_AGENT}
