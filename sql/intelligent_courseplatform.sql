-- 创建表：courses
CREATE TABLE `courses` (
                           `course_id` int NOT NULL AUTO_INCREMENT,
                           `course_source` varchar(255) DEFAULT NULL,
                           `course_video` varchar(255) DEFAULT NULL,
                           `course_name` varchar(255) NOT NULL,
                           `course_description` text,
                           PRIMARY KEY (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建表：course_homework
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建表：course_material
CREATE TABLE `course_material` (
                                   `material_id` bigint NOT NULL AUTO_INCREMENT,
                                   `course_id` int NOT NULL,
                                   `title` varchar(255) NOT NULL,
                                   `file_path` varchar(500) NOT NULL,
                                   `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                   PRIMARY KEY (`material_id`),
                                   KEY `course_id` (`course_id`),
                                   CONSTRAINT `course_material_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建表：course_user
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

-- 创建表：homework_submissions
CREATE TABLE `homework_submissions` (
                                        `submission_id` bigint NOT NULL AUTO_INCREMENT,
                                        `homework_id` bigint NOT NULL,
                                        `user_id` bigint NOT NULL,
                                        `file_path` varchar(500) NOT NULL,
                                        `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                        `grade` decimal(5,2) DEFAULT NULL,
                                        `feedback` text,
                                        PRIMARY KEY (`submission_id`),
                                        KEY `homework_id` (`homework_id`),
                                        KEY `user_id` (`user_id`),
                                        CONSTRAINT `homework_submissions_ibfk_1` FOREIGN KEY (`homework_id`) REFERENCES `course_homework` (`homework_id`),
                                        CONSTRAINT `homework_submissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建表：notice
CREATE TABLE `notice` (
                          `notice_id` int NOT NULL AUTO_INCREMENT,
                          `notice_info` text NOT NULL,
                          `publish_time` datetime NOT NULL,
                          `end_time` datetime NOT NULL,
                          `delete_flag` tinyint(1) DEFAULT '0',
                          PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
