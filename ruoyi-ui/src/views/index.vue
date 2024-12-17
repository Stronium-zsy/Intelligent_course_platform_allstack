<template>
  <div class="app-container home">
    <el-carousel height="400px" style="margin-bottom: 20px;">
      <el-carousel-item v-for="item in carouselItems" :key="item.id">
        <el-image :src="item.imageUrl" fit="cover">
          <div slot="error" class="image-slot">
            <i class="el-icon-picture-outline"></i>
          </div>
        </el-image>
      </el-carousel-item>
    </el-carousel>

    <el-row :gutter="20">
      <!-- Research Section -->
      <el-col :span="8">
        <el-card class="section-card">
          <div slot="header" class="header">
            <span>教学科研</span>
            <span class="subtitle">Research</span>
            <el-link type="primary" class="more">更多 ></el-link>
          </div>
          <el-timeline>
            <el-timeline-item v-for="(item, index) in researchNews" :key="index">
              <el-link>{{ item.title }}</el-link>
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>

      <!-- Campus Section -->
      <el-col :span="8">
        <el-card class="section-card">
          <div slot="header" class="header">
            <span>青青校园</span>
            <span class="subtitle">Viewpoint</span>
            <el-link type="primary" class="more">更多 ></el-link>
          </div>
          <div class="campus-news">
            <div v-for="(item, index) in campusNews" :key="index" class="news-item">
              <h3>{{ item.title }}</h3>
              <p class="date">{{ item.date }}</p>
              <p class="content">{{ item.content }}</p>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- Notice Section -->
      <el-col :span="8">
        <el-card class="section-card">
          <div slot="header" class="header">
            <span>通知公告</span>
            <span class="subtitle">Notice</span>
            <el-link type="primary" class="more">更多 ></el-link>
          </div>
          <div class="notice-list">
            <div v-for="(item, index) in notices" :key="index" class="notice-item">
              <div class="notice-date">
                <span class="day">{{ item.day }}</span>
                <span class="month">{{ item.month }}</span>
              </div>
              <el-link class="notice-title">{{ item.title }}</el-link>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Campus Life Section -->
    <div class="campus-life-section">
      <div class="campus-title">
        <h2>光影交大</h2>
        <p>CAMPUS LIFE</p>
      </div>
      <el-carousel :interval="4000" type="card" height="300px">
        <el-carousel-item v-for="(image, index) in campusImages" :key="index">
          <el-image :src="image" fit="cover"></el-image>
        </el-carousel-item>
      </el-carousel>
    </div>

    <!-- Special Websites Section -->
    <div class="special-websites">
      <h3 class="section-title">专题网站</h3>
      <el-row :gutter="20">
        <el-col :xs="12" :sm="8" :md="6" :lg="4" v-for="(site, index) in specialWebsites" :key="index">
          <a :href="site.url" target="_blank" style="text-decoration: none;">
          <el-card :body-style="{ padding: '0px' }" class="site-card" shadow="hover">
            <el-image :src="site.image" fit="cover" class="site-image"></el-image>
            <div class="site-title" :style="{ backgroundColor: site.bgColor }">
              {{ site.title }}
            </div>
          </el-card>
          </a>
        </el-col>
      </el-row>
    </div>

    <!-- Bottom Navigation -->
    <div class="bottom-nav">
      <el-row type="flex" justify="space-around" align="middle">
        <el-col :span="4" v-for="(item, index) in bottomNavItems" :key="index">
          <div class="nav-item" :style="{ color: item.color }">
            <i :class="item.icon"></i>
            <span>{{ item.title }}</span>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      version: "3.8.8",
      carouselItems: [
        { id: 1, imageUrl: require('@/assets/bjtu_picture/title0.jpg') },
        { id: 2, imageUrl: require('@/assets/bjtu_picture/title1.jpg') },
        { id: 3, imageUrl: require('@/assets/bjtu_picture/title2.jpg') },
        { id: 4, imageUrl: require('@/assets/bjtu_picture/title3.jpg') },
      ],
      researchNews: [
        {title: "我校独立杰出教授医药创新评价研究成果广受社会关注"},
        {title: "TSTE 2024交通运输经济学主编面对面会议在我校举办"},
        {title: "我校在全国大学生物理实验竞赛（创新）中获得4个一等奖"}
      ],
      campusNews: [
        {
          title: "北京交通大学原创话剧《奔以奔》新编巡演圆满完成",
          date: "2024.11.19",
          content: "由我校精心打造的大型原创话剧《奔以奔》新编巡演活动，在新疆医科大学（雪莲山校区）..."
        }
      ],
      notices: [
        {day: "09", month: "2024.12", title: "北京交通大学2025年招收台湾高中毕业生简章"},
        {day: "03", month: "2024.12", title: "北京交通大学2025年澳门保送生招生简章"},
        {day: "31", month: "2024.10", title: "2025年全国硕士研究生招生考试北京交通大学考点（1104）网上确认通知"}
      ],
      campusImages: [
        require('@/assets/bjtu_picture/campus_life0.jpg'),
        require('@/assets/bjtu_picture/campus_life1.jpg'),
        require('@/assets/bjtu_picture/campus_life2.jpg'),
        require('@/assets/bjtu_picture/campus_life3.jpg'),
        require('@/assets/bjtu_picture/campus_life4.jpg'),
      ],
      specialWebsites: [
        {
          title: '人才招聘',
          url: 'http://jgrsc.bjtu.edu.cn/',
          image: require('@/assets/bjtu_picture/website0.jpg'),
          bgColor: '#e74c3c'
        },
        {
          title: '党代会专题网',
          url: "http://news.bjtu.edu.cn/dsecddh/",
          image: require('@/assets/bjtu_picture/website1.jpg'),
          bgColor: '#c0392b'
        },
        {
          title: '中央财政科研政策专栏',
          url: "http://www.bjtu.edu.cn/ztwz/zyczkyzczl/index.htm",
          image: require('@/assets/bjtu_picture/website2.jpg'),
          bgColor: '#e67e22'
        },
        {
          title: '校友网',
          url: "http://alumni.bjtu.edu.cn/",
          image: require('@/assets/bjtu_picture/website3.jpg'),
          bgColor: '#34495e'
        },
        {
          title: '招生咨询网',
          url: 'http://zsw.bjtu.edu.cn/',
          image: require('@/assets/bjtu_picture/website4.jpg'),
          bgColor: '#2980b9'
        },
        {
          title: '校园信息门户',
          url: 'http://mis.bjtu.edu.cn',
          image: require('@/assets/bjtu_picture/website5.jpg'),
          bgColor: '#8e44ad'
        }
      ],
      bottomNavItems: [
        { title: '意见箱', icon: 'el-icon-message', color: '#f39c12' },
        { title: '建言献策', icon: 'el-icon-edit', color: '#3498db' },
        { title: '知行论坛', icon: 'el-icon-chat-dot-square', color: '#16a085' },
        { title: '官方微博', icon: 'el-icon-share', color: '#e74c3c' },
        { title: '官方微信', icon: 'el-icon-chat-line-square', color: '#2ecc71' },
        { title: '微信订阅户', icon: 'el-icon-service', color: '#3498db' }
      ]
    };
  }
};
</script>

