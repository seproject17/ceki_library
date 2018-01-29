<template>
  <div class="book-detail">
    <div class="flex-1">
     <img class="cover" src="/book.png" />
      <div class="title">{{ book.title }}</div>
      <div class="author">{{ book.author }}</div>
    </div>
    <div class="flex-2">
      <div class="annotations">
        {{ book.annotations }}
      </div>
      <div class="control">
        <div>В наличии <el-tag>0</el-tag></div>
        <div><el-button>Скачать</el-button></div>
        <div><el-button>Написать рецензию</el-button></div>
        <div><el-button>Заявка на выдачу</el-button></div>
        <!-- <el-button>У кого?</el-button> -->
      </div>
    </div>
</div>
</template>

<script>
import axios from 'axios'
  export default {
    validate ({ params }) {
      return /^\d+$/.test(params.id)
    },
    async asyncData({ params, app, error }) {
      let book = await app.$axios.$get(`/books/${params.id}`)
      return { book }
    },
    data() {
      return {
        book: {}
      }
    }
  }
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