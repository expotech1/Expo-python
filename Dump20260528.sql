-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: copa
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `alb_id` int NOT NULL AUTO_INCREMENT,
  `alb_edicao` varchar(50) NOT NULL,
  `alb_ano` year DEFAULT NULL,
  `alb_nome` varchar(50) NOT NULL,
  PRIMARY KEY (`alb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colecao`
--

DROP TABLE IF EXISTS `colecao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colecao` (
  `col_id` int NOT NULL AUTO_INCREMENT,
  `col_data` date DEFAULT NULL,
  `col_repetida` tinyint(1) NOT NULL,
  `col_qtd` int NOT NULL,
  `usu_id` int DEFAULT NULL,
  `sel_id` int DEFAULT NULL,
  PRIMARY KEY (`col_id`),
  KEY `usu_id` (`usu_id`),
  KEY `sel_id` (`sel_id`),
  CONSTRAINT `colecao_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuario` (`usu_id`),
  CONSTRAINT `colecao_ibfk_2` FOREIGN KEY (`sel_id`) REFERENCES `selecao` (`sel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colecao`
--

LOCK TABLES `colecao` WRITE;
/*!40000 ALTER TABLE `colecao` DISABLE KEYS */;
/*!40000 ALTER TABLE `colecao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `figurinha`
--

DROP TABLE IF EXISTS `figurinha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `figurinha` (
  `fig_id` int NOT NULL AUTO_INCREMENT,
  `fig_raridade` varchar(50) NOT NULL,
  `fig_numero_jogador` int DEFAULT NULL,
  `jog_id` int DEFAULT NULL,
  `alb_id` int DEFAULT NULL,
  PRIMARY KEY (`fig_id`),
  KEY `jog_id` (`jog_id`),
  KEY `alb_id` (`alb_id`),
  CONSTRAINT `figurinha_ibfk_1` FOREIGN KEY (`jog_id`) REFERENCES `jogador` (`jog_id`),
  CONSTRAINT `figurinha_ibfk_2` FOREIGN KEY (`alb_id`) REFERENCES `album` (`alb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `figurinha`
--

LOCK TABLES `figurinha` WRITE;
/*!40000 ALTER TABLE `figurinha` DISABLE KEYS */;
/*!40000 ALTER TABLE `figurinha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jogador`
--

DROP TABLE IF EXISTS `jogador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jogador` (
  `jog_id` int NOT NULL AUTO_INCREMENT,
  `jog_pais` varchar(50) NOT NULL,
  `jog_posicao` varchar(50) NOT NULL,
  `jog_nome` varchar(100) NOT NULL,
  `sel_id` int DEFAULT NULL,
  PRIMARY KEY (`jog_id`),
  KEY `sel_id` (`sel_id`),
  CONSTRAINT `jogador_ibfk_1` FOREIGN KEY (`sel_id`) REFERENCES `selecao` (`sel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jogador`
--

LOCK TABLES `jogador` WRITE;
/*!40000 ALTER TABLE `jogador` DISABLE KEYS */;
/*!40000 ALTER TABLE `jogador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selecao`
--

DROP TABLE IF EXISTS `selecao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `selecao` (
  `sel_id` int NOT NULL AUTO_INCREMENT,
  `sel_pais` varchar(50) NOT NULL,
  `sel_confederacao` varchar(50) NOT NULL,
  PRIMARY KEY (`sel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selecao`
--

LOCK TABLES `selecao` WRITE;
/*!40000 ALTER TABLE `selecao` DISABLE KEYS */;
/*!40000 ALTER TABLE `selecao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_nome` varchar(100) NOT NULL,
  `usu_email` varchar(100) NOT NULL,
  `usu_senha` varchar(100) NOT NULL,
  PRIMARY KEY (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-28 15:25:36
