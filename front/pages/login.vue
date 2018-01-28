<template>
	<div>
    Добро пожаловать в библиотеку ЦЭКИ!
  
  <div class="login-form">
    <el-input placeholder="Email" v-model="auth.email"></el-input>
    <el-input placeholder="Пароль" type="password" v-model="auth.password"></el-input>
    <el-button @click="tryAuth">Войти</el-button>
  </div>
  </div>
</template>
<script>
	export default {
    data() {
      return {
        auth: {
          email: '',
          password: ''
        }
      }
    },
    methods: {
      async tryAuth() {
        let resp = await this.$axios.post('/login')
        console.log(resp)
      }
    }
	}
</script>

<style lang="scss">
  .login-form {
    background-color: rgba(54, 55, 88, 0.4);
    padding: 5em;
  } 
</style>