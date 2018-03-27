<template>
    <div class="books-page-container">
        <div class="books-container">
            <nuxt-link :to="{ name: 'books-id', params: { id: book.id} }"
                       class="book-item" v-for="book in books"
                       :key="book.id">
                <div class="book-image" :style="`background-image: url(${book.cover.url})`"></div>
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
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
            }

        }
        p {
            text-align: center;
            color: black;
            margin: 0;
        }
    }
</style>
<script>

export default {
    middleware: ['logged'],
    created() {
       this.loadBooksWithQuery(this.$route.query.query);

    },
    methods:{
      loadBooksWithQuery(query){
          console.log("loading book with query", query);
          this.$axios.$get('/books', {
              params: {
                  query: query
              }
          }).then(res => {
              console.log("RES" , res);
             // console.log("RES IS ", res, res.length);
              //et found = [];
              // res.forEach(el=>{
              //     console.log('ssss', el, query);
              //     if (el.isbn && el.isbn.indexOf(query) !== -1)
              //         found.push(el);
              //     if (el.author && el.author.indexOf(query) !== -1)
              //         found.push(el);
              //     if (el.title && el.title.indexOf(query) !== -1)
              //         found.push(el);
              //
              // });
              // console.log("RESULT IS BOOKS", found);
              this.books = res;//(!query || query.length === 0)? res : found;
          });
      }
    },
    data() {
        return {
            books: [],
            err: null,
            searchField: ''
        };
    },
    watch: {
        '$route.query': {
            handler(){
                this.loadBooksWithQuery(this.$route.query.query);
                console.log("QUERY CHANGED");
            },
            deep:true
        }
    }
};
</script>
