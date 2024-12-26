<template>
  <div class="homework-review">
    <el-card>
      <div class="header">
        <h2>作业互评</h2>
      </div>
      <div>
        <el-table :data="submissions" style="width: 100%" stripe>
          <el-table-column prop="userId" label="被评分人 ID" width="120"></el-table-column>
          <el-table-column prop="filePath" label="作业 PDF">
            <template v-slot="scope">
              <button
                @click="viewPDF(scope.row.filePath)"
                class="el-button el-button--primary el-button--mini"
              >
                查看作业
              </button>
            </template>
          </el-table-column>
          <el-table-column label="评分">
            <template v-slot="scope">
              <el-input
                v-model="scores[scope.row.userId]"
                placeholder="请输入分数"
                size="small"
                type="number"
                :min="0"
                :max="100"
              ></el-input>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <div class="submit-button">
        <el-button type="primary" @click="submitScores">提交评分</el-button>
      </div>
    </el-card>

    <!-- PDF 预览 -->
    <div v-if="pdfVisible" class="pdf-container">
      <div class="pdf-header">
        <span>PDF 预览</span>
        <el-button icon="el-icon-close" @click="closePDF" size="mini"></el-button>
      </div>
      <div id="pdfViewer"></div>
    </div>
  </div>
</template>

<script>
import PDFObject from "pdfobject";
import { getReviewTasks, submitScoresToFlask } from "@/api/system/scores";

export default {
  name: "HomeworkReview",
  data() {
    return {
      judger: null, // 当前评分人（登录用户 ID）
      submissions: [], // 待评分的作业列表
      scores: {}, // 存储每个被评分人的分数
      pdfVisible: false, // PDF 预览开关
      pdfFilePath: "", // 当前查看的 PDF 路径
    };
  },
  methods: {
    // 获取当前用户 ID
    getCurrentUserId() {
      // 示例：从 localStorage 中获取用户 ID（根据实际项目调整）
      return localStorage.getItem("userId") || 1; // 默认用户 ID 为 1
    },
    // 加载需要评分的作业列表
    async loadSubmissions() {
      this.judger = this.getCurrentUserId(); // 设置当前用户 ID
      try {
        const response = await getReviewTasks({ judger: this.judger });
        if (response.code === 200) {
          this.submissions = response.data;
          this.submissions.forEach((submission) => {
            this.scores[submission.userId] = ""; // 初始化评分
          });
        } else {
          this.$message.error("加载作业列表失败：" + response.msg);
        }
      } catch (error) {
        console.error("加载作业列表失败:", error);
        this.$message.error("加载作业列表失败，请检查网络或后端服务！");
      }
    },
    // 显示 PDF
    viewPDF(filePath) {
      this.pdfVisible = true;
      PDFObject.embed(`/files/${filePath}`, "#pdfViewer", { height: "500px" });
    },
    // 关闭 PDF 预览
    closePDF() {
      this.pdfVisible = false;
      this.pdfFilePath = "";
    },
    // 提交评分
    async submitScores() {
      const scoreData = [];
      for (const userId in this.scores) {
        scoreData.push({
          judger: this.judger, // 当前用户 ID
          bejudger: userId, // 被评分人 ID
          homework_id: this.submissions.find((s) => s.userId === userId).homeworkId, // 作业 ID
          score: this.scores[userId], // 分数
        });
      }

      try {
        const response = await submitScoresToFlask(scoreData);
        if (response.status === 200) {
          this.$message.success("评分提交成功！");
        } else {
          this.$message.error("评分提交失败：" + response.data.error);
        }
      } catch (error) {
        console.error("评分提交失败:", error);
        this.$message.error("评分提交失败，请检查网络或后端服务！");
      }
    },
  },
  created() {
    this.loadSubmissions(); // 加载需要评分的作业
  },
};
</script>

<style scoped>
.homework-review {
  margin: 20px;
}

.pdf-container {
  position: fixed;
  top: 10%;
  left: 10%;
  width: 80%;
  height: 80%;
  background: #fff;
  box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
  z-index: 9999;
  padding: 10px;
}

.pdf-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 10px;
  border-bottom: 1px solid #ccc;
}

.loading {
  text-align: center;
  padding: 20px;
  font-size: 16px;
  color: #555;
}
</style>
