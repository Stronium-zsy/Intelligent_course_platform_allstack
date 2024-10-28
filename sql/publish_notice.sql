CREATE TABLE publish_notice (
                                notice_id INT,
                                teacher_id BIGINT,
                                PRIMARY KEY (notice_id, teacher_id),                -- 联合主键
                                CONSTRAINT fk_notice_id                             -- 修改外键约束名称
                                    FOREIGN KEY (notice_id) REFERENCES notice(notice_id)
                                        ON DELETE CASCADE,                             -- 当 notice 表中相关记录被删除时，相关的 notice_teacher 记录也会被删除
                                CONSTRAINT fk_teacher_id                            -- 修改外键约束名称
                                    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
                                        ON DELETE CASCADE,                             -- 当 teacher 表中相关记录被删除时，相关的 notice_teacher 记录也会被删除
                                INDEX idx_notice (notice_id),                       -- 为 notice_id 创建索引
                                INDEX idx_teacher (teacher_id)                      -- 为 teacher_id 创建索引
);
