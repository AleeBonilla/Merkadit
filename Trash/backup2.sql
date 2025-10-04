-- MySQL dump 10.13  Distrib 9.4.0, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: Merkadit_DB
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AccountReceivableLog`
--

DROP TABLE IF EXISTS `AccountReceivableLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccountReceivableLog` (
  `accountReceivablesLog` int NOT NULL AUTO_INCREMENT,
  `changeAmount` float DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `changeType` enum('CHARGE','PAYMENT','ADJUSTMENT') DEFAULT NULL,
  `checksum` varchar(64) DEFAULT NULL,
  `transactionId` int NOT NULL,
  `accountReceivableId` int NOT NULL,
  PRIMARY KEY (`accountReceivablesLog`),
  KEY `fk_AccountReceivableLog_AccountsReceivables1_idx` (`accountReceivableId`),
  KEY `fk_AccountReceivableLog_Transactions1_idx` (`transactionId`),
  CONSTRAINT `fk_AccountReceivableLog_AccountsReceivables1` FOREIGN KEY (`accountReceivableId`) REFERENCES `AccountsReceivables` (`accountReceivableId`),
  CONSTRAINT `fk_AccountReceivableLog_Transactions1` FOREIGN KEY (`transactionId`) REFERENCES `Transactions` (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountReceivableLog`
--

