<template>
<div class="discussion-board">
<el-container>
  <el-header class="header">
    <h1 class="title">讨论板</h1>
  </el-header>
  <el-main class="main">
    <el-row :gutter="20">
      <el-col :span="24" v-for="post in posts" :key="post.postId">
        <router-link :to="`/courseDetail/${courseId}/discussion/${post.postId}`" class="post-link">
          <el-card class="post-card">
            <div slot="header" class="post-header">
              <h2 class="post-title">{{ post.title }}</h2>
              <span class="post-time">
                    <i class="el-icon-time"></i>
                    {{ formatDate(post.postTime) }}
                  </span>
            </div>
            <div class="post-content">
              <p>{{ post.content }}</p>
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
          </el-card>
        </router-link>
      </el-col>
    </el-row>
  </el-main>
</el-container>
</div>
</template>

<script>
import axios from 'axios';
import {listPosts} from "@/api/system/posts";

export default {
  name: 'DiscussionBoard',
  data() {
    return {
      courseId: this.$route.params.courseId,
      posts: []
    }
  },
  created() {
    this.fetchDiscussion();
  },

  methods: {
    fetchDiscussion() {
      try {
        listPosts().then(
          response => {
            console.log(response)
            if (response.rows) {
              this.posts = response.rows;

              console.log(this.posts)
            }
          }
        ) // 使用await等待异步操作完成
      } catch(error) {
        console.error('Failed to fetch discussion posts', error);
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
@media (max-width: 768px) {
  .discussion-board {
    width: 100%;
    padding: 1rem;
  }

  .post-card {
    padding: 1rem;
  }
}
</style>
