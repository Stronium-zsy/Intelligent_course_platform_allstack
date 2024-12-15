<template>
  <div id="main-container">
    <!-- 宽屏模板 -->
    <div v-if="!isWideScreen" class="login">
      <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
        <h3 class="title">已有账号登录</h3>
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            auto-complete="off"
            placeholder="账号"
          >
            <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            auto-complete="off"
            placeholder="密码"
            @keyup.enter.native="handleLogin"
          >
            <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
          </el-input>
        </el-form-item>
        <el-form-item prop="code" v-if="captchaEnabled">
          <el-input
            v-model="loginForm.code"
            auto-complete="off"
            placeholder="验证码"
            style="width: 63%"
            @keyup.enter.native="handleLogin"
          >
            <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
          </el-input>
          <div class="login-code">
            <img :src="codeUrl" @click="getCode" class="login-code-img"/>
          </div>
        </el-form-item>
        <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
        <el-form-item style="width:100%;">
          <el-button
            :loading="loading"
            size="medium"
            type="primary"
            style="width:100%;"
            @click.native.prevent="handleLogin"
          >
            <span v-if="!loading">登 录</span>
            <span v-else>登 录 中...</span>
          </el-button>
          <div style="float: right;" v-if="register">
            <router-link class="link-type" :to="'/register'">立即注册</router-link>
          </div>
        </el-form-item>
      </el-form>
      <!-- 底部 -->
      <div class="el-login-footer">
        <span>
        管理员邮箱: zsiyu1725@gmail.com

      </span>
        <span>
            管理员保留网站所有权利 未经允许不得镜像，复制 ICP备: 京ICP备2024085810号
          </span>

      </div>
    </div>

    <!-- 原始模板 -->
    <div v-else class="login-container">
      <div class="user_options-container">
        <div class="user_options-text">
          <div class="user_options-unregistered">
            <h2 class="user_unregistered-title">还没有账户嘛？注册一个吧~</h2>
            <p class="user_unregistered-text">注册需填写用户名，密码，确认密码，验证码。</p>
            <button class="user_unregistered-signup" @click="showSignup">注册</button>
          </div>
          <div class="user_options-registered">
            <h2 class="user_registered-title">已经有账户了？去登陆吧~</h2>
            <p class="user_unregistered-text">登录需填写用户名以及密码</p>
            <button class="user_registered-login" @click="showLogin">登陆</button>
          </div>
        </div>
        <div class="user_options-forms" :class="{'bounceLeft': signupActive, 'bounceRight': !signupActive}">
          <div class="user_forms-login" v-if="!signupActive">
            <h2 class="forms_title">登录</h2>
            <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="forms_form">
              <el-form-item prop="username">
                <el-input v-model="loginForm.username" type="text" auto-complete="off" placeholder="账号">
                  <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
                </el-input>
              </el-form-item>
              <el-form-item prop="password">
                <el-input v-model="loginForm.password" type="password" auto-complete="off" placeholder="密码" @keyup.enter.native="handleLogin">
                  <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
                </el-input>
              </el-form-item>
              <el-form-item prop="code" v-if="captchaEnabled">
                <el-input v-model="loginForm.code" auto-complete="off" placeholder="验证码" style="width: 53%" @keyup.enter.native="handleLogin">
                  <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
                </el-input>
                <div class="login-code">
                  <img :src="codeUrl" @click="getCode" class="login-code-img" />
                </div>
              </el-form-item>
              <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
              <el-form-item style="width:100%;">
                <el-button :loading="loading" size="medium" type="primary" style="width:30%;float:right;" @click.native.prevent="handleLogin">
                  <span v-if="!loading">登 录</span>
                </el-button>
              </el-form-item>
            </el-form>
          </div>
          <div class="user_forms-signup" v-else>
            <h2 class="forms_title">注册</h2>
            <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="forms_form">
              <el-form-item prop="username">
                <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
                  <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
                </el-input>
              </el-form-item>
              <el-form-item prop="password">
                <el-input v-model="registerForm.password" type="password" auto-complete="off" placeholder="密码" @keyup.enter.native="handleRegister">
                  <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
                </el-input>
              </el-form-item>
              <el-form-item prop="confirmPassword">
                <el-input v-model="registerForm.confirmPassword" type="password" auto-complete="off" placeholder="确认密码" @keyup.enter.native="handleRegister">
                  <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
                </el-input>
              </el-form-item>
              <el-form-item prop="code" v-if="captchaEnabled">
                <el-input v-model="registerForm.code" auto-complete="off" placeholder="验证码" style="width: 63%" @keyup.enter.native="handleRegister">
                  <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
                </el-input>
                <div class="register-code">
                  <img :src="codeUrl" @click="getCode" class="register-code-img"/>
                </div>
              </el-form-item>
              <el-form-item style="width:100%;">
                <el-button :loading="loading" size="medium" type="primary" style="width:30%;float:right;" @click.native.prevent="handleRegister">
                  <span v-if="!loading">注 册</span>
                </el-button>
                <div style="float: right;">
                  <router-link class="link-type" @click.native.prevent="showLogin">使用已有账户登录</router-link>
                </div>
              </el-form-item>
            </el-form>
          </div>
        </div>
      </div>
    </div>
    <div class="el-login-footer">
        <span>
        管理员邮箱: zsiyu1725@gmail.com

      </span>
      <span>
            管理员保留网站所有权利 未经允许不得镜像，复制 ICP备: 京ICP备2024085810号
          </span>

    </div>
  </div>
</template>


