<template>
    <div>
        <div class="book-detail">
            <div class="flex-1">
                <img class="cover" src="/book.png"/>
                <div class="title">{{ book.title }}</div>
                <div class="author">{{ book.author }}</div>
            </div>
            <div class="flex-2">
                <div class="annotations">
                    {{ book.annotations }}
                </div>
                <div class="control">
                    <div>
                        <div>В наличии
                            <el-tag>{{book.available_count}}</el-tag>
                        </div>
                        <el-button type="text" v-if="user.role === 'admin'" @click="changeBookCount">изменить количество</el-button>

                    </div>

                    <div>
                        <el-button>Скачать</el-button>
                    </div>
                    <div>
                        <el-button @click="writeReview">Написать рецензию</el-button>
                    </div>
                    <div>
                        <el-button @click="bookRequest">Заявка на выдачу</el-button>
                    </div>
                    <!-- <el-button>У кого?</el-button> -->
                </div>
            </div>
            <smart-modal ref="bookReviewModal" v-model="bookReviewModalData">
                <template slot="fields" slot-scope="props">
                    Текст рецензии
                    <el-input type="textarea" placeholder="Введите текст рецензии"
                              v-model="props.values.comments"></el-input>
                    Ваша оценка
                    <el-rate
                            v-model="props.values.mark"
                            :colors="['#99A9BF', '#F7BA2A', '#FF9900']">
                    </el-rate>
                </template>
            </smart-modal>

        </div>
        <h3>
            Рецензии
        </h3>
        <book-reviews :reviews="reviews">
        </book-reviews>
    </div>

</template>

<script>
import BookReviews from '~/components/BookReviews.vue';
import SmartModal from '~/components/SmartModal.vue';

export default {
    validate({ params }) {
        return /^\d+$/.test(params.id);
    },
    async fetch({ store, params }) {
        await store.dispatch('loadBook', params.id);
        await store.dispatch('loadReviews', params.id);
    },
    data() {
        return {
            bookReviewModalData: {
                fields: {
                    mark: { value: 0 },
                    comments: { value: '' },
                    book: { value: null }
                },
                buttons: [
                    {
                        label: 'Создать',
                        success({ mark, comments, book }, store, modal) {

                            modal.$axios.$post(`/books/${book.id}/review`, {
                                mark, comments
                            }).then((l) => {
                                store.dispatch('loadReviews', book.id).then(res => {
                                    modal.close();
                                    console.log('Создано', mark, comments, l);
                                });
                            });
                        }
                    }
                ]
            }
        };
    },
    methods: {
        writeReview() {
            console.log('WRITING REVIEW FOR VBOOk', this.book);
            this.$refs.bookReviewModal.updateInitialValues({
                comments: '',
                mark: 0,
                book: this.book
            });
            this.$refs.bookReviewModal.show();
        },
        bookRequest() {
            console.log('BOOK REQUEST', this.book);
            this.$axios.$post(`/books/${this.book.id}/borrow`).then(res => {
                console.log('REQUSST SENT ', res);
            });
        },
        changeBookCount(){
            this.$prompt('Введите новое количество книг', 'Tip', {
                confirmButtonText: 'OK',
                cancelButtonText: 'Cancel',
                inputPattern: /[0-9]+/,
                inputErrorMessage: 'должно быть числом!'
            }).then(({value}) => {
                this.$axios.$put(`/books/${this.book.id}`, {
                    max_count: value
                }).then(res=>{
                   console.log("CHANGE QUANTITY", res);
                    store.dispatch('loadBook', params.id);
                    this.$message({
                        type: 'success',
                        message: 'Успешно изменено на:' + value
                    });
                });

            });
        }
    },
    computed: {
        book() {
            console.log(this.$store.state);
            return this.$store.getters.currentBook;
        },
        reviews() {
            return this.$store.getters.currentReviews;
        },
        user() {
            return this.$store.getters.currentUser;
        }
    },
    components: {
        BookReviews, SmartModal
    }
};
</script>

<style lang="scss">
    .book-detail {
        display: flex;
        background-color: rgb(64, 57, 72);
        color: white;
        padding: 25px;

        .flex-1 {
            text-align: center;
        }

        .flex-2 {
            flex: 1 0 auto;
        }

        .cover, .annotations {
            height: 420px;
        }
        .annotation {
            padding: 15px;
        }

        .title, .author {

            font-size: 1.5em;
        }
        .author {
            font-style: italic;
        }

        .control {
            display: flex;
            justify-content: space-evenly;
        }
    }
</style>