LOCK TABLES `AccountReceivableLog` WRITE;
/*!40000 ALTER TABLE `AccountReceivableLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `AccountReceivableLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountsReceivables`
--

DROP TABLE IF EXISTS `AccountsReceivables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AccountsReceivables` (
  `accountReceivableId` int NOT NULL AUTO_INCREMENT,
  `totalAmount` float DEFAULT NULL,
  `currentBalance` float DEFAULT NULL,
  `status` enum('ACTIVE','CLOSED','INACTIVE') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `businessId` int NOT NULL,
  `contractId` int NOT NULL,
  `currencyId` int NOT NULL,
  PRIMARY KEY (`accountReceivableId`),
  KEY `fk_AccountsReceivable_Business1_idx` (`businessId`),
  KEY `fk_AccountsReceivable_Contracts1_idx` (`contractId`),
  KEY `fk_AccountsReceivable_Currencies1_idx` (`currencyId`),
  CONSTRAINT `fk_AccountsReceivable_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_AccountsReceivable_Contracts1` FOREIGN KEY (`contractId`) REFERENCES `Contracts` (`contractId`),
  CONSTRAINT `fk_AccountsReceivable_Currencies1` FOREIGN KEY (`currencyId`) REFERENCES `Currencies` (`currencyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountsReceivables`
--

LOCK TABLES `AccountsReceivables` WRITE;
/*!40000 ALTER TABLE `AccountsReceivables` DISABLE KEYS */;
/*!40000 ALTER TABLE `AccountsReceivables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Addresses`
--

DROP TABLE IF EXISTS `Addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address1` varchar(60) NOT NULL,
  `address2` varchar(60) NOT NULL,
  `zipcode` varchar(6) NOT NULL,
  `geolocation` point NOT NULL,
  `status` enum('ACTIVE','CHANGED','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `cityIid` int NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `fk_Addresses_cities1_idx` (`cityIid`),
  CONSTRAINT `fk_Addresses_cities1` FOREIGN KEY (`cityIid`) REFERENCES `Cities` (`cityId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Addresses`
--

LOCK TABLES `Addresses` WRITE;
/*!40000 ALTER TABLE `Addresses` DISABLE KEYS */;
INSERT INTO `Addresses` VALUES (1,'AV. CENTRAL 27','FRENTE AL BCR','10102',_binary '\0\0\0\0\0\0\0\Ûù~j¼\ô#@!°rh‘\rUÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,1),(2,'CALLE 13 #551','ALAMEDA 4','10201',_binary '\0\0\0\0\0\0\0´\Èv¾Ÿ\Z$@\ìQ¸…UÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,2),(3,'AV. SAN MARCOS','DIAGONAL AL MALL SAN PEDRO','11501',_binary '\0\0\0\0\0\0\0H\áz®\Ç#@{®G\áUÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,3),(4,'CALLE 20','DETRÃS DEL HOSPITAL MÃ‰XICO','10104',_binary '\0\0\0\0\0\0\0œ\Ä °r\è#@fffffUÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(5,'AV. FLORES','FRENTE A LA TEC','40101',_binary '\0\0\0\0\0\0\0/\Ý$$@V-²UÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(6,'BARRIO LA CRUZ','CERCA DE LA IGLESIA CENTRAL','30102',_binary '\0\0\0\0\0\0\0F¶\óýÔ¸#@\î|?5^úTÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,5),(7,'CALLE REAL 77','PLAZA DEPORTIVA','60105',_binary '\0\0\0\0\0\0\0\ÓMbXù#@+‡1UÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,6),(8,'AV. PRINCIPAL','DPT. 514','50201',_binary '\0\0\0\0\0\0\0j¼t“D%@‡\Ù\Î\÷[UÀ','ACTIVE','2025-09-25 00:00:00',NULL,1,7),(9,'Av. Central 100','Edificio A, Piso 1','30101',_binary '\0\0\0\0\0\0\0\î|?5^º#@˜nƒÀúTÀ','ACTIVE','2025-09-29 16:26:28',NULL,1,1),(10,'Calle 5','Local B, Frente a parque','30102',_binary '\0\0\0\0\0\0\0{®G\áº#@{®G\áúTÀ','ACTIVE','2025-09-29 16:26:28',NULL,1,1),(11,'Boulevard Norte','Edificio B, Piso 2','30103',_binary '\0\0\0\0\0\0\0=\n×£p½#@33333ûTÀ','CHANGED','2025-09-29 16:26:28','2025-09-29 16:26:28',1,1),(12,'Ruta 32','Contiguo a gasolinera','30104',_binary '\0\0\0\0\0\0\0X9´\Èv¾#@\ìQ¸…ûTÀ','ACTIVE','2025-09-29 16:26:28',NULL,1,1),(13,'Calle 10','Diagonal a escuela','30105',_binary '\0\0\0\0\0\0\0#\Ûù~j¼#@^ºIûTÀ','ACTIVE','2025-09-29 16:26:28',NULL,1,1);
/*!40000 ALTER TABLE `Addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Applications`
--

DROP TABLE IF EXISTS `Applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Applications` (
  `AppId` int NOT NULL AUTO_INCREMENT,
  `appName` varchar(45) NOT NULL,
  `appType` enum('Web App','Mobile App') DEFAULT NULL,
  `moduleId` int NOT NULL,
  PRIMARY KEY (`AppId`),
  KEY `fk_Applications_Modules1_idx` (`moduleId`),
  CONSTRAINT `fk_Applications_Modules1` FOREIGN KEY (`moduleId`) REFERENCES `Modules` (`moduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Applications`
--

LOCK TABLES `Applications` WRITE;
/*!40000 ALTER TABLE `Applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `Applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BillDetail`
--

DROP TABLE IF EXISTS `BillDetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillDetail` (
  `billDetail_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int DEFAULT NULL,
  `unitPrice` float NOT NULL,
  `subtotal` float DEFAULT NULL,
  `checksum` varchar(64) NOT NULL,
  `createdAt` datetime NOT NULL,
  `saleBillId` int NOT NULL,
  `businessSaleItemId` int DEFAULT NULL,
  `businessProductId` int DEFAULT NULL,
  PRIMARY KEY (`billDetail_id`),
  KEY `fk_BillDetail_SaleBills1_idx` (`saleBillId`),
  KEY `fk_BillDetail_BusinessSaleItems1_idx` (`businessSaleItemId`),
  KEY `fk_billdetail_businessproduct` (`businessProductId`),
  CONSTRAINT `fk_billdetail_businessproduct` FOREIGN KEY (`businessProductId`) REFERENCES `BusinessProducts` (`businessProductId`),
  CONSTRAINT `fk_BillDetail_BusinessSaleItems1` FOREIGN KEY (`businessSaleItemId`) REFERENCES `BusinessSaleItems` (`businessSaleItemId`),
  CONSTRAINT `fk_BillDetail_SaleBills1` FOREIGN KEY (`saleBillId`) REFERENCES `SaleBills` (`saleBillId`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillDetail`
--

LOCK TABLES `BillDetail` WRITE;
/*!40000 ALTER TABLE `BillDetail` DISABLE KEYS */;
INSERT INTO `BillDetail` VALUES (1,3,2000,6000,'2001','2025-08-23 18:57:30',1,NULL,7),(2,5,35000,175000,'2002','2025-08-15 11:14:47',2,NULL,13),(3,5,2000,10000,'2003','2025-09-04 16:48:01',3,NULL,7),(4,3,180000,540000,'2004','2025-07-15 08:48:02',4,NULL,5),(5,10,1200,12000,'2005','2025-07-11 12:43:00',5,NULL,6),(6,5,1250,6250,'2006','2025-08-22 05:13:23',6,NULL,10),(7,2,280000,560000,'2007','2025-06-29 13:37:23',7,NULL,3),(8,1,280000,280000,'2008','2025-06-21 02:01:46',8,NULL,3),(9,1,650000,650000,'2009','2025-06-09 21:47:14',9,NULL,2),(10,3,350000,1050000,'2010','2025-08-22 20:27:41',10,NULL,1),(11,4,1250,5000,'2011','2025-08-27 12:45:14',11,NULL,10),(12,3,85000,255000,'2012','2025-06-10 05:24:18',12,NULL,4),(13,1,350000,350000,'2013','2025-09-26 03:41:02',13,NULL,1),(14,7,1200,8400,'2014','2025-07-11 12:38:38',14,NULL,6),(15,5,1200,6000,'2015','2025-09-30 15:15:20',15,NULL,6),(16,6,35000,210000,'2016','2025-07-10 17:45:33',16,NULL,13),(17,8,1250,10000,'2017','2025-08-23 08:46:50',17,NULL,10),(18,4,4500,18000,'2018','2025-07-12 05:05:45',18,NULL,15),(19,4,6500,26000,'2019','2025-09-02 02:52:06',19,NULL,8),(20,1,85000,85000,'2020','2025-08-15 14:04:24',20,NULL,4),(21,2,1300,2600,'2021','2025-08-15 11:22:23',21,NULL,9),(22,1,85000,85000,'2022','2025-09-06 02:56:24',22,NULL,4),(23,2,1800,3600,'2023','2025-07-23 10:28:05',23,NULL,12),(24,3,1200,3600,'2024','2025-09-14 21:19:48',24,NULL,6),(25,8,6500,52000,'2025','2025-07-23 15:32:46',25,NULL,8),(26,10,2000,20000,'2026','2025-06-08 17:58:39',26,NULL,7),(27,4,22000,88000,'2027','2025-08-28 05:22:08',27,NULL,14),(28,2,22000,44000,'2028','2025-07-12 20:29:45',28,NULL,14),(29,2,650000,1300000,'2029','2025-07-11 03:40:57',29,NULL,2),(30,4,2000,8000,'2030','2025-09-03 05:31:53',30,NULL,7),(31,8,1250,10000,'2031','2025-07-01 12:27:40',31,NULL,10),(32,5,1800,9000,'2032','2025-06-28 12:20:04',32,NULL,12),(33,7,22000,154000,'2033','2025-07-18 03:54:07',33,NULL,14),(34,3,180000,540000,'2034','2025-06-24 16:07:30',34,NULL,5),(35,4,1800,7200,'2035','2025-07-01 16:24:51',35,NULL,12),(36,8,35000,280000,'2036','2025-08-09 21:16:37',36,NULL,13),(37,1,1200,1200,'2037','2025-06-06 16:45:38',37,NULL,6),(38,2,22000,44000,'2038','2025-08-04 01:54:22',38,NULL,14),(39,1,2500,2500,'2039','2025-09-11 14:41:35',39,NULL,11),(40,1,350000,350000,'2040','2025-09-20 06:03:31',40,NULL,1),(41,2,350000,700000,'2041','2025-08-14 09:46:44',41,NULL,1),(42,3,85000,255000,'2042','2025-06-06 08:55:33',42,NULL,4),(43,2,22000,44000,'2043','2025-06-29 09:42:24',43,NULL,14),(44,2,85000,170000,'2044','2025-07-17 08:03:10',44,NULL,4),(45,9,2500,22500,'2045','2025-09-20 22:35:03',45,NULL,11),(46,3,1800,5400,'2046','2025-06-04 07:36:07',46,NULL,12),(47,1,650000,650000,'2047','2025-07-09 00:03:13',47,NULL,2),(48,1,1300,1300,'2048','2025-07-24 17:03:02',48,NULL,9),(49,4,1250,5000,'2049','2025-08-30 08:07:28',49,NULL,10),(50,1,1250,1250,'2050','2025-07-03 14:55:48',50,NULL,10),(51,3,350000,1050000,'2051','2025-07-27 22:15:20',51,NULL,1),(52,2,1300,2600,'2052','2025-07-05 03:33:24',52,NULL,9),(53,1,180000,180000,'2053','2025-07-05 01:03:07',53,NULL,5),(54,9,22000,198000,'2054','2025-08-30 14:27:21',54,NULL,14),(55,1,180000,180000,'2055','2025-07-06 02:18:15',55,NULL,5),(56,1,280000,280000,'2056','2025-08-03 01:45:39',56,NULL,3),(57,10,6500,65000,'2057','2025-06-15 12:57:14',57,NULL,8),(58,7,1800,12600,'2058','2025-06-03 04:56:12',58,NULL,12),(59,3,85000,255000,'2059','2025-08-13 21:22:10',59,NULL,4),(60,2,2000,4000,'2060','2025-08-02 20:55:03',60,NULL,7),(61,4,1300,5200,'2061','2025-07-31 12:07:02',61,NULL,9),(62,2,180000,360000,'2062','2025-08-09 16:11:50',62,NULL,5),(63,1,2000,2000,'2063','2025-06-10 15:32:41',63,NULL,7),(64,3,650000,1950000,'2064','2025-09-12 04:26:39',64,NULL,2),(65,1,85000,85000,'2065','2025-09-05 15:49:05',65,NULL,4),(66,2,35000,70000,'2066','2025-06-20 17:08:30',66,NULL,13),(67,2,650000,1300000,'2067','2025-07-14 11:32:12',67,NULL,2),(68,6,35000,210000,'2068','2025-07-02 00:50:13',68,NULL,13),(69,1,280000,280000,'2069','2025-09-15 10:49:52',69,NULL,3),(70,6,1200,7200,'2070','2025-08-04 18:35:35',70,NULL,6),(71,10,35000,350000,'2071','2025-06-23 05:38:34',71,NULL,13),(72,1,4500,4500,'2072','2025-09-02 21:54:50',72,NULL,15),(73,1,650000,650000,'2073','2025-06-23 13:25:25',73,NULL,2),(74,5,4500,22500,'2074','2025-07-02 09:47:44',74,NULL,15),(75,1,650000,650000,'2075','2025-07-11 20:30:48',75,NULL,2),(76,4,1800,7200,'2076','2025-08-06 08:21:46',76,NULL,12),(77,6,35000,210000,'2077','2025-09-03 15:33:50',77,NULL,13),(78,5,1250,6250,'2078','2025-08-09 16:20:31',78,NULL,10),(79,7,4500,31500,'2079','2025-07-04 18:52:01',79,NULL,15),(80,1,350000,350000,'2080','2025-08-09 18:43:15',80,NULL,1),(81,2,180000,360000,'2081','2025-07-08 07:33:50',81,NULL,5),(82,8,6500,52000,'2082','2025-08-01 08:14:09',82,NULL,8),(83,6,22000,132000,'2083','2025-06-17 14:25:17',83,NULL,14),(84,1,85000,85000,'2084','2025-07-18 16:39:12',84,NULL,4),(85,3,4500,13500,'2085','2025-08-19 20:22:12',85,NULL,15),(86,4,2500,10000,'2086','2025-08-09 05:50:34',86,NULL,11),(87,4,2000,8000,'2087','2025-07-07 10:10:29',87,NULL,7),(88,1,280000,280000,'2088','2025-06-24 11:03:47',88,NULL,3),(89,1,1300,1300,'2089','2025-08-19 12:43:57',89,NULL,9),(90,8,22000,176000,'2090','2025-06-26 15:02:07',90,NULL,14),(91,2,1300,2600,'2091','2025-08-19 06:22:00',91,NULL,9),(92,10,22000,220000,'2092','2025-08-12 05:51:42',92,NULL,14),(93,1,2000,2000,'2093','2025-09-07 16:54:28',93,NULL,7),(94,3,85000,255000,'2094','2025-08-11 08:39:10',94,NULL,4),(95,9,2000,18000,'2095','2025-07-01 09:45:34',95,NULL,7),(96,3,2500,7500,'2096','2025-08-25 15:31:37',96,NULL,11),(97,1,350000,350000,'2097','2025-07-11 22:45:56',97,NULL,1),(98,3,35000,105000,'2098','2025-09-05 07:54:39',98,NULL,13),(99,3,35000,105000,'2099','2025-08-29 12:53:51',99,NULL,13),(100,3,280000,840000,'2100','2025-07-20 12:50:41',100,NULL,3),(101,9,1300,11700,'2101','2025-08-14 07:20:46',101,NULL,9),(102,2,180000,360000,'2102','2025-08-26 00:13:02',102,NULL,5),(103,3,180000,540000,'2103','2025-08-15 12:36:24',103,NULL,5),(104,2,350000,700000,'2104','2025-07-28 14:34:00',104,NULL,1),(105,3,350000,1050000,'2105','2025-08-15 05:06:46',105,NULL,1),(106,6,1800,10800,'2106','2025-07-28 21:05:36',106,NULL,12),(107,7,1200,8400,'2107','2025-06-13 12:00:21',107,NULL,6),(108,2,1300,2600,'2108','2025-08-23 06:25:17',108,NULL,9),(109,3,4500,13500,'2109','2025-09-29 08:47:54',109,NULL,15),(110,1,180000,180000,'2110','2025-09-18 18:37:46',110,NULL,5),(111,5,1800,9000,'2111','2025-09-04 17:07:19',111,NULL,12),(112,2,35000,70000,'2112','2025-08-23 03:43:17',112,NULL,13),(113,3,4500,13500,'2113','2025-08-05 10:52:04',113,NULL,15),(114,3,6500,19500,'2114','2025-06-05 06:26:22',114,NULL,8),(115,7,1200,8400,'2115','2025-06-03 04:52:52',115,NULL,6),(116,3,85000,255000,'2116','2025-09-22 11:21:16',116,NULL,4),(117,3,1250,3750,'2117','2025-09-13 22:27:23',117,NULL,10),(118,6,1250,7500,'2118','2025-06-08 22:55:48',118,NULL,10),(119,2,180000,360000,'2119','2025-07-06 22:43:44',119,NULL,5),(120,10,22000,220000,'2120','2025-08-16 00:57:48',120,NULL,14),(121,4,1300,5200,'2121','2025-06-28 18:42:09',121,NULL,9),(122,3,4500,13500,'2122','2025-09-28 10:09:28',122,NULL,15),(123,9,1300,11700,'2123','2025-09-29 13:53:45',123,NULL,9),(124,2,180000,360000,'2124','2025-08-07 05:55:54',124,NULL,5),(125,2,180000,360000,'2125','2025-07-04 12:33:10',125,NULL,5),(126,5,35000,175000,'2126','2025-08-15 11:19:09',126,NULL,13),(127,1,1800,1800,'2127','2025-06-05 19:14:43',127,NULL,12),(128,2,180000,360000,'2128','2025-07-17 11:32:15',128,NULL,5),(129,3,22000,66000,'2129','2025-09-28 09:56:31',129,NULL,14),(130,3,6500,19500,'2130','2025-09-29 09:06:14',130,NULL,8),(131,9,2000,18000,'2131','2025-08-30 16:51:10',131,NULL,7),(132,1,280000,280000,'2132','2025-06-27 11:02:43',132,NULL,3),(133,8,1250,10000,'2133','2025-06-21 19:46:19',133,NULL,10),(134,3,1800,5400,'2134','2025-07-08 16:33:36',134,NULL,12),(135,1,180000,180000,'2135','2025-07-19 01:28:13',135,NULL,5),(136,2,85000,170000,'2136','2025-09-19 01:07:23',136,NULL,4),(137,3,350000,1050000,'2137','2025-07-30 17:20:21',137,NULL,1),(138,2,280000,560000,'2138','2025-09-24 09:56:30',138,NULL,3),(139,3,350000,1050000,'2139','2025-07-10 03:41:03',139,NULL,1),(140,1,180000,180000,'2140','2025-08-17 14:58:05',140,NULL,5),(141,2,350000,700000,'2141','2025-06-18 07:07:36',141,NULL,1),(142,4,2500,10000,'2142','2025-08-24 14:08:50',142,NULL,11),(143,7,1800,12600,'2143','2025-09-18 13:35:15',143,NULL,12),(144,1,85000,85000,'2144','2025-08-17 20:19:57',144,NULL,4),(145,2,650000,1300000,'2145','2025-09-15 15:04:15',145,NULL,2),(146,9,2500,22500,'2146','2025-09-22 19:04:48',146,NULL,11),(147,1,280000,280000,'2147','2025-08-02 20:51:45',147,NULL,3),(148,9,2000,18000,'2148','2025-06-15 01:43:23',148,NULL,7),(149,2,350000,700000,'2149','2025-07-22 00:25:01',149,NULL,1),(150,3,85000,255000,'2150','2025-08-16 16:23:52',150,NULL,4),(151,7,22000,154000,'2151','2025-09-13 19:46:24',151,NULL,14),(152,7,2000,14000,'2152','2025-09-16 14:47:06',152,NULL,7),(153,1,1250,1250,'2153','2025-07-02 16:23:45',153,NULL,10),(154,8,22000,176000,'2154','2025-07-11 04:53:56',154,NULL,14),(155,1,85000,85000,'2155','2025-08-30 11:47:28',155,NULL,4),(156,6,1800,10800,'2156','2025-07-10 15:17:25',156,NULL,12),(157,8,6500,52000,'2157','2025-07-20 17:01:50',157,NULL,8),(158,2,350000,700000,'2158','2025-06-21 11:53:03',158,NULL,1),(159,7,4500,31500,'2159','2025-09-26 03:40:56',159,NULL,15),(160,3,22000,66000,'2160','2025-06-13 22:08:46',160,NULL,14),(161,1,180000,180000,'2161','2025-09-22 15:14:09',161,NULL,5),(162,2,350000,700000,'2162','2025-08-15 19:10:14',162,NULL,1),(163,2,85000,170000,'2163','2025-08-20 16:32:37',163,NULL,4),(164,1,180000,180000,'2164','2025-09-01 19:28:51',164,NULL,5),(165,1,180000,180000,'2165','2025-08-11 19:56:16',165,NULL,5),(166,5,2000,10000,'2166','2025-08-19 06:22:02',166,NULL,7),(167,1,1250,1250,'2167','2025-06-11 12:53:55',167,NULL,10),(168,2,280000,560000,'2168','2025-06-29 03:28:55',168,NULL,3),(169,3,22000,66000,'2169','2025-07-05 00:54:33',169,NULL,14),(170,1,280000,280000,'2170','2025-09-12 10:43:23',170,NULL,3),(171,10,22000,220000,'2171','2025-07-25 00:27:14',171,NULL,14),(172,7,1200,8400,'2172','2025-08-10 00:52:21',172,NULL,6),(173,5,2500,12500,'2173','2025-09-10 12:08:08',173,NULL,11),(174,7,22000,154000,'2174','2025-06-11 15:34:51',174,NULL,14),(175,1,35000,35000,'2175','2025-09-25 04:43:10',175,NULL,13),(176,5,35000,175000,'2176','2025-06-07 12:50:38',176,NULL,13),(177,2,85000,170000,'2177','2025-09-06 12:09:07',177,NULL,4),(178,5,4500,22500,'2178','2025-09-22 21:26:27',178,NULL,15),(179,5,1250,6250,'2179','2025-09-23 00:58:51',179,NULL,10),(180,9,4500,40500,'2180','2025-06-13 02:42:17',180,NULL,15),(181,5,35000,175000,'2181','2025-07-14 22:56:49',181,NULL,13),(182,3,1300,3900,'2182','2025-07-20 07:45:54',182,NULL,9),(183,9,4500,40500,'2183','2025-08-16 04:52:47',183,NULL,15),(184,1,180000,180000,'2184','2025-08-21 16:34:44',184,NULL,5),(185,6,1200,7200,'2185','2025-08-13 11:15:49',185,NULL,6),(186,9,2500,22500,'2186','2025-09-04 13:14:28',186,NULL,11),(187,3,280000,840000,'2187','2025-06-27 15:53:31',187,NULL,3),(188,3,1800,5400,'2188','2025-09-28 11:26:42',188,NULL,12),(189,2,280000,560000,'2189','2025-06-20 02:54:19',189,NULL,3),(190,2,1300,2600,'2190','2025-08-06 21:17:38',190,NULL,9),(191,6,6500,39000,'2191','2025-06-16 15:38:16',191,NULL,8),(192,1,650000,650000,'2192','2025-09-15 21:11:15',192,NULL,2),(193,9,2500,22500,'2193','2025-09-20 21:29:36',193,NULL,11),(194,1,350000,350000,'2194','2025-08-07 06:08:48',194,NULL,1),(195,7,22000,154000,'2195','2025-09-27 06:19:45',195,NULL,14),(196,7,1250,8750,'2196','2025-08-22 13:53:47',196,NULL,10),(197,1,650000,650000,'2197','2025-08-17 00:03:10',197,NULL,2),(198,2,4500,9000,'2198','2025-07-25 06:46:02',198,NULL,15),(199,3,85000,255000,'2199','2025-09-23 17:37:52',199,NULL,4),(200,5,2000,10000,'2200','2025-09-12 10:52:02',200,NULL,7),(201,1,4500,4500,'2201','2025-06-14 08:10:46',201,NULL,15),(202,2,1250,2500,'2202','2025-09-10 08:23:49',202,NULL,10),(203,1,180000,180000,'2203','2025-09-18 19:57:17',203,NULL,5),(204,5,1200,6000,'2204','2025-07-07 07:35:55',204,NULL,6),(205,1,350000,350000,'2205','2025-06-24 13:24:19',205,NULL,1),(206,2,180000,360000,'2206','2025-09-08 13:22:06',206,NULL,5),(207,3,280000,840000,'2207','2025-08-20 03:35:37',207,NULL,3),(208,3,350000,1050000,'2208','2025-07-19 03:48:40',208,NULL,1),(209,5,1300,6500,'2209','2025-08-19 06:17:41',209,NULL,9),(210,1,350000,350000,'2210','2025-08-20 09:56:32',210,NULL,1),(211,5,2500,12500,'2211','2025-09-22 02:21:25',211,NULL,11),(212,1,1250,1250,'2212','2025-09-14 10:54:14',212,NULL,10),(213,5,1800,9000,'2213','2025-07-13 22:52:28',213,NULL,12),(214,1,4500,4500,'2214','2025-07-16 03:51:50',214,NULL,15),(215,4,1250,5000,'2215','2025-08-10 01:57:40',215,NULL,10),(216,4,1200,4800,'2216','2025-07-16 04:04:44',216,NULL,6),(217,8,4500,36000,'2217','2025-07-28 12:08:02',217,NULL,15),(218,1,85000,85000,'2218','2025-09-26 12:36:26',218,NULL,4),(219,6,6500,39000,'2219','2025-06-11 20:37:32',219,NULL,8),(220,10,1200,12000,'2220','2025-06-22 05:44:02',220,NULL,6),(221,3,1250,3750,'2221','2025-09-29 09:07:19',221,NULL,10),(222,7,1800,12600,'2222','2025-06-19 07:07:36',222,NULL,12),(223,2,280000,560000,'2223','2025-06-13 17:02:57',223,NULL,3),(224,3,280000,840000,'2224','2025-07-02 18:40:04',224,NULL,3),(225,3,180000,540000,'2225','2025-09-03 07:50:22',225,NULL,5),(226,2,280000,560000,'2226','2025-06-18 12:12:19',226,NULL,3),(227,4,2000,8000,'2227','2025-07-18 01:22:45',227,NULL,7),(228,8,22000,176000,'2228','2025-06-28 14:45:56',228,NULL,14),(229,2,650000,1300000,'2229','2025-06-14 02:50:57',229,NULL,2),(230,7,2000,14000,'2230','2025-07-30 15:47:00',230,NULL,7),(231,3,180000,540000,'2231','2025-09-12 03:12:38',231,NULL,5),(232,7,4500,31500,'2232','2025-06-19 09:21:38',232,NULL,15),(233,3,350000,1050000,'2233','2025-09-24 13:47:15',233,NULL,1),(234,9,2500,22500,'2234','2025-08-04 21:08:55',234,NULL,11),(235,3,180000,540000,'2235','2025-08-01 11:05:54',235,NULL,5),(236,3,180000,540000,'2236','2025-07-16 20:28:44',236,NULL,5),(237,3,280000,840000,'2237','2025-07-10 12:37:32',237,NULL,3),(238,3,650000,1950000,'2238','2025-07-07 15:19:35',238,NULL,2),(239,3,85000,255000,'2239','2025-08-22 13:01:18',239,NULL,4),(240,1,280000,280000,'2240','2025-09-11 15:58:49',240,NULL,3),(241,1,85000,85000,'f332ed77342f9ca3993dfe3fb80668931b7ec11758326451cc7c78871584729d','2025-09-30 18:32:29',241,NULL,4),(242,1,85000,85000,'51078cddfd5959e55366ebafb87eb11001fee138b8be323eec59867c1c7402d2','2025-09-30 18:33:09',242,NULL,4);
/*!40000 ALTER TABLE `BillDetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BuildingArea`
--

DROP TABLE IF EXISTS `BuildingArea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BuildingArea` (
  `buildingArea` int NOT NULL AUTO_INCREMENT,
  `floorNumber` int NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'Para ubicar del siguiente modo: "En el pasillo principal, frente a X tienda", "Desde la entrada principal, 50 metros a mano derecha", etc.',
  `status` enum('ACTIVE','UNDER_CONSTRUCTION','UNDER_RENOVATION','CLOSED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `buildingId` int NOT NULL,
  PRIMARY KEY (`buildingArea`),
  KEY `fk_InBuildingLocation_Buildings1_idx` (`buildingId`),
  CONSTRAINT `fk_InBuildingLocation_Buildings1` FOREIGN KEY (`buildingId`) REFERENCES `Buildings` (`buildingId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BuildingArea`
--

LOCK TABLES `BuildingArea` WRITE;
/*!40000 ALTER TABLE `BuildingArea` DISABLE KEYS */;
INSERT INTO `BuildingArea` VALUES (1,1,'Pasillo principal, frente a la recepciÃ³n','ACTIVE','2025-09-25 00:00:00',NULL,1,1),(2,2,'Segundo piso, al lado del ascensor','ACTIVE','2025-09-25 00:00:00',NULL,1,1),(3,1,'Entrada principal, junto al lobby','ACTIVE','2025-09-25 00:00:00',NULL,1,2),(4,3,'Pasillo norte, frente al laboratorio de computaciÃ³n','ACTIVE','2025-09-25 00:00:00',NULL,1,2),(5,1,'Consultorio A, esquina sur del edificio','ACTIVE','2025-09-25 00:00:00',NULL,1,3),(6,2,'Consultorio B, frente al jardÃ­n interior','ACTIVE','2025-09-25 00:00:00',NULL,1,3),(7,1,'Gimnasio, pasillo este junto a la entrada','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(8,2,'Oficina administrativa, frente al Ã¡rea de recepciÃ³n','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(9,1,'Departamento 101, pasillo central','ACTIVE','2025-09-25 00:00:00',NULL,1,5),(10,2,'Departamento 102, frente al ascensor','ACTIVE','2025-09-25 00:00:00',NULL,1,5),(11,1,'Local comercial 1, esquina con la avenida principal','ACTIVE','2025-09-25 00:00:00',NULL,1,6),(12,2,'Local comercial 2, frente al estacionamiento','ACTIVE','2025-09-25 00:00:00',NULL,1,6),(13,1,'Apartamento 201, pasillo oeste','ACTIVE','2025-09-25 00:00:00',NULL,1,7),(14,2,'Apartamento 202, frente al Ã¡rea verde','ACTIVE','2025-09-25 00:00:00',NULL,1,7),(15,1,'Oficina de ventas, pasillo sur, junto a la entrada','ACTIVE','2025-09-25 00:00:00',NULL,1,8),(16,2,'Bodega, frente al Ã¡rea de carga','ACTIVE','2025-09-25 00:00:00',NULL,1,8),(17,1,'Pasillo principal, frente a los puestos de frutas','ACTIVE','2025-09-25 00:00:00',NULL,1,1),(18,1,'Segundo pasillo, junto a los locales de panaderÃ­a','ACTIVE','2025-09-25 00:00:00',NULL,1,1),(19,1,'Zona de alimentos, frente a los carritos de comida rÃ¡pida','ACTIVE','2025-09-25 00:00:00',NULL,1,2),(20,2,'Puestos de verduras y lÃ¡cteos, pasillo norte','ACTIVE','2025-09-25 00:00:00',NULL,1,2),(21,1,'Ãrea de snacks, esquina sur junto a la entrada','ACTIVE','2025-09-25 00:00:00',NULL,1,3),(22,2,'Pasillo central, frente a puestos de carnes','ACTIVE','2025-09-25 00:00:00',NULL,1,3),(23,1,'Comida rÃ¡pida, frente al Ã¡rea de bebidas','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(24,1,'Local de dulces y snacks, pasillo este','ACTIVE','2025-09-25 00:00:00',NULL,1,4),(25,1,'Zona de frutas y verduras, pasillo principal','ACTIVE','2025-09-25 00:00:00',NULL,1,5),(26,2,'Puestos de panaderÃ­a y reposterÃ­a, pasillo sur','ACTIVE','2025-09-25 00:00:00',NULL,1,5),(27,1,'Ãrea de comidas rÃ¡pidas, frente a la plaza central','ACTIVE','2025-09-25 00:00:00',NULL,1,6),(28,2,'Local de productos gourmet, pasillo oeste','ACTIVE','2025-09-25 00:00:00',NULL,1,6),(29,1,'Zona de snacks y bebidas, frente al pasillo principal','ACTIVE','2025-09-25 00:00:00',NULL,1,7),(30,2,'Puestos de comida internacional, esquina norte','ACTIVE','2025-09-25 00:00:00',NULL,1,7),(31,1,'Mercado de productos locales, pasillo central','ACTIVE','2025-09-25 00:00:00',NULL,1,8),(32,2,'Zona de cafÃ©s y reposterÃ­a, frente a los locales minoristas','ACTIVE','2025-09-25 00:00:00',NULL,1,8);
/*!40000 ALTER TABLE `BuildingArea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Buildings`
--

DROP TABLE IF EXISTS `Buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Buildings` (
  `buildingId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1',
  `buildingStatus` enum('ACTIVE','UNDER_CONSTRUCTION','UNDER_RENOVATION','CLOSED') NOT NULL,
  `addressId` int NOT NULL,
  PRIMARY KEY (`buildingId`),
  UNIQUE KEY `addressId_UNIQUE` (`addressId`),
  KEY `fk_buildings_Addresses1_idx` (`addressId`),
  CONSTRAINT `fk_buildings_Addresses1` FOREIGN KEY (`addressId`) REFERENCES `Addresses` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Buildings`
--

LOCK TABLES `Buildings` WRITE;
/*!40000 ALTER TABLE `Buildings` DISABLE KEYS */;
INSERT INTO `Buildings` VALUES (1,'EDIFICIO CANTARRANA 212','2025-09-25 00:00:00',NULL,1,'ACTIVE',1),(2,'TORRE RONALDO FLORES','2025-09-25 00:00:00',NULL,1,'ACTIVE',2),(3,'CENTRO COMERCIAL LA CRUZ','2025-09-25 00:00:00',NULL,1,'ACTIVE',3),(4,'PLAZA REAL 434','2025-09-25 00:00:00',NULL,1,'ACTIVE',4),(5,'CONTENEDORES LA CUCHARA 33','2025-09-25 00:00:00',NULL,1,'ACTIVE',5),(6,'CORA BUILDING','2025-09-25 00:00:00',NULL,1,'ACTIVE',6),(7,'MERCADO CENTRAL','2025-09-25 00:00:00',NULL,1,'ACTIVE',7),(8,'PASEO DE LAS FLORES','2025-09-25 00:00:00',NULL,1,'ACTIVE',8);
/*!40000 ALTER TABLE `Buildings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Business`
--

DROP TABLE IF EXISTS `Business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Business` (
  `businessId` int NOT NULL AUTO_INCREMENT COMMENT 'Negocio/entidad jurÃ­dica',
  `taxId` int NOT NULL,
  `legalId` varchar(45) NOT NULL,
  `name` varchar(50) NOT NULL,
  `legalName` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','SUSPENDED','CLOSED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1',
  `bussinessRoleId` int NOT NULL,
  `legalAddressId` int NOT NULL,
  `legalEntityTypeId` int NOT NULL,
  `changed_by` int DEFAULT NULL,
  PRIMARY KEY (`businessId`),
  KEY `fk_Business_Addresses1_idx` (`legalAddressId`),
  KEY `fk_Business_entityType1_idx` (`legalEntityTypeId`),
  KEY `fk_Business_Users1_idx` (`changed_by`),
  KEY `fk_Business_BusinessRoles1_idx` (`bussinessRoleId`),
  CONSTRAINT `fk_Business_Addresses1` FOREIGN KEY (`legalAddressId`) REFERENCES `Addresses` (`address_id`),
  CONSTRAINT `fk_Business_BusinessRoles1` FOREIGN KEY (`bussinessRoleId`) REFERENCES `BusinessRoles` (`BussinessRoleId`),
  CONSTRAINT `fk_Business_entityType1` FOREIGN KEY (`legalEntityTypeId`) REFERENCES `LegalEntityTypes` (`EntityTypeId`),
  CONSTRAINT `fk_Business_Users1` FOREIGN KEY (`changed_by`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Business`
--

LOCK TABLES `Business` WRITE;
/*!40000 ALTER TABLE `Business` DISABLE KEYS */;
INSERT INTO `Business` VALUES (1,101234567,'1108108601','Mercado 88','Supermercado Central 88 S.A.','Cadena de administradores de supermercados','ACTIVE','2023-03-15 10:23:00',NULL,1,1,8,1,NULL),(2,102345678,'0202020202','GastroPark & Convenience','Parque GastronÃ³mico y de Conveniencia 23 S.R.L.','Cadena administradora de centros gastronÃ³micos y minoristas','ACTIVE','2022-11-08 08:45:00',NULL,1,1,7,1,NULL),(3,103456789,'0303030303','Hamburguesas El Compa','Distribuidora El Compa S.C..','Venta de hamburguesas mÃ³vil (foodtruck)','ACTIVE','2021-07-22 12:10:00',NULL,1,2,7,3,NULL),(4,104567890,'72404040404','Drones CR','Soluciones TecnolÃ³gicas Ricardo C.A.','Venta de drones y piezas por separado','ACTIVE','2020-05-30 09:00:00',NULL,1,2,4,8,NULL),(5,105678901,'05050750505','Mini Market Express','Mini Market Express S.A.','Mercado de conveniencia con alimentos y bebidas','ACTIVE','2023-01-18 14:35:00',NULL,1,2,10,2,NULL),(6,100789312,'10608860606','Restaurante Sabores','Restaurante Sabores S.A.','Restaurante de comida rÃ¡pida y a la carta','ACTIVE','2022-09-10 11:50:00',NULL,1,2,1,4,NULL),(7,103545447,'31101010107','JugueterÃ­a Feliz','JugueterÃ­a Feliz S.R.L.','Juguetes y entretenimiento infantil','ACTIVE','2018-07-22 12:10:00',NULL,1,2,11,2,NULL),(8,103455438,'31012010108','PanaderÃ­a Dulce','PanaderÃ­a Dulce S.A.','PanaderÃ­a y reposterÃ­a','ACTIVE','2018-07-12 12:10:00',NULL,1,2,12,2,NULL),(9,134534409,'31010150109','LibrerÃ­a Alfa','LibrerÃ­a Alfa S.R.L.','Libros y papelerÃ­a','ACTIVE','2018-07-22 12:10:00',NULL,1,2,13,2,NULL),(10,101234567,'01201010341','Mercado 99','Supermercado Central 88 S.A.','Cadena de administradores de supermercados','ACTIVE','2023-03-15 10:23:00',NULL,1,1,2,1,NULL),(11,102345678,'34343456747','Electronic & Convenience','ElectrodomÃ©sticos Alex S.A.','Venta de electrodomÃ©sticos y artÃ­culos de conveniencia','ACTIVE','2022-12-08 08:45:00',NULL,1,2,7,1,NULL),(12,103456789,'03000307303','Tacos El Compadre','Distribuidora El Compadre S.C.','Venta de tacos mÃ³vil (foodtruck)','ACTIVE','2021-07-22 12:10:00',NULL,1,2,5,3,NULL),(13,104567890,'01401106404','Reparaciones cell CR','Soluciones TecnolÃ³gicas Cell C.A.','Venta de piezas de celular','ACTIVE','2017-05-30 09:00:00',NULL,1,2,6,8,NULL),(14,105678901,'05457805405','Bebidas CR7','Bebidas Market CR7 S.R.L.','Mercado de bebidas energÃ©ticas','ACTIVE','2024-01-18 14:35:00',NULL,1,2,10,2,NULL),(15,100789312,'34504504030','Pre U','Articulos universitarios S.C.S.','Venta de artÃ­culos para la universidad','ACTIVE','2022-09-10 11:50:00',NULL,1,2,7,4,NULL),(16,103545447,'31367010172','Yardas Juan','Abastecedor Juan S.R.L.','Venta de bebidas alcohÃ³licas y conveniencia','ACTIVE','2022-07-22 12:10:00',NULL,1,2,11,2,NULL),(17,103455438,'03495094504','PanaderÃ­a Salada','PanaderÃ­a Salada S.R.L.','PanaderÃ­a y reposterÃ­a salada','ACTIVE','2015-07-12 12:10:00',NULL,1,2,12,2,NULL),(18,134534409,'31010154109','LibrerÃ­a Omega','LibrerÃ­a Omega S.R.L.','Libros y papelerÃ­a','ACTIVE','2014-07-22 12:10:00',NULL,1,2,13,2,NULL);
/*!40000 ALTER TABLE `Business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BusinessCategories`
--

DROP TABLE IF EXISTS `BusinessCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BusinessCategories` (
  `businessCategoryId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`businessCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BusinessCategories`
--

LOCK TABLES `BusinessCategories` WRITE;
/*!40000 ALTER TABLE `BusinessCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `BusinessCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BusinessProducts`
--

DROP TABLE IF EXISTS `BusinessProducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BusinessProducts` (
  `businessProductId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `status` enum('ACTIVE','INACTIVE','CHANGED','ELIMINATED') DEFAULT NULL,
  `price` float NOT NULL,
  `cost` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `businessId` int NOT NULL,
  `productCategoryId` int NOT NULL,
  `currencyId` int NOT NULL,
  `unitMeasureId` int DEFAULT NULL,
  PRIMARY KEY (`businessProductId`),
  KEY `fk_BusinessProducts_Business1_idx` (`businessId`),
  KEY `fk_BusinessProducts_ProductCategories1_idx` (`productCategoryId`),
  KEY `fk_BusinessProducts_Currencies1_idx` (`currencyId`),
  KEY `fk_BusinessProducts_UnitMeasures1_idx` (`unitMeasureId`),
  CONSTRAINT `fk_BusinessProducts_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_BusinessProducts_Currencies1` FOREIGN KEY (`currencyId`) REFERENCES `Currencies` (`currencyId`),
  CONSTRAINT `fk_BusinessProducts_ProductCategories1` FOREIGN KEY (`productCategoryId`) REFERENCES `ProductCategories` (`productCategoryId`),
  CONSTRAINT `fk_BusinessProducts_UnitMeasures1` FOREIGN KEY (`unitMeasureId`) REFERENCES `UnitMeasures` (`unitMeasureId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BusinessProducts`
--

LOCK TABLES `BusinessProducts` WRITE;
/*!40000 ALTER TABLE `BusinessProducts` DISABLE KEYS */;
INSERT INTO `BusinessProducts` VALUES (1,'Smart TV 55\"','Televisor inteligente 4K UHD','ACTIVE',350000,280000,'2025-09-30 18:31:54',NULL,1,11,1,1,NULL),(2,'Laptop Gaming','Laptop para gaming 16GB RAM','ACTIVE',650000,520000,'2025-09-30 18:31:54',NULL,1,11,1,1,NULL),(3,'Smartphone Android','TelÃ©fono Android 128GB','ACTIVE',280000,224000,'2025-09-30 18:31:54',NULL,1,11,1,1,NULL),(4,'Auriculares InalÃ¡mbricos','AudÃ­fonos Bluetooth cancelaciÃ³n ruido','ACTIVE',85000,68000,'2025-09-30 18:31:54',NULL,1,11,1,1,NULL),(5,'Tablet 10\"','Tablet 64GB WiFi','ACTIVE',180000,144000,'2025-09-30 18:31:54',NULL,1,11,1,1,NULL),(6,'Bebida EnergÃ©tica 500ml','Bebida energÃ©tica sabor original','ACTIVE',1200,800,'2025-09-30 18:31:54',NULL,1,14,2,1,1),(7,'Bebida EnergÃ©tica 1L','Bebida energÃ©tica tamaÃ±o familiar','ACTIVE',2000,1400,'2025-09-30 18:31:54',NULL,1,14,2,1,1),(8,'Pack 6 Bebidas','Pack de 6 bebidas energÃ©ticas','ACTIVE',6500,4500,'2025-09-30 18:31:54',NULL,1,14,2,1,1),(9,'Bebida Sin AzÃºcar','Bebida energÃ©tica sin azÃºcar','ACTIVE',1300,900,'2025-09-30 18:31:54',NULL,1,14,2,1,1),(10,'Bebida Sabor Frutas','Bebida energÃ©tica sabor frutas tropicales','ACTIVE',1250,850,'2025-09-30 18:31:54',NULL,1,14,2,1,1),(11,'Cuaderno Universitario','Cuaderno 100 hojas rayado','ACTIVE',2500,1500,'2025-09-30 18:31:54',NULL,1,15,3,1,1),(12,'Paquete de LÃ¡pices','Paquete de 12 lÃ¡pices HB','ACTIVE',1800,1200,'2025-09-30 18:31:54',NULL,1,15,3,1,1),(13,'Mochila Universitaria','Mochila resistente para laptop','ACTIVE',35000,25000,'2025-09-30 18:31:54',NULL,1,15,3,1,1),(14,'Calculadora CientÃ­fica','Calculadora para ingenierÃ­a','ACTIVE',22000,16000,'2025-09-30 18:31:54',NULL,1,15,3,1,1),(15,'Set de Marcadores','Set de 8 marcadores permanentes','ACTIVE',4500,3000,'2025-09-30 18:31:54',NULL,1,15,3,1,1);
/*!40000 ALTER TABLE `BusinessProducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BusinessRoles`
--

DROP TABLE IF EXISTS `BusinessRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BusinessRoles` (
  `BussinessRoleId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`BussinessRoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BusinessRoles`
--

LOCK TABLES `BusinessRoles` WRITE;
/*!40000 ALTER TABLE `BusinessRoles` DISABLE KEYS */;
INSERT INTO `BusinessRoles` VALUES (1,'ADMIN'),(2,'TENANT');
/*!40000 ALTER TABLE `BusinessRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BusinessSaleItems`
--

DROP TABLE IF EXISTS `BusinessSaleItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BusinessSaleItems` (
  `businessSaleItemId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `barCode` varchar(50) NOT NULL,
  `status` enum('ACTIVE','INACTIVE','CHANGED','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `businessId` int NOT NULL,
  `currencyId` int NOT NULL,
  PRIMARY KEY (`businessSaleItemId`),
  KEY `fk_BusinessSaleItems_Business1_idx` (`businessId`),
  KEY `fk_BusinessSaleItems_Currencies1_idx` (`currencyId`),
  CONSTRAINT `fk_BusinessSaleItems_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_BusinessSaleItems_Currencies1` FOREIGN KEY (`currencyId`) REFERENCES `Currencies` (`currencyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BusinessSaleItems`
--

LOCK TABLES `BusinessSaleItems` WRITE;
/*!40000 ALTER TABLE `BusinessSaleItems` DISABLE KEYS */;
/*!40000 ALTER TABLE `BusinessSaleItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CategoriesPerBusiness`
--

DROP TABLE IF EXISTS `CategoriesPerBusiness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CategoriesPerBusiness` (
  `BusinessId` int NOT NULL,
  `BuisinessCategoryId` int NOT NULL,
  `status` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`BusinessId`,`BuisinessCategoryId`),
  KEY `fk_Business_has_Business_category_Business_category1_idx` (`BuisinessCategoryId`),
  KEY `fk_Business_has_Business_category_Business1_idx` (`BusinessId`),
  CONSTRAINT `fk_Business_has_Business_category_Business1` FOREIGN KEY (`BusinessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Business_has_Business_category_Business_category1` FOREIGN KEY (`BuisinessCategoryId`) REFERENCES `BusinessCategories` (`businessCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CategoriesPerBusiness`
--

LOCK TABLES `CategoriesPerBusiness` WRITE;
/*!40000 ALTER TABLE `CategoriesPerBusiness` DISABLE KEYS */;
/*!40000 ALTER TABLE `CategoriesPerBusiness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cities`
--

DROP TABLE IF EXISTS `Cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cities` (
  `cityId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `stateId` int NOT NULL,
  PRIMARY KEY (`cityId`),
  KEY `fk_cities_States1_idx` (`stateId`),
  CONSTRAINT `fk_cities_States1` FOREIGN KEY (`stateId`) REFERENCES `States` (`stateId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cities`
--

LOCK TABLES `Cities` WRITE;
/*!40000 ALTER TABLE `Cities` DISABLE KEYS */;
INSERT INTO `Cities` VALUES (1,'SAN JOSÃ‰',1),(2,'ESCAZÃš',1),(3,'SAN PEDRO',1),(4,'CARTAGO',2),(5,'PARAÃSO',2),(6,'BELÃ‰N',3),(7,'SANTO DOMINGO',3);
/*!40000 ALTER TABLE `Cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactMethodTypes`
--

DROP TABLE IF EXISTS `ContactMethodTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContactMethodTypes` (
  `contactMethodTypeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`contactMethodTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactMethodTypes`
--

LOCK TABLES `ContactMethodTypes` WRITE;
/*!40000 ALTER TABLE `ContactMethodTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactMethodTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactMethods`
--

DROP TABLE IF EXISTS `ContactMethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContactMethods` (
  `contactMethodId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `status` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `contactMethodTypeiId` int NOT NULL,
  PRIMARY KEY (`contactMethodId`),
  KEY `fk_ContactMethods_ContactMethod_types1_idx` (`contactMethodTypeiId`),
  CONSTRAINT `fk_ContactMethods_ContactMethod_types1` FOREIGN KEY (`contactMethodTypeiId`) REFERENCES `ContactMethodTypes` (`contactMethodTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactMethods`
--

LOCK TABLES `ContactMethods` WRITE;
/*!40000 ALTER TABLE `ContactMethods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactMethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactMethodsPerBusiness`
--

DROP TABLE IF EXISTS `ContactMethodsPerBusiness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContactMethodsPerBusiness` (
  `businessId` int NOT NULL,
  `contactMethodId` int NOT NULL,
  `status` enum('ACTIVE','INACTIVE','CHANGED','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`businessId`,`contactMethodId`),
  KEY `fk_Business_has_ContactMethods_ContactMethods1_idx` (`contactMethodId`),
  KEY `fk_Business_has_ContactMethods_Business1_idx` (`businessId`),
  CONSTRAINT `fk_Business_has_ContactMethods_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Business_has_ContactMethods_ContactMethods1` FOREIGN KEY (`contactMethodId`) REFERENCES `ContactMethods` (`contactMethodId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactMethodsPerBusiness`
--

LOCK TABLES `ContactMethodsPerBusiness` WRITE;
/*!40000 ALTER TABLE `ContactMethodsPerBusiness` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactMethodsPerBusiness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ContactMethodsPerUser`
--

DROP TABLE IF EXISTS `ContactMethodsPerUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ContactMethodsPerUser` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `contactMethodId` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `status` enum('ACTIVE','INACTIVE','CHANGED','ELIMINATED') NOT NULL,
  PRIMARY KEY (`userId`,`contactMethodId`),
  KEY `fk_Users_has_ContactMethods_ContactMethods1_idx` (`contactMethodId`),
  KEY `fk_Users_has_ContactMethods_Users1_idx` (`userId`),
  CONSTRAINT `fk_Users_has_ContactMethods_ContactMethods1` FOREIGN KEY (`contactMethodId`) REFERENCES `ContactMethods` (`contactMethodId`),
  CONSTRAINT `fk_Users_has_ContactMethods_Users1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ContactMethodsPerUser`
--

LOCK TABLES `ContactMethodsPerUser` WRITE;
/*!40000 ALTER TABLE `ContactMethodsPerUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `ContactMethodsPerUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contracts`
--

DROP TABLE IF EXISTS `Contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contracts` (
  `contractId` int NOT NULL AUTO_INCREMENT,
  `legalId` varchar(50) DEFAULT NULL,
  `rentAmount` float NOT NULL,
  `depositAmount` float NOT NULL COMMENT 'Pago inicial de garantÃ­a',
  `feePercentage` float NOT NULL,
  `status` enum('PENDING','ACTIVE','TERMINATED','EXPIRED') NOT NULL,
  `latePaymentPolicy` varchar(255) NOT NULL,
  `termsAndConditions` tinytext,
  `fileURL` varchar(255) NOT NULL,
  `enabled` tinyint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `rentPaymentFrequencyId` int NOT NULL,
  `currencyId` int NOT NULL,
  `adminBusinessId` int NOT NULL,
  `tenantBusinessId` int NOT NULL,
  `createdBy` int DEFAULT NULL,
  `signedBy` int DEFAULT NULL,
  PRIMARY KEY (`contractId`),
  KEY `fk_Contracts_Business1_idx` (`tenantBusinessId`),
  KEY `fk_Contracts_Business2_idx` (`adminBusinessId`),
  KEY `fk_Contracts_Users1_idx` (`signedBy`),
  KEY `fk_Contracts_Users2_idx` (`createdBy`),
  KEY `fk_Contracts_RentPaymentFrequency1_idx` (`rentPaymentFrequencyId`),
  KEY `fk_Contracts_CurrencyCodes1_idx` (`currencyId`),
  CONSTRAINT `fk_Contracts_Business1` FOREIGN KEY (`tenantBusinessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Contracts_Business2` FOREIGN KEY (`adminBusinessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Contracts_CurrencyCodes1` FOREIGN KEY (`currencyId`) REFERENCES `Currencies` (`currencyId`),
  CONSTRAINT `fk_Contracts_RentPaymentFrequency1` FOREIGN KEY (`rentPaymentFrequencyId`) REFERENCES `RentPaymentFrequencies` (`rentPaymentFrequencyId`),
  CONSTRAINT `fk_Contracts_Users1` FOREIGN KEY (`signedBy`) REFERENCES `Users` (`userId`),
  CONSTRAINT `fk_Contracts_Users2` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contracts`
--

LOCK TABLES `Contracts` WRITE;
/*!40000 ALTER TABLE `Contracts` DISABLE KEYS */;
INSERT INTO `Contracts` VALUES (1,'W912HN-01-C-0022 0034',730000,0,2.8,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo del 5% sobre pendiente por cada dÃ­a de retraso. El inquilino serÃ¡ notificado por correo y tendrÃ¡ un plazo mÃ¡ximo de 10 dÃ­as calendario para regularizar el pago antes de iniciar acciones adicionales.','El uso de las instalaciones estÃ¡ sujeto a las normasy regulaciones . El arrendatario se compromete a cumplir con todas las obligaciones de pago, mantenimiento y seguridad.','https://example.com/files/contrato_001.pdf',1,'2025-07-22 12:10:00',NULL,'2025-08-22 12:10:00','2026-08-22 12:10:00',1,1,1,4,NULL,NULL),(2,'W912HN-01-C-0022 0022',740000,0,6,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo del 5% sobre pendiente por cada dÃ­a de retraso. El inquilino serÃ¡ notificado por correo y tendrÃ¡ un plazo mÃ¡ximo de 10 dÃ­as calendario para regularizar el pago antes de iniciar acciones adicionales.','El uso de las instalaciones estÃ¡ sujeto a las normasy regulaciones . El arrendatario se compromete a cumplir con todas las obligaciones de pago, mantenimiento y seguridad.','https://example.com/files/contrato_002.pdf',1,'2025-03-22 12:10:00',NULL,'2025-04-22 12:10:00','2026-04-22 12:10:00',1,1,1,3,NULL,NULL),(3,'W912HN-01-C-0025 0567',720000,0,6.6,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo del 5% sobre pendiente por cada dÃ­a de retraso. El inquilino serÃ¡ notificado por correo y tendrÃ¡ un plazo mÃ¡ximo de 10 dÃ­as calendario para regularizar el pago antes de iniciar acciones adicionales.','El uso de las instalaciones estÃ¡ sujeto a las normasy regulaciones . El arrendatario se compromete a cumplir con todas las obligaciones de pago, mantenimiento y seguridad.','https://example.com/files/contrato_003.pdf',1,'2024-12-22 12:10:00',NULL,'2025-01-22 12:10:00','2026-01-22 12:10:00',1,1,1,5,NULL,NULL),(4,'W912HN-01-C-0021 1111',735000,0,4,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo del 5% sobre pendiente por cada dÃ­a de retraso. El inquilino serÃ¡ notificado por correo y tendrÃ¡ un plazo mÃ¡ximo de 10 dÃ­as calendario para regularizar el pago antes de iniciar acciones adicionales.','El uso de las instalaciones estÃ¡ sujeto a las normasy regulaciones . El arrendatario se compromete a cumplir con todas las obligaciones de pago, mantenimiento y seguridad.','https://example.com/files/contrato_004.pdf',1,'2024-10-22 12:10:00',NULL,'2025-02-22 12:10:00','2026-02-22 12:10:00',1,1,1,6,NULL,NULL),(5,'CR-2025-001-A 2024',550000,0,5,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo fijo de â‚¡15,000 por cada semana de mora.','El arrendatario deberÃ¡ mantener limpio el local y cumplir con horarios establecidos por la administraciÃ³n.','https://storage.mysite.com/docs/contrato_004.pdf',1,'2025-01-05 10:00:00',NULL,'2025-02-01 00:00:00','2026-02-01 00:00:00',1,1,10,11,NULL,NULL),(6,'CR-2025-002-B 3425',800000,0,7.5,'ACTIVE','El atraso en el pago generarÃ¡ un recargo del 3% mensual sobre el monto pendiente.','El arrendatario se compromete a no modificar la infraestructura sin autorizaciÃ³n expresa.','https://cdn.example.org/uploads/contrato_005.pdf',1,'2025-02-10 09:30:00',NULL,'2025-03-01 00:00:00','2026-03-01 00:00:00',1,1,10,7,NULL,NULL),(7,'CR-2025-003-C 2356',650000,0,6,'ACTIVE','Por cada dÃ­a de atraso se cobrarÃ¡ un recargo del 2% sobre el monto mensual.','El arrendatario deberÃ¡ respetar las normas de seguridad e higiene del mercado.','https://fileserver.local/files/contrato_006.pdf',1,'2025-03-15 15:45:00',NULL,'2025-04-01 00:00:00','2026-04-01 00:00:00',1,1,10,8,NULL,NULL),(8,'CR-2025-004-D 2355',900000,0,8,'ACTIVE','En caso de atraso mayor a 15 dÃ­as, la administraciÃ³n podrÃ¡ suspender el servicio elÃ©ctrico del local.','El arrendatario estÃ¡ obligado a pagar puntualmente y mantener un ambiente seguro para clientes.','https://example.com/files/contrato_007.pdf',1,'2025-04-20 11:20:00',NULL,'2025-05-01 00:00:00','2026-05-01 00:00:00',1,1,10,9,NULL,NULL),(9,'CR-2025-005-E 2353',480000,0,5.5,'ACTIVE','En caso de retraso de pago, se aplicarÃ¡ un recargo del 2% por cada dÃ­a calendario vencido.','El arrendatario deberÃ¡ mantener el local en condiciones de higiene adecuadas.','https://example.com/files/contrato_012.pdf',1,'2025-01-12 09:00:00',NULL,'2025-02-01 00:00:00','2026-02-01 00:00:00',1,1,2,12,NULL,NULL),(10,'CR-2025-006-F 5555',520000,0,6,'ACTIVE','El atraso en el pago generarÃ¡ un recargo fijo de â‚¡10,000 por semana de mora.','El arrendatario no podrÃ¡ realizar modificaciones estructurales sin autorizaciÃ³n previa.','https://storage.mysite.com/docs/contrato_013.pdf',1,'2025-02-01 14:30:00',NULL,'2025-03-01 00:00:00','2026-03-01 00:00:00',1,1,2,13,NULL,NULL),(11,'CR-2025-007-G 7567',600000,0,7,'ACTIVE','En caso de retraso mayor a 10 dÃ­as, la administraciÃ³n podrÃ¡ suspender temporalmente el servicio elÃ©ctrico.','El arrendatario deberÃ¡ respetar las normas de convivencia establecidas.','https://cdn.example.org/uploads/contrato_014.pdf',1,'2025-02-20 11:15:00',NULL,'2025-04-01 00:00:00','2026-04-01 00:00:00',1,1,2,14,NULL,NULL),(12,'CR-2025-008-H 1111',700000,0,7.5,'ACTIVE','Por cada dÃ­a de atraso se cobrarÃ¡ un 3% adicional sobre el monto mensual.','El arrendatario deberÃ¡ cumplir con el horario de apertura y cierre definido por la administraciÃ³n.','https://fileserver.local/files/contrato_015.pdf',1,'2025-03-10 08:20:00',NULL,'2025-05-01 00:00:00','2026-05-01 00:00:00',1,1,2,15,NULL,NULL),(13,'CR-2025-009-I 8999',750000,0,8,'ACTIVE','El incumplimiento en los pagos por mÃ¡s de 30 dÃ­as darÃ¡ lugar a la rescisiÃ³n automÃ¡tica del contrato.','El arrendatario estÃ¡ obligado a mantener libre de deudas los servicios bÃ¡sicos del local.','https://example.com/files/contrato_016.pdf',1,'2025-04-05 10:45:00',NULL,'2025-06-01 00:00:00','2026-06-01 00:00:00',1,1,2,16,NULL,NULL);
/*!40000 ALTER TABLE `Contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Countries` (
  `countryId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`countryId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Countries`
--

LOCK TABLES `Countries` WRITE;
/*!40000 ALTER TABLE `Countries` DISABLE KEYS */;
INSERT INTO `Countries` VALUES (1,'COSTA RICA'),(2,'PANAMÃ'),(3,'NICARAGUA');
/*!40000 ALTER TABLE `Countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Currencies`
--

DROP TABLE IF EXISTS `Currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Currencies` (
  `currencyId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `code` varchar(4) NOT NULL,
  `symbol` varchar(2) NOT NULL,
  PRIMARY KEY (`currencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Currencies`
--

LOCK TABLES `Currencies` WRITE;
/*!40000 ALTER TABLE `Currencies` DISABLE KEYS */;
INSERT INTO `Currencies` VALUES (1,'ColÃ³n costarricense','CRC','â‚¡'),(2,'Dolar estadounidense','USD','$'),(3,'Euro','EUR','â‚¬');
/*!40000 ALTER TABLE `Currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `InventoryId` int NOT NULL AUTO_INCREMENT,
  `status` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `quantity` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `contractId` int NOT NULL,
  `businessProductId` int NOT NULL,
  PRIMARY KEY (`InventoryId`),
  KEY `fk_Inventory_Contracts1_idx` (`contractId`),
  KEY `fk_Inventory_BusinessProducts1_idx` (`businessProductId`),
  CONSTRAINT `fk_Inventory_BusinessProducts1` FOREIGN KEY (`businessProductId`) REFERENCES `BusinessProducts` (`businessProductId`),
  CONSTRAINT `fk_Inventory_Contracts1` FOREIGN KEY (`contractId`) REFERENCES `Contracts` (`contractId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES (1,'ACTIVE',25,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,5,1),(2,'ACTIVE',65,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,5,2),(3,'ACTIVE',43,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,5,3),(4,'ACTIVE',45,'2025-09-30 18:31:54','2025-09-30 18:33:09',1,5,4),(5,'ACTIVE',52,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,5,5),(6,'ACTIVE',262,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,7,6),(7,'ACTIVE',225,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,7,7),(8,'ACTIVE',277,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,7,8),(9,'ACTIVE',289,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,7,9),(10,'ACTIVE',200,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,7,10),(11,'ACTIVE',494,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,8,11),(12,'ACTIVE',296,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,8,12),(13,'ACTIVE',372,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,8,13),(14,'ACTIVE',386,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,8,14),(15,'ACTIVE',518,'2025-09-30 18:31:54','2025-09-30 18:31:55',1,8,15);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InventoryLogTypes`
--

DROP TABLE IF EXISTS `InventoryLogTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryLogTypes` (
  `InventoryLogTypeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`InventoryLogTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InventoryLogTypes`
--

LOCK TABLES `InventoryLogTypes` WRITE;
/*!40000 ALTER TABLE `InventoryLogTypes` DISABLE KEYS */;
INSERT INTO `InventoryLogTypes` VALUES (1,'VENTA_NORMAL'),(2,'VENTA_MAYORISTA'),(3,'COMPRA_PROVEEDOR'),(4,'AJUSTE_INVENTARIO');
/*!40000 ALTER TABLE `InventoryLogTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InventoryLogs`
--

DROP TABLE IF EXISTS `InventoryLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InventoryLogs` (
  `InventoryLogId` int NOT NULL AUTO_INCREMENT,
  `changeQuantity` int NOT NULL,
  `changeType` enum('SALE','PURCHASE','ASJUSTMENT','TRANSFER') NOT NULL,
  `InventoryLogTypeId` int NOT NULL,
  `InventoryId` int NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `createdAt` datetime NOT NULL,
  PRIMARY KEY (`InventoryLogId`),
  KEY `fk_InventoryLogs_InventoryLogTypes1_idx` (`InventoryLogTypeId`),
  KEY `fk_InventoryLogs_Inventory1_idx` (`InventoryId`),
  CONSTRAINT `fk_InventoryLogs_Inventory1` FOREIGN KEY (`InventoryId`) REFERENCES `Inventory` (`InventoryId`),
  CONSTRAINT `fk_InventoryLogs_InventoryLogTypes1` FOREIGN KEY (`InventoryLogTypeId`) REFERENCES `InventoryLogTypes` (`InventoryLogTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InventoryLogs`
--

LOCK TABLES `InventoryLogs` WRITE;
/*!40000 ALTER TABLE `InventoryLogs` DISABLE KEYS */;
INSERT INTO `InventoryLogs` VALUES (1,-3,'SALE',1,7,'fa405b626934edf2ccd7bc71a43fcca0','2025-08-23 18:57:30'),(2,-5,'SALE',1,13,'c0b054a86b8d592f1d285402b08d9c6d','2025-08-15 11:14:47'),(3,-5,'SALE',1,7,'330157f2eb3ff724056e7b9f7f0c3017','2025-09-04 16:48:01'),(4,-3,'SALE',1,5,'ac6216062f6c03efd26008e6f3e955ec','2025-07-15 08:48:02'),(5,-10,'SALE',1,6,'430e90fe6a8e62d337ed2e5e5f041eea','2025-07-11 12:43:00'),(6,-5,'SALE',1,10,'655b6d776a480846457f8a2a2b8b9bf4','2025-08-22 05:13:23'),(7,-2,'SALE',1,3,'48cfd16d274d1d5ad2468cc21ae4e209','2025-06-29 13:37:23'),(8,-1,'SALE',1,3,'e697910276bc02edeb026566acfd1f19','2025-06-21 02:01:46'),(9,-1,'SALE',1,2,'7d7a698a4289cf0a18db75160840d2d8','2025-06-09 21:47:14'),(10,-3,'SALE',1,1,'0dba319b553d15b50f2b5bbfead37ad6','2025-08-22 20:27:41'),(11,-4,'SALE',1,10,'1df0052187c33d2df87e59a4733397ac','2025-08-27 12:45:14'),(12,-3,'SALE',1,4,'fad4b2bad66b74e8ae413a970dd02548','2025-06-10 05:24:18'),(13,-1,'SALE',1,1,'89ff80aeeaa987d2f9900cfab522bc50','2025-09-26 03:41:02'),(14,-7,'SALE',1,6,'bcf6a610022fd15848f564aaa5a3c3ac','2025-07-11 12:38:38'),(15,-5,'SALE',1,6,'f824d95998b0fcaac9c2fe3be08757ca','2025-09-30 15:15:20'),(16,-6,'SALE',1,13,'00d3d791a1c38496e035b1e78988a4a0','2025-07-10 17:45:33'),(17,-8,'SALE',1,10,'68b1bb2319645bba380927e5c1c73b06','2025-08-23 08:46:50'),(18,-4,'SALE',1,15,'54e62b18d6cc45fa215de3396ad04cb1','2025-07-12 05:05:45'),(19,-4,'SALE',1,8,'f9ae2d25f0d65136d920b3b2b1543533','2025-09-02 02:52:06'),(20,-1,'SALE',1,4,'0fcf972a36abf6d9ad5c6b421a0424aa','2025-08-15 14:04:24'),(21,-2,'SALE',1,9,'ee566b61e4ac2cc1cfb69fa2872d3e13','2025-08-15 11:22:23'),(22,-1,'SALE',1,4,'aef3eb7cb277257589117ecb49b335da','2025-09-06 02:56:24'),(23,-2,'SALE',1,12,'af82246bc6f56696e6c1401c18afbfcc','2025-07-23 10:28:05'),(24,-3,'SALE',1,6,'41ef64428883b7a94abc20797c2e7eeb','2025-09-14 21:19:48'),(25,-8,'SALE',1,8,'cf47596556ce6bc215112187c89eb27e','2025-07-23 15:32:46'),(26,-10,'SALE',1,7,'ffb248d4ecd47c74255d4245ab149842','2025-06-08 17:58:39'),(27,-4,'SALE',1,14,'98c69ae13f6def69e5295fd1de971173','2025-08-28 05:22:08'),(28,-2,'SALE',1,14,'25ac2ace42a664df51eca55df3d0d642','2025-07-12 20:29:45'),(29,-2,'SALE',1,2,'e16dc776930c4822b09e2e9913e88032','2025-07-11 03:40:57'),(30,-4,'SALE',1,7,'0e01039c3f4cb75aca34159a249dbc20','2025-09-03 05:31:53'),(31,-8,'SALE',1,10,'c073e528f10e3ff4d1e119aa688e3b45','2025-07-01 12:27:40'),(32,-5,'SALE',1,12,'df4263b7fc0a84269c9f6379cf85c79a','2025-06-28 12:20:04'),(33,-7,'SALE',1,14,'4cc6e5a4301a37b3e9bce628e72dfcb1','2025-07-18 03:54:07'),(34,-3,'SALE',1,5,'463cd431886dd7682235f991bd7bc376','2025-06-24 16:07:30'),(35,-4,'SALE',1,12,'4471c3cda04fa2fbce5522c52d7de000','2025-07-01 16:24:51'),(36,-8,'SALE',1,13,'b443abc1fb770f5d1bd089640bb0acfb','2025-08-09 21:16:37'),(37,-1,'SALE',1,6,'989bb56dc9b036f209fe883d9bc37673','2025-06-06 16:45:38'),(38,-2,'SALE',1,14,'4ae2e4e308ec07d2b05c2d1783c0cc1f','2025-08-04 01:54:22'),(39,-1,'SALE',1,11,'0e51222be6b184b030267f901dd6c9f1','2025-09-11 14:41:35'),(40,-1,'SALE',1,1,'a041833eaefa4b468711912d81c1f46f','2025-09-20 06:03:31'),(41,-2,'SALE',1,1,'888bd22792961f355128109815893116','2025-08-14 09:46:44'),(42,-3,'SALE',1,4,'2028159eab9dbc517d5787a64ea15bdc','2025-06-06 08:55:33'),(43,-2,'SALE',1,14,'ce12469507ef9c885f6af9ac980c6fcb','2025-06-29 09:42:24'),(44,-2,'SALE',1,4,'63e862c7e3e2cf853d0c305ed90f0066','2025-07-17 08:03:10'),(45,-9,'SALE',1,11,'572c790a447433ac5e297fd06ba4197c','2025-09-20 22:35:03'),(46,-3,'SALE',1,12,'d26ee284c9fb153bea4282af47e31446','2025-06-04 07:36:07'),(47,-1,'SALE',1,2,'2f4ef1732dea49727d0a697b4fe4ce18','2025-07-09 00:03:13'),(48,-1,'SALE',1,9,'6a0994ff77be46a42deac70048e8130e','2025-07-24 17:03:02'),(49,-4,'SALE',1,10,'7d9ba27489b84221c55acddc0d10d295','2025-08-30 08:07:28'),(50,-1,'SALE',1,10,'529f35d30565195bdd6ef6d240b13151','2025-07-03 14:55:48'),(51,-3,'SALE',1,1,'56ac5919f176146920eb59c0a50f0fe4','2025-07-27 22:15:20'),(52,-2,'SALE',1,9,'2f2618d202565fc3ae130a37140162c8','2025-07-05 03:33:24'),(53,-1,'SALE',1,5,'621ac0d3b8d03627336e85aca052e8ac','2025-07-05 01:03:07'),(54,-9,'SALE',1,14,'a508bc2b6c8fcf08cc99eb79b94e026d','2025-08-30 14:27:21'),(55,-1,'SALE',1,5,'7a38b1f91eb966de7b1c6ac23697688c','2025-07-06 02:18:15'),(56,-1,'SALE',1,3,'0e14ca9bd0eaef84921bc42a7c0188c5','2025-08-03 01:45:39'),(57,-10,'SALE',1,8,'62b593c6f803ec47288ff1b8258eab49','2025-06-15 12:57:14'),(58,-7,'SALE',1,12,'198a2891efd044f4549686e969118336','2025-06-03 04:56:12'),(59,-3,'SALE',1,4,'0a8af7447e5c666eefe80721d02ae6d1','2025-08-13 21:22:10'),(60,-2,'SALE',1,7,'7a801df398f7e679811c7a10694577ab','2025-08-02 20:55:03'),(61,-4,'SALE',1,9,'e4903300c4137d10549ccf327b16a198','2025-07-31 12:07:02'),(62,-2,'SALE',1,5,'2c0428921e61279721f60d0874652e1d','2025-08-09 16:11:50'),(63,-1,'SALE',1,7,'ea23af4323644adcf6c5ab7461496172','2025-06-10 15:32:41'),(64,-3,'SALE',1,2,'abeb07e2c11be242489e325def273f66','2025-09-12 04:26:39'),(65,-1,'SALE',1,4,'a80fd9741c181472b9edc1ff91db4f00','2025-09-05 15:49:05'),(66,-2,'SALE',1,13,'5c517a794201d0cb6492a8cf00f0a408','2025-06-20 17:08:30'),(67,-2,'SALE',1,2,'c66634a8e3da4f4c9cc591e8187a9cef','2025-07-14 11:32:12'),(68,-6,'SALE',1,13,'e95cebda76e7f966096771ea87872f5b','2025-07-02 00:50:13'),(69,-1,'SALE',1,3,'9c99694e838110b5b3c661ab502e51ab','2025-09-15 10:49:52'),(70,-6,'SALE',1,6,'d36ea03890fc48b7489ae1f4ffe78ada','2025-08-04 18:35:35'),(71,-10,'SALE',1,13,'04cd2c5282b99694a70aa3a64b70a64c','2025-06-23 05:38:34'),(72,-1,'SALE',1,15,'0bfebefd74aed3b634b73c12621fd78c','2025-09-02 21:54:50'),(73,-1,'SALE',1,2,'97013e2887dcfcb07d2a7499da8d977d','2025-06-23 13:25:25'),(74,-5,'SALE',1,15,'7dc8abab6728ed3d15905732ea3d96fc','2025-07-02 09:47:44'),(75,-1,'SALE',1,2,'017a2524e846dfdacd99da7411f10607','2025-07-11 20:30:48'),(76,-4,'SALE',1,12,'94589e013a08162f9673fcd0ef77383a','2025-08-06 08:21:46'),(77,-6,'SALE',1,13,'9d03700e9c50d7a629eeda39d8c6ba0c','2025-09-03 15:33:50'),(78,-5,'SALE',1,10,'6944abf5bab24ffd043d185de55f8e16','2025-08-09 16:20:31'),(79,-7,'SALE',1,15,'7e56e7802fc589676dfc691ef31cd88a','2025-07-04 18:52:01'),(80,-1,'SALE',1,1,'8e87867949513f9c07a9ef2efd689d15','2025-08-09 18:43:15'),(81,-2,'SALE',1,5,'042ab374446d356ac3d1e19626f279f9','2025-07-08 07:33:50'),(82,-8,'SALE',1,8,'3f8f9dae81562e522d2f626c8df1b09f','2025-08-01 08:14:09'),(83,-6,'SALE',1,14,'bb305a14441b020787118c2bd34f58a7','2025-06-17 14:25:17'),(84,-1,'SALE',1,4,'cd72bc12d9831409594af3de3f6a1ae2','2025-07-18 16:39:12'),(85,-3,'SALE',1,15,'54684c0dc824a9fa21919ea959a00f44','2025-08-19 20:22:12'),(86,-4,'SALE',1,11,'23a241c72433ab8b462aaf8d7ee77a16','2025-08-09 05:50:34'),(87,-4,'SALE',1,7,'c23d284e5734b1352c26fe0e31e06955','2025-07-07 10:10:29'),(88,-1,'SALE',1,3,'0f1fb7139b1518686f15bff441d5ba42','2025-06-24 11:03:47'),(89,-1,'SALE',1,9,'784df65e88ec80b453ef3f4d88b45fe0','2025-08-19 12:43:57'),(90,-8,'SALE',1,14,'7074ced4278bd5f486119a715dab05e4','2025-06-26 15:02:07'),(91,-2,'SALE',1,9,'d47635336c4c3e860e85ff57e51c3de9','2025-08-19 06:22:00'),(92,-10,'SALE',1,14,'f2893996affa11b107a9e40febefc826','2025-08-12 05:51:42'),(93,-1,'SALE',1,7,'8e2f3d1dce495b8d630e6485ca04baf8','2025-09-07 16:54:28'),(94,-3,'SALE',1,4,'35b38c7ea7c508acd0341f98ea746dcc','2025-08-11 08:39:10'),(95,-9,'SALE',1,7,'1676a84a84fafcbbfbe4f2a6bd3c380e','2025-07-01 09:45:34'),(96,-3,'SALE',1,11,'bf50b78df759e16ab22df2ebfcc71b2c','2025-08-25 15:31:37'),(97,-1,'SALE',1,1,'a372e5175c08ffb6d91138aa126f9ab6','2025-07-11 22:45:56'),(98,-3,'SALE',1,13,'052e305fa404580c7d2aa7da9806bcb2','2025-09-05 07:54:39'),(99,-3,'SALE',1,13,'06c7f779efd876fa1379f7a1336636d0','2025-08-29 12:53:51'),(100,-3,'SALE',1,3,'7e843228d27d3c6fd57dc0024d910ec6','2025-07-20 12:50:41'),(101,-9,'SALE',1,9,'5c4d20a01759d08963de37ab196317a1','2025-08-14 07:20:46'),(102,-2,'SALE',1,5,'47f905b98b134e73aaa8e8c364bb6ec8','2025-08-26 00:13:02'),(103,-3,'SALE',1,5,'410c18161d544e58f0b719c84f038cd1','2025-08-15 12:36:24'),(104,-2,'SALE',1,1,'b945dfe94d3aee39cac56788f54a1626','2025-07-28 14:34:00'),(105,-3,'SALE',1,1,'5ad9e9bca618b44a480a0bc1f95eb504','2025-08-15 05:06:46'),(106,-6,'SALE',1,12,'8a781499ddd5125ebe027fb2a17f8dd4','2025-07-28 21:05:36'),(107,-7,'SALE',1,6,'ee96839dde705330fb1e58ee0c77b5f9','2025-06-13 12:00:21'),(108,-2,'SALE',1,9,'116cb86e1cc12d554d355fa1945d28d5','2025-08-23 06:25:17'),(109,-3,'SALE',1,15,'0d81277520181969fe44010dc9543e85','2025-09-29 08:47:54'),(110,-1,'SALE',1,5,'5a516abc0ea5a99cecbe20c74ca346fc','2025-09-18 18:37:46'),(111,-5,'SALE',1,12,'940c0f0b8887fcd79428390bca99a803','2025-09-04 17:07:19'),(112,-2,'SALE',1,13,'be09ce26e4c38904a059e5e08133c573','2025-08-23 03:43:17'),(113,-3,'SALE',1,15,'7d080de5c231183f08623a64dd56c9a3','2025-08-05 10:52:04'),(114,-3,'SALE',1,8,'f0abe5e170d7901fd72f921d11e6dc6b','2025-06-05 06:26:22'),(115,-7,'SALE',1,6,'6812548f1c5aeea1eeb96778b90e8263','2025-06-03 04:52:52'),(116,-3,'SALE',1,4,'44dc0905c5dbcc8fbf857fdb2e067247','2025-09-22 11:21:16'),(117,-3,'SALE',1,10,'8cd89bdbda747d78eb7a3a9aad11163f','2025-09-13 22:27:23'),(118,-6,'SALE',1,10,'3eb6a8d31c9377c5a5496c385204a8b7','2025-06-08 22:55:48'),(119,-2,'SALE',1,5,'b506b9727e1013ecd94cca602cd0fed3','2025-07-06 22:43:44'),(120,-10,'SALE',1,14,'e804edd4580fdce3f257e86eb99c6900','2025-08-16 00:57:48'),(121,-4,'SALE',1,9,'dc32614d2ff819213946c1adb2264528','2025-06-28 18:42:09'),(122,-3,'SALE',1,15,'34827e7bbf98644b25705de7b3be9041','2025-09-28 10:09:28'),(123,-9,'SALE',1,9,'9e92b749025629d5303d3e494f803082','2025-09-29 13:53:45'),(124,-2,'SALE',1,5,'e0aec94ae14e76661552151a61459dd1','2025-08-07 05:55:54'),(125,-2,'SALE',1,5,'92c6a8f0065305a66631fb7095c9b36d','2025-07-04 12:33:10'),(126,-5,'SALE',1,13,'c0b054a86b8d592f1d285402b08d9c6d','2025-08-15 11:19:09'),(127,-1,'SALE',1,12,'21eb3b0c2bee9b54a7182e9fbdd88d50','2025-06-05 19:14:43'),(128,-2,'SALE',1,5,'77b20d0f417d2c84696a0fcce291478f','2025-07-17 11:32:15'),(129,-3,'SALE',1,14,'a157fe10047dad67b43227017580a10f','2025-09-28 09:56:31'),(130,-3,'SALE',1,8,'1bd61676f5854d47c035c36aec7d392c','2025-09-29 09:06:14'),(131,-9,'SALE',1,7,'7949df47c16739c4d806b5741ecd0bd8','2025-08-30 16:51:10'),(132,-1,'SALE',1,3,'4e8f884147fd2c776f69cfae22cb16fd','2025-06-27 11:02:43'),(133,-8,'SALE',1,10,'1c83b13c989314ebe7e7f5efcb53c5a4','2025-06-21 19:46:19'),(134,-3,'SALE',1,12,'0d5fb65241e8436548d35dcc4d5311a4','2025-07-08 16:33:36'),(135,-1,'SALE',1,5,'0a069fd77688f626d40c4915f84383b8','2025-07-19 01:28:13'),(136,-2,'SALE',1,4,'74a5e47545964c0a406f71f0d49b5079','2025-09-19 01:07:23'),(137,-3,'SALE',1,1,'96421896f3619bf83a31c1e72a7a9b9e','2025-07-30 17:20:21'),(138,-2,'SALE',1,3,'23b9158a760d474ff095e523d75c563f','2025-09-24 09:56:30'),(139,-3,'SALE',1,1,'3492ba641ee8c504a08ece5817f75e24','2025-07-10 03:41:03'),(140,-1,'SALE',1,5,'f327777693b2d7334fc4b5785fed1492','2025-08-17 14:58:05'),(141,-2,'SALE',1,1,'9828cbbf6bb30cf35085985b487b07e9','2025-06-18 07:07:36'),(142,-4,'SALE',1,11,'29f8bd81e4d374522a7ed4dee27f0767','2025-08-24 14:08:50'),(143,-7,'SALE',1,12,'c62bb7a37130385981eedc0c3e4d932b','2025-09-18 13:35:15'),(144,-1,'SALE',1,4,'f86e0689a3ef24527197be706077df85','2025-08-17 20:19:57'),(145,-2,'SALE',1,2,'606e4979302e1f05848d1309a965a50a','2025-09-15 15:04:15'),(146,-9,'SALE',1,11,'494e19cd14ec0bf40bb018c1e21023f7','2025-09-22 19:04:48'),(147,-1,'SALE',1,3,'6ba546c7839c96f394e0619155d9de58','2025-08-02 20:51:45'),(148,-9,'SALE',1,7,'32ac20b5cccabb70158202bbdb138ae7','2025-06-15 01:43:23'),(149,-2,'SALE',1,1,'d9376f42e52bbe626aaf13ddbfd4288b','2025-07-22 00:25:01'),(150,-3,'SALE',1,4,'f50a4b848e671a02d6c697d6acdf1393','2025-08-16 16:23:52'),(151,-7,'SALE',1,14,'9105660a2b4bc2535cce06b0516775ec','2025-09-13 19:46:24'),(152,-7,'SALE',1,7,'c194819ef18ffa8f6cd1e0156a622410','2025-09-16 14:47:06'),(153,-1,'SALE',1,10,'eed0c942efd499f113721c1d4e770a43','2025-07-02 16:23:45'),(154,-8,'SALE',1,14,'30d19712abb7419faa1195cb7bb68ace','2025-07-11 04:53:56'),(155,-1,'SALE',1,4,'756e751e4e7a7ca23f7dfee063f55d7d','2025-08-30 11:47:28'),(156,-6,'SALE',1,12,'7293d1dd5b689f11319b051ec792846a','2025-07-10 15:17:25'),(157,-8,'SALE',1,8,'8be521da4fabfc38c3d66ba98447efc0','2025-07-20 17:01:50'),(158,-2,'SALE',1,1,'c426feee948f4cdbb091e46e00ac7c91','2025-06-21 11:53:03'),(159,-7,'SALE',1,15,'1c7e6749a035acac3df184922203fa49','2025-09-26 03:40:56'),(160,-3,'SALE',1,14,'dfd4f3fca5b7b4e1a30acdd2e9dcb6c6','2025-06-13 22:08:46'),(161,-1,'SALE',1,5,'c0a2d92f4499055ba15722f138407c30','2025-09-22 15:14:09'),(162,-2,'SALE',1,1,'a5fb83cb97a91bb0f35939ba824ee698','2025-08-15 19:10:14'),(163,-2,'SALE',1,4,'66ec37b9e19468fd7fc1d9508106ddaf','2025-08-20 16:32:37'),(164,-1,'SALE',1,5,'597616ed54130d0080801a28d6ef3a2c','2025-09-01 19:28:51'),(165,-1,'SALE',1,5,'49c514a774f658ed46fbfe167c82b4a0','2025-08-11 19:56:16'),(166,-5,'SALE',1,7,'d5c42502b56693ea1ba3f883b46d7975','2025-08-19 06:22:02'),(167,-1,'SALE',1,10,'3964a5e47162d83ea1c33f8fa426ca76','2025-06-11 12:53:55'),(168,-2,'SALE',1,3,'48cfd16d274d1d5ad2468cc21ae4e209','2025-06-29 03:28:55'),(169,-3,'SALE',1,14,'4a896d1cb9205c1af8e92a1bb48c08d5','2025-07-05 00:54:33'),(170,-1,'SALE',1,3,'0d4ee54ea714b17aa5ae4dcd4d02674b','2025-09-12 10:43:23'),(171,-10,'SALE',1,14,'67cefaa8d7cfa43dea2c21738f5eb5fb','2025-07-25 00:27:14'),(172,-7,'SALE',1,6,'1f8bf901f986ea712b98b94af27c0625','2025-08-10 00:52:21'),(173,-5,'SALE',1,11,'d4cc57bc881d6d0bf2defc48fd66dbd8','2025-09-10 12:08:08'),(174,-7,'SALE',1,14,'82bb1dfbbd0e8ba3498c28d70ba12285','2025-06-11 15:34:51'),(175,-1,'SALE',1,13,'ae2abadfa1178cd24beb17dd8e9d6aeb','2025-09-25 04:43:10'),(176,-5,'SALE',1,13,'f3a32df1c588aba8f1f859c041d66050','2025-06-07 12:50:38'),(177,-2,'SALE',1,4,'de6bd56d98b3ca3511ef1eaa9d0b49fb','2025-09-06 12:09:07'),(178,-5,'SALE',1,15,'bb0ad78a585de926c1f68b07bb32daeb','2025-09-22 21:26:27'),(179,-5,'SALE',1,10,'4ed56357daa7984e9421e2e5b57067b1','2025-09-23 00:58:51'),(180,-9,'SALE',1,15,'d1b132e8050c38b99e5f7a4eaf6677fe','2025-06-13 02:42:17'),(181,-5,'SALE',1,13,'da2f0fe6e33533d7a107132bb1f948a2','2025-07-14 22:56:49'),(182,-3,'SALE',1,9,'243d201ebacfff749b055eb068d42418','2025-07-20 07:45:54'),(183,-9,'SALE',1,15,'250a22d773d73461410f85d27197830b','2025-08-16 04:52:47'),(184,-1,'SALE',1,5,'f91383160a0a8cb4a86b1acda0f0952a','2025-08-21 16:34:44'),(185,-6,'SALE',1,6,'991d225d09bedb5264e806b1b335d2f8','2025-08-13 11:15:49'),(186,-9,'SALE',1,11,'2106a1400c4b9ad1ea1ad5af87b991e4','2025-09-04 13:14:28'),(187,-3,'SALE',1,3,'a66fee9fb1f8cbd4c2d4eaec6ba27ece','2025-06-27 15:53:31'),(188,-3,'SALE',1,12,'b4ffd073294e894d9f1c7a7dbeb780c2','2025-09-28 11:26:42'),(189,-2,'SALE',1,3,'bee97546485478899c7f3c13e34fc923','2025-06-20 02:54:19'),(190,-2,'SALE',1,9,'416d085fd631a9929af0ab2e21ce3102','2025-08-06 21:17:38'),(191,-6,'SALE',1,8,'95c6239a031f5cce19a4f6baed159bf8','2025-06-16 15:38:16'),(192,-1,'SALE',1,2,'c3867785fa4fe17b92fb8ca56b140ca1','2025-09-15 21:11:15'),(193,-9,'SALE',1,11,'572c790a447433ac5e297fd06ba4197c','2025-09-20 21:29:36'),(194,-1,'SALE',1,1,'091b72ea69cccbfbbf585d8dcba2d995','2025-08-07 06:08:48'),(195,-7,'SALE',1,14,'d2e70c6ba80b1d6828a8ecc5301b1363','2025-09-27 06:19:45'),(196,-7,'SALE',1,10,'fc279b6b42d415d00b1b1f63513132a5','2025-08-22 13:53:47'),(197,-1,'SALE',1,2,'6f46d4d53e45db455c79f59dcce1c982','2025-08-17 00:03:10'),(198,-2,'SALE',1,15,'ff47bfe8cf6edbe5e5a7a582327bd7fd','2025-07-25 06:46:02'),(199,-3,'SALE',1,4,'3a9a526658677b075ccf9dc7030e50b1','2025-09-23 17:37:52'),(200,-5,'SALE',1,7,'2dd609b97506c74fbd73c3579c7a03f1','2025-09-12 10:52:02'),(201,-1,'SALE',1,15,'e4f6f8e545152c63ebf38266628871ca','2025-06-14 08:10:46'),(202,-2,'SALE',1,10,'b56fdf58ffd355bb563afdc4f43d183d','2025-09-10 08:23:49'),(203,-1,'SALE',1,5,'5a516abc0ea5a99cecbe20c74ca346fc','2025-09-18 19:57:17'),(204,-5,'SALE',1,6,'74c0f17c38bbae7bd0ab472ffa30067d','2025-07-07 07:35:55'),(205,-1,'SALE',1,1,'12614fa2922b191a832e08a89a868e8b','2025-06-24 13:24:19'),(206,-2,'SALE',1,5,'537ef8e5c702100fcfb8171a0e6abe62','2025-09-08 13:22:06'),(207,-3,'SALE',1,3,'effd775022df4a38bd881c8bd216837c','2025-08-20 03:35:37'),(208,-3,'SALE',1,1,'9b16cabafc089a9fcdf5bf63d238a454','2025-07-19 03:48:40'),(209,-5,'SALE',1,9,'5dec30050d72e97317ad8ad0d5e75b24','2025-08-19 06:17:41'),(210,-1,'SALE',1,1,'943da1d658a46ef47e47bc364945e1f6','2025-08-20 09:56:32'),(211,-5,'SALE',1,11,'c1fe43766cf6ee7c38ee4af2a7ed194d','2025-09-22 02:21:25'),(212,-1,'SALE',1,10,'b7e17fb93e9806c8a8d64e37a571edbb','2025-09-14 10:54:14'),(213,-5,'SALE',1,12,'56c57256b394708be882b8ced36703da','2025-07-13 22:52:28'),(214,-1,'SALE',1,15,'e7a8e3437165dae58528850488c5e7da','2025-07-16 03:51:50'),(215,-4,'SALE',1,10,'0cd82c13af9c91ebaef9275f5356bebb','2025-08-10 01:57:40'),(216,-4,'SALE',1,6,'c47880590025bf7695c7b7dd6a983437','2025-07-16 04:04:44'),(217,-8,'SALE',1,15,'2b71d5f665c03fcbc0953bc0e360f224','2025-07-28 12:08:02'),(218,-1,'SALE',1,4,'56962e925fe5b2d766e4345524c16a80','2025-09-26 12:36:26'),(219,-6,'SALE',1,8,'f662df023b157c7d2fe1957932660963','2025-06-11 20:37:32'),(220,-10,'SALE',1,6,'877ace8e7ddc8678102f12251274a480','2025-06-22 05:44:02'),(221,-3,'SALE',1,10,'9452595b02cca10c61dd00dde97a1bc5','2025-09-29 09:07:19'),(222,-7,'SALE',1,12,'e031c468720d941e6242ab90c8d34bd5','2025-06-19 07:07:36'),(223,-2,'SALE',1,3,'bfe9dec2486cec172d6e1aa7220ae75a','2025-06-13 17:02:57'),(224,-3,'SALE',1,3,'7a04492666b5848a454a4712ccb14737','2025-07-02 18:40:04'),(225,-3,'SALE',1,5,'8714503ad3245ed425e1199b60e7fabd','2025-09-03 07:50:22'),(226,-2,'SALE',1,3,'f22137c681adca2dd49b44867d5eacc2','2025-06-18 12:12:19'),(227,-4,'SALE',1,7,'d3cea6ff779a052864ced4ba222d33bd','2025-07-18 01:22:45'),(228,-8,'SALE',1,14,'7e08476154b22a5924b4ecd818b065b3','2025-06-28 14:45:56'),(229,-2,'SALE',1,2,'8042579a97bb7827c8a728bb4042bfe0','2025-06-14 02:50:57'),(230,-7,'SALE',1,7,'1403ba7eb260d244bce1a4a11c87f06b','2025-07-30 15:47:00'),(231,-3,'SALE',1,5,'c8383b221bdcc7cb9d87d29d313de12b','2025-09-12 03:12:38'),(232,-7,'SALE',1,15,'04e53fd7dd90a3f7fe744fcfc7521e8c','2025-06-19 09:21:38'),(233,-3,'SALE',1,1,'0054a16cd9c7865feed819f63d84a131','2025-09-24 13:47:15'),(234,-9,'SALE',1,11,'c103f110da9874dcc26fd17093c54214','2025-08-04 21:08:55'),(235,-3,'SALE',1,5,'58cc23c411bce8a57ca3d90d5d4d881a','2025-08-01 11:05:54'),(236,-3,'SALE',1,5,'be2426f36e36c00a497217dab0aa7f6b','2025-07-16 20:28:44'),(237,-3,'SALE',1,3,'42d9f602e9c506f14ab942ce7ee6b48a','2025-07-10 12:37:32'),(238,-3,'SALE',1,2,'a879d97eb5a877189dd4de2c699a93cf','2025-07-07 15:19:35'),(239,-3,'SALE',1,4,'fa387c339987e49f9fb8fe9d2cce08f9','2025-08-22 13:01:18'),(240,-1,'SALE',1,3,'d5d195e3d8d761b038b53b4104e3c00e','2025-09-11 15:58:49'),(241,-1,'SALE',1,4,'b4587ea61823c7658882fdac069d30f690abb98907c115962626d8f525ba201d','2025-09-30 18:32:29'),(242,-1,'SALE',1,4,'b08d6da7bfc792ad443e76275dbeb4c548960fec6b2137ed016bd7bad0b5259f','2025-09-30 18:33:09');
/*!40000 ALTER TABLE `InventoryLogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LegalEntityTypes`
--

DROP TABLE IF EXISTS `LegalEntityTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LegalEntityTypes` (
  `EntityTypeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`EntityTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LegalEntityTypes`
--

LOCK TABLES `LegalEntityTypes` WRITE;
/*!40000 ALTER TABLE `LegalEntityTypes` DISABLE KEYS */;
INSERT INTO `LegalEntityTypes` VALUES (1,'S.A.'),(2,'S.R.L.'),(3,'S.C.'),(4,'S.C.S.'),(5,'S.C.A.'),(6,'E.I.R.L.'),(7,'A.C.'),(8,'C.A.'),(9,'L.P.'),(10,'LLC'),(11,'Inc.'),(12,'E.I.');
/*!40000 ALTER TABLE `LegalEntityTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LogLevels`
--

DROP TABLE IF EXISTS `LogLevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LogLevels` (
  `logLevelId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`logLevelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LogLevels`
--

LOCK TABLES `LogLevels` WRITE;
/*!40000 ALTER TABLE `LogLevels` DISABLE KEYS */;
/*!40000 ALTER TABLE `LogLevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LogSources`
--

DROP TABLE IF EXISTS `LogSources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LogSources` (
  `logSourceId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`logSourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LogSources`
--

LOCK TABLES `LogSources` WRITE;
/*!40000 ALTER TABLE `LogSources` DISABLE KEYS */;
/*!40000 ALTER TABLE `LogSources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Markets`
--

DROP TABLE IF EXISTS `Markets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Markets` (
  `marketId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `status` enum('ACTIVE','UNDER_CONSTRUCTION','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `spaceCount` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1',
  `businessId` int NOT NULL,
  `buildingArea` int NOT NULL,
  PRIMARY KEY (`marketId`),
  UNIQUE KEY `inBuildingLocationId_UNIQUE` (`buildingArea`),
  KEY `fk_Markets_inBuildingLocation1_idx` (`buildingArea`),
  KEY `fk_Markets_Business1_idx` (`businessId`),
  CONSTRAINT `fk_Markets_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Markets_inBuildingLocation1` FOREIGN KEY (`buildingArea`) REFERENCES `BuildingArea` (`buildingArea`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Markets`
--

LOCK TABLES `Markets` WRITE;
/*!40000 ALTER TABLE `Markets` DISABLE KEYS */;
INSERT INTO `Markets` VALUES (1,'Mercado 88 SUC1','ACTIVE',10,'2023-11-08 08:45:00',NULL,1,1,18),(2,'Mercado 99 SUC1','ACTIVE',8,'2023-09-08 08:45:00',NULL,1,10,17),(3,'GastroPark 12','ACTIVE',12,'2021-09-08 08:45:00',NULL,1,2,2);
/*!40000 ALTER TABLE `Markets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Modules`
--

DROP TABLE IF EXISTS `Modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Modules` (
  `moduleId` int NOT NULL AUTO_INCREMENT,
  `moduleName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`moduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Modules`
--

LOCK TABLES `Modules` WRITE;
/*!40000 ALTER TABLE `Modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `Modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OperationalExpenseTypes`
--

DROP TABLE IF EXISTS `OperationalExpenseTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OperationalExpenseTypes` (
  `operationalExpenseTypeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`operationalExpenseTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OperationalExpenseTypes`
--

LOCK TABLES `OperationalExpenseTypes` WRITE;
/*!40000 ALTER TABLE `OperationalExpenseTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `OperationalExpenseTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OperationalExpenses`
--

DROP TABLE IF EXISTS `OperationalExpenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OperationalExpenses` (
  `operationalExpenseId` int NOT NULL AUTO_INCREMENT,
  `operationalExpenseTypeId` int NOT NULL,
  `transactionId` int NOT NULL,
  `checksum` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`operationalExpenseId`),
  KEY `fk_OperationalExpenses_OperationalExpenseTypes1_idx` (`operationalExpenseTypeId`),
  KEY `fk_OperationalExpenses_Transactions1_idx` (`transactionId`),
  CONSTRAINT `fk_OperationalExpenses_OperationalExpenseTypes1` FOREIGN KEY (`operationalExpenseTypeId`) REFERENCES `OperationalExpenseTypes` (`operationalExpenseTypeId`),
  CONSTRAINT `fk_OperationalExpenses_Transactions1` FOREIGN KEY (`transactionId`) REFERENCES `Transactions` (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OperationalExpenses`
--

LOCK TABLES `OperationalExpenses` WRITE;
/*!40000 ALTER TABLE `OperationalExpenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `OperationalExpenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PaymentMethods`
--

DROP TABLE IF EXISTS `PaymentMethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentMethods` (
  `paymentMethodId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`paymentMethodId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PaymentMethods`
--

LOCK TABLES `PaymentMethods` WRITE;
/*!40000 ALTER TABLE `PaymentMethods` DISABLE KEYS */;
INSERT INTO `PaymentMethods` VALUES (1,'EFECTIVO'),(2,'TARJETA'),(3,'TRANSFERENCIA');
/*!40000 ALTER TABLE `PaymentMethods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permissions`
--

DROP TABLE IF EXISTS `Permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permissions` (
  `permissionId` int NOT NULL AUTO_INCREMENT,
  `permissionCode` varchar(15) DEFAULT NULL,
  `permissionStatus` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `moduleId` int NOT NULL,
  PRIMARY KEY (`permissionId`),
  KEY `fk_Permissions_Modules1_idx` (`moduleId`),
  CONSTRAINT `fk_Permissions_Modules1` FOREIGN KEY (`moduleId`) REFERENCES `Modules` (`moduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permissions`
--

LOCK TABLES `Permissions` WRITE;
/*!40000 ALTER TABLE `Permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PermissionsPerRole`
--

DROP TABLE IF EXISTS `PermissionsPerRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PermissionsPerRole` (
  `roleId` int NOT NULL,
  `permissionId` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `permissionPerRoleStaus` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  PRIMARY KEY (`roleId`,`permissionId`),
  KEY `fk_Roles_has_Permissions_Permissions1_idx` (`permissionId`),
  KEY `fk_Roles_has_Permissions_Roles1_idx` (`roleId`),
  CONSTRAINT `fk_Roles_has_Permissions_Permissions1` FOREIGN KEY (`permissionId`) REFERENCES `Permissions` (`permissionId`),
  CONSTRAINT `fk_Roles_has_Permissions_Roles1` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PermissionsPerRole`
--

LOCK TABLES `PermissionsPerRole` WRITE;
/*!40000 ALTER TABLE `PermissionsPerRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `PermissionsPerRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductCategories`
--

DROP TABLE IF EXISTS `ProductCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductCategories` (
  `productCategoryId` int NOT NULL AUTO_INCREMENT,
  `productCategoryName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`productCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategories`
--

LOCK TABLES `ProductCategories` WRITE;
/*!40000 ALTER TABLE `ProductCategories` DISABLE KEYS */;
INSERT INTO `ProductCategories` VALUES (1,'ElectrÃ³nicos'),(2,'Bebidas'),(3,'PapelerÃ­a'),(9,'Bocas');
/*!40000 ALTER TABLE `ProductCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RentPaymentFrequencies`
--

DROP TABLE IF EXISTS `RentPaymentFrequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RentPaymentFrequencies` (
  `rentPaymentFrequencyId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT 'MONTHLY',
  PRIMARY KEY (`rentPaymentFrequencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RentPaymentFrequencies`
--

LOCK TABLES `RentPaymentFrequencies` WRITE;
/*!40000 ALTER TABLE `RentPaymentFrequencies` DISABLE KEYS */;
INSERT INTO `RentPaymentFrequencies` VALUES (1,'MONTHLY');
/*!40000 ALTER TABLE `RentPaymentFrequencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Roles` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(40) NOT NULL,
  `roleStatus` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RolesPerUser`
--

DROP TABLE IF EXISTS `RolesPerUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RolesPerUser` (
  `userId` int NOT NULL,
  `roleId` int NOT NULL,
  `status` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `fk_Users_has_Roles_Roles1_idx` (`roleId`),
  KEY `fk_Users_has_Roles_Users1_idx` (`userId`),
  CONSTRAINT `fk_Users_has_Roles_Roles1` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`roleId`),
  CONSTRAINT `fk_Users_has_Roles_Users1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RolesPerUser`
--

LOCK TABLES `RolesPerUser` WRITE;
/*!40000 ALTER TABLE `RolesPerUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `RolesPerUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SaleBills`
--

DROP TABLE IF EXISTS `SaleBills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SaleBills` (
  `saleBillId` int NOT NULL AUTO_INCREMENT,
  `BillNumber` int unsigned NOT NULL,
  `referenceNumber` int unsigned NOT NULL,
  `discount` float DEFAULT NULL,
  `taxAmount` float DEFAULT NULL,
  `taxApplied` float DEFAULT NULL,
  `total` float NOT NULL,
  `paymentConfirmation` json DEFAULT NULL,
  `buyerName` varchar(60) DEFAULT NULL,
  `buyerId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `transactionId` int NOT NULL,
  `contractId` int NOT NULL,
  `paymentMethodId` int NOT NULL,
  PRIMARY KEY (`saleBillId`),
  KEY `fk_GlobalBill_Transactions1_idx` (`transactionId`),
  KEY `fk_SaleBills_Contracts1_idx` (`contractId`),
  KEY `fk_SaleBills_PaymentMethods1_idx` (`paymentMethodId`),
  CONSTRAINT `fk_GlobalBill_Transactions1` FOREIGN KEY (`transactionId`) REFERENCES `Transactions` (`TransactionId`),
  CONSTRAINT `fk_SaleBills_Contracts1` FOREIGN KEY (`contractId`) REFERENCES `Contracts` (`contractId`),
  CONSTRAINT `fk_SaleBills_PaymentMethods1` FOREIGN KEY (`paymentMethodId`) REFERENCES `PaymentMethods` (`paymentMethodId`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SaleBills`
--

LOCK TABLES `SaleBills` WRITE;
/*!40000 ALTER TABLE `SaleBills` DISABLE KEYS */;
INSERT INTO `SaleBills` VALUES (1,1,1001,0,780,0.13,6000,'{\"ref\": \"1\", \"confirmed\": true}','Cliente_1',NULL,'2025-08-23 18:57:30','f3999bfc95ed330be486be19f2ece9ba',1,7,2),(2,2,1002,0,22750,0.13,175000,'{\"ref\": \"2\", \"confirmed\": true}','Cliente_2',NULL,'2025-08-15 11:14:47','99059d0e436dbf06fcc7e68a6c1a9676',2,8,1),(3,3,1003,0,1300,0.13,10000,'{\"ref\": \"3\", \"confirmed\": true}','Cliente_3',NULL,'2025-09-04 16:48:01','e83e88867d7e9c0a282620b4f627e33e',3,7,2),(4,4,1004,0,70200,0.13,540000,'{\"ref\": \"4\", \"confirmed\": true}','Cliente_4',NULL,'2025-07-15 08:48:02','b893acdaffbce1f0510016d44c9f8253',4,5,3),(5,5,1005,0,1560,0.13,12000,'{\"ref\": \"5\", \"confirmed\": true}','Cliente_5',NULL,'2025-07-11 12:43:00','736eee7bc9bbe58fcd877dbd2e7935e8',5,7,3),(6,6,1006,0,812.5,0.13,6250,'{\"ref\": \"6\", \"confirmed\": true}','Cliente_6',NULL,'2025-08-22 05:13:23','b163520429cc633276b6017b7ad4388b',6,7,1),(7,7,1007,0,72800,0.13,560000,'{\"ref\": \"7\", \"confirmed\": true}','Cliente_7',NULL,'2025-06-29 13:37:23','157a0513acb8fe2cc78dcb21100f0f97',7,5,1),(8,8,1008,0,36400,0.13,280000,'{\"ref\": \"8\", \"confirmed\": true}','Cliente_8',NULL,'2025-06-21 02:01:46','8441bba5072204cedc16344419af502d',8,5,3),(9,9,1009,0,84500,0.13,650000,'{\"ref\": \"9\", \"confirmed\": true}','Cliente_9',NULL,'2025-06-09 21:47:14','0037def5f2231b1d8e7e60c471e6d6be',9,5,3),(10,10,1010,0,136500,0.13,1050000,'{\"ref\": \"10\", \"confirmed\": true}','Cliente_10',NULL,'2025-08-22 20:27:41','01711db9830af1869e5ce36043bf4cde',10,5,1),(11,11,1011,0,650,0.13,5000,'{\"ref\": \"11\", \"confirmed\": true}','Cliente_11',NULL,'2025-08-27 12:45:14','6679754b6c944648e774869e347c3aa3',11,7,3),(12,12,1012,0,33150,0.13,255000,'{\"ref\": \"12\", \"confirmed\": true}','Cliente_12',NULL,'2025-06-10 05:24:18','9cde0fcfe5d56b3bc5b1a5c819fa19a8',12,5,2),(13,13,1013,0,45500,0.13,350000,'{\"ref\": \"13\", \"confirmed\": true}','Cliente_13',NULL,'2025-09-26 03:41:02','c286ea221d6a2131a58f8756da4739cd',13,5,1),(14,14,1014,0,1092,0.13,8400,'{\"ref\": \"14\", \"confirmed\": true}','Cliente_14',NULL,'2025-07-11 12:38:38','63b3f7eedb87a0605ae447d53e7d1f7e',14,7,1),(15,15,1015,0,780,0.13,6000,'{\"ref\": \"15\", \"confirmed\": true}','Cliente_15',NULL,'2025-09-30 15:15:20','4d40e75189324a98ff39ee7c7dfc164f',15,7,3),(16,16,1016,0,27300,0.13,210000,'{\"ref\": \"16\", \"confirmed\": true}','Cliente_16',NULL,'2025-07-10 17:45:33','6b8b11feeac8a0782831fe09b8f3e794',16,8,2),(17,17,1017,0,1300,0.13,10000,'{\"ref\": \"17\", \"confirmed\": true}','Cliente_17',NULL,'2025-08-23 08:46:50','9136f83129ec85f4e9c66009513e4565',17,7,3),(18,18,1018,0,2340,0.13,18000,'{\"ref\": \"18\", \"confirmed\": true}','Cliente_18',NULL,'2025-07-12 05:05:45','9f606be635478f8dbd28f65f79b8dcc4',18,8,2),(19,19,1019,0,3380,0.13,26000,'{\"ref\": \"19\", \"confirmed\": true}','Cliente_19',NULL,'2025-09-02 02:52:06','0350702ecf12bcfa1eec367a5a3f4cf6',19,7,3),(20,20,1020,0,11050,0.13,85000,'{\"ref\": \"20\", \"confirmed\": true}','Cliente_20',NULL,'2025-08-15 14:04:24','7cb7c4d0fee8e8789f455c3b511bee20',20,5,3),(21,21,1021,0,338,0.13,2600,'{\"ref\": \"21\", \"confirmed\": true}','Cliente_21',NULL,'2025-08-15 11:22:23','ef5baf5378e8ef800687586cd8886b11',21,7,3),(22,22,1022,0,11050,0.13,85000,'{\"ref\": \"22\", \"confirmed\": true}','Cliente_22',NULL,'2025-09-06 02:56:24','c5395e3b458f3944cecfd1d181fabaa9',22,5,1),(23,23,1023,0,468,0.13,3600,'{\"ref\": \"23\", \"confirmed\": true}','Cliente_23',NULL,'2025-07-23 10:28:05','cdaa0e142a902e16957b12f8158a2990',23,8,1),(24,24,1024,0,468,0.13,3600,'{\"ref\": \"24\", \"confirmed\": true}','Cliente_24',NULL,'2025-09-14 21:19:48','3463a0a77db5cf66e595b4b0c52e8b83',24,7,1),(25,25,1025,0,6760,0.13,52000,'{\"ref\": \"25\", \"confirmed\": true}','Cliente_25',NULL,'2025-07-23 15:32:46','24060ef25f7dded0b32461e7cb894047',25,7,1),(26,26,1026,0,2600,0.13,20000,'{\"ref\": \"26\", \"confirmed\": true}','Cliente_26',NULL,'2025-06-08 17:58:39','92e7fac619925ab2dcad7761d9e14bc3',26,7,2),(27,27,1027,0,11440,0.13,88000,'{\"ref\": \"27\", \"confirmed\": true}','Cliente_27',NULL,'2025-08-28 05:22:08','7e646037394a5b27828e3e356a51a6b7',27,8,2),(28,28,1028,0,5720,0.13,44000,'{\"ref\": \"28\", \"confirmed\": true}','Cliente_28',NULL,'2025-07-12 20:29:45','2409689270591312007f22ce1206b491',28,8,2),(29,29,1029,0,169000,0.13,1300000,'{\"ref\": \"29\", \"confirmed\": true}','Cliente_29',NULL,'2025-07-11 03:40:57','4c4d763340bd2d74b097de1bbc3ffbcc',29,5,3),(30,30,1030,0,1040,0.13,8000,'{\"ref\": \"30\", \"confirmed\": true}','Cliente_30',NULL,'2025-09-03 05:31:53','fcfe2ea5c973cebd8983bcbbaf35e72e',30,7,3),(31,31,1031,0,1300,0.13,10000,'{\"ref\": \"31\", \"confirmed\": true}','Cliente_31',NULL,'2025-07-01 12:27:40','09e65324f9c2816e80823734d4436db2',31,7,3),(32,32,1032,0,1170,0.13,9000,'{\"ref\": \"32\", \"confirmed\": true}','Cliente_32',NULL,'2025-06-28 12:20:04','3a16b9541d99ce3c261cf75e97691fa0',32,8,2),(33,33,1033,0,20020,0.13,154000,'{\"ref\": \"33\", \"confirmed\": true}','Cliente_33',NULL,'2025-07-18 03:54:07','62563e6119455e5c092fcfe17427d0a5',33,8,3),(34,34,1034,0,70200,0.13,540000,'{\"ref\": \"34\", \"confirmed\": true}','Cliente_34',NULL,'2025-06-24 16:07:30','f2acd6af0db1f58c6c5aceddf99736c7',34,5,1),(35,35,1035,0,936,0.13,7200,'{\"ref\": \"35\", \"confirmed\": true}','Cliente_35',NULL,'2025-07-01 16:24:51','a0aaedbc32863e457c52878c5591ee13',35,8,1),(36,36,1036,0,36400,0.13,280000,'{\"ref\": \"36\", \"confirmed\": true}','Cliente_36',NULL,'2025-08-09 21:16:37','a14041b4ab447b689e81d74adb851217',36,8,2),(37,37,1037,0,156,0.13,1200,'{\"ref\": \"37\", \"confirmed\": true}','Cliente_37',NULL,'2025-06-06 16:45:38','91458de1afd7dda315303c314bd950de',37,7,3),(38,38,1038,0,5720,0.13,44000,'{\"ref\": \"38\", \"confirmed\": true}','Cliente_38',NULL,'2025-08-04 01:54:22','dec815aa7cddf037a476abd275be1108',38,8,1),(39,39,1039,0,325,0.13,2500,'{\"ref\": \"39\", \"confirmed\": true}','Cliente_39',NULL,'2025-09-11 14:41:35','6228e69439dc1864b0dfaf146163bd7f',39,8,3),(40,40,1040,0,45500,0.13,350000,'{\"ref\": \"40\", \"confirmed\": true}','Cliente_40',NULL,'2025-09-20 06:03:31','2ea1bb7a371444e923275e0aa6396716',40,5,2),(41,41,1041,0,91000,0.13,700000,'{\"ref\": \"41\", \"confirmed\": true}','Cliente_41',NULL,'2025-08-14 09:46:44','fa18311ed0e84b0ad89e36d34bb97c00',41,5,2),(42,42,1042,0,33150,0.13,255000,'{\"ref\": \"42\", \"confirmed\": true}','Cliente_42',NULL,'2025-06-06 08:55:33','1fb709fdf7f807ab46722dd260091f78',42,5,1),(43,43,1043,0,5720,0.13,44000,'{\"ref\": \"43\", \"confirmed\": true}','Cliente_43',NULL,'2025-06-29 09:42:24','b669d5c0f9817d7e21b04ff51d514981',43,8,3),(44,44,1044,0,22100,0.13,170000,'{\"ref\": \"44\", \"confirmed\": true}','Cliente_44',NULL,'2025-07-17 08:03:10','dcadca7886b0dae159b5b83740e1088a',44,5,2),(45,45,1045,0,2925,0.13,22500,'{\"ref\": \"45\", \"confirmed\": true}','Cliente_45',NULL,'2025-09-20 22:35:03','abc4dcf0b9a97f067c52d889f5b71195',45,8,2),(46,46,1046,0,702,0.13,5400,'{\"ref\": \"46\", \"confirmed\": true}','Cliente_46',NULL,'2025-06-04 07:36:07','b875396e842d59f1cd7348d68f1af2a8',46,8,3),(47,47,1047,0,84500,0.13,650000,'{\"ref\": \"47\", \"confirmed\": true}','Cliente_47',NULL,'2025-07-09 00:03:13','820c0fe1f0d9119dadb6853fd5085097',47,5,3),(48,48,1048,0,169,0.13,1300,'{\"ref\": \"48\", \"confirmed\": true}','Cliente_48',NULL,'2025-07-24 17:03:02','cbaec1adf8fd9c9edfac317f3d953f4d',48,7,1),(49,49,1049,0,650,0.13,5000,'{\"ref\": \"49\", \"confirmed\": true}','Cliente_49',NULL,'2025-08-30 08:07:28','408338efd61923d805a52008f5db3aaa',49,7,3),(50,50,1050,0,162.5,0.13,1250,'{\"ref\": \"50\", \"confirmed\": true}','Cliente_50',NULL,'2025-07-03 14:55:48','197d47cf5e52ba367415c85c7b02adde',50,7,1),(51,51,1051,0,136500,0.13,1050000,'{\"ref\": \"51\", \"confirmed\": true}','Cliente_51',NULL,'2025-07-27 22:15:20','76236d583498709d6f6aae26f4d3dbef',51,5,3),(52,52,1052,0,338,0.13,2600,'{\"ref\": \"52\", \"confirmed\": true}','Cliente_52',NULL,'2025-07-05 03:33:24','c3dad5d1325225d61451eb919de9a16d',52,7,2),(53,53,1053,0,23400,0.13,180000,'{\"ref\": \"53\", \"confirmed\": true}','Cliente_53',NULL,'2025-07-05 01:03:07','d9f2b2c7335a9f094c3e3b0e8a9b8bbf',53,5,2),(54,54,1054,0,25740,0.13,198000,'{\"ref\": \"54\", \"confirmed\": true}','Cliente_54',NULL,'2025-08-30 14:27:21','efbe4e56431df5a8a6f0861646cbe215',54,8,2),(55,55,1055,0,23400,0.13,180000,'{\"ref\": \"55\", \"confirmed\": true}','Cliente_55',NULL,'2025-07-06 02:18:15','67594f6bdfb0625e721165c370d142e9',55,5,2),(56,56,1056,0,36400,0.13,280000,'{\"ref\": \"56\", \"confirmed\": true}','Cliente_56',NULL,'2025-08-03 01:45:39','c53e406613fbc6e6bebe48f510a744a9',56,5,1),(57,57,1057,0,8450,0.13,65000,'{\"ref\": \"57\", \"confirmed\": true}','Cliente_57',NULL,'2025-06-15 12:57:14','a858bd5c925a74f779ef283a5f20c68b',57,7,1),(58,58,1058,0,1638,0.13,12600,'{\"ref\": \"58\", \"confirmed\": true}','Cliente_58',NULL,'2025-06-03 04:56:12','fa826970adc1dba0eaa3bb586901edeb',58,8,1),(59,59,1059,0,33150,0.13,255000,'{\"ref\": \"59\", \"confirmed\": true}','Cliente_59',NULL,'2025-08-13 21:22:10','c857ae7d277df6be4da66182e789c0e1',59,5,3),(60,60,1060,0,520,0.13,4000,'{\"ref\": \"60\", \"confirmed\": true}','Cliente_60',NULL,'2025-08-02 20:55:03','c5eddd1dfb28aad063002700ca89cb88',60,7,2),(61,61,1061,0,676,0.13,5200,'{\"ref\": \"61\", \"confirmed\": true}','Cliente_61',NULL,'2025-07-31 12:07:02','ae6dcc261493a8342f94a47ab95e369c',61,7,3),(62,62,1062,0,46800,0.13,360000,'{\"ref\": \"62\", \"confirmed\": true}','Cliente_62',NULL,'2025-08-09 16:11:50','adf5551042052c6b7afe9ea69198c48b',62,5,3),(63,63,1063,0,260,0.13,2000,'{\"ref\": \"63\", \"confirmed\": true}','Cliente_63',NULL,'2025-06-10 15:32:41','8da328cebd66488318e0f86f26a42891',63,7,3),(64,64,1064,0,253500,0.13,1950000,'{\"ref\": \"64\", \"confirmed\": true}','Cliente_64',NULL,'2025-09-12 04:26:39','04aaf4694ef0a7d89ba4f9beb3172e7d',64,5,1),(65,65,1065,0,11050,0.13,85000,'{\"ref\": \"65\", \"confirmed\": true}','Cliente_65',NULL,'2025-09-05 15:49:05','8bba6a9d347e4be663bd0aaab990b772',65,5,3),(66,66,1066,0,9100,0.13,70000,'{\"ref\": \"66\", \"confirmed\": true}','Cliente_66',NULL,'2025-06-20 17:08:30','ca2981a606fa202227e79c7ad65e9bd4',66,8,1),(67,67,1067,0,169000,0.13,1300000,'{\"ref\": \"67\", \"confirmed\": true}','Cliente_67',NULL,'2025-07-14 11:32:12','00f18ed28a45e7ebe8e90a2984e5ad73',67,5,2),(68,68,1068,0,27300,0.13,210000,'{\"ref\": \"68\", \"confirmed\": true}','Cliente_68',NULL,'2025-07-02 00:50:13','99debc05773d6db0973cb866cbe92203',68,8,2),(69,69,1069,0,36400,0.13,280000,'{\"ref\": \"69\", \"confirmed\": true}','Cliente_69',NULL,'2025-09-15 10:49:52','facbc4b8c321049ecd68443d3b60c63f',69,5,3),(70,70,1070,0,936,0.13,7200,'{\"ref\": \"70\", \"confirmed\": true}','Cliente_70',NULL,'2025-08-04 18:35:35','2d184b272aa715355e8cdb145f753e5f',70,7,1),(71,71,1071,0,45500,0.13,350000,'{\"ref\": \"71\", \"confirmed\": true}','Cliente_71',NULL,'2025-06-23 05:38:34','df5eb46fbe0823c360ef5ba4d281f164',71,8,3),(72,72,1072,0,585,0.13,4500,'{\"ref\": \"72\", \"confirmed\": true}','Cliente_72',NULL,'2025-09-02 21:54:50','7e40769c8bb854db275ba194121c5dda',72,8,2),(73,73,1073,0,84500,0.13,650000,'{\"ref\": \"73\", \"confirmed\": true}','Cliente_73',NULL,'2025-06-23 13:25:25','e6a469e78f0d148f4e017318dd466d33',73,5,3),(74,74,1074,0,2925,0.13,22500,'{\"ref\": \"74\", \"confirmed\": true}','Cliente_74',NULL,'2025-07-02 09:47:44','3d3f501a2d2bb4fca315440adee3c5e5',74,8,2),(75,75,1075,0,84500,0.13,650000,'{\"ref\": \"75\", \"confirmed\": true}','Cliente_75',NULL,'2025-07-11 20:30:48','96e08de4d78f391378d3a721900bc4fb',75,5,2),(76,76,1076,0,936,0.13,7200,'{\"ref\": \"76\", \"confirmed\": true}','Cliente_76',NULL,'2025-08-06 08:21:46','c60c4fefd79e4be1dd69bb6edc9c63a1',76,8,3),(77,77,1077,0,27300,0.13,210000,'{\"ref\": \"77\", \"confirmed\": true}','Cliente_77',NULL,'2025-09-03 15:33:50','4a93e682d7c372b741e493457e85fe9f',77,8,2),(78,78,1078,0,812.5,0.13,6250,'{\"ref\": \"78\", \"confirmed\": true}','Cliente_78',NULL,'2025-08-09 16:20:31','bd1f387f5b47866ca1fa4cde84a60736',78,7,2),(79,79,1079,0,4095,0.13,31500,'{\"ref\": \"79\", \"confirmed\": true}','Cliente_79',NULL,'2025-07-04 18:52:01','8ac1ce0e198d313306276ac9e32cdd04',79,8,2),(80,80,1080,0,45500,0.13,350000,'{\"ref\": \"80\", \"confirmed\": true}','Cliente_80',NULL,'2025-08-09 18:43:15','4c12fafa1261d6f71824d2df294b7b66',80,5,1),(81,81,1081,0,46800,0.13,360000,'{\"ref\": \"81\", \"confirmed\": true}','Cliente_81',NULL,'2025-07-08 07:33:50','12899325a3eb5aab9529105313f74bd4',81,5,2),(82,82,1082,0,6760,0.13,52000,'{\"ref\": \"82\", \"confirmed\": true}','Cliente_82',NULL,'2025-08-01 08:14:09','e303f72ab75c661a5ac3e266af073edb',82,7,1),(83,83,1083,0,17160,0.13,132000,'{\"ref\": \"83\", \"confirmed\": true}','Cliente_83',NULL,'2025-06-17 14:25:17','d465037d54ab07210329aeafd3f9aea1',83,8,1),(84,84,1084,0,11050,0.13,85000,'{\"ref\": \"84\", \"confirmed\": true}','Cliente_84',NULL,'2025-07-18 16:39:12','19d8c7e866803d7a5c87cc52edadf55c',84,5,1),(85,85,1085,0,1755,0.13,13500,'{\"ref\": \"85\", \"confirmed\": true}','Cliente_85',NULL,'2025-08-19 20:22:12','3f4b48cefcd2025c8faa73c4f003b7d9',85,8,3),(86,86,1086,0,1300,0.13,10000,'{\"ref\": \"86\", \"confirmed\": true}','Cliente_86',NULL,'2025-08-09 05:50:34','c35ff8749f50a4fe232c1ccdf67263c8',86,8,2),(87,87,1087,0,1040,0.13,8000,'{\"ref\": \"87\", \"confirmed\": true}','Cliente_87',NULL,'2025-07-07 10:10:29','d28f475b9624f79d57bec67eccf42edb',87,7,3),(88,88,1088,0,36400,0.13,280000,'{\"ref\": \"88\", \"confirmed\": true}','Cliente_88',NULL,'2025-06-24 11:03:47','98f3828224e6a21ea045b0bc28eba68f',88,5,3),(89,89,1089,0,169,0.13,1300,'{\"ref\": \"89\", \"confirmed\": true}','Cliente_89',NULL,'2025-08-19 12:43:57','a1f46b17608af79be8cd43b950a2a2f6',89,7,3),(90,90,1090,0,22880,0.13,176000,'{\"ref\": \"90\", \"confirmed\": true}','Cliente_90',NULL,'2025-06-26 15:02:07','0a1f23c637063cdeb6ff3694570d4731',90,8,2),(91,91,1091,0,338,0.13,2600,'{\"ref\": \"91\", \"confirmed\": true}','Cliente_91',NULL,'2025-08-19 06:22:00','08deaa7acc31ab1e98dd4b6f03751f2f',91,7,3),(92,92,1092,0,28600,0.13,220000,'{\"ref\": \"92\", \"confirmed\": true}','Cliente_92',NULL,'2025-08-12 05:51:42','a3a040dd9d52c8051e6c98f406a550a1',92,8,3),(93,93,1093,0,260,0.13,2000,'{\"ref\": \"93\", \"confirmed\": true}','Cliente_93',NULL,'2025-09-07 16:54:28','538bfce313df1c3847b9b3ffcca8107a',93,7,2),(94,94,1094,0,33150,0.13,255000,'{\"ref\": \"94\", \"confirmed\": true}','Cliente_94',NULL,'2025-08-11 08:39:10','0bf36db2a8fa43c7ce34746057897234',94,5,3),(95,95,1095,0,2340,0.13,18000,'{\"ref\": \"95\", \"confirmed\": true}','Cliente_95',NULL,'2025-07-01 09:45:34','d587609b07a922245ddb5c82aa3de33d',95,7,2),(96,96,1096,0,975,0.13,7500,'{\"ref\": \"96\", \"confirmed\": true}','Cliente_96',NULL,'2025-08-25 15:31:37','e83a260e45271171edf953d53be3f864',96,8,2),(97,97,1097,0,45500,0.13,350000,'{\"ref\": \"97\", \"confirmed\": true}','Cliente_97',NULL,'2025-07-11 22:45:56','b82ab0d1dd0b73ab286f6fa295ab30a1',97,5,2),(98,98,1098,0,13650,0.13,105000,'{\"ref\": \"98\", \"confirmed\": true}','Cliente_98',NULL,'2025-09-05 07:54:39','a06aace994ff5a31c6770c6b3f912101',98,8,2),(99,99,1099,0,13650,0.13,105000,'{\"ref\": \"99\", \"confirmed\": true}','Cliente_99',NULL,'2025-08-29 12:53:51','2d88a616ea1ac971315745fc580f823d',99,8,3),(100,100,1100,0,109200,0.13,840000,'{\"ref\": \"100\", \"confirmed\": true}','Cliente_100',NULL,'2025-07-20 12:50:41','d6f34b85643b52fbac834d56a4992c4d',100,5,3),(101,101,1101,0,1521,0.13,11700,'{\"ref\": \"101\", \"confirmed\": true}','Cliente_101',NULL,'2025-08-14 07:20:46','d4ac9225d87c0e158c38044a2931a5af',101,7,3),(102,102,1102,0,46800,0.13,360000,'{\"ref\": \"102\", \"confirmed\": true}','Cliente_102',NULL,'2025-08-26 00:13:02','0255e8b027ba6321389af5e71ce9baf4',102,5,2),(103,103,1103,0,70200,0.13,540000,'{\"ref\": \"103\", \"confirmed\": true}','Cliente_103',NULL,'2025-08-15 12:36:24','4d0cf8108b135d6b2b84419a1d5cf44e',103,5,1),(104,104,1104,0,91000,0.13,700000,'{\"ref\": \"104\", \"confirmed\": true}','Cliente_104',NULL,'2025-07-28 14:34:00','91361ae1269fc0b185ffc7ed69b9f5f5',104,5,1),(105,105,1105,0,136500,0.13,1050000,'{\"ref\": \"105\", \"confirmed\": true}','Cliente_105',NULL,'2025-08-15 05:06:46','22f3b196a81c99de58c0607de0565863',105,5,2),(106,106,1106,0,1404,0.13,10800,'{\"ref\": \"106\", \"confirmed\": true}','Cliente_106',NULL,'2025-07-28 21:05:36','dec303a73c5d65d557ee8e2b56f4a346',106,8,3),(107,107,1107,0,1092,0.13,8400,'{\"ref\": \"107\", \"confirmed\": true}','Cliente_107',NULL,'2025-06-13 12:00:21','c074da1796d2b9c06b0b5ead46e5df93',107,7,3),(108,108,1108,0,338,0.13,2600,'{\"ref\": \"108\", \"confirmed\": true}','Cliente_108',NULL,'2025-08-23 06:25:17','081603fddbdcde60219777e0fe05231c',108,7,1),(109,109,1109,0,1755,0.13,13500,'{\"ref\": \"109\", \"confirmed\": true}','Cliente_109',NULL,'2025-09-29 08:47:54','0f57e132bf598e1d45edad374ed2b5ee',109,8,1),(110,110,1110,0,23400,0.13,180000,'{\"ref\": \"110\", \"confirmed\": true}','Cliente_110',NULL,'2025-09-18 18:37:46','3807c2f86639985d58bc2828ef2832e3',110,5,1),(111,111,1111,0,1170,0.13,9000,'{\"ref\": \"111\", \"confirmed\": true}','Cliente_111',NULL,'2025-09-04 17:07:19','deb818725012a1568327f8a0e41c922b',111,8,1),(112,112,1112,0,9100,0.13,70000,'{\"ref\": \"112\", \"confirmed\": true}','Cliente_112',NULL,'2025-08-23 03:43:17','c5eaeaa30d70dfc91db0eba9f742cfd8',112,8,1),(113,113,1113,0,1755,0.13,13500,'{\"ref\": \"113\", \"confirmed\": true}','Cliente_113',NULL,'2025-08-05 10:52:04','5014a8c0193cc33cb471cfc901f2e413',113,8,3),(114,114,1114,0,2535,0.13,19500,'{\"ref\": \"114\", \"confirmed\": true}','Cliente_114',NULL,'2025-06-05 06:26:22','18b7a2fec5f4448f1d34dfb34b737593',114,7,2),(115,115,1115,0,1092,0.13,8400,'{\"ref\": \"115\", \"confirmed\": true}','Cliente_115',NULL,'2025-06-03 04:52:52','e2e87f0f20725a61e7c1bf151f41f3c9',115,7,3),(116,116,1116,0,33150,0.13,255000,'{\"ref\": \"116\", \"confirmed\": true}','Cliente_116',NULL,'2025-09-22 11:21:16','d7f7580e02896c54926b70ed89220938',116,5,1),(117,117,1117,0,487.5,0.13,3750,'{\"ref\": \"117\", \"confirmed\": true}','Cliente_117',NULL,'2025-09-13 22:27:23','81447ca93b82c43d0bf723274df06b28',117,7,2),(118,118,1118,0,975,0.13,7500,'{\"ref\": \"118\", \"confirmed\": true}','Cliente_118',NULL,'2025-06-08 22:55:48','57160c0526631d5a056ddc2f2019e05e',118,7,1),(119,119,1119,0,46800,0.13,360000,'{\"ref\": \"119\", \"confirmed\": true}','Cliente_119',NULL,'2025-07-06 22:43:44','0651b464dc0b0e16baa4e55aca2b510e',119,5,2),(120,120,1120,0,28600,0.13,220000,'{\"ref\": \"120\", \"confirmed\": true}','Cliente_120',NULL,'2025-08-16 00:57:48','ef6552c95c9ff6bacdeffa074db8f5f8',120,8,1),(121,121,1121,0,676,0.13,5200,'{\"ref\": \"121\", \"confirmed\": true}','Cliente_121',NULL,'2025-06-28 18:42:09','9fe07876ceeb839aed337e1a868743a4',121,7,2),(122,122,1122,0,1755,0.13,13500,'{\"ref\": \"122\", \"confirmed\": true}','Cliente_122',NULL,'2025-09-28 10:09:28','50e103bfc5e64372f4c5af0acfe92f91',122,8,3),(123,123,1123,0,1521,0.13,11700,'{\"ref\": \"123\", \"confirmed\": true}','Cliente_123',NULL,'2025-09-29 13:53:45','c3d2fc51d38609e0a00cbe9e9b931803',123,7,1),(124,124,1124,0,46800,0.13,360000,'{\"ref\": \"124\", \"confirmed\": true}','Cliente_124',NULL,'2025-08-07 05:55:54','4c6605e36bf07c68b932b71dff48462a',124,5,3),(125,125,1125,0,46800,0.13,360000,'{\"ref\": \"125\", \"confirmed\": true}','Cliente_125',NULL,'2025-07-04 12:33:10','487cf5411bc388ecd100cb1d7f35a396',125,5,1),(126,126,1126,0,22750,0.13,175000,'{\"ref\": \"126\", \"confirmed\": true}','Cliente_126',NULL,'2025-08-15 11:19:09','5f3ef892acc5b48dcec94d5b28bc1fc3',126,8,3),(127,127,1127,0,234,0.13,1800,'{\"ref\": \"127\", \"confirmed\": true}','Cliente_127',NULL,'2025-06-05 19:14:43','45becd02d2bb7189af9e3fabbe9f7f06',127,8,3),(128,128,1128,0,46800,0.13,360000,'{\"ref\": \"128\", \"confirmed\": true}','Cliente_128',NULL,'2025-07-17 11:32:15','3aa216c97df056ca4ead5c4c2ee17c7a',128,5,2),(129,129,1129,0,8580,0.13,66000,'{\"ref\": \"129\", \"confirmed\": true}','Cliente_129',NULL,'2025-09-28 09:56:31','53e18a150381c61f00eb9e0893b91ee2',129,8,3),(130,130,1130,0,2535,0.13,19500,'{\"ref\": \"130\", \"confirmed\": true}','Cliente_130',NULL,'2025-09-29 09:06:14','82ea1c7985795d3033292dfb0051e70c',130,7,3),(131,131,1131,0,2340,0.13,18000,'{\"ref\": \"131\", \"confirmed\": true}','Cliente_131',NULL,'2025-08-30 16:51:10','5cc046c2f0c99095182bd4f9ca949b9b',131,7,1),(132,132,1132,0,36400,0.13,280000,'{\"ref\": \"132\", \"confirmed\": true}','Cliente_132',NULL,'2025-06-27 11:02:43','c8b1c19f75dff8f6fa43b7c7981f36a7',132,5,2),(133,133,1133,0,1300,0.13,10000,'{\"ref\": \"133\", \"confirmed\": true}','Cliente_133',NULL,'2025-06-21 19:46:19','3e27ed6177be54dc03fb37392943c310',133,7,1),(134,134,1134,0,702,0.13,5400,'{\"ref\": \"134\", \"confirmed\": true}','Cliente_134',NULL,'2025-07-08 16:33:36','1b044b5b1db0e56c70a88c450c325523',134,8,2),(135,135,1135,0,23400,0.13,180000,'{\"ref\": \"135\", \"confirmed\": true}','Cliente_135',NULL,'2025-07-19 01:28:13','e0d6b01d32e010a1830598946664a591',135,5,3),(136,136,1136,0,22100,0.13,170000,'{\"ref\": \"136\", \"confirmed\": true}','Cliente_136',NULL,'2025-09-19 01:07:23','3e5e732498cd4d0de3cf630a7c31ae96',136,5,2),(137,137,1137,0,136500,0.13,1050000,'{\"ref\": \"137\", \"confirmed\": true}','Cliente_137',NULL,'2025-07-30 17:20:21','b1c10e7af045e90de44e91f070a7c268',137,5,3),(138,138,1138,0,72800,0.13,560000,'{\"ref\": \"138\", \"confirmed\": true}','Cliente_138',NULL,'2025-09-24 09:56:30','a49f3f3c23d0741374de486d36b6f3be',138,5,3),(139,139,1139,0,136500,0.13,1050000,'{\"ref\": \"139\", \"confirmed\": true}','Cliente_139',NULL,'2025-07-10 03:41:03','338696b311b4fa4ae042853c1095a5c8',139,5,1),(140,140,1140,0,23400,0.13,180000,'{\"ref\": \"140\", \"confirmed\": true}','Cliente_140',NULL,'2025-08-17 14:58:05','4f3bbe62e34bd08818e160d71666000f',140,5,2),(141,141,1141,0,91000,0.13,700000,'{\"ref\": \"141\", \"confirmed\": true}','Cliente_141',NULL,'2025-06-18 07:07:36','ebe6313c52c753a565cc92a6b38cc6fe',141,5,3),(142,142,1142,0,1300,0.13,10000,'{\"ref\": \"142\", \"confirmed\": true}','Cliente_142',NULL,'2025-08-24 14:08:50','669d6e91806ada8c0111f6fdb2a94b95',142,8,3),(143,143,1143,0,1638,0.13,12600,'{\"ref\": \"143\", \"confirmed\": true}','Cliente_143',NULL,'2025-09-18 13:35:15','6d501693d9e770605787134924a5cc35',143,8,2),(144,144,1144,0,11050,0.13,85000,'{\"ref\": \"144\", \"confirmed\": true}','Cliente_144',NULL,'2025-08-17 20:19:57','7dae987191650a4565db77f6bac8f7c9',144,5,3),(145,145,1145,0,169000,0.13,1300000,'{\"ref\": \"145\", \"confirmed\": true}','Cliente_145',NULL,'2025-09-15 15:04:15','c220e4b68f482a80bd8097065b49bc9c',145,5,1),(146,146,1146,0,2925,0.13,22500,'{\"ref\": \"146\", \"confirmed\": true}','Cliente_146',NULL,'2025-09-22 19:04:48','5a64ccf8e5bebe9776759aede10c2a78',146,8,3),(147,147,1147,0,36400,0.13,280000,'{\"ref\": \"147\", \"confirmed\": true}','Cliente_147',NULL,'2025-08-02 20:51:45','19994992e8dfe2b198064b759169f0cf',147,5,1),(148,148,1148,0,2340,0.13,18000,'{\"ref\": \"148\", \"confirmed\": true}','Cliente_148',NULL,'2025-06-15 01:43:23','795ea83ce2b9145a3bf6cd6ed73c69bd',148,7,3),(149,149,1149,0,91000,0.13,700000,'{\"ref\": \"149\", \"confirmed\": true}','Cliente_149',NULL,'2025-07-22 00:25:01','ae83537bf2ee534838ff1184127e1b4e',149,5,3),(150,150,1150,0,33150,0.13,255000,'{\"ref\": \"150\", \"confirmed\": true}','Cliente_150',NULL,'2025-08-16 16:23:52','8dd591ca1813a877ca520351643d7f26',150,5,1),(151,151,1151,0,20020,0.13,154000,'{\"ref\": \"151\", \"confirmed\": true}','Cliente_151',NULL,'2025-09-13 19:46:24','cc6bcb9e537eb03091daae6a599c1368',151,8,3),(152,152,1152,0,1820,0.13,14000,'{\"ref\": \"152\", \"confirmed\": true}','Cliente_152',NULL,'2025-09-16 14:47:06','832120d69996cedb2d567c4c1181de42',152,7,1),(153,153,1153,0,162.5,0.13,1250,'{\"ref\": \"153\", \"confirmed\": true}','Cliente_153',NULL,'2025-07-02 16:23:45','bc0c926cf1a14a2d31b8e1abc4095ad3',153,7,2),(154,154,1154,0,22880,0.13,176000,'{\"ref\": \"154\", \"confirmed\": true}','Cliente_154',NULL,'2025-07-11 04:53:56','df9f0d70bcc8cc761fd5f74bcc3a3a90',154,8,1),(155,155,1155,0,11050,0.13,85000,'{\"ref\": \"155\", \"confirmed\": true}','Cliente_155',NULL,'2025-08-30 11:47:28','8bd27a0759b3b123801828954e7bff95',155,5,1),(156,156,1156,0,1404,0.13,10800,'{\"ref\": \"156\", \"confirmed\": true}','Cliente_156',NULL,'2025-07-10 15:17:25','a5c12645b04cad19ae2f9d9a1a5ead82',156,8,1),(157,157,1157,0,6760,0.13,52000,'{\"ref\": \"157\", \"confirmed\": true}','Cliente_157',NULL,'2025-07-20 17:01:50','514f4f2ddd9e30cb5759340348b4b31a',157,7,1),(158,158,1158,0,91000,0.13,700000,'{\"ref\": \"158\", \"confirmed\": true}','Cliente_158',NULL,'2025-06-21 11:53:03','0f2f149ab7d8d89e030c3b3324189a8e',158,5,2),(159,159,1159,0,4095,0.13,31500,'{\"ref\": \"159\", \"confirmed\": true}','Cliente_159',NULL,'2025-09-26 03:40:56','65f751df1dfb141b1851f0271c98fb94',159,8,3),(160,160,1160,0,8580,0.13,66000,'{\"ref\": \"160\", \"confirmed\": true}','Cliente_160',NULL,'2025-06-13 22:08:46','8df15f92f5f8df97f4cbb7b4ecdb1e8a',160,8,2),(161,161,1161,0,23400,0.13,180000,'{\"ref\": \"161\", \"confirmed\": true}','Cliente_161',NULL,'2025-09-22 15:14:09','f7ad5f344c4fa0a46ff0f15bef057b47',161,5,1),(162,162,1162,0,91000,0.13,700000,'{\"ref\": \"162\", \"confirmed\": true}','Cliente_162',NULL,'2025-08-15 19:10:14','6d20a99eefa976a172ab71fd48993069',162,5,3),(163,163,1163,0,22100,0.13,170000,'{\"ref\": \"163\", \"confirmed\": true}','Cliente_163',NULL,'2025-08-20 16:32:37','987fb75e461b06b1e5f1407b3cb13dba',163,5,2),(164,164,1164,0,23400,0.13,180000,'{\"ref\": \"164\", \"confirmed\": true}','Cliente_164',NULL,'2025-09-01 19:28:51','7af38be6cdeae23684420c8c34adbe6e',164,5,3),(165,165,1165,0,23400,0.13,180000,'{\"ref\": \"165\", \"confirmed\": true}','Cliente_165',NULL,'2025-08-11 19:56:16','ffb9542a90cdbc9296646afac883f193',165,5,2),(166,166,1166,0,1300,0.13,10000,'{\"ref\": \"166\", \"confirmed\": true}','Cliente_166',NULL,'2025-08-19 06:22:02','e6e927f5d11717f92e3eba5ed94797cb',166,7,1),(167,167,1167,0,162.5,0.13,1250,'{\"ref\": \"167\", \"confirmed\": true}','Cliente_167',NULL,'2025-06-11 12:53:55','d954772dbb416f925e8a785894cc81d2',167,7,3),(168,168,1168,0,72800,0.13,560000,'{\"ref\": \"168\", \"confirmed\": true}','Cliente_168',NULL,'2025-06-29 03:28:55','97bea14e9f6793590244e8781fb713e8',168,5,1),(169,169,1169,0,8580,0.13,66000,'{\"ref\": \"169\", \"confirmed\": true}','Cliente_169',NULL,'2025-07-05 00:54:33','79180d60d6ff97266703aca8b3901d93',169,8,1),(170,170,1170,0,36400,0.13,280000,'{\"ref\": \"170\", \"confirmed\": true}','Cliente_170',NULL,'2025-09-12 10:43:23','16ed7b0110bd31b9ec4775336d02f592',170,5,3),(171,171,1171,0,28600,0.13,220000,'{\"ref\": \"171\", \"confirmed\": true}','Cliente_171',NULL,'2025-07-25 00:27:14','73105806ed3ffc749c70eac0cc5fd793',171,8,3),(172,172,1172,0,1092,0.13,8400,'{\"ref\": \"172\", \"confirmed\": true}','Cliente_172',NULL,'2025-08-10 00:52:21','ac992b9d2e5a76efad5a69633c0c979e',172,7,1),(173,173,1173,0,1625,0.13,12500,'{\"ref\": \"173\", \"confirmed\": true}','Cliente_173',NULL,'2025-09-10 12:08:08','850142a1c543eb95f538b27e7177776f',173,8,1),(174,174,1174,0,20020,0.13,154000,'{\"ref\": \"174\", \"confirmed\": true}','Cliente_174',NULL,'2025-06-11 15:34:51','68d955308152d62fbae3c8e7e5620a24',174,8,2),(175,175,1175,0,4550,0.13,35000,'{\"ref\": \"175\", \"confirmed\": true}','Cliente_175',NULL,'2025-09-25 04:43:10','cc193b01161e27b219d91e104b776b10',175,8,2),(176,176,1176,0,22750,0.13,175000,'{\"ref\": \"176\", \"confirmed\": true}','Cliente_176',NULL,'2025-06-07 12:50:38','5160740f5bed2a6d0e6b8d3ebace179e',176,8,3),(177,177,1177,0,22100,0.13,170000,'{\"ref\": \"177\", \"confirmed\": true}','Cliente_177',NULL,'2025-09-06 12:09:07','9d2b169c4884aa0632b90f4fb1fe47d5',177,5,1),(178,178,1178,0,2925,0.13,22500,'{\"ref\": \"178\", \"confirmed\": true}','Cliente_178',NULL,'2025-09-22 21:26:27','3d3a0b64f696f394e336afce103dc955',178,8,3),(179,179,1179,0,812.5,0.13,6250,'{\"ref\": \"179\", \"confirmed\": true}','Cliente_179',NULL,'2025-09-23 00:58:51','4672809535091bea33c817e8efb4cf44',179,7,2),(180,180,1180,0,5265,0.13,40500,'{\"ref\": \"180\", \"confirmed\": true}','Cliente_180',NULL,'2025-06-13 02:42:17','20762510f6e1fa7f7ffc366eae77f541',180,8,1),(181,181,1181,0,22750,0.13,175000,'{\"ref\": \"181\", \"confirmed\": true}','Cliente_181',NULL,'2025-07-14 22:56:49','b1f581aa6790f9fda5d490defc184743',181,8,1),(182,182,1182,0,507,0.13,3900,'{\"ref\": \"182\", \"confirmed\": true}','Cliente_182',NULL,'2025-07-20 07:45:54','f39f6d6742de18e4683d3fe25a9dd577',182,7,1),(183,183,1183,0,5265,0.13,40500,'{\"ref\": \"183\", \"confirmed\": true}','Cliente_183',NULL,'2025-08-16 04:52:47','1c7816d06466acffb790df6b8caacad7',183,8,2),(184,184,1184,0,23400,0.13,180000,'{\"ref\": \"184\", \"confirmed\": true}','Cliente_184',NULL,'2025-08-21 16:34:44','562704f9ff6d34084be719bc765d7bc1',184,5,3),(185,185,1185,0,936,0.13,7200,'{\"ref\": \"185\", \"confirmed\": true}','Cliente_185',NULL,'2025-08-13 11:15:49','8124eca4ea1991774f8660428fb59ad0',185,7,2),(186,186,1186,0,2925,0.13,22500,'{\"ref\": \"186\", \"confirmed\": true}','Cliente_186',NULL,'2025-09-04 13:14:28','94f90eabedbdefcbcc03e3601559a745',186,8,3),(187,187,1187,0,109200,0.13,840000,'{\"ref\": \"187\", \"confirmed\": true}','Cliente_187',NULL,'2025-06-27 15:53:31','a11435f9dc180b6753814c8e567013ae',187,5,3),(188,188,1188,0,702,0.13,5400,'{\"ref\": \"188\", \"confirmed\": true}','Cliente_188',NULL,'2025-09-28 11:26:42','f12de4ccb6bbf847a7ebc49bc5eb67ad',188,8,1),(189,189,1189,0,72800,0.13,560000,'{\"ref\": \"189\", \"confirmed\": true}','Cliente_189',NULL,'2025-06-20 02:54:19','a6fbf82e664fa632563d624d75cee0b7',189,5,3),(190,190,1190,0,338,0.13,2600,'{\"ref\": \"190\", \"confirmed\": true}','Cliente_190',NULL,'2025-08-06 21:17:38','51ad3663396764736b97970fc4806846',190,7,2),(191,191,1191,0,5070,0.13,39000,'{\"ref\": \"191\", \"confirmed\": true}','Cliente_191',NULL,'2025-06-16 15:38:16','9e2fbdc009d864ca31d3ab7771102ef8',191,7,2),(192,192,1192,0,84500,0.13,650000,'{\"ref\": \"192\", \"confirmed\": true}','Cliente_192',NULL,'2025-09-15 21:11:15','52fce5456816e1b4d8738915bef6266f',192,5,3),(193,193,1193,0,2925,0.13,22500,'{\"ref\": \"193\", \"confirmed\": true}','Cliente_193',NULL,'2025-09-20 21:29:36','2cc64ba8165d290392d58779327e20aa',193,8,2),(194,194,1194,0,45500,0.13,350000,'{\"ref\": \"194\", \"confirmed\": true}','Cliente_194',NULL,'2025-08-07 06:08:48','36a7f8b717ce7689ffc635220b5ab3f4',194,5,3),(195,195,1195,0,20020,0.13,154000,'{\"ref\": \"195\", \"confirmed\": true}','Cliente_195',NULL,'2025-09-27 06:19:45','ccc153c5bfad37a6e3046b2e0c4697ef',195,8,3),(196,196,1196,0,1137.5,0.13,8750,'{\"ref\": \"196\", \"confirmed\": true}','Cliente_196',NULL,'2025-08-22 13:53:47','6ca716fae78080cf6a1e8053af1b3ffc',196,7,1),(197,197,1197,0,84500,0.13,650000,'{\"ref\": \"197\", \"confirmed\": true}','Cliente_197',NULL,'2025-08-17 00:03:10','3d1d585bb1901c88250d4bf9fe8ff070',197,5,3),(198,198,1198,0,1170,0.13,9000,'{\"ref\": \"198\", \"confirmed\": true}','Cliente_198',NULL,'2025-07-25 06:46:02','5ccbadf2a7102bde3a3a7b0a3d68cab5',198,8,3),(199,199,1199,0,33150,0.13,255000,'{\"ref\": \"199\", \"confirmed\": true}','Cliente_199',NULL,'2025-09-23 17:37:52','c9c341342ca74c2d8f7f94da01575259',199,5,2),(200,200,1200,0,1300,0.13,10000,'{\"ref\": \"200\", \"confirmed\": true}','Cliente_200',NULL,'2025-09-12 10:52:02','f048a693166e34af9ba84648d9b430dd',200,7,2),(201,201,1201,0,585,0.13,4500,'{\"ref\": \"201\", \"confirmed\": true}','Cliente_201',NULL,'2025-06-14 08:10:46','1a43ac870b46327c32a42392a139f9c0',201,8,2),(202,202,1202,0,325,0.13,2500,'{\"ref\": \"202\", \"confirmed\": true}','Cliente_202',NULL,'2025-09-10 08:23:49','ec56973b9d74e2a3efcb7e4d1c891d63',202,7,1),(203,203,1203,0,23400,0.13,180000,'{\"ref\": \"203\", \"confirmed\": true}','Cliente_203',NULL,'2025-09-18 19:57:17','44e2823d9958217cf0a4cafea604f1ff',203,5,2),(204,204,1204,0,780,0.13,6000,'{\"ref\": \"204\", \"confirmed\": true}','Cliente_204',NULL,'2025-07-07 07:35:55','5ed9480a00810aa2b1f7f3d17431f7b0',204,7,3),(205,205,1205,0,45500,0.13,350000,'{\"ref\": \"205\", \"confirmed\": true}','Cliente_205',NULL,'2025-06-24 13:24:19','55a38436b3467e61075d90108f32b4dd',205,5,2),(206,206,1206,0,46800,0.13,360000,'{\"ref\": \"206\", \"confirmed\": true}','Cliente_206',NULL,'2025-09-08 13:22:06','69fe8f23bb53c5ea1b0e13c790e02967',206,5,2),(207,207,1207,0,109200,0.13,840000,'{\"ref\": \"207\", \"confirmed\": true}','Cliente_207',NULL,'2025-08-20 03:35:37','4b527d39186837d77e5822e7a2a892c4',207,5,2),(208,208,1208,0,136500,0.13,1050000,'{\"ref\": \"208\", \"confirmed\": true}','Cliente_208',NULL,'2025-07-19 03:48:40','b44390220ca1e65d66a358f912af7c6d',208,5,3),(209,209,1209,0,845,0.13,6500,'{\"ref\": \"209\", \"confirmed\": true}','Cliente_209',NULL,'2025-08-19 06:17:41','be2beb1b3d9177d5526ee375cd485c89',209,7,2),(210,210,1210,0,45500,0.13,350000,'{\"ref\": \"210\", \"confirmed\": true}','Cliente_210',NULL,'2025-08-20 09:56:32','3d9a0ba03041bf6ee7ace8615099dbe9',210,5,3),(211,211,1211,0,1625,0.13,12500,'{\"ref\": \"211\", \"confirmed\": true}','Cliente_211',NULL,'2025-09-22 02:21:25','ae905f56995c8620a87fa22dbf937c6c',211,8,1),(212,212,1212,0,162.5,0.13,1250,'{\"ref\": \"212\", \"confirmed\": true}','Cliente_212',NULL,'2025-09-14 10:54:14','caeb77d3b4fd0617d93b94c551fe697c',212,7,2),(213,213,1213,0,1170,0.13,9000,'{\"ref\": \"213\", \"confirmed\": true}','Cliente_213',NULL,'2025-07-13 22:52:28','bba61134eaf7cafc5627c28c07d84990',213,8,3),(214,214,1214,0,585,0.13,4500,'{\"ref\": \"214\", \"confirmed\": true}','Cliente_214',NULL,'2025-07-16 03:51:50','43d12bd17d94b5db784a50430fc97457',214,8,3),(215,215,1215,0,650,0.13,5000,'{\"ref\": \"215\", \"confirmed\": true}','Cliente_215',NULL,'2025-08-10 01:57:40','ebf2151e582c2aed7f5572163d7566dd',215,7,2),(216,216,1216,0,624,0.13,4800,'{\"ref\": \"216\", \"confirmed\": true}','Cliente_216',NULL,'2025-07-16 04:04:44','4e0c5c7c4d4ce6bb3a09f6084476d53e',216,7,2),(217,217,1217,0,4680,0.13,36000,'{\"ref\": \"217\", \"confirmed\": true}','Cliente_217',NULL,'2025-07-28 12:08:02','236d8636fd99644ede55befec30401e3',217,8,3),(218,218,1218,0,11050,0.13,85000,'{\"ref\": \"218\", \"confirmed\": true}','Cliente_218',NULL,'2025-09-26 12:36:26','60b4b9ca4987b3d3dea9eb48295fc569',218,5,2),(219,219,1219,0,5070,0.13,39000,'{\"ref\": \"219\", \"confirmed\": true}','Cliente_219',NULL,'2025-06-11 20:37:32','c580c43b975fb26a2ccf399d582c29b3',219,7,3),(220,220,1220,0,1560,0.13,12000,'{\"ref\": \"220\", \"confirmed\": true}','Cliente_220',NULL,'2025-06-22 05:44:02','5347ab4400dc0845207d5130df4f92ef',220,7,3),(221,221,1221,0,487.5,0.13,3750,'{\"ref\": \"221\", \"confirmed\": true}','Cliente_221',NULL,'2025-09-29 09:07:19','39331ff39f5836bea1a09565a906dc2f',221,7,1),(222,222,1222,0,1638,0.13,12600,'{\"ref\": \"222\", \"confirmed\": true}','Cliente_222',NULL,'2025-06-19 07:07:36','00de3eaa2af04cfe2c506084513ebf94',222,8,3),(223,223,1223,0,72800,0.13,560000,'{\"ref\": \"223\", \"confirmed\": true}','Cliente_223',NULL,'2025-06-13 17:02:57','4db8b30686760763c19815d07e6220c2',223,5,3),(224,224,1224,0,109200,0.13,840000,'{\"ref\": \"224\", \"confirmed\": true}','Cliente_224',NULL,'2025-07-02 18:40:04','4e5d3227e8d02e04ad3f6b5819de2e72',224,5,1),(225,225,1225,0,70200,0.13,540000,'{\"ref\": \"225\", \"confirmed\": true}','Cliente_225',NULL,'2025-09-03 07:50:22','bf941776140cf4b4485107f1b903ec8a',225,5,2),(226,226,1226,0,72800,0.13,560000,'{\"ref\": \"226\", \"confirmed\": true}','Cliente_226',NULL,'2025-06-18 12:12:19','b7cf04a0b3b3acc99551fc5595956bf9',226,5,1),(227,227,1227,0,1040,0.13,8000,'{\"ref\": \"227\", \"confirmed\": true}','Cliente_227',NULL,'2025-07-18 01:22:45','0e5b52b364312b8b29f572d60d97b6a6',227,7,3),(228,228,1228,0,22880,0.13,176000,'{\"ref\": \"228\", \"confirmed\": true}','Cliente_228',NULL,'2025-06-28 14:45:56','af363ab8d5f9c5f606a06f1d383e0659',228,8,2),(229,229,1229,0,169000,0.13,1300000,'{\"ref\": \"229\", \"confirmed\": true}','Cliente_229',NULL,'2025-06-14 02:50:57','6a963e0472b418a9b616aac23f413715',229,5,1),(230,230,1230,0,1820,0.13,14000,'{\"ref\": \"230\", \"confirmed\": true}','Cliente_230',NULL,'2025-07-30 15:47:00','ac3b0b57ce7dbe0386b8a152fd6a509a',230,7,2),(231,231,1231,0,70200,0.13,540000,'{\"ref\": \"231\", \"confirmed\": true}','Cliente_231',NULL,'2025-09-12 03:12:38','c2d83c6611591528bbd22538536d0ae4',231,5,2),(232,232,1232,0,4095,0.13,31500,'{\"ref\": \"232\", \"confirmed\": true}','Cliente_232',NULL,'2025-06-19 09:21:38','bfdd4cfc4bea982ea36631c226bbf106',232,8,1),(233,233,1233,0,136500,0.13,1050000,'{\"ref\": \"233\", \"confirmed\": true}','Cliente_233',NULL,'2025-09-24 13:47:15','aa4c71459ece226547fa0b1c7ddf282c',233,5,3),(234,234,1234,0,2925,0.13,22500,'{\"ref\": \"234\", \"confirmed\": true}','Cliente_234',NULL,'2025-08-04 21:08:55','e0cc05b9531f419278073a0f6ef24239',234,8,1),(235,235,1235,0,70200,0.13,540000,'{\"ref\": \"235\", \"confirmed\": true}','Cliente_235',NULL,'2025-08-01 11:05:54','4fc203deb40430c75cf9acf4066f7e4f',235,5,2),(236,236,1236,0,70200,0.13,540000,'{\"ref\": \"236\", \"confirmed\": true}','Cliente_236',NULL,'2025-07-16 20:28:44','bf3a0898ecb3bcf4159fba247110e77f',236,5,1),(237,237,1237,0,109200,0.13,840000,'{\"ref\": \"237\", \"confirmed\": true}','Cliente_237',NULL,'2025-07-10 12:37:32','6875a3ea973e0f449f80ccf4f69469b7',237,5,3),(238,238,1238,0,253500,0.13,1950000,'{\"ref\": \"238\", \"confirmed\": true}','Cliente_238',NULL,'2025-07-07 15:19:35','65b9cf4568b131be94ae543d874fb566',238,5,3),(239,239,1239,0,33150,0.13,255000,'{\"ref\": \"239\", \"confirmed\": true}','Cliente_239',NULL,'2025-08-22 13:01:18','bcbe3fcfa04a2811917a29093136c752',239,5,2),(240,240,1240,0,36400,0.13,280000,'{\"ref\": \"240\", \"confirmed\": true}','Cliente_240',NULL,'2025-09-11 15:58:49','27f67e3c253967b8dacf9806f3ce3eb3',240,5,1),(241,111134534,322245433,0,11050,0.13,280000,'{\"confirmed\": true}','Juan Lopez',NULL,'2025-09-30 18:32:29','1834bed3027dee5dbef91aceae4e07860b19dba9cb46f7266d62babdc355397d',241,5,1),(242,111134534,322235433,0,11050,0.13,280000,'{\"confirmed\": true}','Juan Gonzales',NULL,'2025-09-30 18:33:09','1834bed3027dee5dbef91aceae4e07860b19dba9cb46f7266d62babdc355397d',242,5,1);
/*!40000 ALTER TABLE `SaleBills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Spaces`
--

DROP TABLE IF EXISTS `Spaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Spaces` (
  `spaceId` int NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `size` float NOT NULL,
  `type` enum('FOOD','RETAIL') NOT NULL,
  `status` enum('AVAILABLE','OCUPPIED','UNDER_RENOVATION','CLOSED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  `marketId` int NOT NULL,
  PRIMARY KEY (`spaceId`),
  UNIQUE KEY `spaceCode_UNIQUE` (`code`),
  KEY `fk_spaces_markets1_idx` (`marketId`),
  CONSTRAINT `fk_spaces_markets1` FOREIGN KEY (`marketId`) REFERENCES `Markets` (`marketId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Spaces`
--

LOCK TABLES `Spaces` WRITE;
/*!40000 ALTER TABLE `Spaces` DISABLE KEYS */;
INSERT INTO `Spaces` VALUES (1,'MS3246',25,'RETAIL','CLOSED','2023-12-09 10:15:00',NULL,1,1),(2,'MS3247',30.5,'FOOD','CLOSED','2023-12-10 11:30:00',NULL,1,1),(3,'MS3248',18.2,'FOOD','CLOSED','2023-12-11 09:00:00',NULL,1,1),(4,'MS3249',25.7,'FOOD','CLOSED','2023-12-12 14:20:00',NULL,1,1),(5,'MS3250',22.1,'RETAIL','AVAILABLE','2023-12-13 08:50:00',NULL,1,1),(6,'MS3251',17.4,'RETAIL','AVAILABLE','2023-12-14 12:10:00',NULL,1,1),(7,'MS3252',22.9,'FOOD','AVAILABLE','2023-12-15 13:45:00',NULL,1,1),(8,'MS3253',20.3,'RETAIL','AVAILABLE','2023-12-16 15:30:00',NULL,1,1),(9,'MS3254',35.8,'FOOD','AVAILABLE','2023-12-17 10:40:00',NULL,1,1),(10,'MS3255',12.5,'FOOD','AVAILABLE','2023-12-18 10:40:00',NULL,1,1),(11,'MS4101',28.5,'RETAIL','CLOSED','2023-09-08 08:45:00',NULL,1,2),(12,'MS4102',32,'RETAIL','CLOSED','2023-09-09 09:10:00',NULL,1,2),(13,'MS4103',19.7,'FOOD','CLOSED','2023-09-10 10:20:00',NULL,1,2),(14,'MS4104',36.2,'RETAIL','CLOSED','2023-09-11 11:05:00',NULL,1,2),(15,'MS4105',25.9,'FOOD','AVAILABLE','2023-09-12 08:55:00',NULL,1,2),(16,'MS4106',17.3,'RETAIL','AVAILABLE','2023-09-13 12:40:00',NULL,1,2),(17,'MS4107',30.6,'FOOD','AVAILABLE','2023-09-14 14:15:00',NULL,1,2),(18,'MS4108',23.1,'RETAIL','AVAILABLE','2023-09-15 09:30:00',NULL,1,2),(19,'MS5101',22.4,'FOOD','CLOSED','2021-09-08 08:45:00',NULL,1,3),(20,'MS5102',45.6,'RETAIL','CLOSED','2021-09-09 09:15:00',NULL,1,3),(21,'MS5103',27.8,'FOOD','CLOSED','2021-09-10 10:05:00',NULL,1,3),(22,'MS5104',41.2,'RETAIL','CLOSED','2021-09-11 11:20:00',NULL,1,3),(23,'MS5105',19.5,'FOOD','CLOSED','2021-09-12 08:55:00',NULL,1,3),(24,'MS5106',18.9,'RETAIL','AVAILABLE','2021-09-13 13:10:00',NULL,1,3),(25,'MS5107',33.1,'FOOD','AVAILABLE','2021-09-14 09:40:00',NULL,1,3),(26,'MS5108',22.3,'RETAIL','AVAILABLE','2021-09-15 14:25:00',NULL,1,3),(27,'MS5109',26.7,'FOOD','AVAILABLE','2021-09-16 08:30:00',NULL,1,3),(28,'MS5110',14,'RETAIL','AVAILABLE','2021-09-17 10:50:00',NULL,1,3),(29,'MS5111',19.9,'FOOD','AVAILABLE','2021-09-18 12:00:00',NULL,1,3),(30,'MS5112',25.6,'RETAIL','AVAILABLE','2021-09-19 15:15:00',NULL,1,3);
/*!40000 ALTER TABLE `Spaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SpacesPerContract`
--

DROP TABLE IF EXISTS `SpacesPerContract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SpacesPerContract` (
  `contractId` int NOT NULL,
  `spaceId` int NOT NULL,
  `status` enum('ACTIVE','CANCELLED','INACTIVE') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`contractId`,`spaceId`),
  KEY `fk_Contracts_has_SpaceInMarket_SpaceInMarket1_idx` (`spaceId`),
  KEY `fk_Contracts_has_SpaceInMarket_Contracts1_idx` (`contractId`),
  CONSTRAINT `fk_Contracts_has_SpaceInMarket_Contracts1` FOREIGN KEY (`contractId`) REFERENCES `Contracts` (`contractId`),
  CONSTRAINT `fk_Contracts_has_SpaceInMarket_SpaceInMarket1` FOREIGN KEY (`spaceId`) REFERENCES `Spaces` (`spaceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SpacesPerContract`
--

LOCK TABLES `SpacesPerContract` WRITE;
/*!40000 ALTER TABLE `SpacesPerContract` DISABLE KEYS */;
INSERT INTO `SpacesPerContract` VALUES (1,1,'ACTIVE','2025-08-22 12:10:00',NULL,1),(2,2,'ACTIVE','2025-03-22 12:10:00',NULL,1),(3,3,'ACTIVE','2024-12-22 12:10:00',NULL,1),(4,4,'ACTIVE','2024-10-22 12:10:00',NULL,1),(5,11,'ACTIVE','2025-01-05 10:00:00',NULL,1),(6,12,'ACTIVE','2025-03-15 15:45:00',NULL,1),(7,13,'ACTIVE','2025-03-15 15:45:00',NULL,1),(8,14,'ACTIVE','2025-04-20 11:20:00',NULL,1),(9,19,'ACTIVE','2025-01-12 09:00:00',NULL,1),(10,20,'ACTIVE','2025-02-01 14:30:00',NULL,1),(11,21,'ACTIVE','2025-02-20 11:15:00',NULL,1),(12,22,'ACTIVE','2025-03-10 08:20:00',NULL,1),(13,23,'ACTIVE','2025-04-05 10:45:00',NULL,1);
/*!40000 ALTER TABLE `SpacesPerContract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `States`
--

DROP TABLE IF EXISTS `States`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `States` (
  `stateId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `countryId` int NOT NULL,
  PRIMARY KEY (`stateId`),
  KEY `fk_States_Countries1_idx` (`countryId`),
  CONSTRAINT `fk_States_Countries1` FOREIGN KEY (`countryId`) REFERENCES `Countries` (`countryId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `States`
--

LOCK TABLES `States` WRITE;
/*!40000 ALTER TABLE `States` DISABLE KEYS */;
INSERT INTO `States` VALUES (1,'SAN JOSÃ‰',1),(2,'CARTAGO',1),(3,'HEREDIA',1);
/*!40000 ALTER TABLE `States` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SystemLogTypes`
--

DROP TABLE IF EXISTS `SystemLogTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SystemLogTypes` (
  `systemLogTypeId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`systemLogTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SystemLogTypes`
--

LOCK TABLES `SystemLogTypes` WRITE;
/*!40000 ALTER TABLE `SystemLogTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `SystemLogTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SystemLogs`
--

DROP TABLE IF EXISTS `SystemLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SystemLogs` (
  `systemLogId` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `postTime` datetime DEFAULT NULL,
  `checksum` varchar(64) DEFAULT NULL,
  `systemLogTypeId` int NOT NULL,
  `moduleId` int NOT NULL,
  `userId` int NOT NULL,
  `logSourceId` int NOT NULL,
  `logLevelId` int NOT NULL,
  PRIMARY KEY (`systemLogId`),
  KEY `fk_SystemLogs_SystemLogTypes1_idx` (`systemLogTypeId`),
  KEY `fk_SystemLogs_Modules1_idx` (`moduleId`),
  KEY `fk_SystemLogs_Users1_idx` (`userId`),
  KEY `fk_SystemLogs_LogSources1_idx` (`logSourceId`),
  KEY `fk_SystemLogs_LogLevels1_idx` (`logLevelId`),
  CONSTRAINT `fk_SystemLogs_LogLevels1` FOREIGN KEY (`logLevelId`) REFERENCES `LogLevels` (`logLevelId`),
  CONSTRAINT `fk_SystemLogs_LogSources1` FOREIGN KEY (`logSourceId`) REFERENCES `LogSources` (`logSourceId`),
  CONSTRAINT `fk_SystemLogs_Modules1` FOREIGN KEY (`moduleId`) REFERENCES `Modules` (`moduleId`),
  CONSTRAINT `fk_SystemLogs_SystemLogTypes1` FOREIGN KEY (`systemLogTypeId`) REFERENCES `SystemLogTypes` (`systemLogTypeId`),
  CONSTRAINT `fk_SystemLogs_Users1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SystemLogs`
--

LOCK TABLES `SystemLogs` WRITE;
/*!40000 ALTER TABLE `SystemLogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `SystemLogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TransactionTypes`
--

DROP TABLE IF EXISTS `TransactionTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TransactionTypes` (
  `transactionType` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`transactionType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TransactionTypes`
--

LOCK TABLES `TransactionTypes` WRITE;
/*!40000 ALTER TABLE `TransactionTypes` DISABLE KEYS */;
INSERT INTO `TransactionTypes` VALUES (1,'VENTA'),(2,'COMPRA'),(3,'GASTO');
/*!40000 ALTER TABLE `TransactionTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions` (
  `TransactionId` int NOT NULL AUTO_INCREMENT,
  `amount` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `status` enum('PENDING','CANCELLED','COMPLETED') NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `transactionType` int NOT NULL,
  `businessId` int NOT NULL,
  `contractId` int DEFAULT NULL,
  `currencyId` int NOT NULL,
  `paymentMethodId` int NOT NULL,
  PRIMARY KEY (`TransactionId`),
  KEY `fk_Transactions_TransactionTypes1_idx` (`transactionType`),
  KEY `fk_Transactions_Business1_idx` (`businessId`),
  KEY `fk_Transactions_Contracts1_idx` (`contractId`),
  KEY `fk_Transactions_Currencies1_idx` (`currencyId`),
  KEY `fk_Transactions_PaymentMethods1_idx` (`paymentMethodId`),
  CONSTRAINT `fk_Transactions_Business1` FOREIGN KEY (`businessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Transactions_Contracts1` FOREIGN KEY (`contractId`) REFERENCES `Contracts` (`contractId`),
  CONSTRAINT `fk_Transactions_Currencies1` FOREIGN KEY (`currencyId`) REFERENCES `Currencies` (`currencyId`),
  CONSTRAINT `fk_Transactions_PaymentMethods1` FOREIGN KEY (`paymentMethodId`) REFERENCES `PaymentMethods` (`paymentMethodId`),
  CONSTRAINT `fk_Transactions_TransactionTypes1` FOREIGN KEY (`transactionType`) REFERENCES `TransactionTypes` (`transactionType`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
INSERT INTO `Transactions` VALUES (1,6000,'2025-08-23 18:57:30','COMPLETED','5a7316eb0f610bc99d9b71d75bd17d2b',1,14,7,1,2),(2,175000,'2025-08-15 11:14:47','COMPLETED','b6958dd557bb3e1a1d4e487fe00f35ed',1,15,8,1,1),(3,10000,'2025-09-04 16:48:01','COMPLETED','f5c3aa939b25e582f3b5d70de3b1fd0c',1,14,7,1,2),(4,540000,'2025-07-15 08:48:02','COMPLETED','24ce2eaa9968c2ed792cf2106128a59a',1,11,5,1,3),(5,12000,'2025-07-11 12:43:00','COMPLETED','785713daf8c2374fbc6192f7d8171012',1,14,7,1,3),(6,6250,'2025-08-22 05:13:23','COMPLETED','6cfd924c6862473805807ae6da2af301',1,14,7,1,1),(7,560000,'2025-06-29 13:37:23','COMPLETED','091fa83f3577b2f881749cb47a073072',1,11,5,1,1),(8,280000,'2025-06-21 02:01:46','COMPLETED','fe065ddc9161c0606948e86bd1eb9fcd',1,11,5,1,3),(9,650000,'2025-06-09 21:47:14','COMPLETED','7bdad3c96da35d5ed5b1193ae0ee95be',1,11,5,1,3),(10,1050000,'2025-08-22 20:27:41','COMPLETED','e0142bd44a1de6bf2a7672c8da3a825e',1,11,5,1,1),(11,5000,'2025-08-27 12:45:14','COMPLETED','5c5c887b601b7b3f240713f1cda63127',1,14,7,1,3),(12,255000,'2025-06-10 05:24:18','COMPLETED','4ced2bbf04b7cb781b2da75f1dc3dfb7',1,11,5,1,2),(13,350000,'2025-09-26 03:41:02','COMPLETED','b1addb8c8ebf04eb62e6a8f6cbdc9126',1,11,5,1,1),(14,8400,'2025-07-11 12:38:38','COMPLETED','2c089ba3acb84f8ad5a65ddf3c7391e9',1,14,7,1,1),(15,6000,'2025-09-30 15:15:20','COMPLETED','1049851780f45d04809dabc8ede4d134',1,14,7,1,3),(16,210000,'2025-07-10 17:45:33','COMPLETED','553fe0927cba9af285198d774c5200a5',1,15,8,1,2),(17,10000,'2025-08-23 08:46:50','COMPLETED','29acc83b2ae63794bd8d819b4dd45695',1,14,7,1,3),(18,18000,'2025-07-12 05:05:45','COMPLETED','cfaa567fbeebdcc321ec5a99c06b5175',1,15,8,1,2),(19,26000,'2025-09-02 02:52:06','COMPLETED','e8089513a2ac6da74d1dab9aa597c7c0',1,14,7,1,3),(20,85000,'2025-08-15 14:04:24','COMPLETED','609d1c4eb873b77adb53fadcc52bc108',1,11,5,1,3),(21,2600,'2025-08-15 11:22:23','COMPLETED','8158a309eb26e7f2e8a7af9a981dceed',1,14,7,1,3),(22,85000,'2025-09-06 02:56:24','COMPLETED','6b56761b5aca67b6c834b6fb68475256',1,11,5,1,1),(23,3600,'2025-07-23 10:28:05','COMPLETED','099b122d47114d92c4d4a09283e7aabb',1,15,8,1,1),(24,3600,'2025-09-14 21:19:48','COMPLETED','37be031884e142d25c6d623a16082b1b',1,14,7,1,1),(25,52000,'2025-07-23 15:32:46','COMPLETED','d9d209f01239f438b0a0a7d9d00d1485',1,14,7,1,1),(26,20000,'2025-06-08 17:58:39','COMPLETED','744bfc18b14b5598b8826dc66f0cbd83',1,14,7,1,2),(27,88000,'2025-08-28 05:22:08','COMPLETED','7aa21596395202aaae063e0f4abc0f78',1,15,8,1,2),(28,44000,'2025-07-12 20:29:45','COMPLETED','4f691f250847f67380729a77af73b121',1,15,8,1,2),(29,1300000,'2025-07-11 03:40:57','COMPLETED','4161aff64c197cc4352b3e163c606369',1,11,5,1,3),(30,8000,'2025-09-03 05:31:53','COMPLETED','b1c7ae9a124a7996dcea623e89d786b0',1,14,7,1,3),(31,10000,'2025-07-01 12:27:40','COMPLETED','ccaec98f2bcba7e0a32facc8f739233e',1,14,7,1,3),(32,9000,'2025-06-28 12:20:04','COMPLETED','30f1b02c7d0b0f8980c24b33048eca60',1,15,8,1,2),(33,154000,'2025-07-18 03:54:07','COMPLETED','e2ccf486ed28050bf96c685efcd6ae21',1,15,8,1,3),(34,540000,'2025-06-24 16:07:30','COMPLETED','19b1e4691d4690cacd0f7f2616dd15b8',1,11,5,1,1),(35,7200,'2025-07-01 16:24:51','COMPLETED','c062e5329519c041b4185e7d32b435ed',1,15,8,1,1),(36,280000,'2025-08-09 21:16:37','COMPLETED','dac47907ef58e2f1935dc11e74725755',1,15,8,1,2),(37,1200,'2025-06-06 16:45:38','COMPLETED','6943ea9682ef2359cfd4181c3082c9f3',1,14,7,1,3),(38,44000,'2025-08-04 01:54:22','COMPLETED','3198d72490433797acf0b1bcad0a9a20',1,15,8,1,1),(39,2500,'2025-09-11 14:41:35','COMPLETED','b7f4de3d5a75c5bdf2a7fa7ac4bb99bc',1,15,8,1,3),(40,350000,'2025-09-20 06:03:31','COMPLETED','dbc064deaefd990830d87630cc1d6966',1,11,5,1,2),(41,700000,'2025-08-14 09:46:44','COMPLETED','9db5b7d00770b1fc159b4cc309fca843',1,11,5,1,2),(42,255000,'2025-06-06 08:55:33','COMPLETED','4cff888c3daeb6548f33ebb2461fa2b8',1,11,5,1,1),(43,44000,'2025-06-29 09:42:24','COMPLETED','f6e41a12a65a409518647399710809e7',1,15,8,1,3),(44,170000,'2025-07-17 08:03:10','COMPLETED','64434d382785d75fdf66dc9667ec5a59',1,11,5,1,2),(45,22500,'2025-09-20 22:35:03','COMPLETED','9839ace325be2acbe7bb76a42fa05afe',1,15,8,1,2),(46,5400,'2025-06-04 07:36:07','COMPLETED','45a6f9ac7bbcf3307ca9958345d8a924',1,15,8,1,3),(47,650000,'2025-07-09 00:03:13','COMPLETED','0b701f92a7fca107f5ed0a36568a7e9b',1,11,5,1,3),(48,1300,'2025-07-24 17:03:02','COMPLETED','22765dc2a3304b7f5c65f14e38eb4e4c',1,14,7,1,1),(49,5000,'2025-08-30 08:07:28','COMPLETED','194b76e0ba92ed109e2cc9eaa48a700c',1,14,7,1,3),(50,1250,'2025-07-03 14:55:48','COMPLETED','6e00116f5a5d9bbac05a8ff7762f02d5',1,14,7,1,1),(51,1050000,'2025-07-27 22:15:20','COMPLETED','29f4194dccfd663b2c7f377f298485bc',1,11,5,1,3),(52,2600,'2025-07-05 03:33:24','COMPLETED','962b66a20fe910f704b7bb8b9d4678bc',1,14,7,1,2),(53,180000,'2025-07-05 01:03:07','COMPLETED','812c1e5e663347de5cdb9e9ec9c641f8',1,11,5,1,2),(54,198000,'2025-08-30 14:27:21','COMPLETED','cb55b34ba8ad1e8a259d53c0876a6726',1,15,8,1,2),(55,180000,'2025-07-06 02:18:15','COMPLETED','28a32f8b4cc1790900bd04a2d18ad642',1,11,5,1,2),(56,280000,'2025-08-03 01:45:39','COMPLETED','0f421be6e349a47ad84ecaf95596be78',1,11,5,1,1),(57,65000,'2025-06-15 12:57:14','COMPLETED','984f198d0c6c2a5f77790b4098928e07',1,14,7,1,1),(58,12600,'2025-06-03 04:56:12','COMPLETED','c7362a7690c429e89369aa291fcd04ee',1,15,8,1,1),(59,255000,'2025-08-13 21:22:10','COMPLETED','1e1fa573486d35c420e4627c8c2fe9af',1,11,5,1,3),(60,4000,'2025-08-02 20:55:03','COMPLETED','09f2221fe96c2f54f843b9f97d7aa7f2',1,14,7,1,2),(61,5200,'2025-07-31 12:07:02','COMPLETED','fc1c9eb8582ff4ab3bd132f942744f43',1,14,7,1,3),(62,360000,'2025-08-09 16:11:50','COMPLETED','88b16d60c11a73c9f15c225b8a58a585',1,11,5,1,3),(63,2000,'2025-06-10 15:32:41','COMPLETED','dd4453b7f6f3cbdf8aece4093b258867',1,14,7,1,3),(64,1950000,'2025-09-12 04:26:39','COMPLETED','ca1d1afe776d2ad751fe1c9c47984896',1,11,5,1,1),(65,85000,'2025-09-05 15:49:05','COMPLETED','9664c00a0b3e6d37d5f96fff33491ad2',1,11,5,1,3),(66,70000,'2025-06-20 17:08:30','COMPLETED','7c3c41c964a13da0e72980df46469fcb',1,15,8,1,1),(67,1300000,'2025-07-14 11:32:12','COMPLETED','3cdfc95ac90c8a9d1dd679555fa54c7f',1,11,5,1,2),(68,210000,'2025-07-02 00:50:13','COMPLETED','cdbf8612e348a139d036deb5180b2bfc',1,15,8,1,2),(69,280000,'2025-09-15 10:49:52','COMPLETED','2bf0c94d0d993cf9afcd77d13f25addc',1,11,5,1,3),(70,7200,'2025-08-04 18:35:35','COMPLETED','6cf1bedff744c7310f97b6def4dbd221',1,14,7,1,1),(71,350000,'2025-06-23 05:38:34','COMPLETED','ffe02083208e9314249551cb154f0e80',1,15,8,1,3),(72,4500,'2025-09-02 21:54:50','COMPLETED','09db3be518af9a7bb337934ed40efdee',1,15,8,1,2),(73,650000,'2025-06-23 13:25:25','COMPLETED','6860e7bbc07c441a4f1e3457a77a69a8',1,11,5,1,3),(74,22500,'2025-07-02 09:47:44','COMPLETED','bc14a3cf45b9b8c4ea6061563d459750',1,15,8,1,2),(75,650000,'2025-07-11 20:30:48','COMPLETED','d1266f3bd9ba4111dc940d0d19c79846',1,11,5,1,2),(76,7200,'2025-08-06 08:21:46','COMPLETED','466a3c4a811d271045fb7f28f8082b2b',1,15,8,1,3),(77,210000,'2025-09-03 15:33:50','COMPLETED','978f9f263a35852ef9d82897e05eb467',1,15,8,1,2),(78,6250,'2025-08-09 16:20:31','COMPLETED','b648520daa38c651c5920bfa6dabdbca',1,14,7,1,2),(79,31500,'2025-07-04 18:52:01','COMPLETED','4754d8291f271a60b76d84b488e57c28',1,15,8,1,2),(80,350000,'2025-08-09 18:43:15','COMPLETED','87c5939c510e76a7703972e55673b68f',1,11,5,1,1),(81,360000,'2025-07-08 07:33:50','COMPLETED','14e75153f95d64bbf5f949984ecb79df',1,11,5,1,2),(82,52000,'2025-08-01 08:14:09','COMPLETED','903f027a27a27b51b8b68a3ad66d31b2',1,14,7,1,1),(83,132000,'2025-06-17 14:25:17','COMPLETED','177c6336cfde96499b30113d6a0b78e4',1,15,8,1,1),(84,85000,'2025-07-18 16:39:12','COMPLETED','1c08bccdd8530d9fee22b4a8ab00c021',1,11,5,1,1),(85,13500,'2025-08-19 20:22:12','COMPLETED','5075522f381758ddeac535bfe8dd479f',1,15,8,1,3),(86,10000,'2025-08-09 05:50:34','COMPLETED','840be39ce90499ec09edcd86adc30dad',1,15,8,1,2),(87,8000,'2025-07-07 10:10:29','COMPLETED','e9afa9ef2ffb2f69c11b408f8517e739',1,14,7,1,3),(88,280000,'2025-06-24 11:03:47','COMPLETED','27866ef176a3df503ab616c8bff3055a',1,11,5,1,3),(89,1300,'2025-08-19 12:43:57','COMPLETED','6a810d7df0e3e02dd8dec8a25fc9538a',1,14,7,1,3),(90,176000,'2025-06-26 15:02:07','COMPLETED','b6c8c9a6a82fd7e7b6ccb4bd3fc6c32f',1,15,8,1,2),(91,2600,'2025-08-19 06:22:00','COMPLETED','4e35fbc7d8d78e4417782210116b4487',1,14,7,1,3),(92,220000,'2025-08-12 05:51:42','COMPLETED','80f83024e0dc9d4d78b241e3e4e51d9a',1,15,8,1,3),(93,2000,'2025-09-07 16:54:28','COMPLETED','df75c2614b9adea098c4823e1ef08a12',1,14,7,1,2),(94,255000,'2025-08-11 08:39:10','COMPLETED','41f1bbe4896386aaa855ac99a0f845d9',1,11,5,1,3),(95,18000,'2025-07-01 09:45:34','COMPLETED','f6f1c4d5740a63ddc69d2df033aad379',1,14,7,1,2),(96,7500,'2025-08-25 15:31:37','COMPLETED','dd398d62d0c5fbe91ae30e2e5ee124f6',1,15,8,1,2),(97,350000,'2025-07-11 22:45:56','COMPLETED','ee32708c825abd371404737bac7bb256',1,11,5,1,2),(98,105000,'2025-09-05 07:54:39','COMPLETED','4c509d9eb51e87d767c3e71381eb0458',1,15,8,1,2),(99,105000,'2025-08-29 12:53:51','COMPLETED','f9edf69a6efad2573553398f421944f1',1,15,8,1,3),(100,840000,'2025-07-20 12:50:41','COMPLETED','b1b4d8ad675c3f6b6586a3716f5ed6a2',1,11,5,1,3),(101,11700,'2025-08-14 07:20:46','COMPLETED','a286c65173d5120a72607530042e0e70',1,14,7,1,3),(102,360000,'2025-08-26 00:13:02','COMPLETED','1555f39815ce89e99f57da01466a8613',1,11,5,1,2),(103,540000,'2025-08-15 12:36:24','COMPLETED','eeec88f13a2d071c57d8fd8205788fc4',1,11,5,1,1),(104,700000,'2025-07-28 14:34:00','COMPLETED','e98400d0e36d4aa8cb9377bfa4ae0727',1,11,5,1,1),(105,1050000,'2025-08-15 05:06:46','COMPLETED','479cbbb4a45c78a388209b440a79604b',1,11,5,1,2),(106,10800,'2025-07-28 21:05:36','COMPLETED','64b0d6db9cfd311c6a72ca685b50c4cc',1,15,8,1,3),(107,8400,'2025-06-13 12:00:21','COMPLETED','e08952206cfa742d67c33f2b8dd652ac',1,14,7,1,3),(108,2600,'2025-08-23 06:25:17','COMPLETED','ab7109667dfd98c0d6003bf7383da3a9',1,14,7,1,1),(109,13500,'2025-09-29 08:47:54','COMPLETED','e02f68041184f5491fea07571b92e32e',1,15,8,1,1),(110,180000,'2025-09-18 18:37:46','COMPLETED','f17ca481b2571b921ca4c23006babe12',1,11,5,1,1),(111,9000,'2025-09-04 17:07:19','COMPLETED','73740b653706cb17876c719009adfdff',1,15,8,1,1),(112,70000,'2025-08-23 03:43:17','COMPLETED','e33ba3212cf6259327c5f5d8714095b6',1,15,8,1,1),(113,13500,'2025-08-05 10:52:04','COMPLETED','c32df5e2a6acd3c9143c90255405c84a',1,15,8,1,3),(114,19500,'2025-06-05 06:26:22','COMPLETED','8441094dec963b3584ddc7e0bdf368c3',1,14,7,1,2),(115,8400,'2025-06-03 04:52:52','COMPLETED','da0b8f0e9a8a4af1fb853c0cd9d50b42',1,14,7,1,3),(116,255000,'2025-09-22 11:21:16','COMPLETED','99cec68632eb2002ce2cf379045f9644',1,11,5,1,1),(117,3750,'2025-09-13 22:27:23','COMPLETED','69d6e04962fd940b6b0ebb67aaa3ab2f',1,14,7,1,2),(118,7500,'2025-06-08 22:55:48','COMPLETED','aaeda575e9cb2a5f4b204d7269672d73',1,14,7,1,1),(119,360000,'2025-07-06 22:43:44','COMPLETED','e620f1cd62fac3908651918baf18832a',1,11,5,1,2),(120,220000,'2025-08-16 00:57:48','COMPLETED','05789f22124b39a834b6ad46062f6d71',1,15,8,1,1),(121,5200,'2025-06-28 18:42:09','COMPLETED','abfbf272218c478d05aea8bba7a77f22',1,14,7,1,2),(122,13500,'2025-09-28 10:09:28','COMPLETED','7570662e7aa05a56c1561a77f2ae8b89',1,15,8,1,3),(123,11700,'2025-09-29 13:53:45','COMPLETED','c07040ce1dae6d01edab7e6a359f0974',1,14,7,1,1),(124,360000,'2025-08-07 05:55:54','COMPLETED','51b67b3da0ddf9556a9f2ef9b0dcc0b9',1,11,5,1,3),(125,360000,'2025-07-04 12:33:10','COMPLETED','7f4cc38d8a29b9aea3e6ea1ef7e6b639',1,11,5,1,1),(126,175000,'2025-08-15 11:19:09','COMPLETED','47f49630f50ef46cc27f5dca6b0330d7',1,15,8,1,3),(127,1800,'2025-06-05 19:14:43','COMPLETED','d29a8f217a0a155d969cb7a13d987a57',1,15,8,1,3),(128,360000,'2025-07-17 11:32:15','COMPLETED','23fd90f15000251a5a6505b6ff14361e',1,11,5,1,2),(129,66000,'2025-09-28 09:56:31','COMPLETED','dd1cbd28f3d6608950b9cd7881108e05',1,15,8,1,3),(130,19500,'2025-09-29 09:06:14','COMPLETED','d52dbffcd0be61648f32ca880b3129a5',1,14,7,1,3),(131,18000,'2025-08-30 16:51:10','COMPLETED','381fb9c9ded4f2a64a2e22dd058ce45e',1,14,7,1,1),(132,280000,'2025-06-27 11:02:43','COMPLETED','d4ef890aa4430eb7bceec21c69d53e31',1,11,5,1,2),(133,10000,'2025-06-21 19:46:19','COMPLETED','fa2a84a4c86b73243ce7684f0d28421d',1,14,7,1,1),(134,5400,'2025-07-08 16:33:36','COMPLETED','278613004da3b9edbe953cb35645084b',1,15,8,1,2),(135,180000,'2025-07-19 01:28:13','COMPLETED','7cf2f528a91652e2e63c8bfbd5265e5e',1,11,5,1,3),(136,170000,'2025-09-19 01:07:23','COMPLETED','08f2e3d19582bd20cd12f63458d37ebc',1,11,5,1,2),(137,1050000,'2025-07-30 17:20:21','COMPLETED','b28ceda63629fd0b3765b507f4eebb4e',1,11,5,1,3),(138,560000,'2025-09-24 09:56:30','COMPLETED','9ea00af2550e224f14b5ca45a7373fbe',1,11,5,1,3),(139,1050000,'2025-07-10 03:41:03','COMPLETED','3fb690140dca64eab248792b37400449',1,11,5,1,1),(140,180000,'2025-08-17 14:58:05','COMPLETED','b70a9847dfdcf064eb80e78c7b843102',1,11,5,1,2),(141,700000,'2025-06-18 07:07:36','COMPLETED','6da53597e4f2a0de4842183807127f1c',1,11,5,1,3),(142,10000,'2025-08-24 14:08:50','COMPLETED','87a655fe54772bb133d872177dd6de1d',1,15,8,1,3),(143,12600,'2025-09-18 13:35:15','COMPLETED','fef9e09ff2a0d59065a1a5bfcbe9150f',1,15,8,1,2),(144,85000,'2025-08-17 20:19:57','COMPLETED','37251f0474a12d39737877f7c906bbc1',1,11,5,1,3),(145,1300000,'2025-09-15 15:04:15','COMPLETED','83246b064ddb6f42786f79afa04cf8fc',1,11,5,1,1),(146,22500,'2025-09-22 19:04:48','COMPLETED','091df692a0a92f99f7c9d1e5b65c871a',1,15,8,1,3),(147,280000,'2025-08-02 20:51:45','COMPLETED','a6b67041d483634310bff3edfda30349',1,11,5,1,1),(148,18000,'2025-06-15 01:43:23','COMPLETED','f7d829c9e39b46c329ceb7a2457a50e5',1,14,7,1,3),(149,700000,'2025-07-22 00:25:01','COMPLETED','3d662230b5b94474f1c12ad3131066a8',1,11,5,1,3),(150,255000,'2025-08-16 16:23:52','COMPLETED','454c57cdd585db9a8660f31a9942f08c',1,11,5,1,1),(151,154000,'2025-09-13 19:46:24','COMPLETED','3f01f21e7b5f7c3c31a6d7443e4d4ae7',1,15,8,1,3),(152,14000,'2025-09-16 14:47:06','COMPLETED','2b6de8c74050beda55b9afedc80d8b1d',1,14,7,1,1),(153,1250,'2025-07-02 16:23:45','COMPLETED','cf8d6972dbf4b5d4d890bab9ad6b9316',1,14,7,1,2),(154,176000,'2025-07-11 04:53:56','COMPLETED','b3ce87527c02f505f88705274e3d00de',1,15,8,1,1),(155,85000,'2025-08-30 11:47:28','COMPLETED','c6ce9660372ce377fb9d82cc144bf913',1,11,5,1,1),(156,10800,'2025-07-10 15:17:25','COMPLETED','72a726a0f223260508bcabca036a94b3',1,15,8,1,1),(157,52000,'2025-07-20 17:01:50','COMPLETED','17bd3065d7437bca297137a48807ea56',1,14,7,1,1),(158,700000,'2025-06-21 11:53:03','COMPLETED','d438eb0c611432d4682df6eceb7319a3',1,11,5,1,2),(159,31500,'2025-09-26 03:40:56','COMPLETED','2eabe35447a196051377ec91eafc8ce2',1,15,8,1,3),(160,66000,'2025-06-13 22:08:46','COMPLETED','a13d9b377651043f92423db0c9df3446',1,15,8,1,2),(161,180000,'2025-09-22 15:14:09','COMPLETED','e9e64bc506cc1780d7132b1643270689',1,11,5,1,1),(162,700000,'2025-08-15 19:10:14','COMPLETED','7423efb2f3ae3d27829b099fd9c15c60',1,11,5,1,3),(163,170000,'2025-08-20 16:32:37','COMPLETED','e1505797afecfee13bc1bf597ae49471',1,11,5,1,2),(164,180000,'2025-09-01 19:28:51','COMPLETED','565fb6089083ca441d6974e91ec7c909',1,11,5,1,3),(165,180000,'2025-08-11 19:56:16','COMPLETED','19ffcf88c327a312883b10179d5a2355',1,11,5,1,2),(166,10000,'2025-08-19 06:22:02','COMPLETED','f129452d29f5c9c1512289e646df5cf5',1,14,7,1,1),(167,1250,'2025-06-11 12:53:55','COMPLETED','b00d70884e59aaa19567ba6988f57f57',1,14,7,1,3),(168,560000,'2025-06-29 03:28:55','COMPLETED','f4106a8ef32dca3788ba3672a310a61e',1,11,5,1,1),(169,66000,'2025-07-05 00:54:33','COMPLETED','6701fbde4fece68999ea3a3846e1d8c9',1,15,8,1,1),(170,280000,'2025-09-12 10:43:23','COMPLETED','1219e7ab00123dcac9fff5b479ae5898',1,11,5,1,3),(171,220000,'2025-07-25 00:27:14','COMPLETED','d7ecebbb7a847481740b63cd90bcfd7a',1,15,8,1,3),(172,8400,'2025-08-10 00:52:21','COMPLETED','05aa5cbf6cf24685ad23af3e4978ab0f',1,14,7,1,1),(173,12500,'2025-09-10 12:08:08','COMPLETED','d24b504fc5b1ef0ac054958fc28008c3',1,15,8,1,1),(174,154000,'2025-06-11 15:34:51','COMPLETED','2f8cb679238f44290ad5b5f1318c37be',1,15,8,1,2),(175,35000,'2025-09-25 04:43:10','COMPLETED','554783644d25be088b4f1cb7485ecd78',1,15,8,1,2),(176,175000,'2025-06-07 12:50:38','COMPLETED','af89b589f07f5814a013f283464846d1',1,15,8,1,3),(177,170000,'2025-09-06 12:09:07','COMPLETED','2314988372c2cf39ae217abe2bec554d',1,11,5,1,1),(178,22500,'2025-09-22 21:26:27','COMPLETED','6812f5d3d3299e1070e2f4e9936eacae',1,15,8,1,3),(179,6250,'2025-09-23 00:58:51','COMPLETED','a5686fd9f2aed9157a24d1453e2100b9',1,14,7,1,2),(180,40500,'2025-06-13 02:42:17','COMPLETED','33b9529fa862ae6d4064670ff8273088',1,15,8,1,1),(181,175000,'2025-07-14 22:56:49','COMPLETED','ac34c9badd4a27036e6cdcfdeb143b6e',1,15,8,1,1),(182,3900,'2025-07-20 07:45:54','COMPLETED','248b3fe040819329d7a326da778c5998',1,14,7,1,1),(183,40500,'2025-08-16 04:52:47','COMPLETED','f5119065d1d9e9d31d82161a0a2e93d0',1,15,8,1,2),(184,180000,'2025-08-21 16:34:44','COMPLETED','33dfc839b70ab819011fc4e1b178e641',1,11,5,1,3),(185,7200,'2025-08-13 11:15:49','COMPLETED','973d5f7d28b8396df356be21c9b073b3',1,14,7,1,2),(186,22500,'2025-09-04 13:14:28','COMPLETED','f5a0899bf06f2842284a5220af3fdfd4',1,15,8,1,3),(187,840000,'2025-06-27 15:53:31','COMPLETED','6554f547d60b26bfe997d2f2f9df1b55',1,11,5,1,3),(188,5400,'2025-09-28 11:26:42','COMPLETED','7c06a4ce77a029d50a4d598085ff86b9',1,15,8,1,1),(189,560000,'2025-06-20 02:54:19','COMPLETED','0af132942266a36c3d35052b2f5a2f92',1,11,5,1,3),(190,2600,'2025-08-06 21:17:38','COMPLETED','835e7ce78f085aa8f633ea2a919b9ae7',1,14,7,1,2),(191,39000,'2025-06-16 15:38:16','COMPLETED','7a843a86a32812abf2e1a070c08cac4b',1,14,7,1,2),(192,650000,'2025-09-15 21:11:15','COMPLETED','c7cd292346fa3b715248bfd0daacc1eb',1,11,5,1,3),(193,22500,'2025-09-20 21:29:36','COMPLETED','ff5dcf38db0477352a0f5507c1f28a00',1,15,8,1,2),(194,350000,'2025-08-07 06:08:48','COMPLETED','13d16e1a8b58d1e066ab0912edaa74e6',1,11,5,1,3),(195,154000,'2025-09-27 06:19:45','COMPLETED','0f617a103feafedd08fa9db677ca0fa5',1,15,8,1,3),(196,8750,'2025-08-22 13:53:47','COMPLETED','7ae1a2fca912bd4cdf89b88e3fd3a69b',1,14,7,1,1),(197,650000,'2025-08-17 00:03:10','COMPLETED','73ea29d0f298ea29890c27d579620b60',1,11,5,1,3),(198,9000,'2025-07-25 06:46:02','COMPLETED','3e2b8fe47ef67c567afa37155e32aab2',1,15,8,1,3),(199,255000,'2025-09-23 17:37:52','COMPLETED','35654c5ed9ac2b457fc54bd29f9d02f1',1,11,5,1,2),(200,10000,'2025-09-12 10:52:02','COMPLETED','1153aabbf5dbf2a70c85aff3c6a48427',1,14,7,1,2),(201,4500,'2025-06-14 08:10:46','COMPLETED','53a07c7b1ec26a14316e66db3925c32e',1,15,8,1,2),(202,2500,'2025-09-10 08:23:49','COMPLETED','aa9f919456dfa07a87a054149c34b260',1,14,7,1,1),(203,180000,'2025-09-18 19:57:17','COMPLETED','2a26de3bc51f9090fd33dfa26d5353a7',1,11,5,1,2),(204,6000,'2025-07-07 07:35:55','COMPLETED','9f115eeb7a3af1474c13b7fbc11d402a',1,14,7,1,3),(205,350000,'2025-06-24 13:24:19','COMPLETED','f34de55b82fb6d0644650bc1458f9f6c',1,11,5,1,2),(206,360000,'2025-09-08 13:22:06','COMPLETED','55dc0807782eb6f4cabc3ee157ae58b3',1,11,5,1,2),(207,840000,'2025-08-20 03:35:37','COMPLETED','735d1bbd8c725ea1527d3085e78b2d90',1,11,5,1,2),(208,1050000,'2025-07-19 03:48:40','COMPLETED','04a8324e18c16411c14c724e8498bcd2',1,11,5,1,3),(209,6500,'2025-08-19 06:17:41','COMPLETED','2a239dc9698d41dd6194b951dd7cc650',1,14,7,1,2),(210,350000,'2025-08-20 09:56:32','COMPLETED','27a4a057a1dd4167edd6d69a30bc7341',1,11,5,1,3),(211,12500,'2025-09-22 02:21:25','COMPLETED','80c988534c8af734f01d1053c9399eda',1,15,8,1,1),(212,1250,'2025-09-14 10:54:14','COMPLETED','162f9a473135d7a85f7aecab58bc5bce',1,14,7,1,2),(213,9000,'2025-07-13 22:52:28','COMPLETED','ec990f6f5950a739d8eee9964ddf5d1d',1,15,8,1,3),(214,4500,'2025-07-16 03:51:50','COMPLETED','5030de65975d32161596c4259bdcde46',1,15,8,1,3),(215,5000,'2025-08-10 01:57:40','COMPLETED','2fed7fd8409d47789d19732d48dd2d1b',1,14,7,1,2),(216,4800,'2025-07-16 04:04:44','COMPLETED','aba25ae2174160241df3fdadb648e701',1,14,7,1,2),(217,36000,'2025-07-28 12:08:02','COMPLETED','c8a8bdeb7d516de93593bb76154d0f4e',1,15,8,1,3),(218,85000,'2025-09-26 12:36:26','COMPLETED','3d0b222f1f356680e4133ff2867bdd02',1,11,5,1,2),(219,39000,'2025-06-11 20:37:32','COMPLETED','22b887fe57062d24104b78e290bccd13',1,14,7,1,3),(220,12000,'2025-06-22 05:44:02','COMPLETED','df5f7a7419c6e7a24e9c41be2dd03495',1,14,7,1,3),(221,3750,'2025-09-29 09:07:19','COMPLETED','1e3af4d0a0dfa9df7b1638c95111842b',1,14,7,1,1),(222,12600,'2025-06-19 07:07:36','COMPLETED','4e299de5a0b3120b775bfd03030f6402',1,15,8,1,3),(223,560000,'2025-06-13 17:02:57','COMPLETED','883514d41dd4267610f5ecdee7c88867',1,11,5,1,3),(224,840000,'2025-07-02 18:40:04','COMPLETED','d148086f158da7dd7adb194efe688fc5',1,11,5,1,1),(225,540000,'2025-09-03 07:50:22','COMPLETED','8c9d33def68f031fd597c2fcb9965176',1,11,5,1,2),(226,560000,'2025-06-18 12:12:19','COMPLETED','5047a080afc7a6ea0da97aa3df8cd268',1,11,5,1,1),(227,8000,'2025-07-18 01:22:45','COMPLETED','939b40d6b5a42e7854bf5d7ab23ef531',1,14,7,1,3),(228,176000,'2025-06-28 14:45:56','COMPLETED','c4e65c85171bb9ed3b6bdd6e802de2ac',1,15,8,1,2),(229,1300000,'2025-06-14 02:50:57','COMPLETED','417205aac1b53f06ab4f60d90c0e7771',1,11,5,1,1),(230,14000,'2025-07-30 15:47:00','COMPLETED','894b663760c1c49b49deb88d80cce9b1',1,14,7,1,2),(231,540000,'2025-09-12 03:12:38','COMPLETED','5cddbc36ff82505fab440129d656077f',1,11,5,1,2),(232,31500,'2025-06-19 09:21:38','COMPLETED','caabfae027637760f64f4a766ac37519',1,15,8,1,1),(233,1050000,'2025-09-24 13:47:15','COMPLETED','f0ca137ab0db87cd25fdf7da8a20bd11',1,11,5,1,3),(234,22500,'2025-08-04 21:08:55','COMPLETED','f7999c701ac87df59ea2f81cfcb23f40',1,15,8,1,1),(235,540000,'2025-08-01 11:05:54','COMPLETED','ee014ffda7e69d1387141e0bec9653d6',1,11,5,1,2),(236,540000,'2025-07-16 20:28:44','COMPLETED','e12e2fffe9b314420b7c61996c55d550',1,11,5,1,1),(237,840000,'2025-07-10 12:37:32','COMPLETED','d0db1017312ae496623c26abe6b82f13',1,11,5,1,3),(238,1950000,'2025-07-07 15:19:35','COMPLETED','2e4abfb2bb5a375c0b6802d5257bf7d7',1,11,5,1,3),(239,255000,'2025-08-22 13:01:18','COMPLETED','f701c199c2a806c2f82c484e2e196898',1,11,5,1,2),(240,280000,'2025-09-11 15:58:49','COMPLETED','a49ffbb665a425e91f24b6a7b1770068',1,11,5,1,1),(241,280000,'2025-09-30 18:32:29','COMPLETED','d8cfbaa2a05105de99a88f94a3163517501a89606c3a232e33311e82dc0d556b',1,11,5,1,1),(242,280000,'2025-09-30 18:33:09','COMPLETED','e12e0623026ca40ab055a563bc1f05645d4f2a47cdc6cd3e79ebdebf2991eb56',1,11,5,1,1);
/*!40000 ALTER TABLE `Transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UnitMeasures`
--

DROP TABLE IF EXISTS `UnitMeasures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UnitMeasures` (
  `unitMeasureId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`unitMeasureId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UnitMeasures`
--

LOCK TABLES `UnitMeasures` WRITE;
/*!40000 ALTER TABLE `UnitMeasures` DISABLE KEYS */;
INSERT INTO `UnitMeasures` VALUES (1,'Unidad','UND'),(2,'Litros','LTS'),(3,'Kilogramos','KGS');
/*!40000 ALTER TABLE `UnitMeasures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserBusiness`
--

DROP TABLE IF EXISTS `UserBusiness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserBusiness` (
  `userId` int NOT NULL,
  `BusinessId` int NOT NULL,
  `status` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`userId`,`BusinessId`),
  KEY `fk_Users_has_Business_Business1_idx` (`BusinessId`),
  KEY `fk_Users_has_Business_Users1_idx` (`userId`),
  CONSTRAINT `fk_Users_has_Business_Business1` FOREIGN KEY (`BusinessId`) REFERENCES `Business` (`businessId`),
  CONSTRAINT `fk_Users_has_Business_Users1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserBusiness`
--

LOCK TABLES `UserBusiness` WRITE;
/*!40000 ALTER TABLE `UserBusiness` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserBusiness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserPermissions`
--

DROP TABLE IF EXISTS `UserPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPermissions` (
  `userId` int NOT NULL,
  `permission_id` int NOT NULL,
  `userPermssionStatus` enum('ACTIVE','INACTIVE','ELIMINATED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`userId`,`permission_id`),
  KEY `fk_Users_has_Permissions_Permissions1_idx` (`permission_id`),
  KEY `fk_Users_has_Permissions_Users1_idx` (`userId`),
  CONSTRAINT `fk_Users_has_Permissions_Permissions1` FOREIGN KEY (`permission_id`) REFERENCES `Permissions` (`permissionId`),
  CONSTRAINT `fk_Users_has_Permissions_Users1` FOREIGN KEY (`userId`) REFERENCES `Users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPermissions`
--

LOCK TABLES `UserPermissions` WRITE;
/*!40000 ALTER TABLE `UserPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userNationalId` varchar(20) NOT NULL,
  `userFirstname` varchar(30) NOT NULL,
  `userLastname` varchar(40) NOT NULL,
  `userPassword` varbinary(160) NOT NULL,
  `userStatus` enum('ACTIVE','CHANGED','INACTIVE','DELETED') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `enabled` tinyint NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-30 19:00:25
