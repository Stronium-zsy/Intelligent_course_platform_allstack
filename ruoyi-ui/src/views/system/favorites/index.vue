<template>
  <div class="app-container">
    <!-- 查询条件表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="80px">
      <el-form-item label="用户名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入用户名"
          clearable
        />
      </el-form-item>
      <el-form-item label="收藏时间" prop="favoriteTime">
        <el-date-picker
          clearable
          v-model="queryParams.favoriteTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择收藏时间"
        ></el-date-picker>
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
    </el-row>

    <!-- 收藏列表表格 -->
    <el-table v-loading="loading" :data="favoritesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户名" align="center" prop="userName" />
      <el-table-column label="帖子标题" align="center">
        <template slot-scope="scope">
          <el-link type="primary" @click="viewPostDetail(scope.row.postId)">
            {{ scope.row.postTitle || '无标题' }}
          </el-link>
        </template>
      </el-table-column>
      <el-table-column label="收藏时间" align="center" prop="favoriteTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.favoriteTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
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
import { listFavoritesByCriteria, listFavorites, delFavorites } from "@/api/system/favorites";

export default {
  name: "Favorites",
  data() {
    return {
      loading: false,
      favoritesList: [],
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: '',
        favoriteTime: null,
      },
      ids: [],
      multiple: true,
      isSearching: false, // 区分是否在执行搜索操作
    };
  },
  created() {
    this.getInitialList();
  },
  methods: {
    /** 获取初始收藏列表，仅加载当前用户的收藏 */
    getInitialList() {
      this.loading = true;
      const userId = this.$store.state.user.id; // 当前登录用户ID
      listFavorites({ userId, pageNum: this.queryParams.pageNum, pageSize: this.queryParams.pageSize }).then((response) => {
        this.favoritesList = response.rows;
        this.total = response.total;
        this.loading = false;
        this.isSearching = false; // 标记非搜索状态
      });
    },
    /** 查询收藏列表（支持用户名或时间条件） */
    getList() {
      this.loading = true;
      listFavoritesByCriteria(this.queryParams).then((response) => {
        this.favoritesList = response.rows;
        this.total = response.total;
        this.loading = false;
        this.isSearching = true; // 标记为搜索状态
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      if (this.queryParams.favoriteTime && !this.queryParams.userName) {
        this.$message.error('请输入用户名后再按日期查询');
        return;
      }
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置查询条件 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        userName: '',
        favoriteTime: null,
      };
      this.getInitialList(); // 重置时回到初始收藏列表
    },
    /** 处理多选框选择事件 */
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.favoriteId);
      this.multiple = !this.ids.length;
    },
    /** 删除收藏记录 */
    handleDelete(row) {
      const favoriteIds = row ? [row.favoriteId] : this.ids;
      this.$modal.confirm('是否确认删除选中的收藏记录？').then(() => {
        return delFavorites(favoriteIds);
      }).then(() => {
        if (this.isSearching) {
          this.getList(); // 搜索状态时刷新搜索结果
        } else {
          this.getInitialList(); // 非搜索状态时刷新初始列表
        }
        this.$modal.msgSuccess("删除成功");
      });
    },
    /** 查看帖子详情 */
    viewPostDetail(postId) {
      if (!postId) {
        this.$message.error('帖子不存在');
        return;
      }
      this.$router.push({name: 'PostDetail', params: {postId}});
    },
  },
};
</script>

<style scoped>
.app-container {
  padding: 20px;
}

.mb8 {
  margin-bottom: 8px;
}
</style>
