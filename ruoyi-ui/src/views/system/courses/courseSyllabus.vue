<script>
import PdfViewer from "@/views/tool/pdf/PDF.vue";

export default {
  name: "courseSyllabus.vue",
  components: {PdfViewer}
}
</script>

<template>
<div style="width:70%;height:100%;margin-left:230px;">
  <PdfViewer
  :pdf-path="`\\courseMaterial\\2\\materialType\\courseCalendar\\“中国特色社会主义理论与实践研究”期末考试通知_20241114174708A003.pdf`"
  />
  <FileUpload/>


</div>
</template>

<style scoped lang="scss">

</style>
