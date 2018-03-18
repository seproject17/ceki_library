<template>
    <div class="admin-container">
        <div class="admin-page-content">
            <div class="admin-buttons">
                <el-button @click="showCreateBookModal">Добавить книгу</el-button>
                <el-button @click="showCreateUserModal">Создать пользователя</el-button>
                <reservations swipeable/>

            </div>
            <div class="admin-buttons-result">
            </div>
        </div>
        <smart-modal ref="create_book_modal" v-model="createBookModalData">
            <template slot="fields" slot-scope="props">
                Название
                <el-input v-model="props.values.title" :placeholder="props.placeholders.title"></el-input>
                Автор
                <el-input v-model="props.values.author" :placeholder="props.placeholders.author"></el-input>
                Описание
                <el-input type="textarea" v-model="props.values.description"
                          :placeholder="props.placeholders.description"></el-input>
                Издательство
                <el-input v-model="props.values.publisher" :placeholder="props.placeholders.publisher"></el-input>
                ISBN
                <el-input v-model="props.values.isbn" :placeholder="props.placeholders.isbn"></el-input>
            </template>
        </smart-modal>
        <smart-modal ref="create_user_modal" v-model="createUserModalData">
            <template slot="fields" slot-scope="props">
                Имя
                <el-input v-model="props.values.name" placeholder="Введите имя"></el-input>
                Фамилия
                <el-input v-model="props.values.surname" placeholder="Введите фамилию"></el-input>
                Почта
                <el-input v-model="props.values.email" placeholder="Введите почту"></el-input>
                Пароль для пользователя (может поменять в личном кабинете)
                <el-input v-model="props.values.password" placeholder="Введите пароль"></el-input>
            </template>
        </smart-modal>
    </div>
</template>

<script>
import SmartModal from '~/components/SmartModal.vue';
import Reservations from '~/components/Reservations'

export default {
    middleware: ['logged', 'admin'],
    data() {
        return {
            createBookModalData: {
                fields: {
                    title: { value: '', placeholder: 'Введите название книги' },
                    author: { value: '', placeholder: 'Укажите автора' },
                    description: { value: '', placeholder: 'Напишите описание' },
                    isbn: { value: '', placeholder: 'ISBN' },
                    publisher: { value: '', placeholder: 'Издательство' }
                },
                buttons: [
                    {
                        label: 'Создать',
                        success({ title, author, description, isbn, publisher }, store, modal) {

                            modal.$axios.$post('/books', {
                                title,
                                author,
                                annotations: description,
                                isbn,
                                publisher
                            }).then((l) => {
                                console.log(l);
                                modal.close();
                            });
                            console.log('Создано', title, author, description, modal, store);
                        }
                    }
                ]
            },
            createUserModalData: {
                fields: {
                    name: { value: '' },
                    surname: { value: '' },
                    email: { value: ''},
                    password: { value: ''},
                },
                buttons: [
                    {
                        label: 'Создать',
                        success({ name, surname, email, password }, store, modal) {

                            modal.$axios.$post(`/users`, {
                                name,
                                surname,
                                email,
                                password
                            }).then((l) => {
                                console.log("USER CREATED", l);
                                modal.close();
                            });
                        }
                    }
                ]
            }
        };
    },
    methods: {
        showCreateBookModal() {
            console.log('SHOW CREATE BOOK MODAL');
            console.log('JJ', this.$refs);
            this.$refs.create_book_modal.updateInitialValues({
                title: '',
                author: ''
            });
            this.$refs.create_book_modal.show();
        },
        showCreateUserModal(){
            console.log('SHOW CREATE user MODAL');
            console.log('JJ', this.$refs);
            this.$refs.create_user_modal.updateInitialValues({
                name: '',
                surname: '',
                email:'',
                password: ''
            });
            this.$refs.create_user_modal.show();
        }
    },
    components: {
        SmartModal, Reservations
    }
};
</script>
