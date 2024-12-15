<template>
  <div class="app-container">
    <div class="message-container">
      <div v-for="(message, index) in messageList" :key="index">
        <!-- 用户名容器 -->
        <div class="user-name-container">
          <div v-if="message.userId !== $store.getters.userId"
               class="user-name">
            <span>
              {{ message.userName }}
              </span>

          </div>
          <div v-if="message.userId === $store.getters.userId"
               class="user-name-self">
            <span>
              {{ message.userName }}
              </span>
          </div>
        </div>
        <!-- 他人的消息 -->
        <div v-if="message.userId !== $store.getters.userId" class="message-wrapper message-wrapper-other">
          <div class="message message-other">
            <p class="message-content">{{ message.messageDetail }}</p>
          </div>
        </div>
        <!-- 自己的消息 -->
        <div v-else class="message-wrapper message-wrapper-self">
          <div class="message message-self">
            <p class="message-content">{{ message.messageDetail }}</p>
          </div>
        </div>
      </div>
    </div>



      <el-input
        type="textarea"
        :rows="2"
        placeholder="请输入内容"
        v-model="textarea"
        class="text-input"
        @keyup.enter.native="handleAdd"
      >
      </el-input>



  </div>
</template>
<style>
.app-container{
  margin-left:200px;
  width:85%;
  height:100%;
  border-radius:5px;
  display:flex;
  flex-direction: column;
}

.text-input{
  width:90%;
  margin-left:5%;
  resize:none;
}
.message-container {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 90%;
  overflow-y: auto;
  padding: 10px;
}
.message-container::-webkit-scrollbar {
  width:0;
}

.message-wrapper {
  display: flex;
  margin-bottom: 10px;
  max-width: 100%; /* 父容器最大宽度 */
}

.message-wrapper-other {
  justify-content: flex-start; /* 他人的消息靠左 */
}

.message-wrapper-self {
  justify-content: flex-end; /* 自己的消息靠右 */
}

.message {
  max-width: 60%; /* 限制消息框宽度 */
  word-wrap: break-word; /* 自动换行 */
  word-break: break-word; /* 防止单词过长溢出 */
  padding: 10px;
  border-radius: 10px;
}

.message-self {
  background-color: #FFA726; /* 自己的消息背景颜色 */
}

.message-other {
  background: #4A90E2;
  /* 他人的消息背景颜色 */
}

.user-name-container {
  display: flex;
  margin-bottom: 5px; /* 用户名和消息之间的间距 */
}

.user-name {
  width:100%;
  font-size: 14px;
  color: #555;
  text-align: left;

}

.user-name-self {
  width:100%;
  font-size: 14px;
  color: #555;
  text-align: right; /* 用户名靠右 */
}


.input-container {
  width: 100%;
  height: 10%;
  justify-content: center;
  align-items: center;
  background: rgba(200, 200, 200, 0.3); /* 设置为浅灰色并增加透明度 */
  backdrop-filter: blur(10px); /* 添加模糊效果以模拟磨砂玻璃质感 */
  border-radius: 10px; /* 使边角变圆滑，增加磨砂的视觉效果 */
  border: 1px solid rgba(255, 255, 255, 0.2); /* 添加轻微的边框以更好地呈现层次感 */
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 添加一些阴影来强调元素的深度 */
}




