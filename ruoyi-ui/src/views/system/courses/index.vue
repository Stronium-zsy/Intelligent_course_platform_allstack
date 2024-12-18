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

    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="课程名称" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:courses:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:courses:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:courses:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:courses:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="coursesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="课程Id" align="center" prop="courseId" />
      <el-table-column label="课程名称" align="center" prop="courseName" />
      <el-table-column label="课程简介" align="center" prop="courseDescription" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:courses:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:courses:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="form.courseName" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="课程介绍" prop="courseDescription">
          <el-input v-model="form.courseDescription" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="课程图片" prop="courseImage">
          <image-upload v-model="form.courseImage"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.courseId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加课程";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const courseId = row.courseId || this.ids
      getCourses(courseId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改课程";
      });
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
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/courses/export', {
        ...this.queryParams
      }, `courses_${new Date().getTime()}.xlsx`)
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
  margin-bottom: 100px;
}
</style>
