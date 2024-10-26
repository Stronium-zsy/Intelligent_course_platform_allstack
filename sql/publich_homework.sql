CREATE TABLE publish_homework (
                                  course_id INT,
                                  teacher_id INT,
                                  homework_id INT,
                                  PRIMARY KEY (homework_id),  -- Assuming each homework has a unique ID
                                  INDEX idx_course_teacher (course_id, teacher_id)
);
CREATE TABLE homework (
                          homework_id INT,
                          homework_path VARCHAR(255),
                          start_time DATETIME DEFAULT NULL,     -- 添加开始时间字段
                          end_time DATETIME DEFAULT NULL,       -- 添加截止时间字段
                          PRIMARY KEY (homework_id),            -- 作业ID作为主键，确保唯一性
                          CONSTRAINT fk_homework_publish        -- 外键约束名称
                              FOREIGN KEY (homework_id) REFERENCES publish_homework(homework_id)
                                  ON DELETE CASCADE                 -- 当 publish_homework 表中相关记录被删除时，相关的 homework 记录也会被删除
);

