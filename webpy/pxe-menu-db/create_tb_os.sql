CREATE TABLE `menu` (
  `id` int(10) NULL AUTO_INCREMENT,
  `distro` varchar(300) DEFAULT 'CentOS',
  `releasever` varchar(300) DEFAULT '6.0',
  `basearch` varchar(300) DEFAULT 'x86_64',
  `dir` varchar(300) DEFAULT 'pxeboot/centos/images',
  `kernel` varchar(300) DEFAULT 'vmlinuz',
  `initrd` varchar(300) DEFAULT 'initrd.gz',
  `append` varchar(300) DEFAULT '',
  `createdtime` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
