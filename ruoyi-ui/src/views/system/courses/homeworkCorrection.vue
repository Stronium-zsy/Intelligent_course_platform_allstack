<script>
import Submissions from "@/views/system/submissions/index.vue";

export default {
  name: "homeworkCorrection.vue",
  components: {Submissions},
  data() {
    return {
        homeworkId:0,
    }
  },

  created() {
    this.homeworkId=this.$route.params.homeworkId
  },
  mounted() {

  }
}
</script>

<template>
<div id="correction-container">
  <div id="homework-list">
    <Submissions/>
  </div>


</div>
</template>

<style scoped lang="scss">
#correction-container{
  margin-left:230px;
  width:90%;
  height:100%;
}
#homework-list{
  width:100%;
  height:100%;
}
</style>
