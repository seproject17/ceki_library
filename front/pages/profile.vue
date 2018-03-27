<template>
    <div>
        <h1 style="text-align: center;padding-bottom:20px;">ЛИЧНЫЙ КАБИНЕТ</h1>
        <div style="display: flex; justify-content: center;align-items: center; margin-top:-37px;">
            <div>
                <div class="user-photo"
                     :style="{'background-image': `url(${user.avatar.url})`}">
                </div>
                <input type="file" @change="onFileChange">
            </div>

            <div style="padding-left:20px;">
                <string-editor :text="user.name" @save="updateName"></string-editor>
                <string-editor :text="user.surname" @save="updateSurname"></string-editor>
            </div>
        </div>

        <template v-if="userBorrowings.length > 0">
            <p>
                Заявки на книги
            </p>
            <el-table :data="userBorrowings"
                      style="width: 100%">
                <el-table-column
                        prop="id"
                        label="ID"
                        sortable
                        align="center"
                        width="100">
                </el-table-column>
                <el-table-column
                        prop="book"
                        label="Книга"
                        sortable
                        align="center">
                    <template slot-scope="scope">
                        {{`${scope.row.book.title} (id: ${scope.row.book.id})`}}
                    </template>
                </el-table-column>
                <el-table-column
                        prop="status"
                        label="Заявка"
                        sortable
                        width="200"
                        align="center">
                    <template slot-scope="scope">
                        {{scope.row.status}}
                    </template>
                </el-table-column>
            </el-table>
        </template>
        <div v-else>
            Вы пока не взяли ни одной книги
        </div>

    </div>

</template>
<style lang="scss">
    .user-photo {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
    }
</style>
<script>
import StringEditor from '~/components/StringEditor.vue';

let VueBase64FileUpload = null;
let components = { StringEditor };
if (process.browser) {
    components['photo-upload'] = require('vue-base64-file-upload');
}


export default {
    middleware: ['logged'],

    computed: {
        user() {
            return this.$store.getters.currentUser;
        },
        userBorrowings(){
            return this.$store.getters.currentUserBorrowings;
        }
    },
    async fetch ({ store, params }) {
        await store.dispatch('loadCurrentUserBorrowings');
    },
    methods: {
        updateName(name) {
            console.log('UPDATE NamE', name);
            this.$axios.$put(`/users/${this.user.id}`, { name }).then(res => {
                this.$store.commit('userLoaded', res);
            });
        },
        updateSurname(surname) {
            this.$axios.$put(`/users/${this.user.id}`, { surname }).then(res => {
                this.$store.commit('userLoaded', res);
            });
        },
        onFileChange(e) {
            //file object

            let files = e.target.files || e.dataTransfer.files;

            if (!files.length)
                return;

            let file = files[0];
            let size = file.size && file.size / Math.pow(1000, 2);

            // update file
            this.file = file;


            let reader = new FileReader();

            reader.onload = (e) => {
                let dataURI = e.target.result;

                if (dataURI) {
                    this.$emit('load', dataURI);
                    console.log('NEW DATA URI', dataURI);
                    this.preview = dataURI;
                    this.$axios.$put(`/users/${this.user.id}`, { avatar: dataURI }).then(res => {
                        console.log('EEEEE', res);
                        this.$store.commit('userLoaded', res);
                    });
                }
            };

            // read blob url from file data
            reader.readAsDataURL(file);
        }
    },
    mounted() {

    },
    data() {
        return {
            customImageMaxSize: 3,
            file: null// megabytes
        };
    },
    components
};
</script>
