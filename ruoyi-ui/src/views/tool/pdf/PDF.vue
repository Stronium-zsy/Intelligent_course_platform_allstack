<template>
  <div class="container">
    <!-- 左侧 PDF 预览 -->
    <div class="pdf-viewer">
      <iframe v-if="pdfUrl" :src="pdfUrl" width="100%" height="100%" frameborder="0"></iframe>
      <div v-else class="loading">
        <span>Loading PDF...</span>
      </div>
    </div>

    <!-- 右侧 思维导图生成与显示 -->
    <div class="mindmap-viewer">
      <div class="action">
        <button @click="generateMindmap" :disabled="isGenerating">生成思维导图</button>
      </div>
      <div v-if="mindmapHtml" class="mindmap-content" v-html="mindmapHtml"></div>
    </div>
  </div>
</template>

<script>
import downloadModule from "@/plugins/download"
import axios from "axios";

export default {
  name: "PdfViewer",
  props: {
    url: {
      type: String,
      default: null,
    },
    pdfPath: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      pdfUrl: "", // PDF 文件地址
      fileUrl: "/pdf-viewer/web/viewer.html?file=", // pdfjs viewer.html 地址
      isGenerating: false, // 是否正在生成思维导图
      mindmapHtml: "", // 思维导图 HTML
    };
  },
  async mounted() {
    if (this.pdfPath) {
      // 使用 async/await 等待 Promise 解析出 blob
      let blob = await downloadModule.__resource__(this.pdfPath);
      if (blob) {
        console.log(blob);
        if (blob.type !== 'application/pdf') {
          blob = new Blob([blob], { type: 'application/pdf' });
        }
        // 释放之前的 URL 以避免内存泄漏
        if (this.pdfUrl) {
          URL.revokeObjectURL(this.pdfUrl);
        }
        this.pdfUrl = this.fileUrl + encodeURIComponent(URL.createObjectURL(blob));
      } else {
        console.error('Failed to fetch Blob');
      }
    } else if (this.url) {
      // 如果传递了 URL，则直接使用 URL
      this.pdfUrl = this.fileUrl + encodeURIComponent(this.url);
    }
  },
  beforeDestroy() {
    if (this.pdfUrl) {
      URL.revokeObjectURL(this.pdfUrl);
    }
  },
  methods: {
    async generateMindmap() {
      if (!this.url && !this.pdfPath) {
        alert("PDF 文件路径未提供");
        return;
      }
      this.isGenerating = true;
      try {
        const pdfPath = this.pdfPath || this.url; // 使用 PDF 路径或 URL
        const response = await axios.post("http://127.0.0.1:5000/generate_mindmap_from_pdf", {
          pdf_path: pdfPath,
        });
        if (response.data && response.data.html_path) {
          this.mindmapHtml = ""; // 清空之前的内容
          const mindmapUrl = response.data.html_path; // 后端返回的 HTML 路径
          // 直接通过 iframe 加载 HTML 文件
          this.mindmapHtml = `<iframe src="${"/mindmaps/" + mindmapUrl}" width="100%" height="600px" frameborder="0"></iframe>`;
        } else {
          console.error("未生成思维导图:", response.data);
        }
      } catch (error) {
        console.error("生成思维导图失败:", error);
      } finally {
        this.isGenerating = false;
      }
    },

},
};



</script>

<style scoped lang="scss">
.container {
  display: flex;
  height: 100%;
  width:1500px;
  overflow: hidden;
}

.pdf-viewer,
.mindmap-viewer {
  flex: 1;
  display: flex;
  flex-direction: column;
  border: 1px solid #ddd;
  overflow: auto;
  height:100%;
}

.pdf-viewer {
  margin-right: 1px; /* 分隔两部分 */
}

.loading {
  display: flex;
  align-items: center;
  justify-content: center;
  flex: 1;
}

.action {
  margin: 10px;
  text-align: center;
}

button {
  padding: 10px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.mindmap-content {
  flex: 1;
  padding: 10px;
  border-top: 1px solid #ddd;
}

</style>
