<template>
  <div class="sidebar-container">
    <el-menu
      :default-active="$route.path"
      class="el-menu-vertical-demo"
      background-color="#304156"
      text-color="#fff"
      active-text-color="#ffd04b"
    >
      <!-- 首页菜单项 -->
      <el-menu-item :index="'/courses'" @click="navigateTo('/courses')">
        <i class="el-icon-house"></i>
        <span>返回首页</span>
      </el-menu-item>

      <!-- 课程信息子菜单 -->
      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-s-grid"></i>
          <span>课程信息</span>
        </template>
        <el-menu-item :index="`/courseDetail/${courseId}/courseSyllabus`" @click="navigateTo(`/courseDetail/${courseId}/courseSyllabus`)">
          <i class="el-icon-document"></i>
          <span>教学大纲</span>
        </el-menu-item>
        <el-menu-item :index="`/courseDetail/${courseId}/courseCalendar`" @click="navigateTo(`/courseDetail/${courseId}/courseCalendar`)">
          <i class="el-icon-date"></i>
          <span>教学日历</span>
        </el-menu-item>
        <el-menu-item :index="`/courseDetail/${courseId}/courseNotifications`" @click="navigateTo(`/courseDetail/${courseId}/courseNotifications`)">
          <i class="el-icon-bell"></i>
          <span>课程通知</span>
        </el-menu-item>
      </el-submenu>

      <!-- 课程资源子菜单 -->
      <el-submenu index="5">
        <template slot="title">
          <i class="el-icon-folder"></i>
          <span>课程资源</span>
        </template>
        <el-menu-item :index="`/courseDetail/${courseId}/courseFiles`" @click="navigateTo(`/courseDetail/${courseId}/courseFiles`)">
          <i class="el-icon-folder-opened"></i>
          <span>文件资料</span>
        </el-menu-item>
        <el-menu-item :index="`/courseDetail/${courseId}/courseVideos`" @click="navigateTo(`/courseDetail/${courseId}/courseVideos`)">
          <i class="el-icon-video-camera"></i>
          <span>视频资料</span>
        </el-menu-item>
      </el-submenu>

      <!-- 课程作业菜单项 -->
      <el-menu-item :index="`/courseDetail/${courseId}/courseHomework`" @click="navigateTo(`/courseDetail/${courseId}/courseHomework`)">
        <i class="el-icon-edit-outline"></i>
        <span>课程作业</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import { listHomework } from "@/api/system/homework";

export default {
  name: "Sidebar",
  data() {
    return {
      courseId: this.$route.params.courseId,
      homeworkList: []
    };
  },
  created() {
    this.fetchHomework();
  },
  methods: {
    // 跳转路由的方法
    navigateTo(routePath) {
      this.$router.push(routePath);
    },
    fetchHomework() {
      // 如果需要，解开并实现获取作业数据的 API 调用
      // listHomework().then(response => {
      //   this.homeworkList = response.data;
      // }).catch(error => {
      //   console.error("Failed to fetch homework list:", error);
      // });
    }
  }
};
</script>

<style scoped>
.sidebar-container {
  width: 250px;
  height: 100vh;
  color: #fff;
}
.el-menu-vertical-demo {
  border-right: none;
}
</style>
