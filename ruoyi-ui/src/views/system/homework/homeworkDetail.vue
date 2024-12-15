<script>
import PdfViewer from "@/views/tool/pdf/PDF.vue";

import { listHomework } from "@/api/system/homework";

export default {
  name: "homeworkDetail.vue",
  components: { PdfViewer },
  data() {
    return {
      pdfPath: "",
      uploadParams: {},
      configList: [],
      total: 0
    };
  },
  methods: {
    getPath() {
      listHomework({
        courseId: this.$router.currentRoute.params.courseId,
        homeworkId: this.$router.currentRoute.params.homeworkId
      }).then(response => {
        this.configList = response.rows || []; // 确保 rows 存在
        this.total = response.total || 0;
        console.log(this.configList)

        // 如果 configList 有内容，则设置 pdfPath
        if (this.configList.length > 0) {
          this.pdfPath = this.configList[0].filePath;
          console.log("PDF Path:", this.pdfPath);
        } else {
          console.warn("No material found for the specified course and material type.");
        }

      }).catch((error) => {
        console.error("Error loading material:", error);
      });

    }
  },
  created() {
    this.getPath();
  }
};
</script>

<template>
  <div class="calendar-container">
    <PdfViewer v-if="pdfPath" :pdf-path="pdfPath" />
  </div>
</template>

<style scoped lang="scss">
.calendar-container {
  height: 100%;
  width: 70%;
  margin-left: 230px;
}
</style>
