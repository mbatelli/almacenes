CREATE DATABASE  IF NOT EXISTS `almacenes` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `almacenes`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: almacenes
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

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
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_critico` int(10) unsigned NOT NULL DEFAULT '0',
  `categoria_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articulo_codigo_unique` (`codigo`),
  UNIQUE KEY `articulo_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (2,NULL,'Urna descartable de cartón',0,2,'2018-10-10 18:20:10','2018-10-10 18:20:10',NULL),(3,NULL,'Sobre para emisión del voto',0,1,'2018-10-10 18:25:42','2018-10-10 18:25:42',NULL),(4,NULL,'Sobre celeste/acuse recibo',0,1,'2018-10-10 18:27:09','2018-10-10 18:27:09',NULL),(5,NULL,'Sobre para boleta oficializada',0,1,'2018-10-10 18:27:43','2018-10-10 18:27:43',NULL),(6,NULL,'Sobre para voto impugnado',0,1,'2018-10-10 18:28:00','2018-10-19 14:10:21',NULL),(7,NULL,'Sobre para voto recurrido',0,1,'2018-10-10 18:28:00','2018-10-12 15:27:16',NULL),(8,NULL,'Formulario Recibo de Urnas',1000,4,'2018-10-19 16:27:20','2018-10-19 16:27:20',NULL),(9,NULL,'Cartel \"Identificación de Cuarto Oscuro\"',0,3,'2018-10-19 16:35:49','2018-10-19 16:35:49',NULL),(10,NULL,'Cartel \"Identificación de Mesa de Votación\"',0,3,'2018-10-19 16:36:42','2018-10-19 16:36:42',NULL);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoria_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Sobres','2018-10-10 11:21:00','2018-10-19 16:15:07',NULL),(2,'Urnas','2018-10-10 18:19:00','2018-10-19 16:14:58',NULL),(3,'Carteles de Mesa de Votación','2018-10-19 16:14:42','2018-10-19 16:14:42',NULL),(4,'Formularios','2018-10-19 16:15:31','2018-10-19 16:15:31',NULL),(5,'Urnas y Elementos para resguardo de documentación','2018-10-19 16:16:02','2018-10-19 16:16:02',NULL),(6,'Elementos para Identificación','2018-10-19 16:16:00','2018-10-19 16:17:09',NULL),(7,'Sobres Especiales','2018-10-19 16:19:58','2018-10-19 16:19:58',NULL),(8,'Material complementario y de contingencia','2018-10-19 16:20:41','2018-10-19 16:20:41',NULL),(9,'Afiches y Carteles','2018-10-19 16:21:02','2018-10-19 16:21:02',NULL);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,1,'Category 1','category-1','2018-10-09 12:36:32','2018-10-09 12:36:32'),(2,NULL,1,'Category 2','category-2','2018-10-09 12:36:32','2018-10-09 12:36:32');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciudad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_postal` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provincia_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ciudad_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` VALUES (1,'La Plata',NULL,1,'2018-10-12 20:09:29','2018-10-12 20:09:29',NULL),(2,'San Fernando del Valle de Catamarca',NULL,2,'2018-10-17 22:26:30','2018-10-17 22:26:30',NULL),(3,'Córdoba',NULL,3,'2018-10-17 22:27:03','2018-10-17 22:27:03',NULL),(4,'Corrientes',NULL,7,'2018-10-17 22:27:27','2018-10-17 22:27:27',NULL),(5,'Resistencia',NULL,4,'2018-10-17 22:27:40','2018-10-17 22:27:40',NULL),(6,'Rawson',NULL,5,'2018-10-17 22:27:55','2018-10-17 22:27:55',NULL),(7,'Paraná',NULL,8,'2018-10-17 22:28:18','2018-10-17 22:28:18',NULL),(8,'Formosa',NULL,9,'2018-10-17 22:28:32','2018-10-17 22:28:32',NULL),(9,'San Salvador de Jujuy',NULL,10,'2018-10-17 22:28:46','2018-10-17 22:28:46',NULL),(10,'Santa Rosa',NULL,11,'2018-10-17 22:29:05','2018-10-17 22:29:05',NULL),(11,'La Rioja',NULL,12,'2018-10-17 22:29:26','2018-10-17 22:29:26',NULL),(12,'Mendoza',NULL,13,'2018-10-17 22:29:38','2018-10-17 22:29:38',NULL),(13,'Posadas',NULL,15,'2018-10-17 22:29:53','2018-10-17 22:29:53',NULL),(14,'Neuquén',NULL,16,'2018-10-17 22:30:09','2018-10-17 22:30:09',NULL),(15,'Viedma',NULL,17,'2018-10-17 22:30:42','2018-10-17 22:30:42',NULL),(16,'Salta',NULL,18,'2018-10-17 22:30:58','2018-10-17 22:30:58',NULL),(17,'San Juan',NULL,19,'2018-10-17 22:31:12','2018-10-17 22:31:12',NULL),(18,'San Luis',NULL,20,'2018-10-17 22:31:28','2018-10-17 22:31:28',NULL),(19,'Río Gallegos',NULL,21,'2018-10-17 22:31:58','2018-10-17 22:31:58',NULL),(20,'Santa Fe',NULL,22,'2018-10-17 22:32:16','2018-10-17 22:32:16',NULL),(21,'Santiago del Estero',NULL,23,'2018-10-17 22:32:31','2018-10-17 22:32:31',NULL),(22,'Ushuaia',NULL,24,'2018-10-17 22:32:45','2018-10-17 22:32:45',NULL),(23,'San Miguel de Tucumán',NULL,25,'2018-10-17 22:33:59','2018-10-17 22:33:59',NULL),(24,'San Martín',NULL,1,'2018-10-17 22:36:22','2018-10-17 22:36:22',NULL),(25,'CABA',NULL,1,'2018-10-19 14:14:41','2018-10-19 14:14:41',NULL);
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),(2,1,'name','text','Name',1,1,1,1,1,1,NULL,2),(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),(4,1,'password','password','Password',1,0,0,1,1,0,NULL,4),(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),(6,1,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,6),(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(8,1,'avatar','image','Avatar',0,1,1,1,1,1,NULL,8),(9,1,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}',10),(10,1,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(12,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),(13,2,'id','number','ID',1,0,0,0,0,0,'',1),(14,2,'name','text','Name',1,1,1,1,1,1,'',2),(15,2,'created_at','timestamp','Created At',0,0,0,0,0,0,'',3),(16,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',4),(17,3,'id','number','ID',1,0,0,0,0,0,NULL,1),(18,3,'name','text','Name',1,1,1,1,1,1,NULL,2),(19,3,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(20,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(21,3,'display_name','text','Display Name',1,1,1,1,1,1,NULL,5),(22,1,'role_id','text','Role',0,1,1,1,1,1,NULL,9),(23,4,'id','number','ID',1,0,0,0,0,0,'',1),(24,4,'parent_id','select_dropdown','Parent',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),(25,4,'order','text','Order',1,1,1,1,1,1,'{\"default\":1}',3),(26,4,'name','text','Name',1,1,1,1,1,1,'',4),(27,4,'slug','text','Slug',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),(28,4,'created_at','timestamp','Created At',0,0,1,0,0,0,'',6),(29,4,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',7),(30,5,'id','number','ID',1,0,0,0,0,0,'',1),(31,5,'author_id','text','Author',1,0,1,1,0,1,'',2),(32,5,'category_id','text','Category',1,0,1,1,1,0,'',3),(33,5,'title','text','Title',1,1,1,1,1,1,'',4),(34,5,'excerpt','text_area','Excerpt',1,0,1,1,1,1,'',5),(35,5,'body','rich_text_box','Body',1,0,1,1,1,1,'',6),(36,5,'image','image','Post Image',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),(37,5,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}',8),(38,5,'meta_description','text_area','Meta Description',1,0,1,1,1,1,'',9),(39,5,'meta_keywords','text_area','Meta Keywords',1,0,1,1,1,1,'',10),(40,5,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}',11),(41,5,'created_at','timestamp','Created At',0,1,1,0,0,0,'',12),(42,5,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',13),(43,5,'seo_title','text','SEO Title',0,1,1,1,1,1,'',14),(44,5,'featured','checkbox','Featured',1,1,1,1,1,1,'',15),(45,6,'id','number','ID',1,0,0,0,0,0,'',1),(46,6,'author_id','text','Author',1,0,0,0,0,0,'',2),(47,6,'title','text','Title',1,1,1,1,1,1,'',3),(48,6,'excerpt','text_area','Excerpt',1,0,1,1,1,1,'',4),(49,6,'body','rich_text_box','Body',1,0,1,1,1,1,'',5),(50,6,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),(51,6,'meta_description','text','Meta Description',1,0,1,1,1,1,'',7),(52,6,'meta_keywords','text','Meta Keywords',1,0,1,1,1,1,'',8),(53,6,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}',9),(54,6,'created_at','timestamp','Created At',1,1,1,0,0,0,'',10),(55,6,'updated_at','timestamp','Updated At',1,0,0,0,0,0,'',11),(56,6,'image','image','Page Image',0,1,1,1,1,1,'',12),(57,7,'id','text','Id',1,0,0,0,0,0,NULL,1),(58,7,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:categoria|max:100\"}}',2),(59,8,'id','text','Id',1,0,0,0,0,0,NULL,1),(60,8,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:presentacion|max:100\"}}',2),(61,8,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',9),(62,8,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',10),(63,8,'cantidad','number','Cantidad',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"bail|nullable|integer|gt:0\",\"default\":null}}',5),(64,8,'peso','number','Peso',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"bail|nullable|numeric|gt:0\",\"default\":null}}',6),(65,8,'volumen','number','Volumen',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"bail|nullable|numeric|gt:0\",\"default\":null}}',7),(66,7,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',3),(67,7,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',4),(68,9,'id','text','Id',1,0,0,0,0,0,NULL,1),(69,9,'codigo','text','Código',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"nullable|unique:articulo|max:50\"}}',2),(70,9,'nombre','text','Nombre',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:articulo|max:100\"}}',3),(71,9,'stock_critico','number','Stock Crítico',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|integer\",\"default\":\"0\"}}',4),(72,9,'categoria_id','select_dropdown','Categoría',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',5),(73,9,'articulo_belongsto_categorium_relationship','relationship','Categoría',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Categoria\",\"table\":\"categoria\",\"type\":\"belongsTo\",\"column\":\"categoria_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(74,9,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',8),(75,9,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',9),(76,9,'articulo_belongstomany_presentacion_relationship','relationship','Presentaciones',0,1,1,1,1,1,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Presentacion\",\"table\":\"presentacion\",\"type\":\"hasMany\",\"column\":\"articulo_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',7),(78,8,'por_defecto','checkbox','Por Defecto',1,1,1,1,1,1,'{\"on\":\"Sí\",\"off\":\"No\",\"checked\":true}',8),(79,8,'presentacion_belongsto_articulo_relationship','relationship','Artículo',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Articulo\",\"table\":\"articulo\",\"type\":\"belongsTo\",\"column\":\"articulo_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',4),(80,8,'articulo_id','select_dropdown','Artículo',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',3),(81,10,'id','text','Id',1,0,0,0,0,0,NULL,1),(82,10,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:tipo_destinatario|max:100\"}}',2),(83,10,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',3),(84,10,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',4),(85,11,'id','text','Id',1,0,0,0,0,0,NULL,1),(86,11,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:provincia|max:60\"}}',2),(87,11,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',3),(88,11,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',4),(89,12,'id','text','Id',1,0,0,0,0,0,NULL,1),(90,12,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:ciudad|max:50\"}}',2),(91,12,'codigo_postal','text','Código Postal',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:10\"}}',3),(92,12,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',6),(93,12,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',7),(94,12,'provincia_id','select_dropdown','Provincia',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',4),(95,12,'ciudad_belongsto_provincium_relationship','relationship','Provincia',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Provincia\",\"table\":\"provincia\",\"type\":\"belongsTo\",\"column\":\"provincia_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(96,13,'id','text','Id',1,0,0,0,0,0,NULL,1),(97,13,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:destinatario|max:100\"}}',2),(98,13,'tipo_destinatario_id','select_dropdown','Tipo Destinatario',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',3),(99,13,'direccion','text','Dirección',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:100\"}}',5),(100,13,'ciudad_id','select_dropdown','Ciudad',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',6),(101,13,'telefono','text','Teléfono',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:20\"}}',8),(102,13,'observaciones','text_area','Observaciones',0,0,1,1,1,1,'{\"validation\":{\"rule\":\"max:500\"}}',9),(103,13,'destinatario_belongsto_tipo_destinatario_relationship','relationship','Tipo Destinatario',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\TipoDestinatario\",\"table\":\"tipo_destinatario\",\"type\":\"belongsTo\",\"column\":\"tipo_destinatario_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',4),(104,13,'destinatario_belongsto_ciudad_relationship','relationship','Ciudad',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Ciudad\",\"table\":\"ciudad\",\"type\":\"belongsTo\",\"column\":\"ciudad_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',7),(105,13,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',10),(106,13,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',11),(107,14,'id','text','Id',1,0,0,0,0,0,NULL,1),(108,14,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:proveedor|max:100\"}}',2),(109,14,'direccion','text','Dirección',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:100\"}}',3),(110,14,'ciudad_id','select_dropdown','Ciudad',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',4),(111,14,'telefono','text','Teléfono',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:20\"}}',6),(112,14,'observaciones','text_area','Observaciones',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:500\"}}',7),(113,14,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',8),(114,14,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',9),(115,14,'proveedor_belongsto_ciudad_relationship','relationship','Ciudad',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Ciudad\",\"table\":\"ciudad\",\"type\":\"belongsTo\",\"column\":\"ciudad_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(116,15,'id','text','Id',1,0,0,0,0,0,NULL,1),(117,15,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:deposito|max:100\"}}',2),(118,15,'direccion','text','Dirección',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:100\"}}',4),(119,15,'ciudad_id','select_dropdown','Ciudad',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',5),(120,15,'telefono','text','Teléfono',0,1,1,1,1,1,'{\"validation\":{\"rule\":\"max:20\"}}',7),(121,15,'observaciones','text','Observaciones',0,0,1,1,1,0,'{\"validation\":{\"rule\":\"max:500\"}}',8),(122,15,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',9),(123,15,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',10),(124,15,'deposito_belongsto_ciudad_relationship','relationship','Ciudad',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Ciudad\",\"table\":\"ciudad\",\"type\":\"belongsTo\",\"column\":\"ciudad_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(125,16,'id','text','Id',1,0,0,0,0,0,NULL,1),(126,16,'nombre','text','Nombre',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:proceso_electoral|max:50\"}}',2),(127,16,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',3),(128,16,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',4),(129,17,'id','text','Id',1,0,0,0,0,0,NULL,1),(130,17,'nro_orden_compra','text','Número',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required|max:50\"}}',2),(131,17,'fecha','date','Fecha',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(132,17,'proveedor_id','select_dropdown','Proveedor',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',4),(134,17,'created_at','timestamp','Creado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',6),(135,17,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',7),(136,17,'orden_compra_belongsto_proveedor_relationship','relationship','Proveedor',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Proveedor\",\"table\":\"proveedor\",\"type\":\"belongsTo\",\"column\":\"proveedor_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(137,18,'id','text','Id',1,0,0,0,0,0,NULL,1),(138,18,'orden_compra_id','text','Orden de Compra',1,0,0,0,0,0,NULL,2),(139,18,'articulo_id','select_dropdown','Artículo',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',3),(140,18,'cantidad','number','Cantidad',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',5),(141,18,'precio','number','Precio',0,1,1,1,1,1,NULL,6),(142,18,'orden_compra_linea_belongsto_articulo_relationship','relationship','Artículo',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Articulo\",\"table\":\"articulo\",\"type\":\"belongsTo\",\"column\":\"articulo_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',4),(143,18,'created_at','timestamp','Creado',0,0,0,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',7),(144,18,'updated_at','timestamp','Actualizado',0,0,0,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',8),(145,19,'id','text','Id',1,0,0,0,0,0,NULL,1),(146,19,'punto_venta','number','Punto Venta',1,1,1,1,1,1,'{\"display\":{\"width\":1}}',5),(147,19,'numero','number','Número',1,1,1,1,1,1,'{\"display\":{\"width\":2}}',6),(148,19,'fecha','date','Fecha',1,1,1,1,1,1,'{\"display\":{\"width\":2}}',7),(149,19,'nota','text_area','Nota',0,0,1,1,1,1,NULL,13),(150,19,'tipo','select_dropdown','Tipo',1,1,1,1,1,1,'{\"default\":\"PROVISORIO_SALIDA\",\"options\":{\"REMITO_SALIDA\":\"Remito de Salida de material\",\"REMITO_ENTRADA\":\"Remito de Entrada de material\",\"COMPROBANTE_AJUSTE\":\"Comprobante de Ajuste\",\"PROVISORIO_SALIDA\":\"Provisorio de Salida\"},\"display\":{\"width\":2}}',2),(151,19,'transportador','text','Transportador',0,0,1,1,1,1,'{\"display\":{\"width\":3}}',14),(152,19,'patente','text','Patente',0,0,1,1,1,1,'{\"display\":{\"width\":1}}',15),(153,19,'conductor','text','Conductor',0,0,1,1,1,1,'{\"display\":{\"width\":4}}',16),(154,19,'dni','number','DNI',0,0,1,1,1,1,'{\"display\":{\"width\":2}}',17),(155,19,'telefono','text','Teléfono',0,0,1,1,1,1,'{\"display\":{\"width\":2}}',18),(156,19,'cantidad_bultos','number','Bultos',0,0,1,1,1,1,'{\"display\":{\"width\":1}}',19),(157,19,'peso','number','Peso',0,0,1,1,1,1,'{\"display\":{\"width\":1}}',20),(158,19,'volumen','number','Volumen',0,0,1,1,1,1,'{\"display\":{\"width\":1}}',21),(159,19,'precintos','text','Precintos',0,0,1,1,1,1,'{\"display\":{\"width\":9}}',22),(160,19,'qr','text','QR',0,0,1,1,1,1,NULL,23),(161,19,'destinatario_id','select_dropdown','Destinatario',0,0,0,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',8),(162,19,'proveedor_id','select_dropdown','Proveedor',0,0,0,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',11),(163,19,'deposito_id','select_dropdown','Depósito',0,0,0,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',3),(164,19,'orden_compra_id','select_dropdown','Orden Compra',0,0,0,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nro_orden_compra\"}}',12),(165,19,'proceso_electoral_id','select_dropdown','Proceso Electoral',0,0,0,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',10),(166,19,'created_at','timestamp','Creado',0,1,1,0,0,0,NULL,24),(167,19,'updated_at','timestamp','Actualizado',0,1,1,0,0,0,NULL,25),(168,20,'id','text','Id',1,0,0,0,0,0,NULL,1),(169,20,'remito_id','text','Remito',1,0,0,0,0,0,NULL,2),(170,20,'articulo_id','select_dropdown','Artículo',1,0,0,1,1,1,'{\"validation\":{\"rule\":\"required\"},\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Seleccionar\"},\"relationship\":{\"key\":\"id\",\"label\":\"nombre\"}}',3),(171,20,'cantidad','number','Cantidad',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',4),(174,20,'created_at','timestamp','Creado',0,0,0,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',5),(175,20,'updated_at','timestamp','Actualizado',0,0,0,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',6),(176,19,'remito_belongsto_deposito_relationship','relationship','Depósito',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Deposito\",\"table\":\"deposito\",\"type\":\"belongsTo\",\"column\":\"deposito_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',4),(177,19,'remito_belongsto_destinatario_relationship','relationship','Destinatario',0,1,1,0,0,0,'{\"model\":\"App\\\\Almacenes\\\\Model\\\\Destinatario\",\"table\":\"destinatario\",\"type\":\"belongsTo\",\"column\":\"destinatario_id\",\"key\":\"id\",\"label\":\"nombre\",\"pivot_table\":\"articulo\",\"pivot\":\"0\",\"taggable\":\"0\"}',9),(178,15,'punto_venta','number','Punto de Venta',1,1,1,1,1,1,'{\"validation\":{\"rule\":\"required\"}}',3),(179,14,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',10),(180,9,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',10),(181,7,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',5),(182,12,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',8),(183,15,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',11),(184,13,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',12),(185,8,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',11),(186,16,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',5),(187,11,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',5),(188,10,'deleted_at','timestamp','Eliminado',0,1,1,0,0,0,'{\"format\":\"%d/%m/%Y %H:%M\"}',5),(189,1,'email_verified_at','timestamp','Email Verified At',0,1,1,1,1,1,NULL,6),(190,1,'deleted_at','timestamp','Deleted At',0,1,1,0,0,0,NULL,12),(191,3,'deleted_at','timestamp','Deleted At',0,0,0,0,0,0,NULL,6);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy',NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-09 12:36:30','2018-11-04 01:41:10'),(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2018-10-09 12:36:30','2018-10-09 12:36:30'),(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-09 12:36:30','2018-11-04 01:42:58'),(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2018-10-09 12:36:32','2018-10-09 12:36:32'),(5,'posts','posts','Post','Posts','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy','','',1,0,NULL,'2018-10-09 12:36:32','2018-10-09 12:36:32'),(6,'pages','pages','Page','Pages','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2018-10-09 12:36:33','2018-10-09 12:36:33'),(7,'categoria','categoria','Categoría','Categorías','voyager-categories','App\\Almacenes\\Model\\Categoria',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-10 11:20:01','2018-10-10 13:42:43'),(8,'presentacion','presentacion','Presentación','Presentaciones','voyager-archive','App\\Almacenes\\Model\\Presentacion',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-10 11:34:36','2018-10-10 13:43:51'),(9,'articulo','articulo','Artículo','Artículos','voyager-tag','App\\Almacenes\\Model\\Articulo',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-10 13:08:22','2018-10-10 13:44:28'),(10,'tipo_destinatario','tipo-destinatario','Tipo Destinatario','Tipos Destinatario','voyager-list','App\\Almacenes\\Model\\TipoDestinatario',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-12 18:40:25','2018-10-12 18:40:25'),(11,'provincia','provincia','Provincia','Provincias','voyager-location','App\\Almacenes\\Model\\Provincia',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-12 19:43:25','2018-10-12 19:43:25'),(12,'ciudad','ciudad','Ciudad','Ciudades','voyager-location','App\\Almacenes\\Model\\Ciudad',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-12 19:50:12','2018-10-12 19:50:12'),(13,'destinatario','destinatario','Destinatario','Destinatarios','voyager-study','App\\Almacenes\\Model\\Destinatario',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-12 19:59:02','2018-10-12 19:59:02'),(14,'proveedor','proveedor','Proveedor','Proveedores','voyager-person','App\\Almacenes\\Model\\Proveedor',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-12 20:27:12','2018-10-12 20:40:06'),(15,'deposito','deposito','Depósito','Depósitos','voyager-shop','App\\Almacenes\\Model\\Deposito',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-14 20:31:12','2018-10-29 12:16:53'),(16,'proceso_electoral','proceso-electoral','Proceso Electoral','Procesos Electorales','voyager-mail','App\\Almacenes\\Model\\ProcesoElectoral',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-14 20:43:20','2018-10-14 20:43:20'),(17,'orden_compra','orden-compra','Orden Compra','Órdenes de Compras','voyager-news','App\\Almacenes\\Model\\OrdenCompra',NULL,'OrdenCompraController',NULL,1,1,'{\"order_column\":null,\"order_display_column\":null}','2018-10-19 22:24:10','2018-10-30 11:59:58'),(18,'orden_compra_linea','orden-compra-linea','Línea de Orden Compra','Lineas de Orden de Compra',NULL,'App\\Almacenes\\Model\\OrdenCompraLinea',NULL,'OrdenCompraController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-28 12:22:18','2018-10-28 12:22:18'),(19,'remito','remito','Remito','Remitos','voyager-news','App\\Almacenes\\Model\\Remito',NULL,'RemitoController',NULL,1,1,'{\"order_column\":null,\"order_display_column\":null}','2018-10-29 20:10:26','2018-10-30 11:50:45'),(20,'remito_linea','remito-linea','Remito Linea','Remito Lineas',NULL,'App\\Almacenes\\Model\\RemitoLinea',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-10-29 20:29:15','2018-10-29 20:29:15');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposito`
--

DROP TABLE IF EXISTS `deposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposito` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad_id` int(10) unsigned NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `punto_venta` smallint(5) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deposito_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposito`
--

LOCK TABLES `deposito` WRITE;
/*!40000 ALTER TABLE `deposito` DISABLE KEYS */;
INSERT INTO `deposito` VALUES (1,'Centro Nacional de Logística Electoral','Ancaste 3701/91',25,'01149123331',NULL,'2018-10-19 14:14:00','2018-11-02 16:38:22',1,NULL),(2,'Centro Nacional de Materiales Especiales','Av. Brasil 3036/38',25,'01149435051',NULL,'2018-10-19 14:15:00','2018-11-02 16:38:30',2,NULL);
/*!40000 ALTER TABLE `deposito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destinatario`
--

DROP TABLE IF EXISTS `destinatario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinatario` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_destinatario_id` int(10) unsigned NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad_id` int(10) unsigned NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `destinatario_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinatario`
--

LOCK TABLES `destinatario` WRITE;
/*!40000 ALTER TABLE `destinatario` DISABLE KEYS */;
INSERT INTO `destinatario` VALUES (1,'Secretaría Electoral de la Provincia de Buenos Aires',1,'Calle 8 entre 50 y 51',1,NULL,NULL,'2018-10-12 20:13:44','2018-10-12 20:13:44',NULL),(2,'Secretaría Electoral de la Provincia de Catamarca',1,'República 323',2,NULL,NULL,'2018-10-17 22:35:05','2018-10-17 22:35:05',NULL);
/*!40000 ALTER TABLE `destinatario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.dashboard',NULL),(2,1,'Media','','_self','voyager-images',NULL,NULL,5,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.media.index',NULL),(3,1,'Users','','_self','voyager-person',NULL,NULL,3,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.users.index',NULL),(4,1,'Roles','','_self','voyager-lock',NULL,NULL,2,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.roles.index',NULL),(5,1,'Tools','','_self','voyager-tools',NULL,NULL,9,'2018-10-09 12:36:30','2018-10-09 12:36:30',NULL,NULL),(6,1,'Menu Builder','','_self','voyager-list',NULL,5,10,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.menus.index',NULL),(7,1,'Database','','_self','voyager-data',NULL,5,11,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,12,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,13,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.bread.index',NULL),(10,1,'Settings','','_self','voyager-settings',NULL,NULL,14,'2018-10-09 12:36:30','2018-10-09 12:36:30','voyager.settings.index',NULL),(11,1,'Categories','','_self','voyager-categories',NULL,NULL,8,'2018-10-09 12:36:32','2018-10-09 12:36:32','voyager.categories.index',NULL),(12,1,'Posts','','_self','voyager-news',NULL,NULL,6,'2018-10-09 12:36:32','2018-10-09 12:36:32','voyager.posts.index',NULL),(13,1,'Pages','','_self','voyager-file-text',NULL,NULL,7,'2018-10-09 12:36:33','2018-10-09 12:36:33','voyager.pages.index',NULL),(14,1,'Hooks','','_self','voyager-hook',NULL,5,13,'2018-10-09 12:36:33','2018-10-09 12:36:33','voyager.hooks',NULL),(18,2,'Categorías','/categoria','_self','voyager-categories','#000000',28,2,'2018-10-11 11:12:23','2018-10-14 21:05:10',NULL,''),(19,2,'Presentaciones','/presentacion','_self','voyager-tag','#000000',28,3,'2018-10-12 15:23:04','2018-10-14 21:05:10',NULL,''),(20,2,'Artículos','/articulo','_self','voyager-archive','#000000',28,1,'2018-10-12 15:24:04','2018-10-14 21:05:10',NULL,''),(21,2,'Tipos Destinatario','/tipo-destinatario','_self','voyager-list','#000000',22,1,'2018-10-12 18:40:25','2018-10-12 20:53:41',NULL,''),(22,2,'Configuración','','_self','voyager-params','#000000',NULL,3,'2018-10-12 19:40:20','2018-11-02 13:27:41',NULL,''),(23,2,'Provincias','/provincia','_self','voyager-location','#000000',22,2,'2018-10-12 19:43:26','2018-10-12 20:53:41',NULL,''),(24,2,'Ciudades','/ciudad','_self','voyager-location','#000000',22,3,'2018-10-12 19:50:12','2018-10-12 20:53:41',NULL,''),(25,2,'Destinatarios','/destinatario','_self','voyager-study','#000000',22,4,'2018-10-12 19:59:02','2018-10-12 20:53:41',NULL,''),(26,2,'Proveedores','/proveedor','_self','voyager-person','#000000',22,5,'2018-10-12 20:24:06','2018-10-12 20:53:41',NULL,''),(28,2,'Artículos','','_self','voyager-archive','#000000',NULL,2,'2018-10-12 20:53:24','2018-11-02 13:27:41',NULL,''),(29,2,'Depósitos','/deposito','_self','voyager-shop','#000000',22,6,'2018-10-14 20:31:12','2018-10-29 12:17:47',NULL,''),(30,2,'Procesos Electorales','/proceso-electoral','_self','voyager-mail','#000000',22,7,'2018-10-14 20:43:20','2018-10-14 21:02:51',NULL,''),(31,2,'Órdenes de Compras','/orden-compra','_self','voyager-news','#000000',32,2,'2018-10-19 22:24:10','2018-11-02 13:27:55',NULL,''),(32,2,'Stock','','_self','voyager-data','#000000',NULL,1,'2018-10-27 15:36:34','2018-11-02 13:27:41',NULL,''),(33,2,'Remitos','/remito','_self','voyager-receipt','#000000',32,1,'2018-10-27 20:08:14','2018-11-02 13:27:55',NULL,'');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2018-10-09 12:36:30','2018-10-09 12:36:30'),(2,'almacenes','2018-10-11 11:10:40','2018-10-11 11:10:40');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_01_01_000000_add_voyager_user_fields',1),(4,'2016_01_01_000000_create_data_types_table',1),(5,'2016_05_19_173453_create_menu_table',1),(6,'2016_10_21_190000_create_roles_table',1),(7,'2016_10_21_190000_create_settings_table',1),(8,'2016_11_30_135954_create_permission_table',1),(9,'2016_11_30_141208_create_permission_role_table',1),(10,'2016_12_26_201236_data_types__add__server_side',1),(11,'2017_01_13_000000_add_route_to_menu_items_table',1),(12,'2017_01_14_005015_create_translations_table',1),(13,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(14,'2017_03_06_000000_add_controller_to_data_types_table',1),(15,'2017_04_21_000000_add_order_to_data_rows_table',1),(16,'2017_07_05_210000_add_policyname_to_data_types_table',1),(17,'2017_08_05_000000_add_group_to_settings_table',1),(18,'2017_11_26_013050_add_user_role_relationship',1),(19,'2017_11_26_015000_create_user_roles_table',1),(20,'2018_03_11_000000_add_user_settings',1),(21,'2018_03_14_000000_add_details_to_data_types_table',1),(22,'2018_03_16_000000_make_settings_value_nullable',1),(23,'2016_01_01_000000_create_pages_table',2),(24,'2016_01_01_000000_create_posts_table',2),(25,'2016_02_15_204651_create_categories_table',2),(26,'2017_04_11_000000_alter_post_nullable_fields_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_compra`
--

DROP TABLE IF EXISTS `orden_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orden_compra` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nro_orden_compra` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_compra`
--

LOCK TABLES `orden_compra` WRITE;
/*!40000 ALTER TABLE `orden_compra` DISABLE KEYS */;
INSERT INTO `orden_compra` VALUES (1,'12313131113','2018-10-28',2,'2018-10-28 21:08:48','2018-10-28 21:08:48');
/*!40000 ALTER TABLE `orden_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_compra_linea`
--

DROP TABLE IF EXISTS `orden_compra_linea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orden_compra_linea` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orden_compra_id` int(10) unsigned NOT NULL,
  `articulo_id` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orden_compra_orden_compra_linea_idx` (`orden_compra_id`),
  CONSTRAINT `fk_orden_compra_orden_compra_linea` FOREIGN KEY (`orden_compra_id`) REFERENCES `orden_compra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_compra_linea`
--

LOCK TABLES `orden_compra_linea` WRITE;
/*!40000 ALTER TABLE `orden_compra_linea` DISABLE KEYS */;
INSERT INTO `orden_compra_linea` VALUES (1,1,2,12,126.70,NULL,NULL),(2,1,3,12500,5.50,NULL,NULL),(3,1,4,3,555.00,NULL,'2018-10-28 21:15:47');
/*!40000 ALTER TABLE `orden_compra_linea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2018-10-09 12:36:33','2018-10-09 12:36:33');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(42,1),(42,3),(43,1),(43,3),(44,1),(44,3),(45,1),(45,3),(46,1),(46,3),(47,1),(47,3),(48,1),(48,3),(49,1),(49,3),(50,1),(50,3),(51,1),(51,3),(52,1),(52,3),(53,1),(53,3),(54,1),(54,3),(55,1),(55,3),(56,1),(56,3),(57,1),(57,3),(58,1),(58,3),(59,1),(59,3),(60,1),(60,3),(61,1),(61,3),(62,1),(62,3),(63,1),(63,3),(64,1),(64,3),(65,1),(65,3),(66,1),(66,3),(67,1),(67,3),(68,1),(68,3),(69,1),(69,3),(70,1),(70,3),(71,1),(71,3),(72,1),(72,3),(73,1),(73,3),(74,1),(74,3),(75,1),(75,3),(76,1),(76,3),(82,1),(82,3),(83,1),(83,3),(84,1),(84,3),(85,1),(85,3),(86,1),(86,3),(87,1),(87,3),(88,1),(88,3),(89,1),(89,3),(90,1),(90,3),(91,1),(91,3),(92,1),(92,3),(93,1),(93,3),(94,1),(94,3),(95,1),(95,3),(96,1),(96,3),(97,1),(98,1),(99,1),(100,1),(101,1),(102,1),(103,1),(104,1),(105,1),(106,1),(117,1),(118,1),(119,1),(120,1),(121,1),(132,1),(133,1),(134,1),(135,1),(136,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2018-10-09 12:36:31','2018-10-09 12:36:31'),(2,'browse_bread',NULL,'2018-10-09 12:36:31','2018-10-09 12:36:31'),(3,'browse_database',NULL,'2018-10-09 12:36:31','2018-10-09 12:36:31'),(4,'browse_media',NULL,'2018-10-09 12:36:31','2018-10-09 12:36:31'),(5,'browse_compass',NULL,'2018-10-09 12:36:31','2018-10-09 12:36:31'),(6,'browse_menus','menus','2018-10-09 12:36:31','2018-10-09 12:36:31'),(7,'read_menus','menus','2018-10-09 12:36:31','2018-10-09 12:36:31'),(8,'edit_menus','menus','2018-10-09 12:36:31','2018-10-09 12:36:31'),(9,'add_menus','menus','2018-10-09 12:36:31','2018-10-09 12:36:31'),(10,'delete_menus','menus','2018-10-09 12:36:31','2018-10-09 12:36:31'),(11,'browse_roles','roles','2018-10-09 12:36:31','2018-10-09 12:36:31'),(12,'read_roles','roles','2018-10-09 12:36:31','2018-10-09 12:36:31'),(13,'edit_roles','roles','2018-10-09 12:36:31','2018-10-09 12:36:31'),(14,'add_roles','roles','2018-10-09 12:36:31','2018-10-09 12:36:31'),(15,'delete_roles','roles','2018-10-09 12:36:31','2018-10-09 12:36:31'),(16,'browse_users','users','2018-10-09 12:36:31','2018-10-09 12:36:31'),(17,'read_users','users','2018-10-09 12:36:31','2018-10-09 12:36:31'),(18,'edit_users','users','2018-10-09 12:36:31','2018-10-09 12:36:31'),(19,'add_users','users','2018-10-09 12:36:31','2018-10-09 12:36:31'),(20,'delete_users','users','2018-10-09 12:36:31','2018-10-09 12:36:31'),(21,'browse_settings','settings','2018-10-09 12:36:31','2018-10-09 12:36:31'),(22,'read_settings','settings','2018-10-09 12:36:31','2018-10-09 12:36:31'),(23,'edit_settings','settings','2018-10-09 12:36:31','2018-10-09 12:36:31'),(24,'add_settings','settings','2018-10-09 12:36:31','2018-10-09 12:36:31'),(25,'delete_settings','settings','2018-10-09 12:36:31','2018-10-09 12:36:31'),(26,'browse_categories','categories','2018-10-09 12:36:32','2018-10-09 12:36:32'),(27,'read_categories','categories','2018-10-09 12:36:32','2018-10-09 12:36:32'),(28,'edit_categories','categories','2018-10-09 12:36:32','2018-10-09 12:36:32'),(29,'add_categories','categories','2018-10-09 12:36:32','2018-10-09 12:36:32'),(30,'delete_categories','categories','2018-10-09 12:36:32','2018-10-09 12:36:32'),(31,'browse_posts','posts','2018-10-09 12:36:32','2018-10-09 12:36:32'),(32,'read_posts','posts','2018-10-09 12:36:32','2018-10-09 12:36:32'),(33,'edit_posts','posts','2018-10-09 12:36:32','2018-10-09 12:36:32'),(34,'add_posts','posts','2018-10-09 12:36:33','2018-10-09 12:36:33'),(35,'delete_posts','posts','2018-10-09 12:36:33','2018-10-09 12:36:33'),(36,'browse_pages','pages','2018-10-09 12:36:33','2018-10-09 12:36:33'),(37,'read_pages','pages','2018-10-09 12:36:33','2018-10-09 12:36:33'),(38,'edit_pages','pages','2018-10-09 12:36:33','2018-10-09 12:36:33'),(39,'add_pages','pages','2018-10-09 12:36:33','2018-10-09 12:36:33'),(40,'delete_pages','pages','2018-10-09 12:36:33','2018-10-09 12:36:33'),(41,'browse_hooks',NULL,'2018-10-09 12:36:33','2018-10-09 12:36:33'),(42,'browse_categoria','categoria','2018-10-10 11:20:01','2018-10-10 11:20:01'),(43,'read_categoria','categoria','2018-10-10 11:20:01','2018-10-10 11:20:01'),(44,'edit_categoria','categoria','2018-10-10 11:20:01','2018-10-10 11:20:01'),(45,'add_categoria','categoria','2018-10-10 11:20:01','2018-10-10 11:20:01'),(46,'delete_categoria','categoria','2018-10-10 11:20:01','2018-10-10 11:20:01'),(47,'browse_presentacion','presentacion','2018-10-10 11:34:36','2018-10-10 11:34:36'),(48,'read_presentacion','presentacion','2018-10-10 11:34:36','2018-10-10 11:34:36'),(49,'edit_presentacion','presentacion','2018-10-10 11:34:36','2018-10-10 11:34:36'),(50,'add_presentacion','presentacion','2018-10-10 11:34:36','2018-10-10 11:34:36'),(51,'delete_presentacion','presentacion','2018-10-10 11:34:36','2018-10-10 11:34:36'),(52,'browse_articulo','articulo','2018-10-10 13:08:22','2018-10-10 13:08:22'),(53,'read_articulo','articulo','2018-10-10 13:08:22','2018-10-10 13:08:22'),(54,'edit_articulo','articulo','2018-10-10 13:08:22','2018-10-10 13:08:22'),(55,'add_articulo','articulo','2018-10-10 13:08:22','2018-10-10 13:08:22'),(56,'delete_articulo','articulo','2018-10-10 13:08:22','2018-10-10 13:08:22'),(57,'browse_tipo_destinatario','tipo_destinatario','2018-10-12 18:40:25','2018-10-12 18:40:25'),(58,'read_tipo_destinatario','tipo_destinatario','2018-10-12 18:40:25','2018-10-12 18:40:25'),(59,'edit_tipo_destinatario','tipo_destinatario','2018-10-12 18:40:25','2018-10-12 18:40:25'),(60,'add_tipo_destinatario','tipo_destinatario','2018-10-12 18:40:25','2018-10-12 18:40:25'),(61,'delete_tipo_destinatario','tipo_destinatario','2018-10-12 18:40:25','2018-10-12 18:40:25'),(62,'browse_provincia','provincia','2018-10-12 19:43:26','2018-10-12 19:43:26'),(63,'read_provincia','provincia','2018-10-12 19:43:26','2018-10-12 19:43:26'),(64,'edit_provincia','provincia','2018-10-12 19:43:26','2018-10-12 19:43:26'),(65,'add_provincia','provincia','2018-10-12 19:43:26','2018-10-12 19:43:26'),(66,'delete_provincia','provincia','2018-10-12 19:43:26','2018-10-12 19:43:26'),(67,'browse_ciudad','ciudad','2018-10-12 19:50:12','2018-10-12 19:50:12'),(68,'read_ciudad','ciudad','2018-10-12 19:50:12','2018-10-12 19:50:12'),(69,'edit_ciudad','ciudad','2018-10-12 19:50:12','2018-10-12 19:50:12'),(70,'add_ciudad','ciudad','2018-10-12 19:50:12','2018-10-12 19:50:12'),(71,'delete_ciudad','ciudad','2018-10-12 19:50:12','2018-10-12 19:50:12'),(72,'browse_destinatario','destinatario','2018-10-12 19:59:02','2018-10-12 19:59:02'),(73,'read_destinatario','destinatario','2018-10-12 19:59:02','2018-10-12 19:59:02'),(74,'edit_destinatario','destinatario','2018-10-12 19:59:02','2018-10-12 19:59:02'),(75,'add_destinatario','destinatario','2018-10-12 19:59:02','2018-10-12 19:59:02'),(76,'delete_destinatario','destinatario','2018-10-12 19:59:02','2018-10-12 19:59:02'),(82,'browse_proveedor','proveedor','2018-10-12 20:27:12','2018-10-12 20:27:12'),(83,'read_proveedor','proveedor','2018-10-12 20:27:12','2018-10-12 20:27:12'),(84,'edit_proveedor','proveedor','2018-10-12 20:27:12','2018-10-12 20:27:12'),(85,'add_proveedor','proveedor','2018-10-12 20:27:12','2018-10-12 20:27:12'),(86,'delete_proveedor','proveedor','2018-10-12 20:27:12','2018-10-12 20:27:12'),(87,'browse_deposito','deposito','2018-10-14 20:31:12','2018-10-14 20:31:12'),(88,'read_deposito','deposito','2018-10-14 20:31:12','2018-10-14 20:31:12'),(89,'edit_deposito','deposito','2018-10-14 20:31:12','2018-10-14 20:31:12'),(90,'add_deposito','deposito','2018-10-14 20:31:12','2018-10-14 20:31:12'),(91,'delete_deposito','deposito','2018-10-14 20:31:12','2018-10-14 20:31:12'),(92,'browse_proceso_electoral','proceso_electoral','2018-10-14 20:43:20','2018-10-14 20:43:20'),(93,'read_proceso_electoral','proceso_electoral','2018-10-14 20:43:20','2018-10-14 20:43:20'),(94,'edit_proceso_electoral','proceso_electoral','2018-10-14 20:43:20','2018-10-14 20:43:20'),(95,'add_proceso_electoral','proceso_electoral','2018-10-14 20:43:20','2018-10-14 20:43:20'),(96,'delete_proceso_electoral','proceso_electoral','2018-10-14 20:43:20','2018-10-14 20:43:20'),(97,'browse_orden_compra','orden_compra','2018-10-19 22:24:10','2018-10-19 22:24:10'),(98,'read_orden_compra','orden_compra','2018-10-19 22:24:10','2018-10-19 22:24:10'),(99,'edit_orden_compra','orden_compra','2018-10-19 22:24:10','2018-10-19 22:24:10'),(100,'add_orden_compra','orden_compra','2018-10-19 22:24:10','2018-10-19 22:24:10'),(101,'delete_orden_compra','orden_compra','2018-10-19 22:24:10','2018-10-19 22:24:10'),(102,'browse_orden_compra_linea','orden_compra_linea','2018-10-28 12:22:18','2018-10-28 12:22:18'),(103,'read_orden_compra_linea','orden_compra_linea','2018-10-28 12:22:18','2018-10-28 12:22:18'),(104,'edit_orden_compra_linea','orden_compra_linea','2018-10-28 12:22:18','2018-10-28 12:22:18'),(105,'add_orden_compra_linea','orden_compra_linea','2018-10-28 12:22:18','2018-10-28 12:22:18'),(106,'delete_orden_compra_linea','orden_compra_linea','2018-10-28 12:22:18','2018-10-28 12:22:18'),(117,'browse_remito','remito','2018-10-29 20:10:26','2018-10-29 20:10:26'),(118,'read_remito','remito','2018-10-29 20:10:26','2018-10-29 20:10:26'),(119,'edit_remito','remito','2018-10-29 20:10:26','2018-10-29 20:10:26'),(120,'add_remito','remito','2018-10-29 20:10:26','2018-10-29 20:10:26'),(121,'delete_remito','remito','2018-10-29 20:10:26','2018-10-29 20:10:26'),(132,'browse_remito_linea','remito_linea','2018-10-29 20:29:15','2018-10-29 20:29:15'),(133,'read_remito_linea','remito_linea','2018-10-29 20:29:15','2018-10-29 20:29:15'),(134,'edit_remito_linea','remito_linea','2018-10-29 20:29:15','2018-10-29 20:29:15'),(135,'add_remito_linea','remito_linea','2018-10-29 20:29:15','2018-10-29 20:29:15'),(136,'delete_remito_linea','remito_linea','2018-10-29 20:29:15','2018-10-29 20:29:15');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,0,NULL,'Lorem Ipsum Post',NULL,'This is the excerpt for the Lorem Ipsum Post','<p>This is the body of the lorem ipsum post</p>','posts/post1.jpg','lorem-ipsum-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2018-10-09 12:36:33','2018-10-09 12:36:33'),(2,0,NULL,'My Sample Post',NULL,'This is the excerpt for the sample Post','<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>','posts/post2.jpg','my-sample-post','Meta Description for sample post','keyword1, keyword2, keyword3','PUBLISHED',0,'2018-10-09 12:36:33','2018-10-09 12:36:33'),(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2018-10-09 12:36:33','2018-10-09 12:36:33'),(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2018-10-09 12:36:33','2018-10-09 12:36:33');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentacion`
--

DROP TABLE IF EXISTS `presentacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presentacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` int(10) unsigned DEFAULT NULL,
  `peso` float DEFAULT NULL,
  `volumen` float DEFAULT NULL,
  `articulo_id` int(10) unsigned NOT NULL,
  `por_defecto` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentacion`
--

LOCK TABLES `presentacion` WRITE;
/*!40000 ALTER TABLE `presentacion` DISABLE KEYS */;
INSERT INTO `presentacion` VALUES (5,'Sobres X 1050',1050,5.5,0.018,3,0,'2018-10-10 18:33:00','2018-10-19 15:11:28',NULL),(6,'Sobres X 500',500,2.75,0.009,3,0,'2018-10-10 18:35:25','2018-10-10 18:35:25',NULL);
/*!40000 ALTER TABLE `presentacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso_electoral`
--

DROP TABLE IF EXISTS `proceso_electoral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proceso_electoral` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proceso_electoral_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso_electoral`
--

LOCK TABLES `proceso_electoral` WRITE;
/*!40000 ALTER TABLE `proceso_electoral` DISABLE KEYS */;
INSERT INTO `proceso_electoral` VALUES (1,'PASO','2018-10-14 21:03:14','2018-10-14 21:03:14',NULL);
/*!40000 ALTER TABLE `proceso_electoral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad_id` int(10) unsigned NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (2,'Imprenta del Congreso de la Nación','Av. Rivadavia 1864',25,NULL,NULL,'2018-11-02 18:33:13','2018-11-02 18:37:02','2018-11-02 18:37:02');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provincia_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (1,'Buenos Aires','2018-10-12 20:07:04','2018-10-12 20:07:04',NULL),(2,'Catamarca','2018-10-12 20:07:20','2018-10-12 20:07:20',NULL),(3,'Córdoba','2018-10-12 20:07:30','2018-10-12 20:07:30',NULL),(4,'Chaco','2018-10-17 21:52:32','2018-10-17 21:52:32',NULL),(5,'Chubut','2018-10-17 21:52:41','2018-10-17 21:52:41',NULL),(7,'Corrientes','2018-10-17 21:56:03','2018-10-17 21:56:03',NULL),(8,'Entre Ríos','2018-10-17 21:56:16','2018-10-17 21:56:16',NULL),(9,'Formosa','2018-10-17 21:56:26','2018-10-17 21:56:26',NULL),(10,'Jujuy','2018-10-17 21:56:43','2018-10-17 21:56:43',NULL),(11,'La Pampa','2018-10-17 21:56:54','2018-10-17 21:56:54',NULL),(12,'La Rioja','2018-10-17 21:57:04','2018-10-17 21:57:04',NULL),(13,'Mendoza','2018-10-17 21:57:24','2018-10-17 21:57:24',NULL),(15,'Misiones','2018-10-17 21:59:13','2018-10-17 21:59:13',NULL),(16,'Neuquén','2018-10-17 21:59:21','2018-10-17 21:59:21',NULL),(17,'Río Negro','2018-10-17 21:59:28','2018-10-17 21:59:28',NULL),(18,'Salta','2018-10-17 21:59:36','2018-10-17 21:59:36',NULL),(19,'San Juan','2018-10-17 21:59:43','2018-10-17 21:59:43',NULL),(20,'San Luis','2018-10-17 21:59:51','2018-10-17 21:59:51',NULL),(21,'Santa Cruz','2018-10-17 21:59:58','2018-10-17 21:59:58',NULL),(22,'Santa Fe','2018-10-17 22:00:09','2018-10-17 22:00:09',NULL),(23,'Santiago del Estero','2018-10-17 22:00:17','2018-10-17 22:00:17',NULL),(24,'Tierra del Fuego, Antártida e Islas del Atlántico Sur','2018-10-17 22:10:47','2018-10-17 22:10:47',NULL),(25,'Tucumán','2018-10-17 22:33:39','2018-10-17 22:33:39',NULL);
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remito`
--

DROP TABLE IF EXISTS `remito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remito` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `punto_venta` smallint(5) unsigned NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `nota` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transportador` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patente` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conductor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dni` int(10) unsigned DEFAULT NULL,
  `telefono` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad_bultos` smallint(5) unsigned DEFAULT NULL,
  `peso` float DEFAULT NULL,
  `volumen` float DEFAULT NULL,
  `precintos` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr` text COLLATE utf8mb4_unicode_ci,
  `destinatario_id` int(10) unsigned DEFAULT NULL,
  `proveedor_id` int(10) unsigned DEFAULT NULL,
  `deposito_id` int(10) unsigned DEFAULT NULL,
  `orden_compra_id` int(10) unsigned DEFAULT NULL,
  `proceso_electoral_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remito`
--

LOCK TABLES `remito` WRITE;
/*!40000 ALTER TABLE `remito` DISABLE KEYS */;
/*!40000 ALTER TABLE `remito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remito_linea`
--

DROP TABLE IF EXISTS `remito_linea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remito_linea` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `remito_id` int(10) unsigned NOT NULL,
  `articulo_id` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remito_linea`
--

LOCK TABLES `remito_linea` WRITE;
/*!40000 ALTER TABLE `remito_linea` DISABLE KEYS */;
/*!40000 ALTER TABLE `remito_linea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Administrator','2018-10-09 12:36:31','2018-10-09 12:36:31',NULL),(2,'user','Normal User','2018-10-09 12:36:31','2018-10-09 12:36:31',NULL),(3,'almacenes_admin','Administrador Almacenes','2018-10-24 14:57:06','2018-10-24 14:57:06',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','Almacenes','','text',1,'Site'),(2,'site.description','Site Description','Sistema Integrado de Gestión de Stock, Control de Existencias, Integridad y Trazabilidad de Materiales, Útiles y Equipamiento Electoral','','text',2,'Site'),(3,'site.logo','Site Logo','','','image',3,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',4,'Site'),(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),(6,'admin.title','Admin Title','Voyager','','text',1,'Admin'),(7,'admin.description','Admin Description','Welcome to Voyager. The Missing Admin for Laravel','','text',2,'Admin'),(8,'admin.loader','Admin Loader','','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)',NULL,'','text',1,'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_destinatario`
--

DROP TABLE IF EXISTS `tipo_destinatario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_destinatario` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tipo_destinatario_nombre_unique` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_destinatario`
--

LOCK TABLES `tipo_destinatario` WRITE;
/*!40000 ALTER TABLE `tipo_destinatario` DISABLE KEYS */;
INSERT INTO `tipo_destinatario` VALUES (1,'Secretaría Electoral','2018-10-12 20:11:32','2018-10-12 20:11:32',NULL),(2,'Comisaría','2018-10-17 21:51:31','2018-10-17 21:51:31',NULL),(3,'Partido Politico','2018-10-19 14:26:40','2018-10-19 14:26:40',NULL),(4,'Ente Provincial','2018-10-19 14:27:03','2018-10-19 14:27:03',NULL),(5,'Ente municipal','2018-10-19 14:27:00','2018-10-24 18:01:00',NULL);
/*!40000 ALTER TABLE `tipo_destinatario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',5,'pt','Post','2018-10-09 12:36:33','2018-10-09 12:36:33'),(2,'data_types','display_name_singular',6,'pt','Página','2018-10-09 12:36:33','2018-10-09 12:36:33'),(3,'data_types','display_name_singular',1,'pt','Utilizador','2018-10-09 12:36:33','2018-10-09 12:36:33'),(4,'data_types','display_name_singular',4,'pt','Categoria','2018-10-09 12:36:33','2018-10-09 12:36:33'),(5,'data_types','display_name_singular',2,'pt','Menu','2018-10-09 12:36:33','2018-10-09 12:36:33'),(6,'data_types','display_name_singular',3,'pt','Função','2018-10-09 12:36:33','2018-10-09 12:36:33'),(7,'data_types','display_name_plural',5,'pt','Posts','2018-10-09 12:36:33','2018-10-09 12:36:33'),(8,'data_types','display_name_plural',6,'pt','Páginas','2018-10-09 12:36:33','2018-10-09 12:36:33'),(9,'data_types','display_name_plural',1,'pt','Utilizadores','2018-10-09 12:36:33','2018-10-09 12:36:33'),(10,'data_types','display_name_plural',4,'pt','Categorias','2018-10-09 12:36:33','2018-10-09 12:36:33'),(11,'data_types','display_name_plural',2,'pt','Menus','2018-10-09 12:36:33','2018-10-09 12:36:33'),(12,'data_types','display_name_plural',3,'pt','Funções','2018-10-09 12:36:33','2018-10-09 12:36:33'),(13,'categories','slug',1,'pt','categoria-1','2018-10-09 12:36:33','2018-10-09 12:36:33'),(14,'categories','name',1,'pt','Categoria 1','2018-10-09 12:36:33','2018-10-09 12:36:33'),(15,'categories','slug',2,'pt','categoria-2','2018-10-09 12:36:33','2018-10-09 12:36:33'),(16,'categories','name',2,'pt','Categoria 2','2018-10-09 12:36:33','2018-10-09 12:36:33'),(17,'pages','title',1,'pt','Olá Mundo','2018-10-09 12:36:33','2018-10-09 12:36:33'),(18,'pages','slug',1,'pt','ola-mundo','2018-10-09 12:36:33','2018-10-09 12:36:33'),(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2018-10-09 12:36:33','2018-10-09 12:36:33'),(20,'menu_items','title',1,'pt','Painel de Controle','2018-10-09 12:36:33','2018-10-09 12:36:33'),(21,'menu_items','title',2,'pt','Media','2018-10-09 12:36:33','2018-10-09 12:36:33'),(22,'menu_items','title',12,'pt','Publicações','2018-10-09 12:36:33','2018-10-09 12:36:33'),(23,'menu_items','title',3,'pt','Utilizadores','2018-10-09 12:36:33','2018-10-09 12:36:33'),(24,'menu_items','title',11,'pt','Categorias','2018-10-09 12:36:33','2018-10-09 12:36:33'),(25,'menu_items','title',13,'pt','Páginas','2018-10-09 12:36:33','2018-10-09 12:36:33'),(26,'menu_items','title',4,'pt','Funções','2018-10-09 12:36:33','2018-10-09 12:36:33'),(27,'menu_items','title',5,'pt','Ferramentas','2018-10-09 12:36:33','2018-10-09 12:36:33'),(28,'menu_items','title',6,'pt','Menus','2018-10-09 12:36:33','2018-10-09 12:36:33'),(29,'menu_items','title',7,'pt','Base de dados','2018-10-09 12:36:33','2018-10-09 12:36:33'),(30,'menu_items','title',10,'pt','Configurações','2018-10-09 12:36:33','2018-10-09 12:36:33');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Admin','admin@admin.com','users/default.png',NULL,'$2y$10$2RO7Mi6H2BnJDoevuoWzCeJ2uZuZBUQzaesvLjiX1sx6jEMSqgtgO','s1scknQxiqYUTENdhdoFgceiKEz0BOiATJyhb5ViNyS5nJACgNkGjyDi1VFG','{\"locale\":\"es\"}','2018-10-09 12:36:32','2018-10-24 14:58:53',NULL),(2,3,'Fabio Leonardi','fabioleonardi197@gmail.com','users/default.png',NULL,'$2y$10$j.cGho/jg4k/zaoUaw52duYfbLUHY2pcwiJWxJBw.B5rKW4Cd9B7q','d0nKco5s7vsE18woV7J0dWTxWl71FXSZkCX776OiYc6z6CZTzfvtO90hjydI','{\"locale\":\"es\"}','2018-10-24 14:58:27','2018-10-24 14:58:27',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-05  0:35:03
