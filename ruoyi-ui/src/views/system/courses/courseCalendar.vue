<script>
import PdfViewer from "@/views/tool/pdf/PDF.vue";
import { listMaterial } from "@/api/system/material";

export default {
  name: "courseCallendar.vue",
  components: { PdfViewer },
  data() {
    return {
      customUploadPath: '/system/material/uploadMaterial',
      pdfPath: "",
      uploadParams: {},
      configList: [],
      total: 0
    };
  },
  methods: {
    getPath() {
      listMaterial({
        courseId: this.$route.params.courseId,
        materialType: "courseCalendar"
      }).then((response) => {
        this.configList = response.rows || []; // 确保 rows 存在
        this.total = response.total || 0;

        // 如果 configList 有内容，则设置 pdfPath
        if (this.configList.length > 0) {
          this.pdfPath = this.configList[0].filePath;
          console.log("PDF Path:", this.pdfPath);
        } else {
          console.warn("No material found for the specified course and material type.");
        }

        // 使用一个新的对象替换 uploadParams
        this.uploadParams = {
          courseId: this.$route.params.courseId,
          materialType: "courseCalendar"
        };
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
    <FileUpload
      :uploadPath="customUploadPath"
      :upload-params="uploadParams"
      v-has-permi="['system:material:add']"
    />
  </div>
</template>

<style scoped lang="scss">
.calendar-container {
  height: 100%;
  width: 70%;
}
</style>
