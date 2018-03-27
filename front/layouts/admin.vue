<template>
    <div class="ceki-library">
        <div class="top-bar-container" style="margin-bottom:20px;">

            <div>
                <el-menu mode="horizontal" router>
                    <el-menu-item index="/admin">Общее</el-menu-item>
                    <el-menu-item index="/admin/users" disabled>Пользователи</el-menu-item>
                    <el-menu-item index="/admin/books" disabled>Книги</el-menu-item>
                </el-menu>
            </div>





            <div class="user-profile">
                <div class="user-profile-image"
                     :style="{'background-image': `url(${$store.getters.currentUser.avatar.url})`}">
                </div>

                <div style="display: flex; align-items: center; flex-direction: column;justify-content: center;">
                    <p style="margin:0;">{{$store.getters.currentUser.name}}</p>
                    <p style="margin:0;">{{$store.getters.currentUser.surname}}</p>
                    <el-button type="text" style="margin:0;padding:0;" @click="logout">Выйти</el-button>
                </div>

            </div>
        </div>
        <nuxt></nuxt>
    </div>
</template>
<script>
export default {
    methods: {
        async logout() {
            await this.$store.dispatch('logout');
            this.$router.push('/login');

        }
    },
    data(){
        return {searchField: ''}
    }
}
</script>

<style lang="scss">
    body {
        background-color: rgb(200, 180, 230);
    }
    .top-bar-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color:white;
        .user-profile {
            font-size: 15px;
            margin-left: 20px;
            margin-right: 20px;
            display: flex;
            align-items: center;
            .user-profile-image {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                margin-right:20px;
            }
        }
    }
</style>
