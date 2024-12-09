<template>
  <div class="app-container">
    <el-row>
      <!-- 左侧课程列表 -->
      <el-col :span="8" class="video-list">
        <!-- 原有表单、表格部分 -->
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
          <video ref="video" controls width="100%" height="650px" @timeupdate="captureAudio"></video>
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
      const video = this.$refs.video;

      // 检查视频元素是否存在
      if (!video || !video.captureStream) {
        console.error("无法访问视频流！");
        return;
      }

      // 获取视频的音频流
      const audioStream = video.captureStream().getAudioTracks();
      if (audioStream.length === 0) {
        console.error("未捕获到音频流！");
        return;
      }

      const audioContext = new AudioContext();
      const destination = audioContext.createMediaStreamDestination();
      const source = audioContext.createMediaStreamSource(new MediaStream(audioStream));
      source.connect(destination);

      // 使用 MediaRecorder 捕获音频
      const mediaRecorder = new MediaRecorder(destination.stream, { mimeType: "audio/webm" });

      const startRecording = () => {
        const chunks = [];

        mediaRecorder.ondataavailable = (e) => {
          if (e.data.size > 0) {
            chunks.push(e.data);
          }
        };

        mediaRecorder.onstop = () => {
          const blob = new Blob(chunks, { type: "audio/webm" });
          const formData = new FormData();
          formData.append("file", blob, `audio_chunk_${Date.now()}.webm`);

          // 发送音频到后端
          fetch("http://localhost:5000/process-audio", {
            method: "POST",
            body: formData,
          })
            .then((res) => res.json())
            .then((data) => console.log("后端处理成功:", data))
            .catch((err) => console.error("后端处理失败:", err));
        };

        // 开始录制 1 分钟音频
        mediaRecorder.start();
        setTimeout(() => {
          mediaRecorder.stop();
        }, 60000); // 录制时间为 1 分钟
      };

      // 每分钟启动一次录制
      setInterval(() => {
        startRecording();
      }, 60000); // 每 1 分钟触发录制逻辑
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
