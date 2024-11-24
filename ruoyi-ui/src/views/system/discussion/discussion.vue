<template>
  <div class="discussion-board">
    <el-container>
      <el-header class="header">
        <h1 class="title">讨论板</h1>
      </el-header>
      <el-main class="main">
        <el-row :gutter="20">
          <el-col :span="24" v-for="post in posts" :key="post.postId">
            <router-link :to="`/discussion/${post.postId}`" class="post-link">
              <el-card class="post-card">
                <div slot="header" class="post-header">
                  <h2 class="post-title">{{ post.title }}</h2>
                  <span class="post-time">
                    <i class="el-icon-time"></i>
                    {{ post.time }}
                  </span>
                </div>
                <div class="post-content">
                  <p>{{ post.content }}</p>
                </div>
                <div class="post-footer">
                  <div class="post-author">
                    <i class="el-icon-user"></i>
                    <span> {{ post.author }}</span>
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

export default {
  name: 'DiscussionBoard',
  data() {
    return {
      posts: [
        {
          postId: 1,
          title: "Vue 3 Composition API: 一个改变游戏规则的特性",
          content: "Vue 3 的 Composition API 带来了组织组件逻辑的新方式。它允许更好的代码重用和组合...",
          time: "2 小时前",
          author: "Jane Doe"
        },
        {
          postId: 2,
          title: "Tailwind CSS: 快速 UI 开发",
          content: "Tailwind CSS 是一个实用优先的 CSS 框架，允许快速 UI 开发。它提供了低级实用类...",
          time: "5 小时前",
          author: "John Smith"
        },
        {
          postId: 3,
          title: "Web 开发的未来",
          content: "随着 Web 技术的发展，我们正在看到向更互动和性能更好的应用程序的转变...",
          time: "1 天前",
          author: "Alice Johnson"
        },
        {
          postId: 4,
          title: "优化 Vue.js 性能",
          content: "性能对于良好的用户体验至关重要。在这篇文章中，我们将探讨优化 Vue.js 应用程序的各种技术...",
          time: "2 天前",
          author: "Bob Wilson"
        }
      ]
    }
  },
  created() {
    this.fetchDiscussion();
  },
  methods: {
    async fetchDiscussion() {
      try {
        const response = await axios.get(`/dev-api/system/discussion`);
        // this.posts = response['posts'];
      } catch(error) {
        console.error('Failed to fetch course', error);
      }
    }
  }
}
</script>

<style scoped>
.discussion-board {
  width: 100%;
  background-color: #f0f2f5;
  padding: 1rem;
}

.header {
  text-align: center;
  margin-bottom: 1rem;
}

.title {
  font-size: 2rem;
  font-weight: bold;
  color: #333;
}

.main {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.post-card {
  width: 80%;
  margin: 0 auto 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.post-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.post-title {
  font-size: 1.5rem;
  font-weight: bold;
  color: #333;
}

.post-time {
  font-size: 0.9rem;
  color: #999;
}

.post-content {
  margin-bottom: 1rem;
  color: #666;
}

.post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.post-author {
  font-size: 0.9rem;
  color: #666;
}

.read-more {
  font-size: 0.9rem;
  color: #409EFF;
}
</style>
