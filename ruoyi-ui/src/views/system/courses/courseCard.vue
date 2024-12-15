<template>
  <div class="card-container">
    <div class="card-wrap"
         @mousemove="handleMouseMove"
         @mouseenter="handleMouseEnter"
         @mouseleave="handleMouseLeave"
         ref="card">
      <div class="card" :style="cardStyle">
        <div class="card-bg" :style="[cardBgTransform, cardBgImage]"></div>
        <div class="card-info">
          <h1>{{ name }}</h1>
          <p>{{ description }}</p>
        </div>
      </div>
      <!-- 详细信息面板 -->
    </div>
    <!--  <div v-if="showDetailPanel" class="details-panel">-->

    <!--    <StatsChart/>-->
    <!--    &lt;!&ndash; 使用图表展示详细数据 &ndash;&gt;-->
    <!--    &lt;!&ndash;      <RecruitmentChart :data="recruitmentData" />&ndash;&gt;-->
    <!--  </div>-->
  </div>
</template>

<script>
// import RecruitmentChart from './RecruitmentChart.vue'; // 确保路径正确


export default {
  name: 'courseCard',
  // components: {
  //   RecruitmentChart
  // },
  props: {
    name: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    image: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      width: 0,
      height: 0,
      mouseX: 0,
      mouseY: 0,
      mouseLeaveDelay: null,
      showDetailPanel: false,
      recruitmentData: {} // 存储图表数据
    };
  },
  computed: {
    mousePX() {
      return this.mouseX / this.width;
    },
    mousePY() {
      return this.mouseY / this.height;
    },
    cardStyle() {
      const rX = this.mousePX * 30;
      const rY = this.mousePY * -30;
      return {
        transform: `rotateY(${rX}deg) rotateX(${rY}deg)`
      };
    },
    cardBgTransform() {
      const tX = this.mousePX * -40;
      const tY = this.mousePY * -40;
      return {
        transform: `translateX(${tX}px) translateY(${tY}px)`
      };
    },
    cardBgImage() {
      return {
        backgroundImage: `url(${this.image})`
      };
    }
  },
  methods: {
    handleMouseMove(e) {
      const rect = this.$refs.card.getBoundingClientRect();
      this.mouseX = e.clientX - rect.left - rect.width / 2;
      this.mouseY = e.clientY - rect.top - rect.height / 2;
    },
    handleMouseEnter() {
      clearTimeout(this.mouseLeaveDelay);
    },
    handleMouseLeave() {
      this.mouseLeaveDelay = setTimeout(() => {
        this.mouseX = 0;
        this.mouseY = 0;
      }, 1000);
    },

  },
  mounted() {
    this.width = this.$refs.card.offsetWidth;
    this.height = this.$refs.card.offsetHeight;
  }
};
</script>

<style scoped>
.card-wrap {
  margin: 10px;
  transform: perspective(800px);
  transform-style: preserve-3d;
  cursor: pointer;
  position: relative; /* Added to position the details panel */
}

.card {
  position: relative;
  flex: 0 0 240px;
  width: 250px;
  height: 350px;
  background-color: #333;
  overflow: hidden;
  border-radius: 10px;
  box-shadow:
    rgba(0, 0, 0, 0.66) 0 30px 60px 0,
    inset #333 0 0 0 5px,
    inset rgba(255, 255, 255, 0.5) 0 0 0 6px;
  transition: 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);
}

.card-bg {
  opacity: 0.5;
  position: absolute;
  top:-20px;
  left:-20px;
  width: 120%;
  height: 120%;
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  transition:
    1s cubic-bezier(0.445, 0.05, 0.55, 0.95),
    opacity 5s 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);
  pointer-events: none;
}

.card-info {
  padding: 20px;
  position: absolute;
  bottom: 0;
  color: #fff;
  transform: translateY(40%);
  transition: 0.6s 1.6s cubic-bezier(0.215, 0.61, 0.355, 1);
}

.card-info p {
  opacity: 0;
  text-shadow: rgba(0, 0, 0, 1) 0 2px 3px;
  transition: 0.6s 1.6s cubic-bezier(0.215, 0.61, 0.355, 1);
}

.card-info * {
  position: relative;
  z-index: 1;
}

.card-info:after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  z-index: 0;
  width: 100%;
  height: 100%;
  background-blend-mode: overlay;
  opacity: 0;
  transform: translateY(100%);
  transition: 5s 1s cubic-bezier(0.445, 0.05, 0.55, 0.95);
}

.card-info h1 {
  font-family: "Playfair Display";
  font-size: 36px;
  font-weight: 700;
  text-shadow: rgba(0, 0, 0, 0.5) 0 10px 10px;
}

.card-wrap:hover .card-info {
  transform: translateY(0);
}

.card-wrap:hover .card-info p {
  opacity: 1;
}

.card-wrap:hover .card-info,
.card-wrap:hover .card-info p {
  transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1);
}

.card-wrap:hover .card-info:after {
  transition: 5s cubic-bezier(0.23, 1, 0.32, 1);
  opacity: 1;
  transform: translateY(0);
}

.card-wrap:hover .card-bg {
  transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1),
  opacity 5s cubic-bezier(0.23, 1, 0.32, 1);
  opacity: 0.8;
}

.card-wrap:hover .card {
  transition: 0.6s cubic-bezier(0.23, 1, 0.32, 1),
  box-shadow 2s cubic-bezier(0.23, 1, 0.32, 1);
  box-shadow: rgba(255, 255, 255, 0.2) 0 0 40px 5px,  /* White outer glow */
  rgba(255, 255, 255, 1) 0 0 0 1px,  /* Solid white border */
  rgba(0, 0, 0, 0.66) 0 30px 60px 0,  /* Black shadow */
  inset #333 0 0 0 5px,  /* Inner dark border */
  inset rgba(255, 255, 255, 0.5) 0 0 0 6px;  /* Inner light border */
}

/* 新增详细信息面板样式 */
.details-panel {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.8);
  color: #fff;
  padding: 20px;
  box-sizing: border-box;
  overflow: auto;
  z-index: 10;
  display: flex;
  flex-direction: column;
}
.close-btn{
  width:30px;
  height:30px;
  position:absolute;
  top:0;
  left:0;
  background:transparent;
}
.details-panel button {
  border: none;
  color: #fff;
  padding: 10px;
  cursor: pointer;
}
</style>
