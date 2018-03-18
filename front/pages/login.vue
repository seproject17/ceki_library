<template>
    <div>
        <div class="login-form">
            <h1>Добро пожаловать в библиотеку ЦЭКИ!</h1>
            <el-input placeholder="Email" v-model="auth.email"></el-input>
            <el-input placeholder="Пароль" type="password" v-model="auth.password"></el-input>
            <el-button @click="tryAuth">Войти</el-button>
            <!--{{$store.getters}}-->
            <span class="error" v-if="error">Ошибка авторизации</span>
        </div>
    </div>
</template>
<script>
export default {
    layout: 'login',
    middleware: ['not-logged'],
    data() {
        return {
            auth: {
                email: '',
                password: ''
            },
            error: false
        };
    },
    methods: {
        async tryAuth() {
            this.error = false;
            try {
                let resp = await this.$axios.post('/users/login', this.auth);
                this.$axios.setHeader('Authorization', resp.token);
                await this.$store.dispatch("loadUser");
                this.$router.push('/');
            } catch (e) {
                this.error = true;
            }
        }
    }
};
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

        margin: 150px auto;
        text-align: center;

        h1 {
            color: white;
        }

        .error {
            color: red;
        }
    }
</style>
