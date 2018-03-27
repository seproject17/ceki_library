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

                    sortable>
                <template slot-scope="scope">
                    <template v-if="scope.row.tags.length>0">
                        <el-tag v-for="tag in scope.row.tags">
                            {{tag.name}}
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
                Макс. количество
                <div>
                    <el-input-number size="mini" v-model="props.values.max_count"></el-input-number>
                </div>
                Теги
                <div>
                    <el-select
                            v-model="props.values.tags"
                            multiple
                            filterable
                            allow-create
                            default-first-option
                            placeholder="выберите теги">
                    </el-select>
                </div>
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
                <div>ISBN</div>
                <el-input v-model="props.values.isbn" :placeholder="props.placeholders.isbn"></el-input>
                Макс. количество
                <div>
                    <el-input-number size="mini" v-model="props.values.max_count"></el-input-number>
                </div>
                Теги
                <div>
                    <el-select
                            v-model="props.values.tags"
                            multiple
                            filterable
                            allow-create
                            default-first-option
                            placeholder="выберите теги">
                    </el-select>
                </div>
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
                    publisher: { value: '', placeholder: 'Издательство' },
                    tags: { value: [] },
                    max_count: {value: 0}
                },
                buttons: [
                    {
                        label: 'Создать',
                        success({ title, author, description, isbn, publisher, tags, max_count }, store, modal) {

                            modal.$axios.$post('/books', {
                                title,
                                author,
                                annotations: description,
                                isbn,
                                publisher,
                                tags,
                                max_count
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
                    id: { value: 0 },
                    tags: { value: [] },
                    max_count: {value: []}
                },
                buttons: [
                    {
                        label: 'Сохранить',
                        success({ title, author, annotations, isbn, publisher, id, tags, max_count }, store, modal) {

                            modal.$axios.$put(`/books/${id}`, {
                                title,
                                author,
                                annotations,
                                isbn,
                                publisher,
                                tags,
                                max_count
                            }).then((l) => {
                                console.log(l);
                                modal.$message({
                                    message: 'Книга обновлена успешно',
                                    type: 'success'
                                });
                                store.dispatch('loadBooks');
                                modal.close();
                            });
                            console.log('Создано', title, author, annotations, modal, store);
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
                author: '',
                tags: [],
                max_count: 0
            });
            this.$refs.create_book_modal.show();
        },
        showUpdateBookModal({ title, author, annotations, isbn, publisher, id, tags,max_count }) {
            console.log('SHOW update book MODAL', { title, author, annotations, isbn, publisher, id, tags,max_count });
            let tagss = [];
            tags.forEach(tag=>tagss.push(tag.name));
            this.$refs.update_book_modal.updateInitialValues({ title, author, annotations, isbn, publisher, id, tags:tagss,max_count});
            this.$refs.update_book_modal.show();
        }

    },
    components: {
        SmartModal, Reservations
    }

};
</script>