</style>
<script>
import { listMessage, getMessage, delMessage, addMessage, updateMessage } from "@/api/system/message";
export default {
  name: "Message",
  data() {
    return {
      socket:"",
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      textarea:"",
      // 【请填写功能名称】表格数据
      messageList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 50,
        courseId: this.$router.currentRoute.params.courseId,
        userId: null,
        messageDetail: null,
        messageType: null,
        createdTime: null
      },
      // 表单参数
      form: {
        courseId:this.$router.currentRoute.params.courseId,
        messageDetail:null,
        messageType:"text",
      },
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
    this.initWebSocket();
  },
  methods: {
    addMessage,
    /** 查询【请填写功能名称】列表 */
    getList() {
      this.loading = true;
      listMessage(this.queryParams).then(response => {
        this.messageList = response.rows;
        console.log(this.messageList);
        this.total = response.total;
        this.loading = false;
      });
    },
    // watch: {
    //   messageList: {
    //     handler(newValue) {
    //       // 滚动到消息容器底部，确保最新消息可见
    //       this.$nextTick(() => {
    //         const container = this.$el.querySelector('.message-container');
    //         if (container) {
    //           container.scrollTop = container.scrollHeight;
    //         }
    //       });
    //     },
    //     deep: true, // 深度监听，确保对数组内对象的变动也生效
    //   }
    // },

    initWebSocket() {
      const wsuri = "ws://localhost:8080/ws/"+this.$store.getters.userId;  // WebSocket 服务器的 URI
      if (typeof WebSocket === "undefined") {     // 检查浏览器是否支持 WebSocket
        console.log("您的浏览器不支持WebSocket");
      } else {
        console.log(wsuri);
        // 创建 WebSocket 连接
        this.websock = new WebSocket(wsuri);
        // 设置 WebSocket 各种事件处理函数
        this.websock.onmessage = this.websocketonmessage; // 接收到消息时调用
        this.websock.onerror = this.websocketonerror; // 连接错误时调用
        this.websock.onclose = this.websocketclose; // 连接关闭时调用
      }
    },
    // 3.3连接建立失败重连
    websocketonerror() {
      this.initWebSocket();   // 重新初始化 WebSocket 连接
    },
    websocketonmessage(e) {
      try {
        // 解析收到的消息
        console.log("收到消息", e.data);
        const receivedMessage = JSON.parse(e.data);
        if(! receivedMessage.userId)
          return;

        // 使用响应式方法更新 messageList
        this.messageList.push(receivedMessage);

        // 确保滚动到消息容器底部
        this.$nextTick(() => {
          const container = this.$el.querySelector('.message-container');
          if (container) {
            container.scrollTop = container.scrollHeight;
          }
        });
      } catch (error) {
        console.error("Error parsing WebSocket message:", error);
      }
    },

    // 3.5向服务器发送数据
    websocketsend(Data) {
      this.websock.send(Data);   // 使用 WebSocket 连接发送数据
    },
    // 3.6WebSocket 连接关闭时调用
    websocketclose(e) {
      console.log('断开连接', e);   // 打印连接断开的信息
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        messageId: null,
        courseId: null,
        userId: null,
        messageDetail: null,
        messageType: null,
        createdTime: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.messageId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      if (this.textarea.trim() === "") {
        this.$modal.msgWarning("请输入内容");
        return;
      }

      // 限制消息长度
      if (this.textarea.length > 200) {
        this.$modal.msgWarning("消息长度不能超过 200 字符");
        return;
      }

      // 创建消息对象
      const newMessage = {
        messageDetail: this.textarea,
        userId: this.$store.getters.userId,
        userName: this.$store.getters.name || "我",
      };

      // 使用 WebSocket 发送消息
      this.websocketsend(JSON.stringify(newMessage));
      this.form.messageDetail = this.textarea;
      addMessage(this.form).then(response => {
        this.$nextTick(() => {
          const container = this.$el.querySelector('.message-container');
          if (container) {
            container.scrollTop = container.scrollHeight; // 滚动到底部
          }
        });
      });

      // 清空输入框
      this.textarea = "";
    },


    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const messageId = row.messageId || this.ids
      getMessage(messageId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改【请填写功能名称】";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.messageId != null) {
            updateMessage(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addMessage(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const messageIds = row.messageId || this.ids;
      this.$modal.confirm('是否确认删除【请填写功能名称】编号为"' + messageIds + '"的数据项？').then(function() {
        return delMessage(messageIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/message/export', {
        ...this.queryParams
      }, `message_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
