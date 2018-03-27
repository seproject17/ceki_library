<template>
    <div>
        <div class="admin-buttons-result" style="padding-bottom:20px;">
            <div class="admin-buttons">
                <el-button @click="showCreateBookModal" icon="el-icon-plus">Книга</el-button>
            </div>
        </div>
        <el-table
                @row-click="showUpdateBookModal"
                :data="books"
                style="width: 100%">
            <el-table-column
                    prop="isbn"
                    label="isbn"
                    sortable
                    align="center"
                    width="100">
            </el-table-column>

            <el-table-column
                    prop="title"
                    sortable
                    align="center"

                    label="Название"
                    width="250">
                <template slot-scope="scope">
                    <div v-if="scope.row.title">{{scope.row.title}}</div>
                    <div v-else>
                        без названия
                    </div>
                </template>
            </el-table-column>
            <el-table-column
                    prop="author"
                    sortable
                    align="center"

                    label="Автор"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="max_count"
                    label="Всего (шт)"
                    sortable
                    align="center"

                    width="100">
            </el-table-column>
            <el-table-column
                    prop="available_count"
                    label="Доступно (шт)"
                    sortable
                    align="center"

                    width="100">
            </el-table-column>
            <el-table-column
                    prop="publisher"
                    label="Издатель"
                    sortable
                    align="center"

                    width="300">
            </el-table-column>
            <el-table-column
                    prop="year"
                    sortable
                    width="100"
                    align="center"

                    label="Год">
            </el-table-column>
            <el-table-column
                    prop="tags"
                    label="Теги"
                    align="center"

                    sortable
                    width="100">
                <template slot-scope="scope">
                    <template v-if="scope.row.tags.length>0">
                        <el-tag v-for="tag in scope.row.tags">
                            {{tag}}
                        </el-tag>
                    </template>
                    <div v-else>
                        без тегов
                    </div>
                </template>
            </el-table-column>
        </el-table>
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
        <smart-modal ref="update_book_modal" v-model="updateBookModalData">
            <template slot="fields" slot-scope="props">
                Название
                <el-input v-model="props.values.title" :placeholder="props.placeholders.title"></el-input>
                Автор
                <el-input v-model="props.values.author" :placeholder="props.placeholders.author"></el-input>
                Описание
                <el-input type="textarea" v-model="props.values.annotations"
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
import Reservations from '~/components/Reservations';

export default {
    layout: 'admin',
    middleware: ['logged', 'admin'],
    async fetch({ store, params }) {
        await store.dispatch('loadBooks');
    },
    computed: {
        books() {
            return this.$store.getters.allBooks;
        }
    },
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
            }, updateBookModalData: {
                fields: {
                    title: { value: '', placeholder: 'Введите название книги' },
                    author: { value: '', placeholder: 'Укажите автора' },
                    annotations: { value: '', placeholder: 'Напишите описание' },
                    isbn: { value: '', placeholder: 'ISBN' },
                    publisher: { value: '', placeholder: 'Издательство' },
                    id: { value: 0 }
                },
                buttons: [
                    {
                        label: 'Сохранить',
                        success({ title, author, description, isbn, publisher, id }, store, modal) {

                            modal.$axios.$put(`/books/${id}`, {
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
        },
        showUpdateBookModal({ title, author, annotations, isbn, publisher, id }) {
            console.log('SHOW update book MODAL', { title, author, annotations, isbn, publisher,id });
            this.$refs.update_book_modal.updateInitialValues({ title, author, annotations, isbn, publisher, id});
            this.$refs.update_book_modal.show();
        }

    },
    components: {
        SmartModal, Reservations
    }

};
</script>
