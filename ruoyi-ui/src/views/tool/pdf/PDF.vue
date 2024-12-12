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
import downloadModule from "@/plugins/download";
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
      let blob = await downloadModule.__resource__(this.pdfPath);
      if (blob) {
        if (blob.type !== "application/pdf") {
          blob = new Blob([blob], { type: "application/pdf" });
        }
        if (this.pdfUrl) {
          URL.revokeObjectURL(this.pdfUrl);
        }
        this.pdfUrl = this.fileUrl + encodeURIComponent(URL.createObjectURL(blob));
      } else {
        console.error("Failed to fetch Blob");
      }
    } else if (this.url) {
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
        const pdfPath = this.pdfPath || this.url;
        const response = await axios.post("http://127.0.0.1:5000/generate_mindmap_from_pdf", {
          pdf_path: pdfPath,
        });
        if (response.data && response.data.html_path) {
          this.mindmapHtml = "";
          const mindmapUrl = response.data.html_path;
          this.mindmapHtml = `<iframe src="/mindmaps/${mindmapUrl}" width="100%" height="600px" frameborder="0"></iframe>`;
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
  flex-direction: column;
  height: 100vh;
  background-color: #f9f9f9;
  gap: 10px;
  padding: 10px;
}

.pdf-viewer,
.mindmap-viewer {
  flex: 1;
  display: flex;
  flex-direction: column;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.pdf-viewer {
  margin-bottom: 10px;
}

.loading {
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 16px;
  color: #555;
}

.action {
  padding: 10px;
  text-align: center;
  background-color: #f4f4f4;
  border-bottom: 1px solid #ddd;
}

button {
  padding: 10px 20px;
  font-size: 16px;
  color: white;
  background-color: #007bff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #0056b3;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.mindmap-content {
  flex: 1;
  padding: 10px;
}

.mindmap-content iframe {
  border: none;
}

@media (min-width: 768px) {
  .container {
    flex-direction: row;
    gap: 20px;
  }

  .pdf-viewer,
  .mindmap-viewer {
    flex: 1;
    height: calc(100vh - 20px);
  }
}
</style>
