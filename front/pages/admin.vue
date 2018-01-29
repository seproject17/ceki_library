<template>
    <div class="admin-container">
        <div class="admin-page-content">
            <div class="admin-buttons">
                <el-button @click="showCreateBookModal">Добавить книгу</el-button>
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
    </div>
</template>

<script>
import SmartModal from '~/components/SmartModal.vue';

export default {
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
        }
    },
    components: {
        SmartModal
    }
};
</script>