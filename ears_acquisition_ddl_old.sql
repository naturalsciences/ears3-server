--GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
--FLUSH PRIVILEGES;

--CREATE DATABASE IF NOT EXISTS `casino` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `casino`;
-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: 192.168.13.34    Database: casino
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.32-MariaDB-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `COMPOSITION`
--


CREATE TABLE hibernate_sequence (next_val bigint);

DROP TABLE IF EXISTS `COMPOSITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPOSITION` (
  `PROGRAM_ID` bigint(20) NOT NULL,
  `EVENT_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`PROGRAM_ID`,`EVENT_ID`),
  KEY `fk_event_idx` (`EVENT_ID`),
  CONSTRAINT `fk_event` FOREIGN KEY (`EVENT_ID`) REFERENCES `event` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CRUISE`
--

DROP TABLE IF EXISTS `CRUISE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CRUISE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `chiefScientist` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chiefScientistOrganisation` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `collateCenter` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cruiseId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cruiseName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endDate` timestamp NULL DEFAULT NULL,
  `objectives` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `platformClass` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `platformCode` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT NULL,
  `startingHarbor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `arrivalHarbor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `cruiseId` (`cruiseId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Cruise_SeaArea`
--

DROP TABLE IF EXISTS `Cruise_SeaArea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cruise_SeaArea` (
  `Cruise_ID` bigint(20) NOT NULL,
  `SeaArea_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`Cruise_ID`,`SeaArea_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Navigation`
--

DROP TABLE IF EXISTS `Navigation`;
DROP TABLE IF EXISTS Navigation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
/*CREATE TABLE `Navigation` (
  `ID` double NOT NULL AUTO_INCREMENT,
  `navigationId` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `depth` double DEFAULT NULL,
  `cog` double DEFAULT NULL,
  `sog` double DEFAULT NULL,
  `heading` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;*/
/*!40101 SET character_set_client = @saved_cs_client */;

create table Navigation (ID bigint not null, cog double precision, depth double precision, heading double precision, lat double precision, lon double precision, navigation_id varchar(15) not null, sog double precision, time timestamp, primary key (ID)) ENGINE=InnoDB

--
-- Table structure for table `PROGRAM`
--

DROP TABLE IF EXISTS `PROGRAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROGRAM` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ProgramId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CruiseId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originatorCode` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PIName` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_program_cruise` (`ProgramId`,`CruiseId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROJECT`
--

DROP TABLE IF EXISTS `PROJECT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROJECT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `projectId` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `projectName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Program_Project`
--

DROP TABLE IF EXISTS `Program_Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program_Project` (
  `PROGRAM_ID` bigint(20) NOT NULL,
  `PROJECT_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`PROGRAM_ID`,`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SEAAREA`
--

DROP TABLE IF EXISTS `SEAAREA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SEAAREA` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `URN` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SeaAreaId` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_urn` (`URN`),
  UNIQUE KEY `unique_SeaAreaId` (`SeaAreaId`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TOOL`
--

DROP TABLE IF EXISTS `TOOL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TOOL` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `idSuper` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_superID_idx` (`idSuper`),
  CONSTRAINT `fk_superID` FOREIGN KEY (`idSuper`) REFERENCES `TOOL` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Thermosal`
--

DROP TABLE IF EXISTS `Thermosal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Thermosal` (
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salinity` double DEFAULT '0',
  `surface_water_temperature` double DEFAULT '0',
  `raw_fluorometry` double DEFAULT '0',
  `conductivity` double DEFAULT '0',
  `sigmaT` double DEFAULT '0',
  `instrument_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`date_time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Weather`
--

DROP TABLE IF EXISTS `Weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Weather` (
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wind_speed` double DEFAULT '0',
  `wind_gust` double DEFAULT '0',
  `wind_direction` double DEFAULT '0',
  `air_temperature` double DEFAULT '0',
  `humidity` double DEFAULT '0',
  `solar_radiation` double DEFAULT '0',
  `air_preasure` double DEFAULT '0',
  `surface_water_temperature` double DEFAULT '0',
  `instrument_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`date_time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `timeStamp` datetime DEFAULT NULL,
  `actor` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `actionName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `actionProperty` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `categoryName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `toolID` bigint(10) DEFAULT NULL,
  `eventId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `eventId` (`eventId`),
  KEY `toolID` (`toolID`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`toolID`) REFERENCES `TOOL` (`ID`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'casino'
--

INSERT INTO `SEAAREA` VALUES (1,'URN:SDN:C19::GTLAK020','SDN:C19::GTLAK020'),(2,'URN:SDN:C19::10_7','SDN:C19::10_7'),(3,'URN:SDN:C19::10_6','SDN:C19::10_6'),(4,'URN:SDN:C19::10_5','SDN:C19::10_5'),(5,'URN:SDN:C19::GTLAK022','SDN:C19::GTLAK022'),(6,'URN:SDN:C19::GTLAK021','SDN:C19::GTLAK021'),(7,'URN:SDN:C19::10_4','SDN:C19::10_4'),(8,'URN:SDN:C19::10_3','SDN:C19::10_3'),(9,'URN:SDN:C19::10_2','SDN:C19::10_2'),(10,'URN:SDN:C19::10_1','SDN:C19::10_1'),(11,'URN:SDN:C19::8_4_','SDN:C19::8_4_'),(12,'URN:SDN:C19::GTLAK024','SDN:C19::GTLAK024'),(13,'URN:SDN:C19::GTLAK023','SDN:C19::GTLAK023'),(14,'URN:SDN:C19::10_9','SDN:C19::10_9'),(15,'URN:SDN:C19::GTLAK025','SDN:C19::GTLAK025'),(16,'URN:SDN:C19::10_8','SDN:C19::10_8'),(17,'URN:SDN:C19::10','SDN:C19::10'),(18,'URN:SDN:C19::GTLAK011','SDN:C19::GTLAK011'),(19,'URN:SDN:C19::GTLAK010','SDN:C19::GTLAK010'),(20,'URN:SDN:C19::10_6_1','SDN:C19::10_6_1'),(21,'URN:SDN:C19::GTLAK017','SDN:C19::GTLAK017'),(22,'URN:SDN:C19::7_1','SDN:C19::7_1'),(23,'URN:SDN:C19::GTLAK016','SDN:C19::GTLAK016'),(24,'URN:SDN:C19::GTLAK019','SDN:C19::GTLAK019'),(25,'URN:SDN:C19::7_2','SDN:C19::7_2'),(26,'URN:SDN:C19::7_3','SDN:C19::7_3'),(27,'URN:SDN:C19::GTLAK018','SDN:C19::GTLAK018'),(28,'URN:SDN:C19::GTLAK013','SDN:C19::GTLAK013'),(29,'URN:SDN:C19::7_4','SDN:C19::7_4'),(30,'URN:SDN:C19::7_5','SDN:C19::7_5'),(31,'URN:SDN:C19::GTLAK012','SDN:C19::GTLAK012'),(32,'URN:SDN:C19::7_6','SDN:C19::7_6'),(33,'URN:SDN:C19::GTLAK015','SDN:C19::GTLAK015'),(34,'URN:SDN:C19::7_7','SDN:C19::7_7'),(35,'URN:SDN:C19::GTLAK014','SDN:C19::GTLAK014'),(36,'URN:SDN:C19::7_8','SDN:C19::7_8'),(37,'URN:SDN:C19::7_9','SDN:C19::7_9'),(38,'URN:SDN:C19::1','SDN:C19::1'),(39,'URN:SDN:C19::2','SDN:C19::2'),(40,'URN:SDN:C19::3','SDN:C19::3'),(41,'URN:SDN:C19::4','SDN:C19::4'),(42,'URN:SDN:C19::5','SDN:C19::5'),(43,'URN:SDN:C19::6','SDN:C19::6'),(44,'URN:SDN:C19::7','SDN:C19::7'),(45,'URN:SDN:C19::8','SDN:C19::8'),(46,'URN:SDN:C19::9','SDN:C19::9'),(47,'URN:SDN:C19::IRM','SDN:C19::IRM'),(48,'URN:SDN:C19::GTLAK008','SDN:C19::GTLAK008'),(49,'URN:SDN:C19::GTLAK007','SDN:C19::GTLAK007'),(50,'URN:SDN:C19::GTLAK001','SDN:C19::GTLAK001'),(51,'URN:SDN:C19::GTLAK009','SDN:C19::GTLAK009'),(52,'URN:SDN:C19::6_1','SDN:C19::6_1'),(53,'URN:SDN:C19::5_17','SDN:C19::5_17'),(54,'URN:SDN:C19::6_2','SDN:C19::6_2'),(55,'URN:SDN:C19::6_3','SDN:C19::6_3'),(56,'URN:SDN:C19::6_4','SDN:C19::6_4'),(57,'URN:SDN:C19::6_5','SDN:C19::6_5'),(58,'URN:SDN:C19::6_6','SDN:C19::6_6'),(59,'URN:SDN:C19::MKM','SDN:C19::MKM'),(60,'URN:SDN:C19::6_7','SDN:C19::6_7'),(61,'URN:SDN:C19::6_8','SDN:C19::6_8'),(62,'URN:SDN:C19::5_10','SDN:C19::5_10'),(63,'URN:SDN:C19::6_9','SDN:C19::6_9'),(64,'URN:SDN:C19::5_12','SDN:C19::5_12'),(65,'URN:SDN:C19::5_11','SDN:C19::5_11'),(66,'URN:SDN:C19::5_14','SDN:C19::5_14'),(67,'URN:SDN:C19::5_13','SDN:C19::5_13'),(68,'URN:SDN:C19::5_16','SDN:C19::5_16'),(69,'URN:SDN:C19::5_15','SDN:C19::5_15'),(70,'URN:SDN:C19::10_12','SDN:C19::10_12'),(71,'URN:SDN:C19::10_11','SDN:C19::10_11'),(72,'URN:SDN:C19::10_14','SDN:C19::10_14'),(73,'URN:SDN:C19::5_1','SDN:C19::5_1'),(74,'URN:SDN:C19::5_2','SDN:C19::5_2'),(75,'URN:SDN:C19::5_3','SDN:C19::5_3'),(76,'URN:SDN:C19::5_4','SDN:C19::5_4'),(77,'URN:SDN:C19::5_5','SDN:C19::5_5'),(78,'URN:SDN:C19::5_6','SDN:C19::5_6'),(79,'URN:SDN:C19::5_7','SDN:C19::5_7'),(80,'URN:SDN:C19::5_8','SDN:C19::5_8'),(81,'URN:SDN:C19::5_9','SDN:C19::5_9'),(82,'URN:SDN:C19::SVX00003','SDN:C19::SVX00003'),(83,'URN:SDN:C19::SVX00004','SDN:C19::SVX00004'),(84,'URN:SDN:C19::SVX00001','SDN:C19::SVX00001'),(85,'URN:SDN:C19::SVX00002','SDN:C19::SVX00002'),(86,'URN:SDN:C19::6_19','SDN:C19::6_19'),(87,'URN:SDN:C19::6_18','SDN:C19::6_18'),(88,'URN:SDN:C19::6_11','SDN:C19::6_11'),(89,'URN:SDN:C19::7_8_1','SDN:C19::7_8_1'),(90,'URN:SDN:C19::6_10','SDN:C19::6_10'),(91,'URN:SDN:C19::6_13','SDN:C19::6_13'),(92,'URN:SDN:C19::6_12','SDN:C19::6_12'),(93,'URN:SDN:C19::6_15','SDN:C19::6_15'),(94,'URN:SDN:C19::6_14','SDN:C19::6_14'),(95,'URN:SDN:C19::6_17','SDN:C19::6_17'),(96,'URN:SDN:C19::6_16','SDN:C19::6_16'),(97,'URN:SDN:C19::1_15','SDN:C19::1_15'),(98,'URN:SDN:C19::1_14','SDN:C19::1_14'),(99,'URN:SDN:C19::4_1','SDN:C19::4_1'),(100,'URN:SDN:C19::1_13','SDN:C19::1_13'),(101,'URN:SDN:C19::4_2','SDN:C19::4_2'),(102,'URN:SDN:C19::4_3','SDN:C19::4_3'),(103,'URN:SDN:C19::6_22','SDN:C19::6_22'),(104,'URN:SDN:C19::6_21','SDN:C19::6_21'),(105,'URN:SDN:C19::6_23','SDN:C19::6_23'),(106,'URN:SDN:C19::10_10','SDN:C19::10_10'),(107,'URN:SDN:C19::1_12','SDN:C19::1_12'),(108,'URN:SDN:C19::1_11','SDN:C19::1_11'),(109,'URN:SDN:C19::1_10','SDN:C19::1_10'),(110,'URN:SDN:C19::6_20','SDN:C19::6_20'),(111,'URN:SDN:C19::SVX00025','SDN:C19::SVX00025'),(112,'URN:SDN:C19::SVX00023','SDN:C19::SVX00023'),(113,'URN:SDN:C19::SVX00024','SDN:C19::SVX00024'),(114,'URN:SDN:C19::SVX00021','SDN:C19::SVX00021'),(115,'URN:SDN:C19::SVX00022','SDN:C19::SVX00022'),(116,'URN:SDN:C19::SVX00020','SDN:C19::SVX00020'),(117,'URN:SDN:C19::UKMDN018','SDN:C19::UKMDN018'),(118,'URN:SDN:C19::UKMDN019','SDN:C19::UKMDN019'),(119,'URN:SDN:C19::UKMDN016','SDN:C19::UKMDN016'),(120,'URN:SDN:C19::UKMDN017','SDN:C19::UKMDN017'),(121,'URN:SDN:C19::UKMDN014','SDN:C19::UKMDN014'),(122,'URN:SDN:C19::UKMDN015','SDN:C19::UKMDN015'),(123,'URN:SDN:C19::UKMDN012','SDN:C19::UKMDN012'),(124,'URN:SDN:C19::UKMDN013','SDN:C19::UKMDN013'),(125,'URN:SDN:C19::UKMDN010','SDN:C19::UKMDN010'),(126,'URN:SDN:C19::UKMDN011','SDN:C19::UKMDN011'),(127,'URN:SDN:C19::NSL03','SDN:C19::NSL03'),(128,'URN:SDN:C19::IA','SDN:C19::IA'),(129,'URN:SDN:C19::NSL01','SDN:C19::NSL01'),(130,'URN:SDN:C19::NSL02','SDN:C19::NSL02'),(131,'URN:SDN:C19::SVX00018','SDN:C19::SVX00018'),(132,'URN:SDN:C19::SVX00019','SDN:C19::SVX00019'),(133,'URN:SDN:C19::8_4_1','SDN:C19::8_4_1'),(134,'URN:SDN:C19::SVX00016','SDN:C19::SVX00016'),(135,'URN:SDN:C19::SVX00017','SDN:C19::SVX00017'),(136,'URN:SDN:C19::SVX00014','SDN:C19::SVX00014'),(137,'URN:SDN:C19::SVX00015','SDN:C19::SVX00015'),(138,'URN:SDN:C19::SVX00012','SDN:C19::SVX00012'),(139,'URN:SDN:C19::SVX00013','SDN:C19::SVX00013'),(140,'URN:SDN:C19::SVX00010','SDN:C19::SVX00010'),(141,'URN:SDN:C19::SVX00011','SDN:C19::SVX00011'),(142,'URN:SDN:C19::3_1','SDN:C19::3_1'),(143,'URN:SDN:C19::UKMDN009','SDN:C19::UKMDN009'),(144,'URN:SDN:C19::3_2','SDN:C19::3_2'),(145,'URN:SDN:C19::3_3','SDN:C19::3_3'),(146,'URN:SDN:C19::UKMDN007','SDN:C19::UKMDN007'),(147,'URN:SDN:C19::3_4','SDN:C19::3_4'),(148,'URN:SDN:C19::UKMDN008','SDN:C19::UKMDN008'),(149,'URN:SDN:C19::UKMDN005','SDN:C19::UKMDN005'),(150,'URN:SDN:C19::UKMDN006','SDN:C19::UKMDN006'),(151,'URN:SDN:C19::UKMDN003','SDN:C19::UKMDN003'),(152,'URN:SDN:C19::UKMDN004','SDN:C19::UKMDN004'),(153,'URN:SDN:C19::UKMDN001','SDN:C19::UKMDN001'),(154,'URN:SDN:C19::UKMDN002','SDN:C19::UKMDN002'),(155,'URN:SDN:C19::7_13','SDN:C19::7_13'),(156,'URN:SDN:C19::7_11','SDN:C19::7_11'),(157,'URN:SDN:C19::7_12','SDN:C19::7_12'),(158,'URN:SDN:C19::2_2_2','SDN:C19::2_2_2'),(159,'URN:SDN:C19::SVX00009','SDN:C19::SVX00009'),(160,'URN:SDN:C19::2_2_1','SDN:C19::2_2_1'),(161,'URN:SDN:C19::SVX00007','SDN:C19::SVX00007'),(162,'URN:SDN:C19::SVX00008','SDN:C19::SVX00008'),(163,'URN:SDN:C19::7_10','SDN:C19::7_10'),(164,'URN:SDN:C19::SVX00005','SDN:C19::SVX00005'),(165,'URN:SDN:C19::SVX00006','SDN:C19::SVX00006'),(166,'URN:SDN:C19::ZZ','SDN:C19::ZZ'),(167,'URN:SDN:C19::IJM','SDN:C19::IJM'),(168,'URN:SDN:C19::3_1_1_1','SDN:C19::3_1_1_1'),(169,'URN:SDN:C19::3_1_1_2','SDN:C19::3_1_1_2'),(170,'URN:SDN:C19::3_1_1_3','SDN:C19::3_1_1_3'),(171,'URN:SDN:C19::7_6_1','SDN:C19::7_6_1'),(172,'URN:SDN:C19::3_1_1_4','SDN:C19::3_1_1_4'),(173,'URN:SDN:C19::3_1_1_5','SDN:C19::3_1_1_5'),(174,'URN:SDN:C19::5_15_1','SDN:C19::5_15_1'),(175,'URN:SDN:C19::3_1_2','SDN:C19::3_1_2'),(176,'URN:SDN:C19::2_1','SDN:C19::2_1'),(177,'URN:SDN:C19::2_2','SDN:C19::2_2'),(178,'URN:SDN:C19::2_3','SDN:C19::2_3'),(179,'URN:SDN:C19::2_4','SDN:C19::2_4'),(180,'URN:SDN:C19::2_5','SDN:C19::2_5'),(181,'URN:SDN:C19::2_6','SDN:C19::2_6'),(182,'URN:SDN:C19::2_7','SDN:C19::2_7'),(183,'URN:SDN:C19::2_8','SDN:C19::2_8'),(184,'URN:SDN:C19::2_9','SDN:C19::2_9'),(185,'URN:SDN:C19::3_1_1','SDN:C19::3_1_1'),(186,'URN:SDN:C19::10_10_1','SDN:C19::10_10_1'),(187,'URN:SDN:C19::UKMDN056','SDN:C19::UKMDN056'),(188,'URN:SDN:C19::UKMDN054','SDN:C19::UKMDN054'),(189,'URN:SDN:C19::UKMDN055','SDN:C19::UKMDN055'),(190,'URN:SDN:C19::3_1_2_1','SDN:C19::3_1_2_1'),(191,'URN:SDN:C19::UKMDN052','SDN:C19::UKMDN052'),(192,'URN:SDN:C19::3_1_2_2','SDN:C19::3_1_2_2'),(193,'URN:SDN:C19::UKMDN053','SDN:C19::UKMDN053'),(194,'URN:SDN:C19::3_1_2_3','SDN:C19::3_1_2_3'),(195,'URN:SDN:C19::UKMDN050','SDN:C19::UKMDN050'),(196,'URN:SDN:C19::3_1_2_4','SDN:C19::3_1_2_4'),(197,'URN:SDN:C19::UKMDN051','SDN:C19::UKMDN051'),(198,'URN:SDN:C19::5_16_1','SDN:C19::5_16_1'),(199,'URN:SDN:C19::1_1','SDN:C19::1_1'),(200,'URN:SDN:C19::1_2','SDN:C19::1_2'),(201,'URN:SDN:C19::1_3','SDN:C19::1_3'),(202,'URN:SDN:C19::1_4','SDN:C19::1_4'),(203,'URN:SDN:C19::1_5','SDN:C19::1_5'),(204,'URN:SDN:C19::1_6','SDN:C19::1_6'),(205,'URN:SDN:C19::1_7','SDN:C19::1_7'),(206,'URN:SDN:C19::1_8','SDN:C19::1_8'),(207,'URN:SDN:C19::UKMDN049','SDN:C19::UKMDN049'),(208,'URN:SDN:C19::9_1','SDN:C19::9_1'),(209,'URN:SDN:C19::1_9','SDN:C19::1_9'),(210,'URN:SDN:C19::UKMDN047','SDN:C19::UKMDN047'),(211,'URN:SDN:C19::9_2','SDN:C19::9_2'),(212,'URN:SDN:C19::9_3','SDN:C19::9_3'),(213,'URN:SDN:C19::UKMDN048','SDN:C19::UKMDN048'),(214,'URN:SDN:C19::9_4','SDN:C19::9_4'),(215,'URN:SDN:C19::UKMDN045','SDN:C19::UKMDN045'),(216,'URN:SDN:C19::UKMDN046','SDN:C19::UKMDN046'),(217,'URN:SDN:C19::9_5','SDN:C19::9_5'),(218,'URN:SDN:C19::9_6','SDN:C19::9_6'),(219,'URN:SDN:C19::UKMDN043','SDN:C19::UKMDN043'),(220,'URN:SDN:C19::UKMDN044','SDN:C19::UKMDN044'),(221,'URN:SDN:C19::9_7','SDN:C19::9_7'),(222,'URN:SDN:C19::UKMDN041','SDN:C19::UKMDN041'),(223,'URN:SDN:C19::9_8','SDN:C19::9_8'),(224,'URN:SDN:C19::9_9','SDN:C19::9_9'),(225,'URN:SDN:C19::UKMDN042','SDN:C19::UKMDN042'),(226,'URN:SDN:C19::UKMDN040','SDN:C19::UKMDN040'),(227,'URN:SDN:C19::1_7_1','SDN:C19::1_7_1'),(228,'URN:SDN:C19::UKMDN038','SDN:C19::UKMDN038'),(229,'URN:SDN:C19::UKMDN039','SDN:C19::UKMDN039'),(230,'URN:SDN:C19::UKMDN036','SDN:C19::UKMDN036'),(231,'URN:SDN:C19::UKMDN037','SDN:C19::UKMDN037'),(232,'URN:SDN:C19::UKMDN034','SDN:C19::UKMDN034'),(233,'URN:SDN:C19::UKMDN035','SDN:C19::UKMDN035'),(234,'URN:SDN:C19::UKMDN032','SDN:C19::UKMDN032'),(235,'URN:SDN:C19::UKMDN033','SDN:C19::UKMDN033'),(236,'URN:SDN:C19::UKMDN030','SDN:C19::UKMDN030'),(237,'URN:SDN:C19::UKMDN031','SDN:C19::UKMDN031'),(238,'URN:SDN:C19::FRAM','SDN:C19::FRAM'),(239,'URN:SDN:C19::8_3_2','SDN:C19::8_3_2'),(240,'URN:SDN:C19::8_3_1','SDN:C19::8_3_1'),(241,'URN:SDN:C19::8_3_3','SDN:C19::8_3_3'),(242,'URN:SDN:C19::UKMDN029','SDN:C19::UKMDN029'),(243,'URN:SDN:C19::8_1','SDN:C19::8_1'),(244,'URN:SDN:C19::UKMDN027','SDN:C19::UKMDN027'),(245,'URN:SDN:C19::8_2','SDN:C19::8_2'),(246,'URN:SDN:C19::UKMDN028','SDN:C19::UKMDN028'),(247,'URN:SDN:C19::8_3','SDN:C19::8_3'),(248,'URN:SDN:C19::7_4_2','SDN:C19::7_4_2'),(249,'URN:SDN:C19::UKMDN025','SDN:C19::UKMDN025'),(250,'URN:SDN:C19::7_4_1','SDN:C19::7_4_1'),(251,'URN:SDN:C19::UKMDN026','SDN:C19::UKMDN026'),(252,'URN:SDN:C19::UKMDN023','SDN:C19::UKMDN023'),(253,'URN:SDN:C19::UKMDN024','SDN:C19::UKMDN024'),(254,'URN:SDN:C19::9_16','SDN:C19::9_16'),(255,'URN:SDN:C19::UKMDN021','SDN:C19::UKMDN021'),(256,'URN:SDN:C19::9_15','SDN:C19::9_15'),(257,'URN:SDN:C19::UKMDN022','SDN:C19::UKMDN022'),(258,'URN:SDN:C19::9_14','SDN:C19::9_14'),(259,'URN:SDN:C19::9_13','SDN:C19::9_13'),(260,'URN:SDN:C19::UKMDN020','SDN:C19::UKMDN020'),(261,'URN:SDN:C19::9_12','SDN:C19::9_12'),(262,'URN:SDN:C19::9_11','SDN:C19::9_11'),(263,'URN:SDN:C19::9_10','SDN:C19::9_10'),(264,'urn:',''),(265,'urn:SDN:C16::04','SDN:C16::04');

--CREATE USER 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.* TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.COMPOSITION TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.CRUISE TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Cruise_SeaArea TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.event TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Navigation TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.PROGRAM TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Program_Project TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.PROJECT TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.SEAAREA TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Thermosal TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.TOOL TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Weather TO 'casino'@'localhost' IDENTIFIED BY 'casino';

GRANT LOCK TABLES ON casino.* TO 'casino'@'localhost' IDENTIFIED BY 'casino'; --needed to do a database dump
FLUSH PRIVILEGES;


-- Dumping routines for database 'casino'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-07 16:46:57
