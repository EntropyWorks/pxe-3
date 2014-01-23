CREATE TABLE `ipxe` (
  `mac` varchar(30) DEFAULT '00:00:00:00:00:00',
  `ip` varchar(30) DEFAULT '0.0.0.0',
  `uuid` varchar(30) DEFAULT '',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
