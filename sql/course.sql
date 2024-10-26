CREATE TABLE course (
                        course_id INT AUTO_INCREMENT,
                        course_source VARCHAR(255),
                        course_video VARCHAR(255),
                        PRIMARY KEY (course_id)
);
CREATE TABLE student_course (
                                course_id INT,
                                student_id BIGINT,
                                PRIMARY KEY (course_id, student_id),  -- 联合主键
                                CONSTRAINT fk_student_course_course
                                    FOREIGN KEY (course_id) REFERENCES course(course_id)
                                        ON DELETE CASCADE,
                                CONSTRAINT fk_student_course_student
                                    FOREIGN KEY (student_id) REFERENCES sys_user(user_id)
                                        ON DELETE CASCADE,
                                INDEX idx_course (course_id),         -- 为 course_id 创建索引
                                INDEX idx_student (student_id)        -- 为 student_id 创建索引
);
CREATE TABLE teacher_course (
                                teacher_id BIGINT,                            -- 教师ID字段
                                course_id INT,                               -- 课程ID字段
                                PRIMARY KEY (teacher_id, course_id),        -- 联合主键，确保教师和课程的组合唯一
                                CONSTRAINT fk_teacher_course                -- 外键约束名称
                                    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
                                        ON DELETE CASCADE,                      -- 当 teacher 表中的记录被删除时，相应的 teacher_course 记录也会被删除
                                CONSTRAINT fk_course_teacher               -- 外键约束名称
                                    FOREIGN KEY (course_id) REFERENCES course(course_id)
                                        ON DELETE CASCADE,                      -- 当 course 表中的记录被删除时，相应的 teacher_course 记录也会被删除
                                INDEX idx_teacher (teacher_id),              -- 为 teacher_id 创建索引
                                INDEX idx_course (course_id)                 -- 为 course_id 创建索引
);
