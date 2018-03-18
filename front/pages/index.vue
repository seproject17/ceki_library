<template>
    <div class="books-page-container">
        <div class="top-bar-container">
            <div style="flex-grow: 1;">
                <el-input placeholder="Введите название, автора, isbn книги" v-model="searchField">
                    <template slot="append">
                        <el-button>Поиск</el-button>
                    </template>
                </el-input>
            </div>


            <div class="user-profile">
                <div class="user-profile-image"
                     :style="{'background-image': `url(${$store.getters.currentUser.avatar.url})`}">
                </div>

                <div style="display: flex; align-items: center; flex-direction: column;justify-content: center;">
                    <p style="margin:0;">{{$store.getters.currentUser.name}}</p>
                    <p style="margin:0;">{{$store.getters.currentUser.surname}}</p>
                    <el-button type="text" style="margin:0;padding:0;"
                               @click="$router.push('/profile')">Профиль
                    </el-button>
                    <el-button type="text" style="margin:0;padding:0;"
                               v-if="$store.getters.currentUser.role === 'admin'"
                               @click="$router.push('/admin')">Администрирование
                    </el-button>

                    <el-button type="text" style="margin:0;padding:0;" @click="logout">Выйти</el-button>
                </div>

            </div>
        </div>


        <div class="books-container">
            <nuxt-link :to="{ name: 'books-id', params: { id: book.id} }"
                       class="book-item" v-for="book in books"
                       :key="book.id">
                <div class="book-image"></div>
                <p>
                    {{book.title}}
                </p>
                <p>
                    {{book.author}}
                </p>
            </nuxt-link>
        </div>
    </div>
</template>
<style lang="scss">
    .books-page-container {
        font-size: 1px;
        max-width: 1200px;
        margin: auto;
        .top-bar-container {
            display: flex;
            justify-content: space-between;
            .user-profile {
                font-size: 15em;
                margin-left: 20px;
                display: flex;
                .user-profile-image {
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    background-repeat: no-repeat;
                    background-size: cover;
                    background-position: center;
                }
            }
        }
    }

    .books-container {
        display: flex;
        font-size: 17em;
        justify-content: center;
        flex-wrap: wrap;
        .book-item {
            flex-basis: 20%;
            margin: 10px;
            text-decoration: none;
            .book-image {
                height: 200px;
                width: 150px;
                margin: auto;
                background: url(/book.png) center center;
                background-size: contain;
                background-repeat: no-repeat;
            }

        }
        p {
            text-align: center;
            color: white;
            margin: 0;
        }
    }
</style>
<script>

export default {
    middleware: ['logged'],
    created() {
        this.$axios.$get('/books').then(res => {
            this.books = res;
        });
    },
    data() {
        return {
            books: [],
            err: null,
            searchField: ''
        };
    },
    methods: {
        bug() {
            this.$axios.get('/users').then(res => {
                console.log('LLLL', res);
            });

        },
        async logout() {
            await this.$store.dispatch('logout');
            this.$router.push('/login');

        }
    }
};
</script>
