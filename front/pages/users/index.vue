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
          <el-table-column label="Действия">
            <template slot-scope="{ row }">
              <el-button
                size="mini"
                @click="handleEdit(row.id)">?</el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(row.id)">X</el-button>
            </template>
          </el-table-column>
      </el-table>
        <el-button @click="showCreateUserModal">Создать пользователя</el-button>
        <smart-modal ref="create_user_modal" v-model="createUserModalData">
            <template slot="fields" slot-scope="props">
                Имя
                <el-input v-model="props.values.name" :placeholder="props.placeholders.name"></el-input>
                Фамилия
                <el-input v-model="props.values.surname" :placeholder="props.placeholders.surname"></el-input>
                E-mail
                <el-input v-model="props.values.email"
                          :placeholder="props.placeholders.email"></el-input>
                Пароль
                <el-input type="password" v-model="props.values.password" :placeholder="props.placeholders.password"></el-input>
                Права доступа
                <el-select v-model="props.values.role" placeholder="">
                  <el-option v-for="item in roles" :key="item.value" :label="item.label" :value="item.value"></el-option>
                </el-select>
            </template>
        </smart-modal>
  </div>
</template>

<script>
import SmartModal from '~/components/SmartModal.vue'
export default {
  name: 'users-index',
  async asyncData({ params, app }) {
      let users = await app.$axios.$get('/users')
      return { users }
  },
  data() {
      return {
          users: [],
          roles: [
            {value: 'visitor', label: 'Читатель'},
            {value: 'admin', label: 'Админ'},
            {value: 'librarian', label: 'Библиотекарь'}
          ],
            createUserModalData: {
                fields: {
                    name: { value: '', placeholder: 'Имя' },
                    surname: { value: '', placeholder: 'Фамилия' },
                    email: { value: '', placeholder: 'E-mail' },
                    password: { value: '', placeholder: 'Пароль' },
                    role: { value: '', placeholder: 'Права доступа' }
                },
            buttons: [
                {
                    label: 'Создать',
                    success({ name, surname, email, password, role }, store, modal) {

                        modal.$axios.$post('/users', {
                            name,
                            surname,
                            email,
                            password,
                            role
                        }).then((l) => {
                            console.log(l);
                            modal.close();
                        })
                    }
                }
            ]
        }
      }
  },
  mounted() {
      console.log(this.users)
  },
  methods: {
      showCreateUserModal() {
            console.log('JJ', this.$refs);
            // this.$refs.create_book_modal.updateInitialValues({
            //     title: '',
            //     author: ''
            // });
            this.$refs.create_user_modal.show();
        
      },
      handleEdit(userId) {},
      handleDelete(userId) {
        if (confirm('Точно удаляем?')) {
          this.$axios.$delete(`/users/${userId}`)
        }
      }
  },
  components: {
    SmartModal
  }
}
</script>
