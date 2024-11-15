-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: intelligent_course_platform
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `course_homework`
--

DROP TABLE IF EXISTS `course_homework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_homework` (
  `homework_id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `due_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`homework_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `course_homework_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_homework`
--

LOCK TABLES `course_homework` WRITE;
/*!40000 ALTER TABLE `course_homework` DISABLE KEYS */;
INSERT INTO `course_homework` VALUES (2,1,'hw1','lll','2024-11-12 12:21:49','2024-11-12 12:21:55'),(3,2,'2222','22222','2024-11-12 12:24:34','2024-11-12 12:24:36');
/*!40000 ALTER TABLE `course_homework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_material`
--

DROP TABLE IF EXISTS `course_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_material` (
  `material_id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `material_type` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`material_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `course_material_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_material`
--

LOCK TABLES `course_material` WRITE;
/*!40000 ALTER TABLE `course_material` DISABLE KEYS */;
INSERT INTO `course_material` VALUES (3,2,'courseCalendar','“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf','\\courseMaterial\\2\\materialType\\courseCalendar\\“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf','2024-11-14 09:47:08'),(4,3,'courseCalendar','“中国特色社会主义理论与实践研究”期末考试通知_20241114180315A001.pdf','/courseMaterial/3/materialType/courseCalendar/“中国特色社会主义理论与实践研究”期末考试通知_20241114180315A001.pdf','2024-11-14 10:03:15'),(5,1,'courseCalendar','0702物理学科评审意见_20241114183257A004.pdf','/courseMaterial/1/materialType/courseCalendar/0702物理学科评审意见_20241114183257A004.pdf','2024-11-14 10:32:57');
/*!40000 ALTER TABLE `course_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_user`
--

DROP TABLE IF EXISTS `course_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_user` (
  `course_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  `role` enum('TEACHER','STUDENT') NOT NULL,
  `enrolled_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `course_user_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `course_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_user`
--

LOCK TABLES `course_user` WRITE;
/*!40000 ALTER TABLE `course_user` DISABLE KEYS */;
INSERT INTO `course_user` VALUES (1,1,'TEACHER','2024-11-11 14:54:55');
/*!40000 ALTER TABLE `course_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_source` varchar(255) DEFAULT NULL,
  `course_video` varchar(255) DEFAULT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_description` text,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'lll','fwalegfowegofwao','2','ofoeasfowoae'),(2,'gaweg','fwalegfowegofwao','helllllllo','fwaeofoawefo'),(3,NULL,'fwalegfowegofwao','helllllllo','fmwaepfpwea');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (15,'course_homework','',NULL,NULL,'CourseHomework','crud','','com.ruoyi.system','system','homework',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(16,'course_material','',NULL,NULL,'CourseMaterial','crud','','com.ruoyi.system','system','material',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(17,'course_user','',NULL,NULL,'CourseUser','crud','','com.ruoyi.system','system','user',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(18,'courses','',NULL,NULL,'Courses','crud','','com.ruoyi.system','system','courses',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(19,'homework_submissions','',NULL,NULL,'HomeworkSubmissions','crud','','com.ruoyi.system','system','submissions',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(20,'notice','',NULL,NULL,'Notice','crud','','com.ruoyi.system','system','notice',NULL,'ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(21,'sys_config','参数配置表',NULL,NULL,'SysConfig','crud','','com.ruoyi.system','system','config','参数配置','ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(22,'sys_dict_data','字典数据表',NULL,NULL,'SysDictData','crud','','com.ruoyi.system','system','data','字典数据','ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(23,'sys_dict_type','字典类型表',NULL,NULL,'SysDictType','crud','','com.ruoyi.system','system','type','字典类型','ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL),(24,'sys_job','定时任务调度表',NULL,NULL,'SysJob','crud','','com.ruoyi.system','system','job','定时任务调度','ruoyi','0','/',NULL,'admin','2024-11-11 22:33:26','',NULL,NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (66,15,'homework_id',NULL,'bigint','Long','homeworkId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(67,15,'course_id',NULL,'int','Long','courseId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(68,15,'title',NULL,'varchar(255)','String','title','0','0','1','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(69,15,'description',NULL,'text','String','description','0','0','0','1','1','1','1','EQ','textarea','',4,'admin','2024-11-11 22:33:26','',NULL),(70,15,'due_date',NULL,'timestamp','Date','dueDate','0','0','0','1','1','1','1','EQ','datetime','',5,'admin','2024-11-11 22:33:26','',NULL),(71,15,'created_at',NULL,'timestamp','Date','createdAt','0','0','0','1','1','1','1','EQ','datetime','',6,'admin','2024-11-11 22:33:26','',NULL),(72,16,'material_id',NULL,'bigint','Long','materialId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(73,16,'course_id',NULL,'int','Long','courseId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(74,16,'title',NULL,'varchar(255)','String','title','0','0','1','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(75,16,'file_path',NULL,'varchar(500)','String','filePath','0','0','1','1','1','1','1','EQ','textarea','',4,'admin','2024-11-11 22:33:26','',NULL),(76,16,'created_at',NULL,'timestamp','Date','createdAt','0','0','0','1','1','1','1','EQ','datetime','',5,'admin','2024-11-11 22:33:26','',NULL),(77,17,'course_id',NULL,'int','Long','courseId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(78,17,'user_id',NULL,'bigint','Long','userId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(79,17,'role',NULL,'enum(\'TEACHER\',\'STUDENT\')','String','role','0','0','1','1','1','1','1','EQ',NULL,'',3,'admin','2024-11-11 22:33:26','',NULL),(80,17,'enrolled_at',NULL,'timestamp','Date','enrolledAt','0','0','0','1','1','1','1','EQ','datetime','',4,'admin','2024-11-11 22:33:26','',NULL),(81,18,'course_id',NULL,'int','Long','courseId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(82,18,'course_source',NULL,'varchar(255)','String','courseSource','0','0','0','1','1','1','1','EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(83,18,'course_video',NULL,'varchar(255)','String','courseVideo','0','0','0','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(84,18,'course_name',NULL,'varchar(255)','String','courseName','0','0','1','1','1','1','1','LIKE','input','',4,'admin','2024-11-11 22:33:26','',NULL),(85,18,'course_description',NULL,'text','String','courseDescription','0','0','0','1','1','1','1','EQ','textarea','',5,'admin','2024-11-11 22:33:26','',NULL),(86,19,'submission_id',NULL,'bigint','Long','submissionId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(87,19,'homework_id',NULL,'bigint','Long','homeworkId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(88,19,'user_id',NULL,'bigint','Long','userId','0','0','1','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(89,19,'file_path',NULL,'varchar(500)','String','filePath','0','0','1','1','1','1','1','EQ','textarea','',4,'admin','2024-11-11 22:33:26','',NULL),(90,19,'submitted_at',NULL,'timestamp','Date','submittedAt','0','0','0','1','1','1','1','EQ','datetime','',5,'admin','2024-11-11 22:33:26','',NULL),(91,19,'grade',NULL,'decimal(5,2)','BigDecimal','grade','0','0','0','1','1','1','1','EQ','input','',6,'admin','2024-11-11 22:33:26','',NULL),(92,19,'feedback',NULL,'text','String','feedback','0','0','0','1','1','1','1','EQ','textarea','',7,'admin','2024-11-11 22:33:26','',NULL),(93,20,'notice_id',NULL,'int','Long','noticeId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(94,20,'notice_info',NULL,'text','String','noticeInfo','0','0','1','1','1','1','1','EQ','textarea','',2,'admin','2024-11-11 22:33:26','',NULL),(95,20,'publish_time',NULL,'datetime','Date','publishTime','0','0','1','1','1','1','1','EQ','datetime','',3,'admin','2024-11-11 22:33:26','',NULL),(96,20,'end_time',NULL,'datetime','Date','endTime','0','0','1','1','1','1','1','EQ','datetime','',4,'admin','2024-11-11 22:33:26','',NULL),(97,20,'delete_flag',NULL,'tinyint(1)','Integer','deleteFlag','0','0','0','1','1','1','1','EQ','input','',5,'admin','2024-11-11 22:33:26','',NULL),(98,21,'config_id','参数主键','int','Long','configId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(99,21,'config_name','参数名称','varchar(100)','String','configName','0','0','0','1','1','1','1','LIKE','input','',2,'admin','2024-11-11 22:33:26','',NULL),(100,21,'config_key','参数键名','varchar(100)','String','configKey','0','0','0','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(101,21,'config_value','参数键值','varchar(500)','String','configValue','0','0','0','1','1','1','1','EQ','textarea','',4,'admin','2024-11-11 22:33:26','',NULL),(102,21,'config_type','系统内置（Y是 N否）','char(1)','String','configType','0','0','0','1','1','1','1','EQ','select','',5,'admin','2024-11-11 22:33:26','',NULL),(103,21,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',6,'admin','2024-11-11 22:33:26','',NULL),(104,21,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',7,'admin','2024-11-11 22:33:26','',NULL),(105,21,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',8,'admin','2024-11-11 22:33:26','',NULL),(106,21,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',9,'admin','2024-11-11 22:33:26','',NULL),(107,21,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',10,'admin','2024-11-11 22:33:26','',NULL),(108,22,'dict_code','字典编码','bigint','Long','dictCode','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(109,22,'dict_sort','字典排序','int','Long','dictSort','0','0','0','1','1','1','1','EQ','input','',2,'admin','2024-11-11 22:33:26','',NULL),(110,22,'dict_label','字典标签','varchar(100)','String','dictLabel','0','0','0','1','1','1','1','EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(111,22,'dict_value','字典键值','varchar(100)','String','dictValue','0','0','0','1','1','1','1','EQ','input','',4,'admin','2024-11-11 22:33:26','',NULL),(112,22,'dict_type','字典类型','varchar(100)','String','dictType','0','0','0','1','1','1','1','EQ','select','',5,'admin','2024-11-11 22:33:26','',NULL),(113,22,'css_class','样式属性（其他样式扩展）','varchar(100)','String','cssClass','0','0','0','1','1','1','1','EQ','input','',6,'admin','2024-11-11 22:33:26','',NULL),(114,22,'list_class','表格回显样式','varchar(100)','String','listClass','0','0','0','1','1','1','1','EQ','input','',7,'admin','2024-11-11 22:33:26','',NULL),(115,22,'is_default','是否默认（Y是 N否）','char(1)','String','isDefault','0','0','0','1','1','1','1','EQ','input','',8,'admin','2024-11-11 22:33:26','',NULL),(116,22,'status','状态（0正常 1停用）','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','',9,'admin','2024-11-11 22:33:26','',NULL),(117,22,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',10,'admin','2024-11-11 22:33:26','',NULL),(118,22,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',11,'admin','2024-11-11 22:33:26','',NULL),(119,22,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',12,'admin','2024-11-11 22:33:26','',NULL),(120,22,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',13,'admin','2024-11-11 22:33:26','',NULL),(121,22,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',14,'admin','2024-11-11 22:33:26','',NULL),(122,23,'dict_id','字典主键','bigint','Long','dictId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(123,23,'dict_name','字典名称','varchar(100)','String','dictName','0','0','0','1','1','1','1','LIKE','input','',2,'admin','2024-11-11 22:33:26','',NULL),(124,23,'dict_type','字典类型','varchar(100)','String','dictType','0','0','0','1','1','1','1','EQ','select','',3,'admin','2024-11-11 22:33:26','',NULL),(125,23,'status','状态（0正常 1停用）','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','',4,'admin','2024-11-11 22:33:26','',NULL),(126,23,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',5,'admin','2024-11-11 22:33:26','',NULL),(127,23,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',6,'admin','2024-11-11 22:33:26','',NULL),(128,23,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',7,'admin','2024-11-11 22:33:26','',NULL),(129,23,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',8,'admin','2024-11-11 22:33:26','',NULL),(130,23,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',9,'admin','2024-11-11 22:33:26','',NULL),(131,24,'job_id','任务ID','bigint','Long','jobId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-11 22:33:26','',NULL),(132,24,'job_name','任务名称','varchar(64)','String','jobName','1','0','0','1',NULL,NULL,NULL,'LIKE','input','',2,'admin','2024-11-11 22:33:26','',NULL),(133,24,'job_group','任务组名','varchar(64)','String','jobGroup','1','0','0','1',NULL,NULL,NULL,'EQ','input','',3,'admin','2024-11-11 22:33:26','',NULL),(134,24,'invoke_target','调用目标字符串','varchar(500)','String','invokeTarget','0','0','1','1','1','1','1','EQ','textarea','',4,'admin','2024-11-11 22:33:26','',NULL),(135,24,'cron_expression','cron执行表达式','varchar(255)','String','cronExpression','0','0','0','1','1','1','1','EQ','input','',5,'admin','2024-11-11 22:33:26','',NULL),(136,24,'misfire_policy','计划执行错误策略（1立即执行 2执行一次 3放弃执行）','varchar(20)','String','misfirePolicy','0','0','0','1','1','1','1','EQ','input','',6,'admin','2024-11-11 22:33:26','',NULL),(137,24,'concurrent','是否并发执行（0允许 1禁止）','char(1)','String','concurrent','0','0','0','1','1','1','1','EQ','input','',7,'admin','2024-11-11 22:33:26','',NULL),(138,24,'status','状态（0正常 1暂停）','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','',8,'admin','2024-11-11 22:33:26','',NULL),(139,24,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',9,'admin','2024-11-11 22:33:26','',NULL),(140,24,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',10,'admin','2024-11-11 22:33:26','',NULL),(141,24,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',11,'admin','2024-11-11 22:33:26','',NULL),(142,24,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',12,'admin','2024-11-11 22:33:26','',NULL),(143,24,'remark','备注信息','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',13,'admin','2024-11-11 22:33:26','',NULL);
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homework_submissions`
--

DROP TABLE IF EXISTS `homework_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homework_submissions` (
  `submission_id` bigint NOT NULL AUTO_INCREMENT,
  `homework_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `grade` decimal(5,2) DEFAULT NULL,
  `feedback` text,
  `course_id` int NOT NULL,
  PRIMARY KEY (`submission_id`),
  KEY `homework_id` (`homework_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `homework_submissions_ibfk_1` FOREIGN KEY (`homework_id`) REFERENCES `course_homework` (`homework_id`),
  CONSTRAINT `homework_submissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homework_submissions`
--

LOCK TABLES `homework_submissions` WRITE;
/*!40000 ALTER TABLE `homework_submissions` DISABLE KEYS */;
INSERT INTO `homework_submissions` VALUES (6,2,1,'/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241113225344A001.txt','2024-11-13 14:53:44',NULL,NULL,1),(7,2,1,'/course_homework/1/homework/2/user/1/37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114130623A001.txt','2024-11-14 05:06:23',NULL,NULL,1),(8,3,1,'/course_homework/2/homework/3/user/1/36.本科生学籍管理制度补充规定_636669942272995514_20241114130645A002.txt','2024-11-14 05:06:45',NULL,NULL,2),(9,2,1,'/course_homework/1/homework/2/user/1/20   年度收费项目备案表_20241114153730A002.txt','2024-11-14 07:37:30',NULL,NULL,1),(10,2,1,'/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241114181047A002.pdf','2024-11-14 10:10:47',NULL,NULL,1),(11,3,1,'/course_homework/2/homework/3/user/1/0702物理学科评审意见_20241114181953A003.pdf','2024-11-14 10:19:53',NULL,NULL,2),(12,2,1,'/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241114235649A002.pdf','2024-11-14 15:56:49',NULL,NULL,1),(13,2,1,'/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241115000514A001.pdf','2024-11-14 16:05:14',NULL,NULL,1);
/*!40000 ALTER TABLE `homework_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT,
  `notice_info` text NOT NULL,
  `publish_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `delete_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2024-09-13 15:47:04','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2024-09-13 15:47:04','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2024-09-13 15:47:04','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','false','Y','admin','2024-09-13 15:47:04','admin','2024-09-13 16:21:27','是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','true','Y','admin','2024-09-13 15:47:04','admin','2024-09-13 15:57:50','是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2024-09-13 15:47:04','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-09-13 15:47:03','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2024-09-13 15:47:04','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2024-09-13 15:47:04','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2024-09-13 15:47:04','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2024-09-13 15:47:04','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2024-09-13 15:47:04','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2024-09-13 15:47:04','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2024-09-13 15:47:04','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2024-09-13 15:47:04','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2024-09-13 15:47:04','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2024-09-13 15:47:04','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2024-09-13 15:47:04','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2024-09-13 15:47:04','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2024-09-13 15:47:04','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2024-09-13 15:47:04','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2024-09-13 15:47:04','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2024-09-13 15:47:04','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2024-09-13 15:47:04','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2024-09-13 15:47:04','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2024-09-13 15:47:04','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2024-09-13 15:47:04','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2024-09-13 15:47:04','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2024-09-13 15:47:04','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2024-09-13 15:47:04','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2024-09-13 15:47:04','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2024-09-13 15:47:04','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2024-09-13 15:47:04','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2024-09-13 15:47:04','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2024-09-13 15:47:04','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2024-09-13 15:47:04','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2024-09-13 15:47:04','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2024-09-13 15:47:04','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2024-09-13 15:47:04','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2024-09-13 15:47:04','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2024-09-13 15:47:04','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-09-13 15:57:18'),(101,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-09-13 15:58:12'),(102,'20301098','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:00:01'),(103,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-09-13 16:21:10'),(104,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-09-13 16:21:32'),(105,'20301098','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:40'),(106,'20301099','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:42'),(107,'20301104','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:43'),(108,'20301106','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:45'),(109,'21301050','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:47'),(110,'21301134','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:49'),(111,'21301135','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:50'),(112,'21311045','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:52'),(113,'22221208','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:53'),(114,'22301007','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:55'),(115,'22301008','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:57'),(116,'22301010','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:28:58'),(117,'22301011','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:00'),(118,'22301013','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:02'),(119,'22301014','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:03'),(120,'22301015','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:05'),(121,'22301022','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:07'),(122,'22301028','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:09'),(123,'22301029','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:10'),(124,'22301040','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:12'),(125,'22301048','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:13'),(126,'22301054','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:15'),(127,'22301055','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:17'),(128,'22301056','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:18'),(129,'22301057','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:20'),(130,'22301058','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:22'),(131,'22301060','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:23'),(132,'22301061','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:25'),(133,'22301064','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:27'),(134,'22301065','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:28'),(135,'22301070','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:30'),(136,'22301082','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:32'),(137,'22301083','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:33'),(138,'22301087','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:35'),(139,'22301088','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:37'),(140,'22301089','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:39'),(141,'22301090','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:40'),(142,'22301091','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:42'),(143,'22301097','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:44'),(144,'22301101','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:45'),(145,'22301102','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:47'),(146,'22301103','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:48'),(147,'22301105','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:49'),(148,'22301108','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:51'),(149,'22301109','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:52'),(150,'22301112','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:54'),(151,'22301117','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:55'),(152,'22301128','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:56'),(153,'22301131','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:58'),(154,'22301132','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:29:59'),(155,'22301135','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:00'),(156,'22301137','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:02'),(157,'22301138','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:03'),(158,'22301139','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:05'),(159,'22301144','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:06'),(160,'22301148','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:08'),(161,'22301151','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:10'),(162,'22301152','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:11'),(163,'22301163','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:13'),(164,'22301167','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:14'),(165,'22301172','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:15'),(166,'23309001','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-09-13 16:30:17'),(167,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-09-13 17:32:43'),(168,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-24 14:31:00'),(169,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-24 14:31:11'),(170,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-24 14:31:26'),(171,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-24 15:08:26'),(172,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-24 15:08:37'),(173,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-24 15:08:55'),(174,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-24 15:09:06'),(175,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 00:43:27'),(176,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 14:51:58'),(177,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 19:07:26'),(178,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-27 19:49:55'),(179,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 19:50:08'),(180,'22301058','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-27 19:53:47'),(181,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 19:53:59'),(182,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 21:22:56'),(183,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-27 23:10:37'),(184,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-28 22:22:03'),(185,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-01 15:05:43'),(186,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-11 22:32:46'),(187,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-12 11:57:32'),(188,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-12 15:53:32'),(189,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-12 17:40:32'),(190,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-12 19:40:59'),(191,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-13 10:42:59'),(192,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-13 14:53:11'),(193,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-13 15:47:27'),(194,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-13 15:47:41'),(195,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-13 21:47:03'),(196,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 13:06:05'),(197,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 15:33:01'),(198,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 17:22:20'),(199,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-14 18:28:23'),(200,'siyu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','注册成功','2024-11-14 18:28:40'),(201,'siyu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 18:28:54'),(202,'siyu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-14 18:29:01'),(203,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 18:29:12'),(204,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 23:53:56'),(205,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-14 23:54:13'),(206,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-14 23:54:16'),(207,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-15 15:04:42');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2024-09-13 15:47:04','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2024-09-13 15:47:04','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2024-09-13 15:47:04','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2024-09-13 15:47:04','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2024-09-13 15:47:04','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2024-09-13 15:47:04','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2024-09-13 15:47:04','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2024-09-13 15:47:04','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2024-09-13 15:47:04','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2024-09-13 15:47:04','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2024-09-13 15:47:04','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2024-09-13 15:47:04','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2024-09-13 15:47:04','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2024-09-13 15:47:04','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2024-09-13 15:47:04','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2024-09-13 15:47:04','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2024-09-13 15:47:04','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2024-09-13 15:47:04','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2024-09-13 15:47:04','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2024-09-13 15:47:04','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2024-09-13 15:47:04','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2024-09-13 15:47:04','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2024-09-13 15:47:04','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2024-09-13 15:47:04','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2024-09-13 15:47:04','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2024-09-13 15:47:04','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2024-09-13 15:47:04','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2024-09-13 15:47:04','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2024-09-13 15:47:04','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2024-09-13 15:47:04','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2024-09-13 15:47:04','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2024-09-13 15:47:04','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2024-09-13 15:47:04','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2024-09-13 15:47:04','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2024-09-13 15:47:04','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2024-09-13 15:47:04','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2024-09-13 15:47:04','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2024-09-13 15:47:04','',NULL,''),(2000,'收藏夹',0,3,'/favorite',NULL,NULL,'',1,0,'M','0','0',NULL,'form','admin','2024-10-24 14:47:21','',NULL,''),(2001,'课程列表',0,1,'courses','system/courses/index',NULL,'',1,0,'C','0','0','system:courses:list','education','admin','2024-11-11 22:46:23','admin','2024-11-12 19:57:56','课程列表'),(2002,'【请填写功能名称】查询',2001,1,'#','',NULL,'',1,0,'F','0','0','system:courses:query','#','admin','2024-11-11 22:46:23','',NULL,''),(2003,'【请填写功能名称】新增',2001,2,'#','',NULL,'',1,0,'F','0','0','system:courses:add','#','admin','2024-11-11 22:46:23','',NULL,''),(2004,'【请填写功能名称】修改',2001,3,'#','',NULL,'',1,0,'F','0','0','system:courses:edit','#','admin','2024-11-11 22:46:23','',NULL,''),(2005,'【请填写功能名称】删除',2001,4,'#','',NULL,'',1,0,'F','0','0','system:courses:remove','#','admin','2024-11-11 22:46:23','',NULL,''),(2006,'【请填写功能名称】导出',2001,5,'#','',NULL,'',1,0,'F','0','0','system:courses:export','#','admin','2024-11-11 22:46:23','',NULL,''),(2008,'【请填写功能名称】查询',2007,1,'#','',NULL,'',1,0,'F','0','0','system:homework:query','#','admin','2024-11-11 22:46:23','',NULL,''),(2009,'【请填写功能名称】新增',2007,2,'#','',NULL,'',1,0,'F','0','0','system:homework:add','#','admin','2024-11-11 22:46:23','',NULL,''),(2010,'【请填写功能名称】修改',2007,3,'#','',NULL,'',1,0,'F','0','0','system:homework:edit','#','admin','2024-11-11 22:46:23','',NULL,''),(2011,'【请填写功能名称】删除',2007,4,'#','',NULL,'',1,0,'F','0','0','system:homework:remove','#','admin','2024-11-11 22:46:23','',NULL,''),(2012,'【请填写功能名称】导出',2007,5,'#','',NULL,'',1,0,'F','0','0','system:homework:export','#','admin','2024-11-11 22:46:23','',NULL,''),(2014,'【请填写功能名称】查询',2013,1,'#','',NULL,'',1,0,'F','0','0','system:material:query','#','admin','2024-11-11 22:46:23','',NULL,''),(2015,'【请填写功能名称】新增',2013,2,'#','',NULL,'',1,0,'F','0','0','system:material:add','#','admin','2024-11-11 22:46:23','',NULL,''),(2016,'【请填写功能名称】修改',2013,3,'#','',NULL,'',1,0,'F','0','0','system:material:edit','#','admin','2024-11-11 22:46:23','',NULL,''),(2017,'【请填写功能名称】删除',2013,4,'#','',NULL,'',1,0,'F','0','0','system:material:remove','#','admin','2024-11-11 22:46:23','',NULL,''),(2018,'【请填写功能名称】导出',2013,5,'#','',NULL,'',1,0,'F','0','0','system:material:export','#','admin','2024-11-11 22:46:23','',NULL,''),(2020,'【请填写功能名称】查询',2019,1,'#','',NULL,'',1,0,'F','0','0','system:submissions:query','#','admin','2024-11-11 22:46:44','',NULL,''),(2021,'【请填写功能名称】新增',2019,2,'#','',NULL,'',1,0,'F','0','0','system:submissions:add','#','admin','2024-11-11 22:46:44','',NULL,''),(2022,'【请填写功能名称】修改',2019,3,'#','',NULL,'',1,0,'F','0','0','system:submissions:edit','#','admin','2024-11-11 22:46:44','',NULL,''),(2023,'【请填写功能名称】删除',2019,4,'#','',NULL,'',1,0,'F','0','0','system:submissions:remove','#','admin','2024-11-11 22:46:44','',NULL,''),(2024,'【请填写功能名称】导出',2019,5,'#','',NULL,'',1,0,'F','0','0','system:submissions:export','#','admin','2024-11-11 22:46:44','',NULL,''),(2026,'【请填写功能名称】查询',2025,1,'#','',NULL,'',1,0,'F','0','0','system:user:query','#','admin','2024-11-11 22:46:44','',NULL,''),(2027,'【请填写功能名称】新增',2025,2,'#','',NULL,'',1,0,'F','0','0','system:user:add','#','admin','2024-11-11 22:46:44','',NULL,''),(2028,'【请填写功能名称】修改',2025,3,'#','',NULL,'',1,0,'F','0','0','system:user:edit','#','admin','2024-11-11 22:46:44','',NULL,''),(2029,'【请填写功能名称】删除',2025,4,'#','',NULL,'',1,0,'F','0','0','system:user:remove','#','admin','2024-11-11 22:46:44','',NULL,''),(2030,'【请填写功能名称】导出',2025,5,'#','',NULL,'',1,0,'F','0','0','system:user:export','#','admin','2024-11-11 22:46:44','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2024-09-13 15:47:04','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2024-09-13 15:47:04','',NULL,'管理员'),(10,'hello','2',_binary '<p>你好</p>','0','admin','2024-10-24 15:08:22','admin','2024-10-27 19:47:41',NULL);
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-09-13 15:47:04\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-09-13 15:57:50',30),(101,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2024-09-13 15:47:04\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-09-13 16:21:27',13),(102,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"收藏夹\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"/favorite\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-24 14:47:22',31),(103,'通知公告',1,'com.ruoyi.web.controller.system.SysNoticeController.add()','POST',1,'admin','研发部门','/system/notice','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"noticeContent\":\"<p>你好</p>\",\"noticeTitle\":\"hello\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-24 15:08:22',8),(104,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin','研发部门','/system/user/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2024-10-24 15:15:00',1080),(105,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"course,teacher_course,homework,publish_notice,publish_homework,teacher,student_course,student_notice,notice\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 01:02:36',198),(106,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"course,homework,notice,publish_homework,publish_notice,student_course,student_notice,teacher,teacher_course\"}',NULL,0,NULL,'2024-10-27 01:03:10',474),(107,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/1,2,3,4,5,6,7,8,9','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 14:52:11',43),(108,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"course_user,homework_submissions,course_homework,course_material,courses\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 14:52:37',155),(109,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"course_homework,course_material,course_user,courses,homework_submissions\"}',NULL,0,NULL,'2024-10-27 14:52:46',352),(110,'通知公告',2,'com.ruoyi.web.controller.system.SysNoticeController.edit()','PUT',1,'admin','研发部门','/system/notice','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-10-24 15:08:22\",\"noticeContent\":\"<p>你好</p>\",\"noticeId\":10,\"noticeTitle\":\"hello\",\"noticeType\":\"2\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 19:47:42',17),(111,'【请填写功能名称】',2,'com.ruoyi.system.controller.CoursesController.edit()','PUT',1,'admin','研发部门','/system/courses','127.0.0.1','内网IP','{\"courseId\":1,\"courseVideo\":\"fwalegfowegofwao\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 20:01:08',11),(112,'课程资料',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/course_material','127.0.0.1','内网IP','{\"courseId\":\"1\"}','{\"msg\":\"文件上传失败：\\r\\n### Error updating database.  Cause: java.sql.SQLException: Field \'title\' doesn\'t have a default value\\r\\n### The error may exist in file [E:\\\\IdeaProjects\\\\Intelligent_course_platform\\\\ruoyi-admin\\\\target\\\\classes\\\\mapper\\\\system\\\\CourseMaterialMapper.xml]\\r\\n### The error may involve com.ruoyi.system.mapper.CourseMaterialMapper.insertCourseMaterial-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into course_material          ( course_id,                          file_path )           values ( ?,                          ? )\\r\\n### Cause: java.sql.SQLException: Field \'title\' doesn\'t have a default value\\n; Field \'title\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'title\' doesn\'t have a default value\",\"code\":500}',0,NULL,'2024-10-27 21:23:21',356),(113,'课程资料',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/course_material','127.0.0.1','内网IP','{\"courseId\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 21:25:27',68),(114,'课程资料',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/course_material','127.0.0.1','内网IP','{\"courseId\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 21:27:25',32),(115,'课程资料',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/course_material','127.0.0.1','内网IP','{\"courseId\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 21:27:39',28),(116,'【请填写功能名称】',1,'com.ruoyi.system.controller.CoursesController.add()','POST',1,'admin','研发部门','/system/courses','127.0.0.1','内网IP','{\"courseId\":2,\"courseVideo\":\"fwalegfowegofwao\",\"params\":{}}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'course_name\' doesn\'t have a default value\r\n### The error may exist in file [E:\\IdeaProjects\\Intelligent_course_platform\\ruoyi-admin\\target\\classes\\mapper\\system\\CoursesMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.CoursesMapper.insertCourses-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into courses          ( course_video )           values ( ? )\r\n### Cause: java.sql.SQLException: Field \'course_name\' doesn\'t have a default value\n; Field \'course_name\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'course_name\' doesn\'t have a default value','2024-10-27 23:19:53',11),(117,'【请填写功能名称】',1,'com.ruoyi.system.controller.CoursesController.add()','POST',1,'admin','研发部门','/system/courses','127.0.0.1','内网IP','{\"courseId\":3,\"courseName\":\"helllllllo\",\"courseVideo\":\"fwalegfowegofwao\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 23:20:15',5),(118,'【请填写功能名称】',2,'com.ruoyi.system.controller.CoursesController.edit()','PUT',1,'admin','研发部门','/system/courses','127.0.0.1','内网IP','{\"courseId\":2,\"courseName\":\"helllllllo\",\"courseVideo\":\"fwalegfowegofwao\",\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-27 23:20:45',12),(119,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/10,11,12,13,14','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-11 22:32:58',38),(120,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"course_user,course_material,courses,homework_submissions,course_homework,notice,sys_config,sys_dict_data,sys_dict_type,sys_job\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-11 22:33:26',254),(121,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"course_homework,course_material,course_user,courses,homework_submissions\"}',NULL,0,NULL,'2024-11-11 22:33:55',280),(122,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"course_user\"}',NULL,0,NULL,'2024-11-11 22:58:27',82),(123,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/courses/index\",\"createTime\":\"2024-11-11 22:46:23\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"课程列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"courses\",\"perms\":\"system:courses:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-12 19:57:56',54),(124,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"\\r\\n### Error updating database.  Cause: java.sql.SQLException: Field \'file_path\' doesn\'t have a default value\\r\\n### The error may exist in file [E:\\\\IdeaProjects\\\\Intelligent_course_platform\\\\ruoyi-admin\\\\target\\\\classes\\\\mapper\\\\system\\\\HomeworkSubmissionsMapper.xml]\\r\\n### The error may involve com.ruoyi.system.mapper.HomeworkSubmissionsMapper.insertHomeworkSubmissions-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into homework_submissions          ( homework_id,             user_id,                                                                 course_id )           values ( ?,             ?,                                                                 ? )\\r\\n### Cause: java.sql.SQLException: Field \'file_path\' doesn\'t have a default value\\n; Field \'file_path\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'file_path\' doesn\'t have a default value\",\"code\":500}',0,NULL,'2024-11-13 22:39:52',121),(125,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1\\\\//20   年度收费项目备案表_20241113224309A001.txt\",\"code\":200,\"newFileName\":\"20   年度收费项目备案表_20241113224309A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1\\\\//20   年度收费项目备案表_20241113224309A001.txt\",\"originalFilename\":\"20   年度收费项目备案表.txt\"}',0,NULL,'2024-11-13 22:43:09',34),(126,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1\\\\//14-15第二学期研究生“统计方法与计算”课补考通知_20241113224554A001.txt\",\"code\":200,\"newFileName\":\"14-15第二学期研究生“统计方法与计算”课补考通知_20241113224554A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1\\\\//14-15第二学期研究生“统计方法与计算”课补考通知_20241113224554A001.txt\",\"originalFilename\":\"14-15第二学期研究生“统计方法与计算”课补考通知.txt\"}',0,NULL,'2024-11-13 22:45:54',26),(127,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1//14-15第二学期研究生“统计方法与计算”课补考通知_20241113224754A001.txt\",\"code\":200,\"newFileName\":\"14-15第二学期研究生“统计方法与计算”课补考通知_20241113224754A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/profile/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1//14-15第二学期研究生“统计方法与计算”课补考通知_20241113224754A001.txt\",\"originalFilename\":\"14-15第二学期研究生“统计方法与计算”课补考通知.txt\"}',0,NULL,'2024-11-13 22:47:54',16),(128,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1//“综合英语”外教班开始选课_20241113224916A001.txt\",\"code\":200,\"newFileName\":\"“综合英语”外教班开始选课_20241113224916A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework\\\\1\\\\homework\\\\2\\\\user\\\\1//“综合英语”外教班开始选课_20241113224916A001.txt\",\"originalFilename\":\"“综合英语”外教班开始选课.txt\"}',0,NULL,'2024-11-13 22:49:16',29),(129,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1//36.本科生学籍管理制度补充规定_636669942272995514_20241113225231A001.txt\",\"code\":200,\"newFileName\":\"36.本科生学籍管理制度补充规定_636669942272995514_20241113225231A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1//36.本科生学籍管理制度补充规定_636669942272995514_20241113225231A001.txt\",\"originalFilename\":\"36.本科生学籍管理制度补充规定_636669942272995514.txt\"}',0,NULL,'2024-11-13 22:52:31',27),(130,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241113225344A001.txt\",\"code\":200,\"newFileName\":\"“中国特色社会主义理论与实践研究”期末考试通知_20241113225344A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241113225344A001.txt\",\"originalFilename\":\"“中国特色社会主义理论与实践研究”期末考试通知.txt\"}',0,NULL,'2024-11-13 22:53:44',24),(131,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114130623A001.txt\",\"code\":200,\"newFileName\":\"37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114130623A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114130623A001.txt\",\"originalFilename\":\"37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527.txt\"}',0,NULL,'2024-11-14 13:06:23',35),(132,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"3\",\"courseId\":\"2\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/2/homework/3/user/1/36.本科生学籍管理制度补充规定_636669942272995514_20241114130645A002.txt\",\"code\":200,\"newFileName\":\"36.本科生学籍管理制度补充规定_636669942272995514_20241114130645A002.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/2/homework/3/user/1/36.本科生学籍管理制度补充规定_636669942272995514_20241114130645A002.txt\",\"originalFilename\":\"36.本科生学籍管理制度补充规定_636669942272995514.txt\"}',0,NULL,'2024-11-14 13:06:45',14),(133,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"filePath\":\"/course_homework/null/homework/null/user/null/20   年度收费项目备案表_20241114153312A001.txt\",\"params\":{}}','{\"msg\":\"\\r\\n### Error updating database.  Cause: java.sql.SQLException: Field \'homework_id\' doesn\'t have a default value\\r\\n### The error may exist in file [E:\\\\IdeaProjects\\\\Intelligent_course_platform\\\\ruoyi-admin\\\\target\\\\classes\\\\mapper\\\\system\\\\HomeworkSubmissionsMapper.xml]\\r\\n### The error may involve com.ruoyi.system.mapper.HomeworkSubmissionsMapper.insertHomeworkSubmissions-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into homework_submissions          ( file_path )           values ( ? )\\r\\n### Cause: java.sql.SQLException: Field \'homework_id\' doesn\'t have a default value\\n; Field \'homework_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'homework_id\' doesn\'t have a default value\",\"code\":500}',0,NULL,'2024-11-14 15:33:12',84),(134,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/20   年度收费项目备案表_20241114153730A002.txt\",\"code\":200,\"newFileName\":\"20   年度收费项目备案表_20241114153730A002.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/20   年度收费项目备案表_20241114153730A002.txt\",\"originalFilename\":\"20   年度收费项目备案表.txt\"}',0,NULL,'2024-11-14 15:37:30',13),(135,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"1\"}','{\"msg\":\"\\r\\n### Error updating database.  Cause: java.sql.SQLException: Field \'material_id\' doesn\'t have a default value\\r\\n### The error may exist in file [E:\\\\IdeaProjects\\\\Intelligent_course_platform\\\\ruoyi-admin\\\\target\\\\classes\\\\mapper\\\\system\\\\CourseMaterialMapper.xml]\\r\\n### The error may involve com.ruoyi.system.mapper.CourseMaterialMapper.insertCourseMaterial-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into course_material          ( course_id,                          file_path,                          material_type )           values ( ?,                          ?,                          ? )\\r\\n### Cause: java.sql.SQLException: Field \'material_id\' doesn\'t have a default value\\n; Field \'material_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'material_id\' doesn\'t have a default value\",\"code\":500}',0,NULL,'2024-11-14 15:46:15',14),(136,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"1\"}','{\"msg\":\"\\r\\n### Error updating database.  Cause: java.sql.SQLException: Field \'title\' doesn\'t have a default value\\r\\n### The error may exist in file [E:\\\\IdeaProjects\\\\Intelligent_course_platform\\\\ruoyi-admin\\\\target\\\\classes\\\\mapper\\\\system\\\\CourseMaterialMapper.xml]\\r\\n### The error may involve com.ruoyi.system.mapper.CourseMaterialMapper.insertCourseMaterial-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: insert into course_material          ( course_id,                          file_path,                          material_type )           values ( ?,                          ?,                          ? )\\r\\n### Cause: java.sql.SQLException: Field \'title\' doesn\'t have a default value\\n; Field \'title\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'title\' doesn\'t have a default value\",\"code\":500}',0,NULL,'2024-11-14 15:59:23',5),(137,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"1\"}','{\"msg\":\"操作成功\",\"fileName\":\"/courseMaterial/1/materialType/courseCalendar/37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114160043A001.txt\",\"code\":200,\"newFileName\":\"37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114160043A001.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/courseMaterial/1/materialType/courseCalendar/37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527_20241114160043A001.txt\",\"originalFilename\":\"37.本科生修读校外课程和在线开放课程管理办法（试行）_636669942273225527.txt\"}',0,NULL,'2024-11-14 16:00:43',20),(138,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"2\"}','{\"msg\":\"操作成功\",\"fileName\":\"/courseMaterial/2/materialType/courseCalendar/20   年度收费项目备案表_20241114174640A002.txt\",\"code\":200,\"newFileName\":\"20   年度收费项目备案表_20241114174640A002.txt\",\"insertResult\":1,\"url\":\"http://localhost:8080/courseMaterial/2/materialType/courseCalendar/20   年度收费项目备案表_20241114174640A002.txt\",\"originalFilename\":\"20   年度收费项目备案表.txt\"}',0,NULL,'2024-11-14 17:46:40',19),(139,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"2\"}','{\"msg\":\"操作成功\",\"fileName\":\"/courseMaterial/2/materialType/courseCalendar/“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf\",\"code\":200,\"newFileName\":\"“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/courseMaterial/2/materialType/courseCalendar/“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf\",\"originalFilename\":\"“中国特色社会主义理论与实践研究”期末考试通知.pdf\"}',0,NULL,'2024-11-14 17:47:08',38),(140,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"3\"}','{\"msg\":\"操作成功\",\"fileName\":\"/courseMaterial/3/materialType/courseCalendar/“中国特色社会主义理论与实践研究”期末考试通知_20241114180315A001.pdf\",\"code\":200,\"newFileName\":\"“中国特色社会主义理论与实践研究”期末考试通知_20241114180315A001.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/courseMaterial/3/materialType/courseCalendar/“中国特色社会主义理论与实践研究”期末考试通知_20241114180315A001.pdf\",\"originalFilename\":\"“中国特色社会主义理论与实践研究”期末考试通知.pdf\"}',0,NULL,'2024-11-14 18:03:15',26),(141,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241114181047A002.pdf\",\"code\":200,\"newFileName\":\"“中国特色社会主义理论与实践研究”期末考试通知_20241114181047A002.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/“中国特色社会主义理论与实践研究”期末考试通知_20241114181047A002.pdf\",\"originalFilename\":\"“中国特色社会主义理论与实践研究”期末考试通知.pdf\"}',0,NULL,'2024-11-14 18:10:47',22),(142,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"3\",\"courseId\":\"2\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/2/homework/3/user/1/0702物理学科评审意见_20241114181953A003.pdf\",\"code\":200,\"newFileName\":\"0702物理学科评审意见_20241114181953A003.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/2/homework/3/user/1/0702物理学科评审意见_20241114181953A003.pdf\",\"originalFilename\":\"0702物理学科评审意见.pdf\"}',0,NULL,'2024-11-14 18:19:53',40),(143,'【请填写功能名称】',1,'com.ruoyi.system.controller.CourseMaterialController.add()','POST',1,'admin','研发部门','/system/material/uploadMaterial','127.0.0.1','内网IP','{\"materialType\":\"courseCalendar\",\"courseId\":\"1\"}','{\"msg\":\"操作成功\",\"fileName\":\"/courseMaterial/1/materialType/courseCalendar/0702物理学科评审意见_20241114183257A004.pdf\",\"code\":200,\"newFileName\":\"0702物理学科评审意见_20241114183257A004.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/courseMaterial/1/materialType/courseCalendar/0702物理学科评审意见_20241114183257A004.pdf\",\"originalFilename\":\"0702物理学科评审意见.pdf\"}',0,NULL,'2024-11-14 18:32:57',33),(144,'用户头像',2,'com.ruoyi.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/avatar/0_20241114235440A001.jpg\",\"code\":200}',0,NULL,'2024-11-14 23:54:40',26),(145,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"13390140422\",\"sex\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-14 23:55:03',12),(146,'【请填写功能名称】',5,'com.ruoyi.system.controller.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241114235649A002.pdf\",\"code\":200,\"newFileName\":\"0801力学学科评审意见书_20241114235649A002.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241114235649A002.pdf\",\"originalFilename\":\"0801力学学科评审意见书.pdf\"}',0,NULL,'2024-11-14 23:56:49',26),(147,'【请填写功能名称】',5,'com.ruoyi.system.HomeworkSubmissionsController.uploadFile()','POST',1,'admin','研发部门','/system/submissions/uploadHomework','127.0.0.1','内网IP','{\"homeworkId\":\"2\",\"courseId\":\"1\",\"userId\":\"1\",\"username\":\"admin\"}','{\"msg\":\"操作成功\",\"fileName\":\"/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241115000514A001.pdf\",\"code\":200,\"newFileName\":\"0801力学学科评审意见书_20241115000514A001.pdf\",\"insertResult\":1,\"url\":\"http://localhost:8080/course_homework/1/homework/2/user/1/0801力学学科评审意见书_20241115000514A001.pdf\",\"originalFilename\":\"0801力学学科评审意见书.pdf\"}',0,NULL,'2024-11-15 00:05:14',25),(148,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"22301058@bjtu.edu.cn\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"13390140422\",\"sex\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-15 00:19:56',18),(149,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"22301058@bjtu.edu.cn\",\"nickName\":\"张思宇\",\"params\":{},\"phonenumber\":\"13390140422\",\"sex\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-15 00:20:05',10),(150,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"course_homework,course_material,course_user,courses,homework_submissions,notice\"}',NULL,0,NULL,'2024-11-15 15:05:09',781);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2024-09-13 15:47:03','',NULL,''),(2,'se','项目经理',2,'0','admin','2024-09-13 15:47:03','',NULL,''),(3,'hr','人力资源',3,'0','admin','2024-09-13 15:47:03','',NULL,''),(4,'user','普通员工',4,'0','admin','2024-09-13 15:47:03','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2024-09-13 15:47:03','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2024-09-13 15:47:03','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','张思宇','00','22301058@bjtu.edu.cn','13390140422','0','/avatar/0_20241114235440A001.jpg','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2024-11-15 15:04:43','admin','2024-09-13 15:47:03','','2024-11-15 15:04:42','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2024-09-13 15:47:03','admin','2024-09-13 15:47:03','',NULL,'测试员'),(101,NULL,'20301098','20301098','00','','','0','','$2a$10$.x91FWKCju4z90cRdbAlN.e/vPFA5czP0v.vIwqqixNZn8xcJzAwO','0','0','',NULL,'','2024-09-13 16:28:40','',NULL,NULL),(102,NULL,'20301099','20301099','00','','','0','','$2a$10$7QoMm4wS0AOH.swOm6qf..VShPbmh.Ia.tkRqK9UOyQMqAT1.zekq','0','0','',NULL,'','2024-09-13 16:28:42','',NULL,NULL),(103,NULL,'20301104','20301104','00','','','0','','$2a$10$xEBuvR7hQd/OkBit7D7hQ.7Z3w2T/a8F2wCr7HUkoX4dz8gePzXT2','0','0','',NULL,'','2024-09-13 16:28:43','',NULL,NULL),(104,NULL,'20301106','20301106','00','','','0','','$2a$10$FLn/Cl8m6g/MHlVAECH7SeV8WpweWm5Bc26WIC.WL6c4MaCVNwM8W','0','0','',NULL,'','2024-09-13 16:28:45','',NULL,NULL),(105,NULL,'21301050','21301050','00','','','0','','$2a$10$ol7UYdFghwgbw.1Eyi63zuJYbU/1kMG5ug1OzwAjYd6TCEspmGvH.','0','0','',NULL,'','2024-09-13 16:28:47','',NULL,NULL),(106,NULL,'21301134','21301134','00','','','0','','$2a$10$8K5ZCgGeMbJ9Xl7vgwtDm.1gILNG71qTQZAuQ0.oVBe0y2sXDTyD.','0','0','',NULL,'','2024-09-13 16:28:48','',NULL,NULL),(107,NULL,'21301135','21301135','00','','','0','','$2a$10$x5cuMRIv1S7znhgIYQp0cuzQ.oiZnF6guV5x3.ZJcBBq8jFbCYqeq','0','0','',NULL,'','2024-09-13 16:28:50','',NULL,NULL),(108,NULL,'21311045','21311045','00','','','0','','$2a$10$xh86zBNGOiqyTX.ldwbsnOESLfUZ1RoXVWcvaNtaO.MC6AE3Z4756','0','0','',NULL,'','2024-09-13 16:28:52','',NULL,NULL),(109,NULL,'22221208','22221208','00','','','0','','$2a$10$hnbL5jr6uDc.CxdVINd6WOGBRBbmc00X1og7/GJdABzIweZ4S4ZX2','0','0','',NULL,'','2024-09-13 16:28:53','',NULL,NULL),(110,NULL,'22301007','22301007','00','','','0','','$2a$10$WSvuERJv5VvU3vZfScGLPOxE3Qpv3KyxDueHa.dAcXja.LzqiwUdm','0','0','',NULL,'','2024-09-13 16:28:55','',NULL,NULL),(111,NULL,'22301008','22301008','00','','','0','','$2a$10$rVQiZ8G5PhKeiqUAbBq8tO0JuICRdGKWnFhRY8vsLV6.lYWzB48Fy','0','0','',NULL,'','2024-09-13 16:28:57','',NULL,NULL),(112,NULL,'22301010','22301010','00','','','0','','$2a$10$ajY.sg7J/82VzUydCnlxvuMUu0SY67v5e4pE9AOdUyZgqRrSghyxq','0','0','',NULL,'','2024-09-13 16:28:58','',NULL,NULL),(113,NULL,'22301011','22301011','00','','','0','','$2a$10$HlMjJzvVOjkyQh5N9dYaiuqUdlDmqdfRZnLVKeBhzAsE0WbS6hEXG','0','0','',NULL,'','2024-09-13 16:29:00','',NULL,NULL),(114,NULL,'22301013','22301013','00','','','0','','$2a$10$5ohSU9eckbhM78VHrlC/de/vkXULo/xYuqbPB8cUFgQ3f8xDTbM4u','0','0','',NULL,'','2024-09-13 16:29:02','',NULL,NULL),(115,NULL,'22301014','22301014','00','','','0','','$2a$10$BYK6fsO7cy2ghlvjbWBH2.C/WYMFH8c5nBCcrwAUJztOKtqUIE4/6','0','0','',NULL,'','2024-09-13 16:29:03','',NULL,NULL),(116,NULL,'22301015','22301015','00','','','0','','$2a$10$6LH54jyoptP8H11bnkmx4OdP.UJhiFLdu.CL98.M.weN5Ot0E8fdy','0','0','',NULL,'','2024-09-13 16:29:05','',NULL,NULL),(117,NULL,'22301022','22301022','00','','','0','','$2a$10$ujfrdmuZSwRhcakAa9pj/uVCZWz44FDULjpaKiF8hlsI0ch2NMdJS','0','0','',NULL,'','2024-09-13 16:29:07','',NULL,NULL),(118,NULL,'22301028','22301028','00','','','0','','$2a$10$78YVaOCTan4KjY0g9hN/I.wMF9/DDqGEXhcfR0erZr0uzPgWm3I5m','0','0','',NULL,'','2024-09-13 16:29:09','',NULL,NULL),(119,NULL,'22301029','22301029','00','','','0','','$2a$10$vpLMsD9q.81MwNo1KrVI0u7B0VwC9HhQCkLPugOgYv0naM125qT8a','0','0','',NULL,'','2024-09-13 16:29:10','',NULL,NULL),(120,NULL,'22301040','22301040','00','','','0','','$2a$10$1CSVzE.0.AGV2Qu94mNCfOXuTBhzP2TuPKu0nIG21tA/PPKNKClZe','0','0','',NULL,'','2024-09-13 16:29:12','',NULL,NULL),(121,NULL,'22301048','22301048','00','','','0','','$2a$10$anoUZs2WEbiz464Y/I23U.oi7Ev.sI1ng7AZzLUq2D5pS/BK6UWNS','0','0','',NULL,'','2024-09-13 16:29:13','',NULL,NULL),(122,NULL,'22301054','22301054','00','','','0','','$2a$10$.FCJ9hEkg/wxf0X4aI2XMejUFTEedgnnDTDapuMG19L3l7yOy3Qia','0','0','',NULL,'','2024-09-13 16:29:15','',NULL,NULL),(123,NULL,'22301055','22301055','00','','','0','','$2a$10$Nadus391Do1tRuwGwVltZuegotjO.G5CWhXlfGMJ/v3D97XJOLoxS','0','0','',NULL,'','2024-09-13 16:29:17','',NULL,NULL),(124,NULL,'22301056','22301056','00','','','0','','$2a$10$AKDOsWJb2TvvY/xYCkLt2.HK8wfJ2HXX1C2bg9h6oTlnij5uqnM.G','0','0','',NULL,'','2024-09-13 16:29:18','',NULL,NULL),(125,NULL,'22301057','22301057','00','','','0','','$2a$10$EY525PjTfClJ3foOTMa2n.hDS3aCAn4RneVxp7hUFllU9iplx02.K','0','0','',NULL,'','2024-09-13 16:29:20','',NULL,NULL),(126,NULL,'22301058','22301058','00','','','0','','$2a$10$BlWZpBaTm9b6EIvtkWpPqe1MnF5jmgZ6YlAkaFQCQXxISwo/zcxu.','0','0','127.0.0.1','2024-10-27 19:50:08','','2024-09-13 16:29:22','','2024-10-27 19:50:08',NULL),(127,NULL,'22301060','22301060','00','','','0','','$2a$10$8c17ksVu/UOHN.FEqE6bOefoEgzyhy2qNMLZkKQol/ohxgc9.K9Re','0','0','',NULL,'','2024-09-13 16:29:23','',NULL,NULL),(128,NULL,'22301061','22301061','00','','','0','','$2a$10$6nAY4kyyOOSmPlBf9QOakO5jRnIusIZT8LBQn4atMTClzi6IBkvoy','0','0','',NULL,'','2024-09-13 16:29:25','',NULL,NULL),(129,NULL,'22301064','22301064','00','','','0','','$2a$10$u9wgOmuDgOySmXAGqdf4oeUT2YYbUBbDJcWH16eehrHl57ELpMGMi','0','0','',NULL,'','2024-09-13 16:29:27','',NULL,NULL),(130,NULL,'22301065','22301065','00','','','0','','$2a$10$Fvu5XmyERNqw600jz2pWT.iXeNB0FtfQxlWXP1Zej3diiT4RpVPfq','0','0','',NULL,'','2024-09-13 16:29:28','',NULL,NULL),(131,NULL,'22301070','22301070','00','','','0','','$2a$10$pGq2MFrZaomSsW0/ag7WgOus6zymxOZ.JuSMrKI9oB.vySo7syDni','0','0','',NULL,'','2024-09-13 16:29:30','',NULL,NULL),(132,NULL,'22301082','22301082','00','','','0','','$2a$10$g2RNz5/qbVE9ryoc086i.uUwNlmbdlHuv7LW1VADXo4BEfVZiwVe2','0','0','',NULL,'','2024-09-13 16:29:32','',NULL,NULL),(133,NULL,'22301083','22301083','00','','','0','','$2a$10$sf1GNT.HSG1iQPfnEwgJnudD/D.3s7fXypsAxQEO8bd.HMFVBw5p6','0','0','',NULL,'','2024-09-13 16:29:33','',NULL,NULL),(134,NULL,'22301087','22301087','00','','','0','','$2a$10$KdkvpceaXJ/HSMj3KwQmr.NSlcnNJ6xyOMOhvRdtmJSREjHEmHDxy','0','0','',NULL,'','2024-09-13 16:29:35','',NULL,NULL),(135,NULL,'22301088','22301088','00','','','0','','$2a$10$A4HIYqYUpSZN2pNvJkxNYejkyc4BG.sGZKXNTmpuzfB4ssV8A9b/S','0','0','',NULL,'','2024-09-13 16:29:37','',NULL,NULL),(136,NULL,'22301089','22301089','00','','','0','','$2a$10$tMAjqNdosGqK7PwVozmD7ODgeDAWGu/jxp6J4NwMwBjPrS/AB1v5i','0','0','',NULL,'','2024-09-13 16:29:39','',NULL,NULL),(137,NULL,'22301090','22301090','00','','','0','','$2a$10$wl18662fUqbB.MuV8gKdw.ALzsRbGTmLrqXFQ0be3lpnKgmgkLHaK','0','0','',NULL,'','2024-09-13 16:29:40','',NULL,NULL),(138,NULL,'22301091','22301091','00','','','0','','$2a$10$XLRSwYh8DFd4vnrrvphhMO9USp4NYyf.MD408.8/CZ3qI5zRQxFpC','0','0','',NULL,'','2024-09-13 16:29:42','',NULL,NULL),(139,NULL,'22301097','22301097','00','','','0','','$2a$10$qioVRSQXhNPaLHvPq5L6DeyXHaUqRqX8aBjz2DJX1waU5vBCvhDsy','0','0','',NULL,'','2024-09-13 16:29:44','',NULL,NULL),(140,NULL,'22301101','22301101','00','','','0','','$2a$10$inf.Zaa0XQeIqHN1MuiTWu8.fDqDHt.un38TWj7g4Fd1y/fcE/7Y.','0','0','',NULL,'','2024-09-13 16:29:45','',NULL,NULL),(141,NULL,'22301102','22301102','00','','','0','','$2a$10$z6Ti/Uemu96egwgi3/x1KeTNFKOHeGrCo646WS0UcbkaJtBm/HuxG','0','0','',NULL,'','2024-09-13 16:29:47','',NULL,NULL),(142,NULL,'22301103','22301103','00','','','0','','$2a$10$ZE8j4NkObuXo2FQ2A5B7vOYMAvz6Mtjcl4QyFUOHdkYnuOclQsobe','0','0','',NULL,'','2024-09-13 16:29:48','',NULL,NULL),(143,NULL,'22301105','22301105','00','','','0','','$2a$10$tw4JdSYu80crknLFzDPs0uIg5Hh8fW3ZJBp6K6XEyDSWxwkq0up/S','0','0','',NULL,'','2024-09-13 16:29:49','',NULL,NULL),(144,NULL,'22301108','22301108','00','','','0','','$2a$10$5VjS/lympYlSf6U4luIvs.gJpAfkWn5li7T8F/wOzCoLadkqj2K4a','0','0','',NULL,'','2024-09-13 16:29:51','',NULL,NULL),(145,NULL,'22301109','22301109','00','','','0','','$2a$10$Xic9LMqQAuaeQ.vtJRIvreBEGZyjq5hCgcHYpgi3LHX1znDA7YfKW','0','0','',NULL,'','2024-09-13 16:29:52','',NULL,NULL),(146,NULL,'22301112','22301112','00','','','0','','$2a$10$/mC85L0D3wSrVLyj/AXv6u5bQtb3BfvYrfPlxy8PJr/otZkv/ZXza','0','0','',NULL,'','2024-09-13 16:29:54','',NULL,NULL),(147,NULL,'22301117','22301117','00','','','0','','$2a$10$q6WxKdpP4ZVxYVngjgnGdeKaYZlvqTJ7peP6Phop9paUIO6RiYbUK','0','0','',NULL,'','2024-09-13 16:29:55','',NULL,NULL),(148,NULL,'22301128','22301128','00','','','0','','$2a$10$.DoyGspPriWBpRi5bLOIPu6pt/FEwsdRrkjVGUPRiQPrz0bzXwD5.','0','0','',NULL,'','2024-09-13 16:29:56','',NULL,NULL),(149,NULL,'22301131','22301131','00','','','0','','$2a$10$NmZ9ZYdg6doGlalOnWWfFOaDdjsNfDkn4uRwsbKEAYWu2JqqcTOYa','0','0','',NULL,'','2024-09-13 16:29:58','',NULL,NULL),(150,NULL,'22301132','22301132','00','','','0','','$2a$10$.TD0dq/Y.zjI5CjkV5Oal.HyOVwSbxsWSlaRugKtX7cv94/Z2c1S.','0','0','',NULL,'','2024-09-13 16:29:59','',NULL,NULL),(151,NULL,'22301135','22301135','00','','','0','','$2a$10$a7qE6diT5onTbT86l8EZx.IPK4.K150TgHN2IDnyt6R90ga5181am','0','0','',NULL,'','2024-09-13 16:30:00','',NULL,NULL),(152,NULL,'22301137','22301137','00','','','0','','$2a$10$REdEMJFOCJ5QwsKJDYMxWuRCOPkdd23yLkxiEaXYKzv.Ld8Xa8jgi','0','0','',NULL,'','2024-09-13 16:30:02','',NULL,NULL),(153,NULL,'22301138','22301138','00','','','0','','$2a$10$wFnuA2bmB0rH2R.tTQJubedhFOezFo3kVbyGQ3PJEc/WURL7H9e6y','0','0','',NULL,'','2024-09-13 16:30:03','',NULL,NULL),(154,NULL,'22301139','22301139','00','','','0','','$2a$10$l/bzeW5jyZAlcpzqp/xTH.M7lUqdRbT50/Fgj2RNUzu9wZf4JAkgK','0','0','',NULL,'','2024-09-13 16:30:05','',NULL,NULL),(155,NULL,'22301144','22301144','00','','','0','','$2a$10$no5qGxbUjwHnmDcydlnEr.0QfAwdQzB8tUui.jkNN0x9sfhzVLpMG','0','0','',NULL,'','2024-09-13 16:30:06','',NULL,NULL),(156,NULL,'22301148','22301148','00','','','0','','$2a$10$zQ.1ky/qTN6c5UjcB6CL/ezXro0a8bKtJhz5wQzNdFEDPIzOYdyCK','0','0','',NULL,'','2024-09-13 16:30:08','',NULL,NULL),(157,NULL,'22301151','22301151','00','','','0','','$2a$10$7EUauVGgCqr.IMNm3cMK7u6yvFf4fbp0RSkSFXA6ZqVVJBUt19MUe','0','0','',NULL,'','2024-09-13 16:30:09','',NULL,NULL),(158,NULL,'22301152','22301152','00','','','0','','$2a$10$2or0GewPuyD18630EE1zkuoBiAVR9irep.b842cduunyR88ba8NO6','0','0','',NULL,'','2024-09-13 16:30:11','',NULL,NULL),(159,NULL,'22301163','22301163','00','','','0','','$2a$10$c/OmiG768.UDVksP/PKisuz7tWKovPkBS6mnjsyrB/ue5us.CJX5a','0','0','',NULL,'','2024-09-13 16:30:13','',NULL,NULL),(160,NULL,'22301167','22301167','00','','','0','','$2a$10$GTQrZGyShV1.6H6VQMKRhuvnO4OCOzNfJvqH6m4UcMJDI3qNzO1Hq','0','0','',NULL,'','2024-09-13 16:30:14','',NULL,NULL),(161,NULL,'22301172','22301172','00','','','0','','$2a$10$t6/2tA17tk.rNsASNN1p1.MT8viBeY4pGAjfTNrpiPrKv3aBGyfHm','0','0','',NULL,'','2024-09-13 16:30:15','',NULL,NULL),(162,NULL,'23309001','23309001','00','','','0','','$2a$10$wdghpjfRklm3YGKtnGoiDuv6/F.4wlt5ahwD47shwL3OrZtDkg.hm','0','0','',NULL,'','2024-09-13 16:30:17','',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-15 15:21:35
