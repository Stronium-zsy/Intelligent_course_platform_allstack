<template>
  <div class="discussion-board">
    <el-container>
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
  </div>
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
  width: 75%;
  max-width: 1200px;
  margin: 0 auto;
  background-color: #f6fbff;
}


.title {
  font-size: 2.5rem;
  font-weight: bold;
}

.main {
  padding: 2rem;
}

.new-post-card {
  margin-bottom: 2rem;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}

.new-post-card h2 {
  margin-bottom: 1rem;
  color: #409EFF;
}

.posts-list {
  max-height: 800px;
  overflow-y: auto;
}

.post-card {
  width: 100%;
  margin-bottom: 1.5rem;
  border-radius: 8px;
  transition: all 0.3s ease-in-out;
}

.post-card:hover {
  transform: translateY(-5px);
}

.post-link {
  text-decoration: none;
  color: inherit;
}

.post-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #ebeef5;
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
}

.post-title {
  font-size: 1.3rem;
  font-weight: bold;
  color: #303133;
  margin: 0;
}

.post-time {
  font-size: 0.9rem;
  color: #909399;
}

.post-content {
  color: #606266;
  line-height: 1.6;
  margin-bottom: 1rem;
}

.post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #ebeef5;
  padding-top: 0.5rem;
}

.post-author {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  color: #606266;
}

.post-stats {
  display: flex;
  align-items: center;
}

.stat-button {
  padding: 0;
  margin-right: 1rem;
}

.read-more {
  color: #409EFF;
}

.read-more:hover {
  text-decoration: underline;
}

@media (max-width: 768px) {
  .discussion-board {
    width: 100%;
  }

  .main {
    padding: 1rem;
  }

  .post-footer {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }

  .post-stats {
    width: 100%;
    justify-content: space-between;
  }
}
</style>
