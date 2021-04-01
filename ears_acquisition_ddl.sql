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

create table Navigation (ID bigint not null, cog double precision, depth double precision, heading double precision, lat double precision, lon double precision, navigation_id varchar(15) not null, sog double precision, time timestamp, primary key (ID)) ENGINE=MyISAM;

--
-- Table structure for table `Thermosal`
--

DROP TABLE IF EXISTS `Thermosal`;
DROP TABLE IF EXISTS Thermosal;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
/*CREATE TABLE `Thermosal` (
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salinity` double DEFAULT '0',
  `surface_water_temperature` double DEFAULT '0',
  `raw_fluorometry` double DEFAULT '0',
  `conductivity` double DEFAULT '0',
  `sigmaT` double DEFAULT '0',
  `instrument_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`date_time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;*/
/*!40101 SET character_set_client = @saved_cs_client */;

create table Thermosal (ID bigint not null, conductivity double precision, date_time timestamp, instrument_time datetime, raw_fluorometry double precision, salinity double precision, sigma_t double precision, surface_water_temperature double precision, primary key (ID)) ENGINE=MyISAM;

--
-- Table structure for table `Weather`
--

DROP TABLE IF EXISTS `Weather`;
DROP TABLE IF EXISTS Weather;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
/*CREATE TABLE `Weather` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;*/
/*!40101 SET character_set_client = @saved_cs_client */;

create table Weather (date_time timestamp not null, air_preasure double precision, air_temperature double precision, humidity double precision, instrument_time datetime, solar_radiation double precision, surface_water_temperature double precision, wind_direction double precision, wind_gust double precision, wind_speed double precision, primary key (date_time)) ENGINE=MyISAM;

--CREATE USER 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.* TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Navigation TO 'casino'@'localhost' IDENTIFIED BY 'casino';
GRANT SELECT,INSERT,UPDATE,DELETE ON casino.Thermosal TO 'casino'@'localhost' IDENTIFIED BY 'casino';
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
