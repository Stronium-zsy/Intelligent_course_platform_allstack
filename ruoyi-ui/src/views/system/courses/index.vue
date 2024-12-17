<template>
  <div class="app-container">
    <div class="course-card-container">
      <el-row :gutter="20">
        <el-col :span="6" v-for="(course, index) in coursesList" :key="index">
          <course-card
            :image="course.courseImage"
            :description="course.courseDescription"
            :name="course.courseName"
            :isSingle="coursesList.length === 1"
            @click.native="goToCourseDetail(course.courseId)"
          />
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
import { listCourses, getCourses, delCourses, addCourses, updateCourses } from "@/api/system/courses";
import CourseCard from "@/views/system/courses/courseCard.vue";

export default {
  name: "Courses",
  components: { CourseCard },
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      coursesList: [],
      title: "",
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseSource: null,
        courseVideo: null,
        courseName: null,
        courseDescription: null,
        courseImage: null,
      },
      form: {},
      rules: {
        courseName: [
          { required: true, message: "课程名称不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      listCourses(this.queryParams).then(response => {
        console.log(response); // 打印 response 对象
        this.coursesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },

    goToCourseDetail(courseId) {
      this.$router.push({ name: 'CourseDetail', params: { courseId } });
    },
    cancel() {
      this.open = false;
      this.reset();
    },
    reset() {
      this.form = {
        courseId: null,
        courseSource: null,
        courseVideo: null,
        courseName: null,
        courseDescription: null
      };
      this.resetForm("form");
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.courseId != null) {
            updateCourses(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addCourses(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    handleDelete(row) {
      const courseIds = row.courseId || this.ids;
      this.$modal.confirm('是否确认删除课程编号为"' + courseIds + '"的数据项？').then(() => {
        return delCourses(courseIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
.app-container {
  padding: 5px;
}

.course-card-container {
  display: flex;
  flex-wrap: wrap;
  width: 100%;
  height: 100%;
}
</style>
