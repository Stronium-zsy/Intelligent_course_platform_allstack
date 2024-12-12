<template>
  <div class="app-container">
    <!-- 使用 CourseCard 展示课程信息 -->
    <div class="course-card-container">
      <el-row :gutter="20">
        <el-col :span="6" v-for="(course, index) in coursesList" :key="index">
          <course-card
            :image="course.courseImage"
            :description="course.courseDescription"
            :name="course.courseName"

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
      // 控制加载状态
      loading: true,
      // 选中数组
      ids: [],
      // 控制单个或多个禁用状态
      single: true,
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 课程总数
      total: 0,
      // 课程列表
      coursesList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseSource: null,
        courseVideo: null,
        courseName: null,
        courseDescription: null,
        courseImage:null,
      },
      // 表单参数
      form: {},
      // 表单校验
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
    /** 获取课程列表 */
    getList() {
      this.loading = true;

      listCourses(this.queryParams).then(response => {
        this.coursesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    goToCourseDetail(courseId) {
      this.$router.push({ name: 'CourseDetail', params: { courseId } });
    },
    /** 取消按钮 */
    cancel() {
      this.open = false;
      this.reset();
    },
    /** 重置表单 */
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
    /** 搜索操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 表单重置 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 提交表单 */
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
    /** 删除课程 */
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
  width:100%;
  height:100%;

}

</style>
