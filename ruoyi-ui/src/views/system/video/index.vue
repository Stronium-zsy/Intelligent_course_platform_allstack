<script>
import videoPlayer from "@/views/system/video/videoPlayer.vue";

export default {
  name: "courseVideos.vue",
  components: {videoPlayer},
  mounted() {
    // 创建一个 <script> 元素
    const script = document.createElement("script");
    script.setAttribute("data-embed-id", "f4160e15-fa22-4ff7-9c99-130ecda3566e");
    script.setAttribute("data-base-api-url", "http://www.my-bjtu.cloud:3001/api/embed");
    script.src = "http://www.my-bjtu.cloud:3001/embed/anythingllm-chat-widget.min.js";

    // 将 script 标签插入到页面底部
    document.body.appendChild(script);
  },
}
</script>

<template>
<div class="course-video-container">
<!--  <HlsVideoPlayer/>-->
  <video-player/>

</div>
</template>

<style scoped lang="scss">
.course-video-container{
  width:100%;
  height:100%;
}

</style>
