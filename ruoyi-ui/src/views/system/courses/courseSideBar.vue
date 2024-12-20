<template>
  <div class="course-sidebar-container">
    <!-- 收起/展开切换按钮 -->
    <button class="toggle-btn" @click="toggleCollapse">
      <i :class="isCollapse ? 'el-icon-s-unfold' : 'el-icon-s-fold'"></i>
    </button>

    <!-- 菜单组件 -->
    <el-menu
      :default-active="$route.path"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      :collapse="isCollapse"
      background-color="#304156"
      text-color="#bfcbd9"
      active-text-color="#409eff"
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
      <el-menu-item :index="`/courseDiscussion/${courseId}/courseDiscussion`" @click="navigateTo(`/courseDetail/${courseId}/discussion`)">
        <i class="el-icon-chat-dot-round"></i>
        <span>课程讨论</span>
      </el-menu-item>
      <el-menu-item :index="`/courseDetail/${courseId}/courseUser`" @click="navigateTo(`/courseDetail/${courseId}/courseUser`)">
        <i class="el-icon-user-solid"></i>
        <span>人员管理</span>
      </el-menu-item>
      <!-- 作业互评菜单项 -->
      <el-menu-item :index="`/courseDetail/${courseId}/coursePeerReview`" @click="navigateTo(`/courseDetail/${courseId}/coursePeerReview`)">
        <i class="el-icon-s-check"></i>
        <span>作业互评</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script>
import { listHomework } from "@/api/system/homework";
export default {
  name: "CourseSideBar",
  props: {
    defaultActive: {
      type: String,
      default: "1-1"
    }
  },
  data() {
    return {
      isCollapse: false, // 控制侧边栏收起/展开
      courseId: this.$route.params.courseId,
      homeworkList: []
    };
  },
  methods: {
    handleOpen(key, keyPath) {
      console.log("Open:", key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log("Close:", key, keyPath);
    },
    navigateTo(routePath) {
      this.$router.push(routePath);
    },
    toggleCollapse() {
      this.isCollapse = !this.isCollapse;
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
.course-sidebar-container {
  height: 100vh;
  background-color: rgb(48, 65, 86);
  color: #fff;
  display: flex;
  flex-direction: column;
}

.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  flex-grow: 1;
}

.toggle-btn {
  background-color: transparent;
  border: none;
  color: #fff;
  cursor: pointer;
  font-size: 18px;
  margin: 10px;
}

.toggle-btn:hover {
  color: #409EFF;
}
</style>
