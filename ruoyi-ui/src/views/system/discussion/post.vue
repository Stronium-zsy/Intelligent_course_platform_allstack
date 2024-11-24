<template>
  <div class="post-detail">
    <el-button class="back-button" icon="el-icon-arrow-left" @click="goBack">返回</el-button>
    <!-- 主帖子内容 -->
    <el-card class="post-card">
      <div class="post-header">
        <div class="author-info">
          <el-avatar :size="40" src="/placeholder.svg?height=40&width=40"></el-avatar>
          <div class="author-meta">
            <span class="author-name">{{ post.author }}</span>
            <span class="post-time">{{ post.timeAgo }}</span>
          </div>
        </div>
      </div>

      <h1 class="post-title">{{ post.title }}</h1>
      <div class="post-content">{{ post.content }}</div>

      <div class="post-stats">
        <div class="stat-item">
          <el-button type="text" @click="handleLike">
            <i class="el-icon-thumb"></i>
            <span>{{ post.likes }}</span>
          </el-button>
        </div>
        <div class="stat-item">
          <el-button type="text" @click="handleBookmark">
            <i class="el-icon-star-off"></i>
            <span>{{ post.bookmarks }}</span>
          </el-button>
        </div>
      </div>
    </el-card>

    <!-- 评论列表 -->
    <div class="comments-section">
      <el-card v-for="comment in comments" :key="comment.id" class="comment-card">
        <div class="comment-header">
          <div class="author-info">
            <el-avatar :size="32" src="/placeholder.svg?height=32&width=32"></el-avatar>
            <div class="author-meta">
              <span class="author-name">{{ comment.author }}</span>
              <div class="comment-meta">
                <span class="comment-time">{{ comment.timeAgo }}</span>
                <span class="comment-number">#{{ comment.number }}</span>
              </div>
              <div class="comment-meta"></div>
            </div>
          </div>
        </div>

        <div class="comment-content">{{ comment.content }}</div>

        <div class="comment-actions">
          <el-button type="text" @click="likeComment(comment.id)">
            <i class="el-icon-thumb"></i>
            <span>{{ comment.likes }}</span>
          </el-button>
        </div>
      </el-card>
    </div>

    <!-- 回复表单 -->
    <el-card class="reply-form">
      <h3>评论</h3>
      <el-form :model="replyForm" @submit.native.prevent="submitReply">
        <el-form-item>
          <el-input
              type="textarea"
              :rows="4"
              v-model="replyForm.content"
              placeholder="留下你的评论..."
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" native-type="submit" :loading="submitting">
            发送
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'PostDetail',
  data() {
    return {
      post: {
        postId: '1',
        title: 'Vue 3 Composition API: 一个改变游戏规则的特性',
        author: 'Jane Doe',
        timeAgo: '2 天前',
        content: 'Vue 3 的 Composition API 带来了组织组件逻辑的新方式。它允许更好的代码重用和组合。这个 API 提供了一组基于函数的 API，允许灵活地组合组件逻辑。在这篇文章中，我们将探讨如何使用 Composition API 来创建更易于维护和可扩展的 Vue 应用程序。',
        likes: 42,
        bookmarks: 15,
        replies: 3
      },
      comments: [
        {
          commentId: 1,
          author: 'John Smith',
          number: 1,
          timeAgo: '1 天前',
          content: '好文章！我最近的项目中一直在使用 Composition API，它确实改善了我的代码组织。你有什么建议可以将较大的 Vue 2 项目迁移到 Vue 3 和 Composition API 吗？',
          likes: 8
        },
        {
          commentId: 2,
          author: 'Alice Johnson',
          number: 2,
          timeAgo: '20 小时前',
          content: '我还在适应 Composition API。它很强大，但对于简单的组件，我发现它比 Options API 更冗长。你有什么想法在什么时候使用其中一个吗？',
          likes: 5
        },
        {
          commentId: 3,
          author: 'Bob Wilson',
          number: 3,
          timeAgo: '10 小时前',
          content: '感谢这篇信息丰富的文章！我很好奇 Composition API 如何处理代码拆分和懒加载。你已经探索过这个方面了吗？',
          likes: 3
        }
      ],
      replyForm: {
        content: ''
      },
      submitting: false
    }
  },
  created() {
    this.fetchPost();
  },
  methods: {
    async fetchPost() {
      try {
        const postId = this.$route.params.postId;
        const response = await axios.get(`/dev-api/system/discussion/${postId}`);
        // this.post = response.data['post'];
        // this.comments = response.data['comments'];
      } catch (error) {
        console.error('Failed to fetch course:', error);
      }
    },

    handleLike() {
      this.post.likes++
    },
    handleBookmark() {
      this.post.bookmarks++
    },
    likeComment(commentId) {
      const comment = this.comments.find(c => c.id === commentId)
      if (comment) {
        comment.likes++
      }
    },
    showReplyForm(commentId) {
      // 实现回复特定评论的逻辑
      this.replyForm.replyTo = commentId
    },
    async submitReply() {
      if (!this.replyForm.content.trim()) {
        return
      }

      this.submitting = true
      try {
        // 模拟API调用
        await new Promise(resolve => setTimeout(resolve, 1000))

        this.comments.push({
          id: this.comments.length + 1,
          author: '当前用户',
          number: this.comments.length + 1,
          timeAgo: '刚刚',
          content: this.replyForm.content,
          likes: 0
        })

        this.replyForm.content = ''
        this.$message.success('回复提交成功！')
      } catch (error) {
        this.$message.error('回复提交失败')
      } finally {
        this.submitting = false
      }
    },
    goBack() {
      this.$router.go(-1)
    }
  }
}
</script>

<style scoped>
.post-detail {
  width: 80%;
  margin: 0 auto;
  padding: 20px;
}

.post-card {
  margin-bottom: 24px;
}

.post-header {
  margin-bottom: 20px;
}

.author-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.author-meta {
  display: flex;
  flex-direction: column;
}

.author-name {
  font-weight: 600;
  font-size: 16px;
}

.post-time {
  color: #8492a6;
  font-size: 14px;
}

.post-title {
  font-size: 28px;
  font-weight: bold;
  margin: 16px 0;
}

.post-content {
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 24px;
}

.post-stats {
  display: flex;
  gap: 24px;
  padding-top: 16px;
  border-top: 1px solid #ebeef5;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 4px;
  color: #606266;
}

.comments-section {
  margin-bottom: 24px;
}

.comment-card {
  margin-bottom: 16px;
}

.comment-header {
  margin-bottom: 12px;
}

.comment-meta {
  display: flex;
  gap: 8px;
  color: #8492a6;
  font-size: 14px;
}

.comment-content {
  font-size: 15px;
  line-height: 1.5;
  margin-bottom: 12px;
}

.comment-actions {
  display: flex;
  gap: 16px;
}

.reply-form {
  margin-top: 24px;
}

.reply-form h3 {
  margin-bottom: 16px;
  font-size: 18px;
  font-weight: 600;
}

.back-button {
  margin-bottom: 20px;
}
</style>
