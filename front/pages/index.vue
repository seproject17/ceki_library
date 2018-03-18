<template>
    <div class="books-page-container">
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
    }
};
</script>
