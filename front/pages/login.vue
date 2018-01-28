<template>
	<div>
  <div class="login-form">
    <h1>Добро пожаловать в библиотеку ЦЭКИ!</h1>
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
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;

    height: 300px;
    max-width: 800px;

    background-color: rgba(54, 55, 88, 0.4);
    padding: 5em;

    margin: auto;
    text-align: center;

    h1 {
      color: white;
    }
  } 
</style>