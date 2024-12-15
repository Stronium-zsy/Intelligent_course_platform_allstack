-- 创建 posts 表
CREATE TABLE posts (
                       post_id INT AUTO_INCREMENT PRIMARY KEY,
                       course_id INT NOT NULL,
                       user_id BIGINT NOT NULL,
                       title VARCHAR(255) NOT NULL,
                       author_name VARCHAR(255) NOT NULL,
                       content TEXT NOT NULL,
                       post_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       likes_count INT DEFAULT 0,
                       favorites_count INT DEFAULT 0,
                       FOREIGN KEY (course_id) REFERENCES courses(course_id),
                       FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
);

-- 创建 comments 表
CREATE TABLE comments (
                          comment_id INT AUTO_INCREMENT PRIMARY KEY,
                          post_id INT NOT NULL,
                          user_id BIGINT NOT NULL,
                          comment_index INT NOT NULL,
                          author_name VARCHAR(255) NOT NULL,
                          content TEXT NOT NULL,
                          comment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          likes_count INT DEFAULT 0,
                          favorites_count INT DEFAULT 0,
                          FOREIGN KEY (post_id) REFERENCES posts(post_id),
                          FOREIGN KEY (user_id) REFERENCES sys_user(user_id)
);


CREATE TABLE user_favorites (
                                favorite_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '收藏记录ID',
                                user_id BIGINT NOT NULL COMMENT '用户ID',
                                post_id BIGINT NOT NULL COMMENT '帖子ID',
                                favorite_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
                                UNIQUE KEY unique_user_post (user_id, post_id) COMMENT '用户对帖子的唯一收藏约束'
) COMMENT='用户收藏表';
