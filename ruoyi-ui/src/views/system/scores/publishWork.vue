<template>
  <div>
    <el-form ref="form" label-width="120px">
      <el-form-item label="作业 ID">
        <el-input v-model="homeworkId" placeholder="请输入作业 ID"></el-input>
      </el-form-item>
      <el-form-item label="互评人数">
        <el-input-number v-model="judgeNum" :min="1" :max="10" placeholder="默认值为2"></el-input-number>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitArrangement">提交互评安排</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { arrangeHomework } from "@/api/system/arrange"; // 调用 Flask 接口方法

export default {
  data() {
    return {
      homeworkId: "", // 用户输入的作业 ID
      judgeNum: 2 // 默认互评人数为2
    };
  },
  methods: {
    async submitArrangement() {
      try {
        const response = await arrangeHomework(this.homeworkId, this.judgeNum);
        this.$message.success(response.message || "互评安排成功！");
      } catch (error) {
        this.$message.error("提交失败，请检查输入！");
        console.error(error);
      }
    }
  }
};
</script>
