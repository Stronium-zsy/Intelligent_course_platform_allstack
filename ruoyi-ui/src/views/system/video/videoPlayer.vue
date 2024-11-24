<template>
  <div class="app-container">
    <el-row>
      <!-- 左侧课程列表 -->
      <el-col :span="8" class="video-list">
        <el-form
          :model="queryParams"
          ref="queryForm"
          size="small"
          :inline="true"
          label-width="68px"
        >
          <el-form-item label="课程名称">
            <el-input
              v-model="queryParams.courseName"
              placeholder="请输入课程名称"
              clearable
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="教师名称">
            <el-input
              v-model="queryParams.teacherName"
              placeholder="请输入教师名称"
              clearable
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="时间">
            <el-date-picker
              v-model="queryParams.classTime"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="请选择时间"
              clearable
            />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">
              搜索
            </el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">
              重置
            </el-button>
          </el-form-item>
        </el-form>
        <el-table
          v-loading="loading"
          :data="videosList"
          border
          @row-click="handleRowClick"
          highlight-current-row
        >
          <el-table-column type="index" width="50" align="center" label="序号" />
          <el-table-column prop="courseName" label="课程名称" align="center" />
          <el-table-column prop="teacherName" label="教师名称" align="center" />
          <el-table-column
            prop="classTime"
            label="课程时间"
            align="center"
            width="180"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.classTime, '{y}-{m}-{d}') }}</span>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页 -->
        <pagination
          v-show="total > 0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>

      <!-- 右侧视频播放 -->
      <el-col :span="16" class="video-player">
        <div v-if="currentVideo">
          <h2>当前播放：{{ currentVideo.courseName }}</h2>
          <p><strong>教师：</strong>{{ currentVideo.teacherName }}</p>
          <p><strong>时间：</strong>{{ parseTime(currentVideo.classTime, '{y}-{m}-{d}') }}</p>
          <video ref="video" controls width="100%" height="650px"></video>
        </div>
        <div v-else>
          <h2>请选择课程进行播放</h2>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import Hls from "hls.js";
import { listVideos } from "@/api/system/videos";
import { parseTime } from "@/utils/ruoyi";

export default {
  name: "videoPlayer",
  data() {
    return {
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseName: "",
        teacherName: "",
        classTime: "",
      },
      // 数据源
      videosList: [],
      total: 0,
      loading: false,
      currentVideo: null, // 当前播放的视频信息
    };
  },
  created() {
    this.getList();
  },
  methods: {
    parseTime,
    /** 获取课程视频列表 */
    getList() {
      this.loading = true;
      listVideos(this.queryParams).then((response) => {
        this.videosList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索功能 */
    handleQuery() {
      this.queryParams.pageNum = 1; // 重置到第一页
      this.getList();
    },
    /** 重置查询条件 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        courseName: "",
        teacherName: "",
        classTime: "",
      };
      this.handleQuery();
    },
    /** 点击课程行播放视频 */
    handleRowClick(row) {
      this.currentVideo = row; // 设置当前播放的视频信息
      this.$nextTick(() => {
        const video = this.$refs.video;
        const videoUrl = row.videoPath;

        if (Hls.isSupported()) {
          const hls = new Hls();
          hls.attachMedia(video);
          hls.loadSource(videoUrl);
        } else if (video.canPlayType("application/vnd.apple.mpegurl")) {
          video.src = videoUrl;
          video.addEventListener("canplay", () => {
            video.play();
          });
        }
      });
    },
  },
};
</script>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.video-list {
  padding-right: 10px;
  border-right: 1px solid #ccc;
  height: calc(100vh - 150px);
  overflow-y: auto;
}

.video-player {
  padding-left: 10px;
  height: calc(100vh - 150px);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.pagination {
  margin-top: 10px;
  display: flex;
  justify-content: center;
}
</style>
