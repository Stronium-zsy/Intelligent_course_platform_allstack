<template>
  <div class="file-explorer-container">
    <div class="file-explorer">
      <!-- 左侧文件树 -->
      <div class="file-tree">
        <el-tree
          ref="tree"
          :data="fileTreeData"
          :props="defaultProps"
          @node-click="handleNodeClick"
          :expand-on-click-node="false"
          node-key="path"
          class="custom-tree"
        >
          <span slot-scope="{ node, data }" class="custom-tree-node">
            <i
              :class="[data.directory ? 'el-icon-folder' : 'el-icon-document']"
              class="node-icon"
            ></i>
            <span>{{ data.name }}</span>
          </span>
        </el-tree>
      </div>

      <!-- 右侧区域 - 文件预览和上传 -->
      <div class="file-preview">
        <template v-if="selectedFile && selectedFile.directory === false">
          <!-- PDF预览区域 -->
          <div class="pdf-header">
            <h3>{{ selectedFile.name }}</h3>
            <el-button type="primary" size="small" @click="downloadPdf">
              下载文件
            </el-button>
          </div>
          <div class="pdf-container">
            <transition name="fade" mode="out-in">
              <iframe
                v-if="selectedFile.url"
                :src="selectedFile.url"
                class="pdf-iframe"
                :key="selectedFile.path"
              ></iframe>
            </transition>
          </div>
        </template>

        <div v-else-if="selectedFolder && selectedFolder.directory">
          <!-- 文件夹选择区域，显示上传文件功能 -->
          <div class="upload-header">
            <h3>上传到文件夹：{{ selectedFolder.name }}</h3>
          </div>
          <div class="upload-container">
            <FileUpload
              :upload-path="customUploadPath"
              :upload-params="uploadParams"
              @upload-success="handleUploadSuccess" />
          </div>
        </div>

        <div v-else class="empty-state">
          <el-empty description="请选择文件或文件夹进行操作" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getFolderStructure } from "@/api/system/folderStructure";
import PdfViewer from "@/views/tool/pdf/PDF.vue";

export default {
  name: "FileExplorer",
  components: { PdfViewer },

  data() {
    return {
      selectedFile: null,
      selectedFolder: null,
      fileTreeData: [],
      defaultProps: {
        children: "children",
        label: "name",
      },
      customUploadPath: "/system/material/uploadFiles",
      uploadParams: {
        courseMaterial: {
          materialType: "courseFiles",
          courseId: this.$router.currentRoute.params.courseId,
        },
        path: "",
      },
    };
  },

  mounted() {
    this.fetchFolderStructure();
  },

  methods: {
    async fetchFolderStructure() {
      try {
        const response = await getFolderStructure(this.$router.currentRoute.params.courseId);
        this.fileTreeData = this.formatFileTree(response.data);
      } catch (error) {
        console.error("Error fetching folder structure:", error);
      }
    },

    formatFileTree(data) {
      return data.map((item) => {
        return {
          ...item,
          children: item.children && item.children.length ? this.formatFileTree(item.children) : [],
        };
      });
    },

    handleNodeClick(data) {
      if (data.directory) {
        this.selectedFolder = data;
        this.uploadParams.path = data.path;
        this.selectedFile = null;
      } else {
        this.selectedFile = "/" + data.path;
        this.selectedFolder = null;
      }
    },

    downloadPdf() {
      if (this.selectedFile && this.selectedFile.url) {
        const link = document.createElement("a");
        link.href = this.selectedFile.url;
        link.download = this.selectedFile.name;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }
    },

    handleUploadSuccess(response, file) {
      this.$message.success(`${file.name} 上传成功`);
      this.fetchFolderStructure();
    },
  },
};
</script>

<style scoped>
.file-explorer-container {
  height: 100%;
  width: 100%;
  min-height: 500px;
  padding: 10px;
  box-sizing: border-box;
}

.file-explorer {
  display: flex;
  flex-direction: column;
  height: 100%;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  background-color: #fff;
  overflow: hidden;
}

.file-tree {
  width: 100%;
  max-height: 40%;
  overflow-y: auto;
  padding: 10px;
  border-bottom: 1px solid #dcdfe6;
  background-color: #f9f9f9;
}

.custom-tree {
  background: transparent;
}

.custom-tree-node {
  display: inline-flex;
  align-items: center;
  font-size: 14px;
}

.node-icon {
  margin-right: 8px;
  font-size: 16px;
}

.file-preview {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: #f5f7fa;
  overflow: auto;
}

.pdf-header,
.upload-header {
  padding: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #fff;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.upload-container {
  flex: 1;
  padding: 16px;
}

.pdf-container {
  flex: 1;
  padding: 16px;
  overflow: auto;
}

.pdf-iframe {
  width: 100%;
  height: calc(100vh - 200px);
  border: none;
  background: white;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.empty-state {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  background-color: #fff;
}

@media (min-width: 768px) {
  .file-explorer {
    flex-direction: row;
  }

  .file-tree {
    width: 280px;
    max-height: 100%;
    border-right: 1px solid #dcdfe6;
    border-bottom: none;
  }

  .file-preview {
    flex: 1;
    min-width: 0;
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease-in-out;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
