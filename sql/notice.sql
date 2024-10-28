CREATE TABLE notice (
         notice_id INT AUTO_INCREMENT PRIMARY KEY,
         notice_info TEXT NOT NULL,
         publish_time DATETIME NOT NULL,
         end_time DATETIME NOT NULL,
         delete_flag TINYINT(1) DEFAULT 0
     );
CREATE EVENT IF NOT EXISTS update_delete_flag
     ON SCHEDULE EVERY 1 MINUTE
     DO
     UPDATE notice
                   SET delete_flag = 1
                   WHERE end_time <= NOW() AND delete_flag = 0;
CREATE TABLE student_notice (
         student_id BIGINT,
         notice_id INT,
         PRIMARY KEY (student_id, notice_id),
         CONSTRAINT fk_student
             FOREIGN KEY (student_id) REFERENCES sys_user(user_id)
             ON DELETE CASCADE,
         CONSTRAINT fk_notice
             FOREIGN KEY (notice_id) REFERENCES notice(notice_id)
             ON DELETE CASCADE
     );
