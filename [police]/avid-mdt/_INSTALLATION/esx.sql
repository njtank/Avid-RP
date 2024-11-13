CREATE TABLE IF NOT EXISTS `avid-mdt_annoucements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL DEFAULT '',
  `content` longtext NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `annid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_citizen_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `date` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `reason` longtext NOT NULL DEFAULT '',
  `officer` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_evidences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `subtitle` longtext NOT NULL,
  `creator` varchar(50) NOT NULL DEFAULT '',
  `officer_involved` longtext DEFAULT '{}',
  `citizen_involved` longtext DEFAULT '{}',
  `images` longtext DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `fine` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  `officer` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_housenotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `house_name` varchar(50) DEFAULT NULL,
  `date` int(11) DEFAULT 0,
  `note` longtext DEFAULT NULL,
  `officer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_jails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `reason` longtext NOT NULL DEFAULT '',
  `fine` int(11) NOT NULL DEFAULT 0,
  `jail` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  `officer` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `title` longtext NOT NULL DEFAULT '',
  `content` longtext NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `annid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `mdt_color` varchar(50) DEFAULT '#0D141F',
  `main_color` varchar(50) DEFAULT '#111925',
  `second_color` varchar(50) DEFAULT '#0D141F',
  `third_color` varchar(50) DEFAULT '#1E2839',
  `fourth_color` varchar(50) DEFAULT '#316BFF',
  `language` varchar(50) DEFAULT 'en',
  `mdtscale` varchar(50) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_vehicle_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(15) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL DEFAULT 0,
  `note` longtext NOT NULL DEFAULT '',
  `officer` varchar(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `plate` (`plate`),
  KEY `note` (`note`(768)),
  KEY `officer` (`officer`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `avid-mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `subtitle` longtext NOT NULL,
  `creator` varchar(50) NOT NULL DEFAULT '',
  `officer_involved` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `citizen_involved` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `users` ADD `mdt_picture` longtext DEFAULT NULL, ADD `mdt_searched` int(11) DEFAULT 0;