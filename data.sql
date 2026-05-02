-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `admindata`
--

DROP TABLE IF EXISTS `admindata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admindata` (
  `adminid` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `phone_no` varchar(10) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` varbinary(255) DEFAULT NULL,
  `agreed` enum('on','off') DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `profile_img` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`adminid`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone_no` (`phone_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admindata`
--

LOCK TABLES `admindata` WRITE;
/*!40000 ALTER TABLE `admindata` DISABLE KEYS */;
INSERT INTO `admindata` VALUES (2,'Akshay Nandan','9014258004','akshaynandancheedaraboyina21@gmail.com',_binary '$2b$12$WqlASTVP3rczBFLjnQAKOuZOEeChZrmOiSx0ZqqP.DSXlSf9H/YKu','on','vijayawada','J9cB7e.jpg');
/*!40000 ALTER TABLE `admindata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `itemid` binary(16) NOT NULL,
  `item_name` text NOT NULL,
  `item_description` longtext,
  `price` decimal(20,4) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `category` enum('Home appliances','electronics','fasion','sports','grocery') DEFAULT NULL,
  `item_image` varchar(15) DEFAULT NULL,
  `added_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`itemid`),
  KEY `added_by` (`added_by`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `admindata` (`adminid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (_binary '•’°îx\Ñ\ﬁÅw—∞','Spykar Men Blue Skinny Fit Low Rise Casual Jeans','Product details\r\nMaterial typeCotton\r\nStyleJeans\r\nClosure typeButton & Zip\r\nOccasion typeCasual\r\nCare instructionsMachine Wash\r\nFit typeSlim\r\nCountry of OriginIndia',1329.0000,10,'fasion','K4uE9m.jpg',2),(_binary 'V\‡ºîw\Ñ\ﬁÅw—∞','Haier 325 L 3 Star Frost Free Bottom Mount Double Door Refrigerator|Convertible 14-in-1|Jhukna Mat-Bottom Freezer|Digital Display Panel|Triple Inverter|Twist Ice Maker (HEB-333DS-P, Dazzle Steel)','Eligible for Free Open Box Inspection Details \r\nProduct Dimensions	66.5D x 62.3W x 164H Centimeters\r\nBrand	Haier\r\nCapacity	325 litres\r\nConfiguration	Full-Sized Freezer-on-Bottom\r\nBEE Star Rating	3 Star',34990.0000,3,'Home appliances','V7yY0d.jpg',2),(_binary 'ÜÜd∆îx\Ñ\ﬁÅw—∞','Tata Sampann Organic Unpolished Chana Dal, 1kg','Brand	Tata Sampann\r\nItem Weight	1000 Grams\r\nSpeciality	Organic\r\nItem Form	Granule\r\nDiet Type	Vegan\r\nPackage Weight	0.96 Kilograms\r\nVariety	Chickpeas\r\nManufacturer	Tata Sampann\r\nNet Quantity	1000.0 Grams\r\n',175.0000,3,'grocery','N4fF5n.jpg',2),(_binary 'ß´]åîx\Ñ\ﬁÅw—∞','Tata Salt 1 Kg, Free Flowing and Iodised Namak, Vacuum Evaporated, Salt in Fresh','\r\nFlavour	Iodised Salt\r\nBrand	TATA SALT\r\nItem Weight	1 Kilograms\r\nSpeciality	Vegetarian\r\nNet Quantity	1000.0 Grams',30.0000,2,'grocery','F1gI7n.jpg',2),(_binary 'Áãñ\Íîw\Ñ\ﬁÅw—∞','ASIAN Men\'s Wonder Sports Running,Walking & Gym Shoes with Casual Sneaker Lightweight Lace-Up Shoes for Men\'s Delta-20','Product details\r\nMaterial typeFabric\r\nClosure typeLace-Up\r\nHeel typeFlat\r\nWater resistance levelNot Water Resistant\r\nSole materialEthylene Vinyl Acetate\r\nStyleSneaker\r\nCountry of OriginIndia\r\n',859.0000,6,'fasion','S4iE4v.jpg',2),(_binary '\Îì\·îv\Ñ\ﬁÅw—∞','Panasonic 23L Convection Microwave Oven(NN-CT353BFDG,Black Mirror, 360¬∞ Heat Wrap, Magic Grill)','Eligible for Free Open Box Inspection Details \r\nBrand	Panasonic\r\nProduct Dimensions	40.5D x 48.6W x 29.2H Centimeters\r\nColour	Black Mirror\r\nCapacity	23 litres\r\nSpecial Feature	Auto Cook',10590.0000,1,'Home appliances','F2cC3s.jpg',2);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderid` binary(30) NOT NULL,
  `itemid` binary(16) DEFAULT NULL,
  `item_name` longtext,
  `quantity` int unsigned DEFAULT NULL,
  `total_amount` decimal(20,4) DEFAULT NULL,
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `item_image` varchar(20) DEFAULT NULL,
  `payment_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  KEY `payment_by` (`payment_by`),
  KEY `itemid` (`itemid`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`payment_by`) REFERENCES `userdata` (`userid`) ON DELETE SET NULL,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (_binary 'order_RLoWLGpgkwuJBa\0\0\0\0\0\0\0\0\0\0',_binary '•’°îx\Ñ\ﬁÅw—∞','',1,132900.0000,'2025-09-25 16:45:06','K4uE9m.jpg',4),(_binary 'order_RLrhVpif9CsQWK\0\0\0\0\0\0\0\0\0\0',_binary 'ß´]åîx\Ñ\ﬁÅw—∞','',1,3000.0000,'2025-09-25 19:50:22','F1gI7n.jpg',4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int unsigned NOT NULL AUTO_INCREMENT,
  `review_text` text,
  `rating` enum('1','2','3','4','5') DEFAULT NULL,
  `itemid` binary(16) DEFAULT NULL,
  `userid` int unsigned DEFAULT NULL,
  `comment_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `review_title` text,
  PRIMARY KEY (`review_id`),
  KEY `itemid` (`itemid`),
  KEY `userid` (`userid`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE SET NULL,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `userdata` (`userid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdata`
--

DROP TABLE IF EXISTS `userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdata` (
  `userid` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` text,
  `password` varbinary(255) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `phone_no` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `password` (`password`),
  UNIQUE KEY `phone_no` (`phone_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdata`
--

LOCK TABLES `userdata` WRITE;
/*!40000 ALTER TABLE `userdata` DISABLE KEYS */;
INSERT INTO `userdata` VALUES (4,'Nandan','akshaynandancheedaraboyina21@gmail.com','Prasadam Padu',_binary '$2b$12$oCmgpKgRZGISdEwLXi9JzuWWlZOHzapQOfhBv4ubWNu2QAYVd/Esu','male','9014258007');
/*!40000 ALTER TABLE `userdata` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-27 15:55:10
