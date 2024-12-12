<template>
    <el-container>
      <el-header class="header">
        <h1 class="title">讨论板</h1>
      </el-header>
      <el-main class="main">
        <el-row :gutter="20">
          <el-col :span="24">
            <div class="posts-list">
              <el-card v-for="post in posts" :key="post.postId" class="post-card">
                <router-link :to="`/courseDetail/${courseId}/discussion/${post.postId}`" class="post-link">
                  <div slot="header" class="post-header">
                    <h2 class="post-title">{{ post.title }}</h2>
                    <span class="post-time">
                      <i class="el-icon-time"></i>
                      {{ formatDate(post.postTime) }}
                    </span>
                  </div>
                  <div class="post-content">
                    <p>{{ post.title }}</p> <!-- 修改为显示标题 -->
                  </div>
                  <div class="post-footer">
                    <div class="post-author">
                      <i class="el-icon-user"></i>
                      <span> {{ post.authorName }}</span>
                    </div>
                    <div class="post-stats">
                      <span><i class="el-icon-thumb"></i> {{ post.likesCount }} 赞</span>
                      <span><i class="el-icon-star-on"></i> {{ post.favoritesCount }} 收藏</span>
                    </div>
                    <el-button type="text" class="read-more">
                      阅读更多
                      <i class="el-icon-arrow-right"></i>
                    </el-button>
                  </div>
                </router-link>
              </el-card>
            </div>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="24">
            <el-card class="new-post-card">
              <h2>发新帖</h2>
              <el-form :model="newPost" @submit.native.prevent="submitPost">
                <el-form-item label="标题">
                  <el-input v-model="newPost.title"></el-input>
                </el-form-item>
                <el-form-item label="内容">
                  <el-input type="textarea" v-model="newPost.content"></el-input>
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" native-type="submit" :loading="submitting">提交</el-button>
                </el-form-item>
              </el-form>
            </el-card>
          </el-col>
        </el-row>
      </el-main>
    </el-container>
</template>

<script>
import axios from 'axios';
import { listPosts, addPosts } from "@/api/system/posts";

export default {
  name: 'DiscussionBoard',
  data() {
    return {
      courseId: this.$route.params.courseId,
      posts: [],
      newPost: {
        title: '',
        content: ''
      },
      submitting: false // 表单提交状态
    }
  },
  created() {
    this.fetchDiscussion();
  },
  methods: {
    fetchDiscussion() {
      try {
        listPosts({pageNum: 1, pageSize: 99999}).then(
          response => {
            if (response.rows) {
              this.posts = response.rows;
            }
          }
        );
      } catch (error) {
        console.error('Failed to fetch discussion posts', error);
      }
    },
    async submitPost() {
      if (!this.newPost.title.trim() || !this.newPost.content.trim()) {
        this.$message.error('标题和内容不能为空');
        return;
      }

      this.submitting = true;
      try {
        const response = await addPosts({
          courseId: this.courseId,
          title: this.newPost.title,
          content: this.newPost.content,
          userId: this.$store.state.user.id, // 假设用户ID存储在Vuex状态管理中
          authorName: this.$store.state.user.name // 假设用户名存储在Vuex状态管理中
        });

        // 确保服务器返回了新的帖子对象
        if (response) {
          this.newPost.title = '';
          this.newPost.content = '';
          this.$message.success('帖子发送成功！');
          this.fetchDiscussion(); // 重新获取帖子列表
        } else {
          this.$message.error('帖子发布失败');
        }

      } catch (error) {
        console.error('Failed to submit post:', error);
        this.$message.error('帖子发布失败');
      } finally {
        this.submitting = false;
      }
    },
    formatDate(dateStr) {
      const date = new Date(dateStr);
      return date.toLocaleString(); // 将ISO格式的时间字符串转换为本地时间字符串
    }
  }
}
</script>

<style scoped>
.discussion-board {
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
  background-color: #f5f5f5; /* 更浅的背景色 */
  padding: 2rem;
}

.header {
  text-align: center;
  margin-bottom: 2rem;
}

.title {
  font-size: 2.5rem;
  font-weight: bold;
  color: #333;
  border-bottom: 2px solid #e6e6e6; /* 添加下划线 */
  padding-bottom: 0.5rem;
}

.main {
  background-color: #fff; /* 白色背景 */
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
}

.new-post-card {
  margin-bottom: 2rem;
}

.posts-list {
  max-height: 600px; /* 设置最大高度 */
  overflow-y: auto; /* 启用垂直滚动条 */
}

.post-card {
  width: 100%;
  margin-bottom: 1.5rem;
  border: 1px solid #ddd; /* 边框颜色 */
  border-radius: 4px;
  background-color: #fff;
  padding: 1.5rem;
  transition: all 0.3s ease-in-out;
}

.post-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 悬停时的阴影效果 */
}

.post-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #ddd; /* 分割线 */
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
}

.post-title {
  font-size: 1.3rem;
  font-weight: bold;
  color: #000;
}

.post-time {
  font-size: 0.9rem;
  color: #999;
}

.post-content {
  color: #333;
  line-height: 1.6;
}

.post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 1rem;
  border-top: 1px solid #ddd; /* 分割线 */
  padding-top: 0.5rem;
}

.post-author {
  font-size: 0.9rem;
  color: #666;
}

.read-more {
  font-size: 0.9rem;
  color: #0057e7; /* 蓝色链接颜色 */
}

.read-more:hover {
  text-decoration: underline;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .discussion-board {
    width: 100%;
    padding: 1rem;
  }

  .post-card {
    padding: 1rem;
  }

  .post-title {
    font-size: 1.2rem; /* 调整标题字体大小 */
  }

  .post-time {
    font-size: 0.8rem;
  }

  .post-author,
  .post-stats {
    font-size: 0.8rem;
  }

  .new-post-card h2 {
    font-size: 1.5rem; /* 调整新帖标题字体大小 */
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .discussion-board {
    width: 100%;
    padding: 1rem;
  }

  .post-card {
    padding: 1rem;
  }

  /* 将 .post-footer 改为垂直排列 */
  .post-footer {
    flex-direction: column;
    align-items: flex-start; /* 让子元素对齐左边 */
    gap: 10px; /* 子元素之间的间距 */
  }

  /* 调整 post-footer 中的子元素 */
  .post-author,
  .post-stats {
    font-size: 0.8rem;
    color: #666;
  }

  /* 调整按钮和链接的位置 */
  .read-more {
    align-self: flex-start; /* 确保 "阅读更多" 按钮在左侧 */
  }
}
</style>
