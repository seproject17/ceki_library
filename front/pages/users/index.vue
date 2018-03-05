<template>
  <div>
      <el-table :data="users">
          <el-table-column
          label=""
          >
          <template slot-scope="{ row }">
              <img :src="row.avatar.url"/>
          </template>
          </el-table-column>
          <el-table-column
            prop="email"
            label="E-mail"
          ></el-table-column>
           <el-table-column
            prop="name"
            label="Имя"
          ></el-table-column>
          <el-table-column
            prop="surname"
            label="Фамилия"
          ></el-table-column>
          <el-table-column
            prop="role"
            label="Роль"
          ></el-table-column>
      </el-table>
  </div>
</template>

<script>
export default {
  name: 'users-index',
  async asyncData({ params, app }) {
      let users = await app.$axios.$get('/users')
      return { users }
  },
  data() {
      return {
          users: []
      }
  },
  mounted() {
      console.log(this.users)
  }
}
</script>
