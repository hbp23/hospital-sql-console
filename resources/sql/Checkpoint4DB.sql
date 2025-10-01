-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: localhost    Database: Checkpoint4DB
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `Admission`
--

DROP TABLE IF EXISTS `Admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admission` (
  `admission_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `diagnosis_id` int NOT NULL,
  `room_number` int NOT NULL,
  `primary_doctor` int NOT NULL,
  `admission_date` date NOT NULL,
  `discharge_date` date DEFAULT NULL,
  `assigned_room_by` int NOT NULL,
  `discharged_by` int DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  UNIQUE KEY `admission_id_UNIQUE` (`admission_id`),
  KEY `patient_id_idx` (`patient_id`),
  KEY `patient_idx` (`patient_id`),
  KEY `diagnosis_id_idx` (`diagnosis_id`),
  KEY `room_idx` (`room_number`),
  KEY `primary_doctor_idx` (`primary_doctor`),
  KEY `assigned_room_by_idx` (`assigned_room_by`),
  KEY `discharged_by_idx` (`discharged_by`),
  CONSTRAINT `assigned_room_by` FOREIGN KEY (`assigned_room_by`) REFERENCES `Employee` (`employee_id`),
  CONSTRAINT `diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `Diagnosis` (`diagnosis_id`),
  CONSTRAINT `discharged_by` FOREIGN KEY (`discharged_by`) REFERENCES `Employee` (`employee_id`),
  CONSTRAINT `patient` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`),
  CONSTRAINT `primary_doctor` FOREIGN KEY (`primary_doctor`) REFERENCES `Employee` (`employee_id`),
  CONSTRAINT `room` FOREIGN KEY (`room_number`) REFERENCES `Room` (`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admission`
--

LOCK TABLES `Admission` WRITE;
/*!40000 ALTER TABLE `Admission` DISABLE KEYS */;
INSERT INTO `Admission` VALUES (1010,101,14,10,1352,'2025-03-28','2025-03-28',1123,1123),(1020,102,1243,3,2142,'2025-03-28',NULL,1123,NULL),(1030,103,124,2,1352,'2025-03-29','2025-03-30',1123,1123),(1040,104,3,8,1352,'2025-03-30','2025-03-30',1123,1123);
/*!40000 ALTER TABLE `Admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diagnosis`
--

DROP TABLE IF EXISTS `Diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Diagnosis` (
  `diagnosis_id` int NOT NULL,
  `diagnosis` varchar(255) NOT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `name_UNIQUE` (`diagnosis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diagnosis`
--

LOCK TABLES `Diagnosis` WRITE;
/*!40000 ALTER TABLE `Diagnosis` DISABLE KEYS */;
INSERT INTO `Diagnosis` VALUES (124,'Broken ankle'),(3,'Cough'),(14,'Flu'),(1243,'Pancreatitis');
/*!40000 ALTER TABLE `Diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `employee_id` int NOT NULL,
  `role` enum('staff','technician','nurse','administrator','doctor') NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `employee_id_UNIQUE` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1123,'administrator','May','Cruze',NULL),(1352,'doctor','Henry','Stone','cardio'),(2142,'doctor','Po','Chester','internal medicine'),(4321,'nurse','Polly','Johnson',NULL),(6453,'technician','Will','Billingsley',NULL),(9023,'staff','Lemo','Reed',NULL);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hospital`
--

DROP TABLE IF EXISTS `Hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hospital` (
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hospital`
--

