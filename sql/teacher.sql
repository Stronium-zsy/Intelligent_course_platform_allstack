CREATE TABLE teacher (
                         teacher_id BIGINT AUTO_INCREMENT PRIMARY KEY,                -- 主键，自增
                         teacher_name VARCHAR(100) NOT NULL,                          -- 教师姓名
                         teacher_nick_name VARCHAR(100),                              -- 教师昵称
                         email VARCHAR(255) UNIQUE,                                   -- 电子邮件，唯一
                         phonenumber VARCHAR(20),                                     -- 电话号码
                         sex TINYINT(1) NOT NULL DEFAULT 0,                           -- 性别，1表示男性，0表示女性
                         password VARCHAR(255) NOT NULL,                              -- 密码（建议存储哈希值）
                         del_flag TINYINT(1) NOT NULL DEFAULT 0,                      -- 删除标志，0表示未删除，1表示已删除
                         login_ip VARCHAR(45),                                        -- 登录IP地址（支持IPv6）
                         login_date DATETIME,                                         -- 最后登录日期
                         create_by BIGINT,                                            -- 创建者ID，外键可选
                         create_time DATETIME DEFAULT CURRENT_TIMESTAMP,              -- 创建时间，默认当前时间
                         update_by BIGINT,                                            -- 更新者ID，外键可选
                         update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 更新时间，自动更新时间
                         remark TEXT,                                                 -- 备注
                         INDEX idx_teacher_email (email),                             -- 为email创建索引
                         INDEX idx_teacher_phonenumber (phonenumber)                 -- 为phonenumber创建索引
    -- 如果有需要，可以添加外键约束，例如：
    -- CONSTRAINT fk_create_by FOREIGN KEY (create_by) REFERENCES sys_user(user_id) ON DELETE SET NULL,
    -- CONSTRAINT fk_update_by FOREIGN KEY (update_by) REFERENCES sys_user(user_id) ON DELETE SET NULL
);
