<template>
  <div class="post-detail">
    <el-button class="back-button" icon="el-icon-arrow-left" @click="goBack">返回</el-button>

    <!-- 主帖子内容 -->
    <el-card v-if="post" class="post-card">
      <div class="post-header">
        <div class="author-info">
          <el-avatar :size="40" :src="post.authorAvatar || '/placeholder.svg?height=40&width=40'"></el-avatar>
          <div class="author-meta">
            <span class="author-name">{{ post.authorName }}</span>
            <span class="post-time">{{ formatDate(post.postTime) }}</span>
          </div>
        </div>
      </div>

      <h1 class="post-title">{{ post.title }}</h1>
      <div class="post-content">{{ post.content }}</div>

      <div class="post-stats">
        <div class="stat-item">
          <el-button type="text" @click="handleLike('post', post.postId)">
            <i class="el-icon-thumb"></i>
            <span>{{ post.likesCount }} 赞</span>
          </el-button>
        </div>
        <div class="stat-item">
          <el-button type="text" @click="handleBookmark(post.postId)">
            <i class="el-icon-star-off"></i>
            <span>{{ post.favoritesCount }} 收藏</span>
          </el-button>
        </div>
      </div>
    </el-card>

    <!-- 评论列表 -->
    <div v-if="comments.length > 0" class="comments-section">
      <h2>评论区</h2>
      <el-card v-for="comment in comments" :key="comment.commentId" class="comment-card">
        <div class="comment-header">
          <div class="author-info">
            <el-avatar :size="32" :src="comment.authorAvatar || '/placeholder.svg?height=32&width=32'"></el-avatar>
            <div class="author-meta">
              <span class="author-name">{{ comment.authorName }}</span>
              <div class="comment-meta">
                <span class="comment-time">{{ formatDate(comment.commentTime) }}</span>
                <span class="comment-number">#{{ comment.commentIndex }}</span>
              </div>
            </div>
          </div>
          <div class="comment-actions">
            <el-button type="text" @click="likeComment('comment', comment.commentId)">
              <i class="el-icon-thumb"></i>
              <span>{{ comment.likesCount }} 赞</span>
            </el-button>
            <el-button type="text" @click="showReplyForm(comment.commentId)">回复</el-button>
          </div>
        </div>
        <div class="comment-content">{{ comment.content }}</div>
        <div v-if="replyingTo === comment.commentId" class="reply-form-inline">
          <el-input
            type="textarea"
            :rows="2"
            v-model="replyForm.content"
            placeholder="留下你的回复..."
          ></el-input>
          <el-button type="primary" @click="submitReply(comment.commentId)">发送</el-button>
        </div>
      </el-card>
    </div>
    <p v-else>暂无评论</p>

    <!-- 回复表单 -->
    <el-card class="reply-form">
      <h3>发表评论</h3>
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
import axios from 'axios';
import { getPosts } from '@/api/system/posts';
import { listComments } from '@/api/system/comments';
import { addComments } from '@/api/system/comments';
import moment from 'moment';


export default {
  name: 'PostDetail',
  data() {
    return {
      postId: this.$route.params.postId, // 获取路由参数中的帖子ID
      post: null, // 存储帖子详情
      comments: [], // 存储评论列表
      replyForm: {
        content: '',
        replyTo: null
      },
      replyingTo: null, // 当前正在回复的评论ID
      submitting: false // 表单提交状态
    };
  },
  created() {
    this.fetchPost();
    this.fetchComments();
  },
  methods: {
    fetchPost() {
      try {
        getPosts(this.postId).then(
          response => {
            // console.log(response);
            if (response.data) {
              this.post = response.data;
              // console.log(this.post);
            }
          }
        );
      } catch (error) {
        console.error('Failed to fetch post:', error);
        this.$message.error('加载帖子失败');
      }
    },

    fetchComments() {
  try {
    listComments({ postId: this.postId }).then(
      response => {
        console.log(response);
        if (response.rows) {
          this.comments = response.rows;
          console.log(this.comments);
        }
      }
    );
  } catch (error) {
    console.error('Failed to fetch comments', error);
  }
},
    handleLike(type, id) {
      this.updateLikeCount(type, id, 'like');
    },
    handleBookmark(id) {
      this.updateLikeCount('post', id, 'bookmark');
    },
    likeComment(type, id) {
      this.updateLikeCount(type, id, 'like');
    },
    showReplyForm(commentId) {
      this.replyingTo = commentId;
      this.replyForm.replyTo = commentId;
      this.replyForm.content = ''; // 清空回复框内容
    },

    async submitReply(replyTo = null) {
  if (!this.replyForm.content.trim()) {
    return;
  }

  this.submitting = true;
  try {
    const response = await addComments({
      postId: this.postId,
      replyTo,
      content: this.replyForm.content,
      userId: this.$store.state.user.id, // 假设用户ID存储在Vuex状态管理中
      commentIndex: this.comments.length + 1 // 设置评论索引
    });

    // 假设服务器返回了新的评论对象
    const newComment = response.data;
    newComment.commentIndex = this.comments.length + 1;

    this.comments.push(newComment);
    this.replyForm.content = '';
    this.replyingTo = null;
    this.$message.success('回复提交成功！');
  } catch (error) {
    console.error('Failed to submit reply:', error);
    this.$message.error('回复提交失败');
  } finally {
    this.submitting = false;
  }
},

    updateLikeCount(type, id, action) {
      let target;
      if (type === 'post') {
        target = this.post;
      } else if (type === 'comment') {
        target = this.comments.find(c => c.commentId === id);
      }

      if (target) {
        if (action === 'like') {
          target.likesCount++;
        } else if (action === 'bookmark') {
          target.favoritesCount++;
        }
        // 这里应该有实际的API调用来更新服务器上的点赞或收藏状态
        // 例如：axios.post('/api/like', { id, action, type });
      }
    },
    goBack() {
      this.$router.go(-1);
    },
    formatDate(date) {
      return moment(date).fromNow();
    }
  }
};
</script>

<style scoped>
.post-detail {
  width: 80%;
  margin: 0 auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.post-card {
  margin-bottom: 24px;
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
}

.post-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  border-bottom: 1px solid #ddd;
  padding-bottom: 10px;
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
  color: #333;
}

.post-content {
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 24px;
  color: #666;
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
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
}

.comment-card {
  margin-bottom: 16px;
  border-bottom: 1px solid #ddd;
  padding-bottom: 16px;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
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
  color: #666;
}

.comment-actions {
  display: flex;
  gap: 16px;
}

.reply-form {
  margin-top: 24px;
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  padding: 1.5rem;
}

.reply-form h3 {
  margin-bottom: 16px;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.back-button {
  margin-bottom: 20px;
  background-color: transparent;
  border: none;
  color: #0057e7;
  font-size: 16px;
}

.reply-form-inline {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-top: 12px;
}
</style>
