# Kickstart file automatically generated by anaconda.

#version=RHEL6
install
cdrom
lang en_US.UTF-8
keyboard us
network --device eth0 --mtu=1500 --bootproto static --ip 192.168.0.64 --netmask 255.255.255.0 --gateway 192.168.0.1 --nameserver 8.8.8.8 --hostname CactiEZ.local
rootpw  --iscrypted $6$efjM/rw2qK1YkDqZ$.RK6VkWR5TB0sP4cRWBDbhEx8/5Ojz4yIJpOSKspkLP66hSMIXKe4M1tam9j8L.SflBJXDgQco/XotEtmhIrB0

firewall --service=ssh --service=snmp --service=http
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --disabled
timezone Asia/Shanghai
bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb quiet"
# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
#clearpart --all --initlabel

#part /boot --fstype=ext4 --size=200
#part pv.O6MpJy-t9WL-kzT0-X3Pa-QBAn-aqHs-75QWpO --grow --size=200

#volgroup vg_cactiezv10 --pesize=4096 pv.O6MpJy-t9WL-kzT0-X3Pa-QBAn-aqHs-75QWpO
#logvol / --fstype=ext4 --name=LogVol00 --vgname=vg_cactiezv10 --grow --size=8192
#logvol swap --name=LogVol01 --vgname=vg_cactiezv10 --size=1024
repo --name="CactiEZ"  --baseurl=file:///mnt/source/ --cost=100
repo --name="CactiEZ"  --baseurl=file:///mnt/source/ --cost=100

%packages --excludedocs --nobase
@Core
@core
@server-policy
curl
elinks
expect
file
ftp
httpd
lftp
man
mysql-server
net-snmp
net-snmp-utils
ntp
openssh-clients
pango
php
php-gd
php-mysql
rsyslog-mysql
system-config-network-tui
vim-enhanced
wget

%end

%post --nochroot
mkdir -p /mnt/sysimage/tmp/cactiez >> /tmp/ins.log 2>&1
cp /mnt/source/Packages/cactiez-x86_64.tgz /mnt/sysimage/tmp/cactiez >> /tmp/ins.log 2>&1

%end

%post
cd /tmp/cactiez >> /tmp/ins.log 2>&1
tar zxvf cactiez-x86_64.tgz >> /tmp/ins.log 2>&1

cp -rf /tmp/cactiez/var/www/html/* /var/www/html >> /tmp/ins.log 2>&1
cp -rf /tmp/cactiez/usr/* /usr >> /tmp/ins.log 2>&1
cp -rf /tmp/cactiez/etc/* /etc >> /tmp/ins.log 2>&1

service mysqld start >> /tmp/ins.log 2>&1
/usr/bin/mysqladmin --user=root create cacti >> /tmp/ins.log 2>&1
mysql -e "GRANT ALL ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'cactiuser'" >> /tmp/ins.log 2>&1

mysql cacti < /var/www/html/cactiez.sql
service mysqld stop >> /tmp/ins.log 2>&1

chmod -R 777 /var/www/html/log/
chmod -R 7755 /var/www/html/rra/
chmod -R 755 /var/www/html/scripts/
chmod -R 755 /usr/local/spine/bin/
chmod -R 755 /usr/local/rrdtool/bin/
chown -R apache:apache /var/www/html/

echo '*/10 * * * * /usr/sbin/ntpdate 0.rhel.pool.ntp.org && /sbin/clock -w' > /tmp/crontab2.tmp
echo '*/5 * * * * php /var/www/html/poller.php > /dev/null 2>&1' >> /tmp/crontab2.tmp
crontab /tmp/crontab2.tmp
rm /tmp/crontab2.tmp

for service in httpd mysqld snmpd
do
  chkconfig --level 235 $service on
done

#rm -rf /tmp/*

%end