<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="添加时间" prop="enrolledAt">
        <el-date-picker clearable
                        v-model="queryParams.enrolledAt"
                        type="date"
                        value-format="yyyy-MM-dd hh:mm:ss"
                        placeholder="请选择添加时间">
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
          v-hasPermi="['system:user:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:user:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseUserList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户Id" align="center" prop="userId" />
      <el-table-column label="用户名称" align="center" prop="userName" />
      <el-table-column label="角色" align="center" prop="role" />
      <el-table-column label="添加时间" align="center" prop="enrolledAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.enrolledAt, '{y}-{m}-{d} {h}:{m}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:user:remove']"
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

    <!-- 添加对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-table v-loading="loading2" :data="otherStuList" @selection-change="handleSelectionAdd">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="用户Id" align="center" prop="userId" />
        <el-table-column label="名称" align="center" prop="userName" />
        <el-table-column label="角色" align="center" prop="roleName" />
      </el-table>
      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams_dialog.pageNum"
        :limit.sync="queryParams_dialog.pageSize"
        @pagination="getOtherStuList"
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listCourseUser,
  getCourseUser,
  delCourseUser,
  addCourseUser,
  listOtherStu,
  listUserName
} from "@/api/system/courseUser";

export default {
  name: "CourseUser",
  data() {
    return {
      // 遮罩层
      loading: true,
      loading2: true,
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
      courseUserList: [],
      // 保存选择的用户
      selectedUsers: [],
      // 其他学生列表
      otherStuList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseId: this.$router.currentRoute.params.courseId,
        role: null,
        enrolledAt: null
      },
      // 弹窗查询参数
      queryParams_dialog: {
        pageNum: 1,
        pageSize: 10,
        courseId: this.$router.currentRoute.params.courseId,
        role: null,
        enrolledAt: null
      },
      courseId: null,
      // 表单参数
      form: {
        courseId: this.$router.currentRoute.params.courseId,
      },
      // 表单校验
        rules: {
          selectedUsers: [
            { required: true, message: "请选择至少一个用户", trigger: "change" },
          ],
        },
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listUserName(this.queryParams).then(response => {
        this.courseUserList = response.rows;
        this.total = response.total;
        this.loading = false;
      })
    },
    /** 查询未选课学生 **/
    getOtherStuList() {
      this.loading2 = true;
      listOtherStu(this.queryParams_dialog).then(response => {
        this.otherStuList = response.rows;
        console.log(this.otherStuList);
        this.total = response.total;
        this.loading2 = false;
      })
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        courseId: null,
        userId: null,
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
      this.ids = selection.map(item => item.courseId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    // 选择新增用户
    handleSelectionAdd(selection) {
      this.selectedUsers = selection;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加学生";
      this.getOtherStuList();
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const courseId = row.courseId || this.ids
      getCourseUser(courseId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改【请填写功能名称】";
      });
    },
    submitForm() {
      if (this.selectedUsers.length === 0) {
        this.$message.error("请选择至少一个用户");
        return;
      }
      const selectedUserIds = this.selectedUsers.map(row => row.userId);
      const roles = this.selectedUsers.map(row => {
        // 判断 roleName 是否为 'student' 或 null，如果是，则赋值 'STUDENT'，否则赋值 'TEACHER'
        return (row.roleName === 'student' || row.roleName === null) ? 'STUDENT' : 'TEACHER';
      });
      const courseId = this.$router.currentRoute.params.courseId;

      // 生成每个用户的 courseUserData，确保每个用户的 role 是单独的
      const courseUserData = selectedUserIds.map((userId, index) => ({
        userId: userId,
        courseId: courseId,
        role: roles[index],  // 使用 roles 数组中的值来确保每个用户的 role 是独立的
      }));
      this.open = false;
      addCourseUser(courseUserData)
        .then(response => {
          // 如果成功，提示成功信息
          this.$message.success("用户添加成功");
          this.open = false;  // 关闭对话框
          this.getList();
        })
        .catch(error => {
          this.$message.error("添加用户失败");
        });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const userId = row.userId || this.ids;
      const courseId = this.$router.currentRoute.params.courseId;
      this.$modal.confirm('是否确认删除"' + row.userName + '"的数据项？').then(function() {
        return delCourseUser(courseId, userId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/user/export', {
        ...this.queryParams
      }, `user_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
