<script>
import PdfViewer from "@/views/tool/pdf/PDF.vue";

export default {
  name: "homeworkDetail.vue",
  components: {PdfViewer}
}
</script>

<template>
  <div class="homework-container">
    <PdfViewer url=""/>

  </div>
</template>

<style scoped lang="scss">
.homework-container{
  width:100%;
  height:100%;
}

</style>
