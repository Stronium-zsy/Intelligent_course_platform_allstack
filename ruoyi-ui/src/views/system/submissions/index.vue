<template>
  <div class="submissions-container">
    <div class="homework-list">
      <el-table v-loading="loading" :data="submissionsList" @selection-change="handleSelectionChange">
        <el-table-column label="作业名称" align="center" prop="filePath" >
          <template slot-scope="scope" >
            <span @click="checkHomework(scope.row.filePath)">{{ getLastName(scope.row.filePath) }}</span>
          </template>
        </el-table-column>

        <el-table-column label="提交时间" align="center" prop="submittedAt" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.submittedAt, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['system:submissions:edit']"
            >评分</el-button>
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

      <!-- 添加或修改【请填写功能名称】对话框 -->
      <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">

          <el-form-item label="分数" prop="grade">
            <el-input v-model="form.grade" placeholder="请输入分数" />
          </el-form-item>
          <el-form-item label="反馈" prop="feedback">
            <el-input v-model="form.feedback" type="textarea" placeholder="请输入作业反馈" />
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </el-dialog>

    </div>
    <div class="homework-detail">
      <PdfViewer :pdf-path="checkedHomework" v-if="checkedHomework" :key="checkedHomework" />
    </div>

  </div>
</template>

<script>
import { listSubmissions, getSubmissions, delSubmissions, addSubmissions, updateSubmissions } from "@/api/system/submissions";
import PdfViewer from "@/views/tool/pdf/PDF.vue";

export default {
  name: "Submissions",
  components: {PdfViewer},
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
      submissionsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        homeworkId: null,
        userId: null,
        filePath: null,
        submittedAt: null,
        grade: null,
        feedback: null
      },
      checkedHomework:"",
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        homeworkId: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
        userId: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
        filePath: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listSubmissions(this.queryParams).then(response => {
        this.submissionsList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    checkHomework(homeworkPath){
      this.checkedHomework=homeworkPath
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        submissionId: null,
        homeworkId: null,
        userId: null,
        filePath: null,
        submittedAt: null,
        grade: null,
        feedback: null
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
      this.ids = selection.map(item => item.submissionId)
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
      const submissionId = row.submissionId || this.ids
      getSubmissions(submissionId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "请打分并对作业做出评价";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.submissionId != null) {
            updateSubmissions(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addSubmissions(this.form).then(response => {
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
      const submissionIds = row.submissionId || this.ids;
      this.$modal.confirm('是否确认删除【请填写功能名称】编号为"' + submissionIds + '"的数据项？').then(function() {
        return delSubmissions(submissionIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    getLastName(filePath) {
      if (!filePath) return '';
      const parts = filePath.split('/');
      return parts[parts.length - 1]; // 返回最后的部分
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/submissions/export', {
        ...this.queryParams
      }, `submissions_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
<style>
.submissions-container{
  margin-left:0;
  width:100%;
  height:100%;
  display:flex;
  flex-direction:row;
}
.homework-list{
  flex-direction:column;
  height:auto;
  width:25%;
}
.homework-detail{
  width:65%;
  margin-left:5%;
}
</style>
