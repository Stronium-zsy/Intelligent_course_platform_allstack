<template>
  <div class="app-container">
    <!-- 搜索和课程列表 -->
    <el-row class="search-section" gutter="20">
      <el-col :span="24">
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
            <el-button
              type="primary"
              icon="el-icon-search"
              size="mini"
              @click="handleQuery"
            >
              搜索
            </el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">
              重置
            </el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <el-row class="video-list-section" gutter="20">
      <el-col :span="24">
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
    </el-row>

    <el-row class="video-player-section" gutter="20">
      <el-col :span="24">
        <div v-if="currentVideo" class="video-player">
          <h2 class="compact">当前播放：{{ currentVideo.courseName }}</h2>
          <p class="compact"><strong>教师：</strong>{{ currentVideo.teacherName }}</p>
          <p class="compact"><strong>时间：</strong>{{ parseTime(currentVideo.classTime, '{y}-{m}-{d}') }}</p>
          <video
            ref="video"
            controls
            width="100%"
            height="auto"
            @timeupdate="captureAudio"
          ></video>
        </div>
        <div v-else class="no-video">
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
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseName: "",
        teacherName: "",
        classTime: "",
      },
      videosList: [],
      total: 0,
      loading: false,
      currentVideo: null,
      lastCapturedTime: 0, // 上次提取的时间点
    };
  },
  created() {
    this.getList();
  },
  methods: {
    parseTime,
    getList() {
      this.loading = true;
      listVideos(this.queryParams).then((response) => {
        this.videosList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
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
    handleRowClick(row) {
      this.currentVideo = row;
      this.$nextTick(() => {
        const video = this.$refs.video;
        const videoUrl = row.videoPath;
        if (Hls.isSupported()) {
          const hls = new Hls();
          hls.attachMedia(video);
          hls.loadSource(videoUrl);
        } else if (video.canPlayType("application/vnd.apple.mpegurl")) {
          video.src = videoUrl;
          video.addEventListener("canplay", () => video.play());
        }
      });
    },
    captureAudio() {
      // captureAudio implementation
    },
  },
};
</script>

<style scoped>
.app-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
  width: 90%;
}

.search-section,
.video-list-section,
.video-player-section {
  width: 100%;
  box-sizing: border-box;
}

.video-player {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.no-video {
  text-align: center;
  color: #888;
}

.compact {
  margin: 5px 0;
  line-height: 1.2;
}
</style>