<style scoped lang="scss">


.app-container {
  padding: 20px;
  background-color: #f0f2f5;

  .bjtu-homepage {
    max-width: 1200px;
    margin: 0 auto;
  }

  .news-section {
    margin-top: 20px;
  }

  .news-title {
    font-size: 24px;
    font-weight: bold;
  }

  .news-subtitle {
    font-size: 16px;
    color: #909399;
    margin-left: 10px;
  }

  .featured-news-item {
    margin-bottom: 20px;
    position: relative;
  }

  .news-date {
    position: absolute;
    top: 0;
    left: 0;
    background-color: rgba(255, 255, 255, 0.8);
    padding: 5px 10px;
    text-align: center;
  }

  .news-date strong {
    font-size: 24px;
    display: block;
  }

  .news-date span {
    font-size: 14px;
  }

  .featured-news-item h3 {
    margin-top: 10px;
    font-size: 18px;
  }

  .featured-news-item p {
    color: #606266;
    margin-bottom: 10px;
  }

  .news-list {
    list-style-type: none;
    padding: 0;
  }

  .news-list li {
    margin-bottom: 15px;
  }

  .news-list .news-date {
    font-size: 12px;
    color: #909399;
    margin-left: 10px;
  }

  .el-carousel__item {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .el-image {
    width: 100%;
    height: 100%;
  }

  .section-card {
    margin-bottom: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

    .header {
      display: flex;
      align-items: center;
      padding: 10px 20px;
      border-bottom: 1px solid #e4e7ed;

      .subtitle {
        color: #909399;
        margin-left: 10px;
        font-size: 14px;
      }

      .more {
        margin-left: auto;
        font-size: 14px;
      }
    }
  }

  .campus-news {
    .news-item {
      margin-bottom: 20px;
      padding: 0 20px;

      h3 {
        margin: 0 0 10px 0;
        font-size: 16px;
        color: #303133;
      }

      .date {
        color: #909399;
        font-size: 12px;
      }

      .content {
        color: #606266;
        font-size: 14px;
      }
    }
  }

  .notice-list {
    .notice-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
      padding: 0 20px;

      .notice-date {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-right: 15px;
        min-width: 60px;

        .day {
          font-size: 24px;
          font-weight: bold;
          color: #409EFF;
        }

        .month {
          font-size: 12px;
          color: #909399;
        }
      }

      .notice-title {
        font-size: 14px;
        text-align: left;
      }
    }
  }

  .campus-life-section {
    background-color: #005293;
    padding: 40px 0;

    .campus-title {
      text-align: center;
      color: white;
      margin-bottom: 30px;

      h2 {
        font-size: 32px;
        margin: 0;
      }

      p {
        font-size: 16px;
        margin: 5px 0 0;
        opacity: 0.8;
      }
    }

    .el-carousel {
      padding: 0 20px;

      .el-image {
        width: 100%;
        height: 100%;
        border-radius: 8px;
      }
    }
  }

  .special-websites {
    padding: 20px;
    background-color: #f0f2f5;

    .section-title {
      font-size: 24px;
      color: #2c3e50;
      margin-bottom: 30px;
    }

    .site-card {
      margin-bottom: 20px;
      border-radius: 8px;
      overflow: hidden;

      .site-image {
        height: 150px;
        width: 100%;
      }

      .site-title {
        color: white;
        padding: 10px;
        text-align: center;
        font-size: 14px;
      }
    }
  }

  .bottom-nav {
    background-color: #f8f9fa;
    padding: 20px 0;
    border-top: 1px solid #eee;

    .nav-item {
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        transform: translateY(-2px);
      }

      i {
        font-size: 24px;
        margin-bottom: 8px;
        display: block;
      }

      span {
        font-size: 14px;
        display: block;
      }
    }
  }
}
</style>
