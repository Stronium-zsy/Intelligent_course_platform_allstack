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
              @upload-success="handleUploadSuccess"/>
          </div>
        </div>

        <div v-else class="empty-state">
          <el-empty description="请选择文件或文件夹进行操作" v-if="!selectedFile"/>
          <PdfViewer :pdf-path="selectedFile" v-if="selectedFile" :key="selectedFile"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getFolderStructure } from "@/api/system/folderStructure";
import PdfViewer from "@/views/tool/pdf/PDF.vue";

export default {
  name: 'FileExplorer',
  components: {PdfViewer},


  data() {
    return {
      selectedFile: null,
      selectedFolder: null,
      fileTreeData: [], // 初始为空，后面通过API填充
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      customUploadPath: '/system/material/uploadFiles',
      uploadParams: {
        courseMaterial:{
          materialType:"courseFiles",
          courseId: this.$router.currentRoute.params.courseId
        },
        path:""

      },
    };
  },

  mounted() {
    this.fetchFolderStructure(); // 页面加载后获取文件夹结构
  },

  watch: {
    // 监听 selectedFile 的变化，当其变化时，强制重新渲染 PdfViewer
    selectedFile(newValue, oldValue) {
      this.$nextTick(() => {
        // 确保 DOM 更新完后才执行
        this.selectedFileKey = newValue ? newValue.path : null;
      });
    }
  },

  methods: {
    // 从后端获取文件夹结构
    async fetchFolderStructure() {
      try {
        const response = await getFolderStructure(this.$router.currentRoute.params.courseId); // 调用后端API获取文件夹结构
        // 处理返回的数据以适配前端需要的格式
        this.fileTreeData = this.formatFileTree(response.data);

        console.log("Folder structure fetched successfully:", this.fileTreeData);
      } catch (error) {
        console.error("Error fetching folder structure:", error);
      }
    },

    // 格式化文件树数据
    formatFileTree(data) {
      return data.map(item => {
        return {
          ...item,
          children: item.children && item.children.length ? this.formatFileTree(item.children) : [],
        };
      });
    },

    handleNodeClick(data) {
      if (data.directory) {
        // 如果点击的是文件夹，展示上传文件功能
        this.selectedFolder = data;
        this.uploadParams.path = data.path;
        this.selectedFile = null;
      } else {
        // 如果点击的是文件，展示文件预览功能
        this.selectedFile = "/"+data.path;
        this.selectedFolder = null;
      }
    },

    downloadPdf() {
      if (this.selectedFile && this.selectedFile.url) {
        const link = document.createElement('a');
        link.href = this.selectedFile.url;
        link.download = this.selectedFile.name;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }
    },

    beforeUpload(file) {
      // 可以在这里进行上传前的校验
      console.log("Before upload: ", file);
      return true; // 返回 true 继续上传，返回 false 则取消上传
    },

    handleUploadSuccess(response, file, fileList) {
      this.$message.success(`${file.name} 上传成功`);
      this.fetchFolderStructure(); // 上传成功后刷新文件夹结构
    }
  }
};
</script>

<style scoped>
/* 样式保持不变 */
.file-explorer-container {
  height: 100%;
  width: 90%;
  margin-left: 200px;
  min-height: 500px;
}

.file-explorer {
  display: flex;
  height: 100%;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  background-color: #fff;
}

.file-tree {
  width: 280px;
  border-right: 1px solid #dcdfe6;
  padding: 10px;
  overflow-y: auto;
  background-color: #fff;
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
  min-width: 0;
}

.pdf-header, .upload-header {
  padding: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #dcdfe6;
  background-color: #fff;
}

.upload-container {
  flex: 1;
  padding: 16px;
}

.pdf-header h3, .upload-header h3 {
  margin: 0;
  font-size: 16px;
  color: #303133;
}

.pdf-container {
  flex: 1;
  padding: 16px;
  overflow: auto;
}

.pdf-iframe {
  width: 100%;
  height: 100%;
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

/* 树节点样式 */
::v-deep .el-tree-node__content {
  height: 32px;
}

::v-deep .el-tree-node__content:hover {
  background-color: #f5f7fa;
}

::v-deep .el-tree-node.is-current > .el-tree-node__content {
  background-color: #ecf5ff;
}

::v-deep .el-tree-node__expand-icon {
  padding: 6px;
}

::v-deep .el-tree-node__children {
  padding-left: 16px;
}

/* 过渡效果 */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s ease-in-out;
}

.fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
  opacity: 0;
}
</style>
