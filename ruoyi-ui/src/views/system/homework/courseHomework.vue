<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="作业id" prop="courseId">
        <el-input
          v-model="queryParams.courseId"
          placeholder="请输入作业id"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="作业名称" prop="title" >
        <el-input
          v-model="queryParams.title"
          placeholder="请输入作业名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="截至日期" prop="dueDate">
        <el-date-picker clearable
                        v-model="queryParams.dueDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择截止日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="教师名称" prop="createdAt">
        <el-date-picker clearable
                        v-model="queryParams.createdAt"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择教师名称">
        </el-date-picker>
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
          v-hasPermi="['system:homework:add']"
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
          v-hasPermi="['system:homework:edit']"
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
          v-hasPermi="['system:homework:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:homework:export']"
        >导出</el-button>
      </el-col>
    </el-row>
    <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>

    <el-table v-loading="loading" :data="homeworkList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="作业Id" align="center" prop="homeworkId" />
      <el-table-column label="课程Id" align="center" prop="courseId" />
      <el-table-column label="作业名称" align="center" prop="title">
        <template slot-scope="scope">
          <el-link type="primary" @click="navigateTo(`/courseDetail/${queryParams.courseId}/courseHomework/${scope.row.homeworkId}`)">
            {{ scope.row.title }}
          </el-link>
        </template>
      </el-table-column>

      <el-table-column label="作业描述" align="center" prop="description" />
      <el-table-column label="截止日期" align="center" prop="dueDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.dueDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="发布日期" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" v-has-permi="['system:homework:edit'] ">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:homework:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:homework:remove']"
          >删除</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:submissions:add']"
          >提交</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleCorrection(scope.row)"
            v-hasPermi="['system:submissions:query']"
          >批改</el-button>
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
    <FileUpload
      :uploadPath="customUploadPath"
      v-if="showUpLoad"
      :upload-params="uploadParams"
    />
    <FileUpload
      :uploadPath="updateHomeworkPath"
      v-if="showUpdate"
      :upload-params="updateHomeworkParams"
      />

    <!-- 添加或修改【请填写功能名称】对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="课程标题" prop="title">
          <el-input v-model="form.title" placeholder="课程标题" />
        </el-form-item>
        <el-form-item label="课程描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="课程描述" />
        </el-form-item>
        <el-form-item label="截止日期" prop="dueDate">
          <el-date-picker clearable
                          v-model="form.dueDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择截止日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="发布日期" prop="createdAt">
          <el-date-picker clearable
                          v-model="form.createdAt"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择发布日期">
          </el-date-picker>
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
import { listHomework, getHomework, delHomework, addHomework, updateHomework } from "@/api/system/homework";


export default {
  name: "courseHomework",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 【请填写功能名称】表格数据
      homeworkList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      showUpLoad:false,
      showUpdate:false,

      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseId: this.$router.currentRoute.params.courseId,
        title: null,
        description: null,
        dueDate: null,
        createdAt: null
      },
      customUploadPath: '/system/submissions/uploadHomework',
      updateHomeworkPath:'/system/homework/updateHomework',
      updateHomeworkParams: {},
      // 表单参数
      form: {
        courseId: this.$router.currentRoute.params.courseId,
      },
      homeworkId: 0,
      // 表单校验
      rules: {
        courseId: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
        title: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
      },

      uploadParams: {}
    };
  },
  created() {
    this.getList();
  },

  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listHomework(this.queryParams).then(response => {
        this.homeworkList = response.rows;
        this.total = response.total;
        this.loading = false;
      });

    },
    handleCorrection(row) {
      this.$router.push("/courseDetail/"+this.$router.currentRoute.params.courseId+"/homeworkCorrection/" + row.homeworkId);
    },
    navigateTo(routePath) {
      this.$router.push(
        routePath
      );
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        homeworkId: null,
        courseId: null,
        title: null,
        description: null,
        dueDate: null,
        createdAt: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.homeworkId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加【请填写功能名称】";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.homeworkId = row.homeworkId
      this.showUpdate = true
      this.updateHomeworkParams = {

         courseId: this.$router.currentRoute.params.courseId,
         homeworkId: this.homeworkId,

      };
      console.log(this.updateHomeworkParams)
      // getHomework(this.homeworkId).then(response => {
      //   this.form = response.data;
      //   this.open = true;
      //   this.title = "修改【请填写功能名称】";
      // });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.homeworkId != null) {
            console.log(this.form);
            updateHomework(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addHomework(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const homeworkIds = row.homeworkId || this.ids;
      this.$modal.confirm('是否确认删除【请填写功能名称】编号为"' + homeworkIds + '"的数据项？').then(function() {
        return delHomework(homeworkIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/homework/export', {
        ...this.queryParams
      }, `homework_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
<style>
.app-container{
  display:flex;
  flex-direction: column;
  width:80%;
}
</style>
