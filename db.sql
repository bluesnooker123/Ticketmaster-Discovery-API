-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table json.backup_events
CREATE TABLE IF NOT EXISTS `backup_events` (
  `backup_events_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` int(11) DEFAULT NULL,
  `id` text,
  `field` text,
  `Old_value` text,
  `New_value` text,
  PRIMARY KEY (`backup_events_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.backup_events: 0 rows
/*!40000 ALTER TABLE `backup_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_events` ENABLE KEYS */;

-- Dumping structure for table json.events
CREATE TABLE IF NOT EXISTS `events` (
  `events_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `type` text,
  `id` text,
  `test` text,
  `url` text,
  `locale` text,
  `promoter_id` text,
  `promoter_name` text,
  `promoter_description` text,
  `startDateTime` text,
  `startTBD` text,
  `startTBA` text,
  `endDateTime` text,
  PRIMARY KEY (`events_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events: 0 rows
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Dumping structure for table json.events_classifications
CREATE TABLE IF NOT EXISTS `events_classifications` (
  `events_classifications_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` varchar(100) DEFAULT NULL,
  `primary` varchar(100) DEFAULT NULL,
  `segment_id` varchar(100) DEFAULT NULL,
  `segment_name` varchar(100) DEFAULT NULL,
  `genre_id` varchar(100) DEFAULT NULL,
  `genre_name` varchar(100) DEFAULT NULL,
  `subGenre_id` varchar(100) DEFAULT NULL,
  `subGenre_name` varchar(100) DEFAULT NULL,
  `type_id` varchar(100) DEFAULT NULL,
  `type_name` varchar(100) DEFAULT NULL,
  `subType_id` varchar(100) DEFAULT NULL,
  `subType_name` varchar(50) DEFAULT NULL,
  `family` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_classifications_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_classifications: 0 rows
/*!40000 ALTER TABLE `events_classifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_classifications` ENABLE KEYS */;

-- Dumping structure for table json.events_dates
CREATE TABLE IF NOT EXISTS `events_dates` (
  `events_dates_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` int(11) DEFAULT NULL,
  `localDate` varchar(50) DEFAULT NULL,
  `localTime` varchar(50) DEFAULT NULL,
  `dateTime` varchar(50) DEFAULT NULL,
  `dateTBD` varchar(50) DEFAULT NULL,
  `dateTBA` varchar(50) DEFAULT NULL,
  `timeTBA` varchar(50) DEFAULT NULL,
  `noSpecificTime` varchar(50) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `spanMultipleDays` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_dates_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_dates: 0 rows
/*!40000 ALTER TABLE `events_dates` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_dates` ENABLE KEYS */;

-- Dumping structure for table json.events_products
CREATE TABLE IF NOT EXISTS `events_products` (
  `events_products_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `url` text,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_products_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_products: 0 rows
/*!40000 ALTER TABLE `events_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_products` ENABLE KEYS */;

-- Dumping structure for table json.events_products_classifications
CREATE TABLE IF NOT EXISTS `events_products_classifications` (
  `events_products_classifications_id` int(11) NOT NULL,
  `events_product_id` int(11) DEFAULT NULL,
  `events_id` int(11) DEFAULT NULL,
  `primary` varchar(50) DEFAULT NULL,
  `segment_id` varchar(50) DEFAULT NULL,
  `segment_name` varchar(50) DEFAULT NULL,
  `genre_id` varchar(50) DEFAULT NULL,
  `genre_name` varchar(50) DEFAULT NULL,
  `subGenre_id` varchar(50) DEFAULT NULL,
  `subGenre_name` varchar(50) DEFAULT NULL,
  `type_id` varchar(50) DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `subType_id` varchar(50) DEFAULT NULL,
  `subType_name` varchar(50) DEFAULT NULL,
  `family` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_products_classifications_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_products_classifications: 0 rows
/*!40000 ALTER TABLE `events_products_classifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_products_classifications` ENABLE KEYS */;

-- Dumping structure for table json.events_sales
CREATE TABLE IF NOT EXISTS `events_sales` (
  `events_sales_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` int(11) DEFAULT NULL,
  `startDateTime` varchar(50) DEFAULT NULL,
  `startTBD` varchar(50) DEFAULT NULL,
  `startTBA` varchar(50) DEFAULT NULL,
  `endDateTime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_sales_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_sales: 0 rows
/*!40000 ALTER TABLE `events_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_sales` ENABLE KEYS */;

-- Dumping structure for table json.events_sales_presales
CREATE TABLE IF NOT EXISTS `events_sales_presales` (
  `events_sales_presales_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_id` int(11) DEFAULT NULL,
  `startDateTime` varchar(50) DEFAULT NULL,
  `endDateTime` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`events_sales_presales_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table json.events_sales_presales: 0 rows
/*!40000 ALTER TABLE `events_sales_presales` DISABLE KEYS */;
/*!40000 ALTER TABLE `events_sales_presales` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