<script>
import { getCodeImg, register } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'

export default {
  name: "Login",
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.registerForm.password !== value) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };
    return {
      isWideScreen: window.innerWidth > 798, // 新增属性，判断是否为宽屏
      signupActive: false,
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      registerForm: {
        username: "",
        password: "",
        confirmPassword: "",
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      registerRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" },
          { min: 2, max: 20, message: '用户账号长度必须介于 2 和 20 之间', trigger: 'blur' }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" },
          { min: 5, max: 20, message: "用户密码长度必须介于 5 和 20 之间", trigger: "blur" },
          { pattern: /^[^<>"'|\\]+$/, message: "不能包含非法字符：< > \" ' \\\ |", trigger: "blur" }
        ],
        confirmPassword: [
          { required: true, trigger: "blur", message: "请再次输入您的密码" },
          { required: true, validator: equalToPassword, trigger: "blur" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: true,
      redirect: undefined
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getCode();
    this.getCookie();
    window.addEventListener('resize', this.handleResize); // 添加窗口大小变化监听
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize); // 移除监听器
  },
  methods: {
    handleResize() {
      this.isWideScreen = window.innerWidth > 798;
    },
    showSignup() {
      this.signupActive = true;
    },
    showLogin() {
      this.signupActive = false;
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
          this.registerForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(() => {});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    },
    handleRegister() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true;
          register(this.registerForm).then(res => {
            const username = this.registerForm.username;
            this.$alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", '系统提示', {
              dangerouslyUseHTMLString: true,
              type: 'success'
            }).then(() => {
              this.loading=false;
              this.$router.push({ path: "/login" });
            }).catch(() => {});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          })
        }
      });
    }
  }
};
</script>


<style scoped lang="scss">
#main-container {
  height:100%;
}
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100vh;
  position: relative;
  overflow: hidden;
}

.login-container::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-size: cover;
  background:linear-gradient(to right bottom,#9B24A6,#3282F6);
  filter: blur(3px); /* 调整模糊度，值越大越模糊 */
  z-index: -1; /* 确保伪元素在内容后面 */
}
.user_options-container {
  position: relative;
  width: 80%;
}

.user_options-text {
  display: flex;
  justify-content: space-between;
  width: 100%;
  background-color: rgba(34, 34, 34, 0.85);
  border-radius: 3px;
}

.user_options-registered,
.user_options-unregistered {
  width: 50%;
  padding: 75px 45px;
  color: #fff;
  font-weight: 300;
}

.user_registered-title,
.user_unregistered-title {
  margin-bottom: 15px;
  font-size: 1.66rem;
  line-height: 1em;
}

.user_unregistered-text,
.user_registered-text {
  font-size: 0.83rem;
  line-height: 1.4em;
}

.user_registered-login,
.user_unregistered-signup {
  margin-top: 30px;
  border: 1px solid #ccc;
  border-radius: 3px;
  padding: 10px 30px;
  color: #fff;
  background-color: transparent;
  text-transform: uppercase;
  line-height: 1em;
  letter-spacing: 0.2rem;
  width: 30%;
}

.user_options-forms {
  position: absolute;
  top: 50%;
  left: 30px;
  width: calc(50% - 30px);
  min-height: 420px;
  background-color: #fff;
  border-radius: 3px;
  box-shadow: 2px 0 15px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  transform: translate3d(100%, -50%, 0);
  transition: transform 0.4s ease-in-out;
  padding-left: 10px;
  padding-right: 10px;
  &.bounceLeft {
    animation: bounceLeft 1s forwards;
  }
  &.bounceRight {
    animation: bounceRight 1s forwards;
  }
}

@keyframes bounceLeft {
  0% {
    transform: translate3d(100%, -50%, 0);
  }
  50% {
    transform: translate3d(-30px, -50%, 0);
  }
  100% {
    transform: translate3d(0, -50%, 0);
  }
}

@keyframes bounceRight {
  0% {
    transform: translate3d(0, -50%, 0);
  }
  50% {
    transform: translate3d(calc(100% + 30px), -50%, 0);
  }
  100% {
    transform: translate3d(100%, -50%, 0);
  }
}

.forms_title {
  margin-bottom: 45px;
  font-size: 1.5rem;
  font-weight: 500;
  line-height: 1em;
  text-transform: uppercase;
  color: #e8716d;
  letter-spacing: 0.1rem;
}

.el-input {
  height: 38px;
  width: 95%;
  input {
    border-radius: 5px;
    background-color: transparent;
    height: 38px;
  }
}

.input-icon {
  height: 39px;
  width: 14px;
  margin-left: 2px;
}
.register-code,
.login-code {
  width: 33%;
  height: 38px;
  float: right;
  transform: translateX(-30px);
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.register-code-img,
.login-code-img {
  height: 38px;
}

.el-register-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}

.user_forms-login,
.user_forms-signup{
  height:400px;
}
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background:linear-gradient(to right bottom,#9B24A6,#3282F6);
  background-size: cover;
}
.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #707070;
}

.login-form {
  border-radius: 6px;
  background-color:white;
  width: 400px;
  padding: 25px 25px 5px 25px;
  box-shadow: 2px 0 15px rgba(0, 0, 0, 0.25);
  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}
.login-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.login-code {
  width: 33%;
  height: 38px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.el-login-footer {
  height: 60px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
  display: flex;
  flex-direction: column;
  span{
    height:30px;
    top:0;
    bottom:5px;
  }

}
.login-code-img {
  height: 38px;
}
</style>
