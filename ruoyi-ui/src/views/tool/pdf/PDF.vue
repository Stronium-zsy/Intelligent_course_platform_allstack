<template>
  <div class="container">
    <iframe v-if="pdfUrl" :src="pdfUrl" width="100%" height="100%" frameborder="0"></iframe>
    <div v-else class="loading">
      <span>Loading PDF...</span>
    </div>
  </div>
</template>

<script>
import downloadModule from "@/plugins/download"
export default {
  name: "PdfViewer",
  props: {
    url: {
      type: String,
      default: null
    },
    pdfPath: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      pdfUrl: "", // PDF 文件地址
      fileUrl: "/pdf-viewer/web/viewer.html?file=" // pdfjs viewer.html 地址
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
        // 如果成功获取到 Blob 数据，则创建对象 URL
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
    // 释放 Blob URL，避免内存泄漏
    if (this.blob && this.pdfUrl) {
      URL.revokeObjectURL(this.pdfUrl);
    }
  }
};
</script>

<style scoped lang="scss">
.container {
  width: 100%;
  height: 100%;
  position: relative;
}

.loading {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}
</style>