LOCK TABLES `Hospital` WRITE;
/*!40000 ALTER TABLE `Hospital` DISABLE KEYS */;
INSERT INTO `Hospital` VALUES ('Auburn Hospital','251 S Donahue Dr, Auburn, AL 36849');
/*!40000 ALTER TABLE `Hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient` (
  `patient_id` int NOT NULL,
  `insurance_policy` varchar(50) NOT NULL,
  `emergency_contact` varchar(255) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `patient_id_UNIQUE` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (101,'AB23213412','John Snow 435-949-1234','Joe','Smith','1985-03-02'),(102,'BC48294104','Jan Lopez 345-934-4343','Jen','Lopez','1999-05-22'),(103,'AB04248525','Jo Patel 665-234-1142','Henry','Patel','1945-11-14'),(104,'BC09138467','John Smith 901-303-4114','Al','Green','2002-01-30');
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Doctors`
--

DROP TABLE IF EXISTS `Patient_Doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Doctors` (
  `doctor_id` int NOT NULL,
  `admission_id` int NOT NULL,
  PRIMARY KEY (`doctor_id`,`admission_id`),
  KEY `admission_idx` (`admission_id`),
  CONSTRAINT `admission` FOREIGN KEY (`admission_id`) REFERENCES `Admission` (`admission_id`),
  CONSTRAINT `doctor` FOREIGN KEY (`doctor_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Doctors`
--

LOCK TABLES `Patient_Doctors` WRITE;
/*!40000 ALTER TABLE `Patient_Doctors` DISABLE KEYS */;
INSERT INTO `Patient_Doctors` VALUES (1352,1010),(1352,1020),(2142,1020),(1352,1030),(1352,1040),(2142,1040);
/*!40000 ALTER TABLE `Patient_Doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Room` (
  `room_number` int NOT NULL,
  `patient_id` int DEFAULT NULL,
  PRIMARY KEY (`room_number`),
  UNIQUE KEY `room_number_UNIQUE` (`room_number`),
  UNIQUE KEY `patient_id_UNIQUE` (`patient_id`),
  CONSTRAINT `patient_id` FOREIGN KEY (`patient_id`) REFERENCES `Patient` (`patient_id`),
  CONSTRAINT `room_chk_1` CHECK ((`room_number` between 1 and 20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
INSERT INTO `Room` VALUES (1,NULL),(2,NULL),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL),(20,NULL),(3,102);
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Treatment`
--

DROP TABLE IF EXISTS `Treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Treatment` (
  `treatment_id` int NOT NULL,
  `type` enum('procedure','medication') NOT NULL,
  `description` text NOT NULL,
  `order_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ordered_by_id` int NOT NULL,
  `admission_id` int NOT NULL,
  PRIMARY KEY (`treatment_id`),
  UNIQUE KEY `treatment_id_UNIQUE` (`treatment_id`),
  KEY `employee_id_idx` (`ordered_by_id`),
  KEY `admission_id_idx` (`admission_id`),
  CONSTRAINT `admission_id` FOREIGN KEY (`admission_id`) REFERENCES `Admission` (`admission_id`),
  CONSTRAINT `ordered_by_id` FOREIGN KEY (`ordered_by_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Treatment`
--

LOCK TABLES `Treatment` WRITE;
/*!40000 ALTER TABLE `Treatment` DISABLE KEYS */;
INSERT INTO `Treatment` VALUES (23,'medication','Flu medicine','2025-03-28 19:23:12',1352,1010),(27,'medication','Pain medicine','2025-03-29 01:03:30',2142,1020),(29,'medication','Pain medicine','2025-03-29 23:04:55',1352,1030),(35,'medication','Cough syrup','2025-03-30 15:20:15',2142,1040),(339,'procedure','Pancreas removal','2025-03-29 13:10:00',2142,1020);
/*!40000 ALTER TABLE `Treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Treatment_Administration`
--

DROP TABLE IF EXISTS `Treatment_Administration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Treatment_Administration` (
  `treatment_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `administration_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`,`administration_time`,`treatment_id`),
  KEY `treatment_idx` (`treatment_id`),
  CONSTRAINT `employee` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`),
  CONSTRAINT `treatment` FOREIGN KEY (`treatment_id`) REFERENCES `Treatment` (`treatment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Treatment_Administration`
--

LOCK TABLES `Treatment_Administration` WRITE;
/*!40000 ALTER TABLE `Treatment_Administration` DISABLE KEYS */;
INSERT INTO `Treatment_Administration` VALUES (23,4321,'2025-03-28 19:42:42'),(27,1352,'2025-03-29 03:01:05'),(29,1352,'2025-03-29 23:30:51'),(35,4321,'2025-03-30 15:30:35'),(339,2142,'2025-03-29 15:00:00');
/*!40000 ALTER TABLE `Treatment_Administration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-29  1:18:07
