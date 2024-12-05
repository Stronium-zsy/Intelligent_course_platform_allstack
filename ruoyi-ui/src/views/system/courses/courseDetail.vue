<template>
  <div class="course-detail-container">
    <Sidebar />
    <div class="course-content">
      <router-view />
    </div>
  </div>
</template>

<script>
import Sidebar from './courseSideBar.vue';

export default {
  name: "CourseDetail",
  components: {
    Sidebar
  }
};
</script>

<style scoped>
.course-detail-container {
  display: flex;
}

.course-content {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
  height: 100vh;
}
</style>
