<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="帖子ID" prop="postId">
        <el-input
          v-model="queryParams.postId"
          placeholder="请输入帖子ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="收藏时间" prop="favoriteTime">
        <el-date-picker
          clearable
          v-model="queryParams.favoriteTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择收藏时间"
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
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:favorites:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="favoritesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="收藏记录ID" align="center" prop="favoriteId" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="帖子ID" align="center" prop="postId" />
      <el-table-column label="收藏时间" align="center" prop="favoriteTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.favoriteTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="primary"
            @click="viewPost(scope.row.postId)"
          >查看帖子</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:favorites:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { listFavorites, delFavorites } from "@/api/system/favorites";

export default {
  name: "Favorites",
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
      // 用户收藏表格数据
      favoritesList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        postId: null,
        favoriteTime: null
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询用户收藏列表 */
    getList() {
      this.loading = true;
      listFavorites(this.queryParams).then((response) => {
        this.favoritesList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        postId: null,
        favoriteTime: null
      };
      this.getList();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.favoriteId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 查看帖子详情 */
    viewPost(postId) {
      this.$router.push({
        name: "PostDetail", // 对应路由名称
        params: {postId}  // 帖子ID
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const favoriteIds = row.favoriteId || this.ids;
      this.$modal
        .confirm('是否确认删除用户收藏编号为"' + favoriteIds + '"的数据项？')
        .then(function () {
          return delFavorites(favoriteIds);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {
        });
    }
  }
};
</script>
