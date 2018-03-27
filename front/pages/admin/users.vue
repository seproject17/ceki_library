<template>
    <div>
        <div class="admin-buttons-result" style="padding-bottom:20px;">
            <div class="admin-buttons">
                <el-button @click="showCreateUserModal" icon="el-icon-plus">Пользователь</el-button>
            </div>
        </div>
        <el-table
                :data="users"
                style="width: 100%"
                @row-click="showUpdateUserModal">
            <el-table-column
                    prop="id"
                    label="ID"
                    sortable
                    align="center"
                    width="100">
            </el-table-column>
            <el-table-column
                    prop="name"
                    label="Имя"
                    sortable
                    align="center">
            </el-table-column>

            <el-table-column
                    prop="surname"
                    sortable
                    align="center"

                    label="Фамилия">
            </el-table-column>
            <el-table-column
                    prop="email"
                    sortable
                    align="center"

                    label="Почта"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="role"
                    label="Роль"
                    sortable
                    align="center"

                    width="100">

            </el-table-column>

        </el-table>
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
        <smart-modal ref="update_user_modal" v-model="updateUserModalData">
            <template slot="fields" slot-scope="props">
                Имя
                <el-input v-model="props.values.name" placeholder="Введите имя"></el-input>
                Фамилия
                <el-input v-model="props.values.surname" placeholder="Введите фамилию"></el-input>
            </template>
        </smart-modal>
    </div>
</template>
<script>
import SmartModal from '~/components/SmartModal.vue';
import Reservations from '~/components/Reservations'
export default {
    layout: 'admin',
    middleware: ['logged', 'admin'],
    async fetch({ store, params }) {
        await store.dispatch('loadUsers');
    },
    computed: {
        users() {
            return this.$store.getters.allUsers;
        }
    },
    data() {
        return {
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
            },
            updateUserModalData: {
                fields: {
                    name: { value: '' },
                    surname: { value: '' },
                    id: { value : 0 }
                },
                buttons: [
                    {
                        label: 'Удалить',
                        success({ name, surname, email, password, id }, store, modal) {
                            modal.$confirm('Вы уверены?', 'Внимание', {
                                confirmButtonText: 'Да',
                                cancelButtonText: 'Нет',
                                type: 'warning'
                            }).then(() => {
                                modal.$axios.$delete(`/users/${id}`).then((l) => {
                                    modal.$message({
                                        message: 'Пользователь удален успешно',
                                        type: 'success'
                                    });
                                    store.dispatch("loadUsers");
                                    modal.close();
                                });
                            });

                        }
                    },
                    {
                        label: 'Сохранить',
                        success({ name, surname, email, password, id }, store, modal) {

                            modal.$axios.$put(`/users/${id}`, {
                                name,
                                surname,
                            }).then((l) => {
                                modal.$message({
                                    message: 'Пользователь обновлен успешно',
                                    type: 'success'
                                });
                                store.dispatch("loadUsers");
                                modal.close();
                            });
                        }
                    }
                ]
            }
        };
    },
    methods: {
        showCreateUserModal(){
            console.log('SHOW CREATE user MODAL');
            console.log('JJ', this.$refs);
            this.$refs.create_user_modal.updateInitialValues({
                name: '',
                surname: '',
                email:''
            });
            this.$refs.create_user_modal.show();
        },
        showUpdateUserModal({name, surname, id}){
            console.log('SHOW update user MODAL', {name, surname, id});
            console.log('JJ', this.$refs);
            this.$refs.update_user_modal.updateInitialValues({
                name,
                surname,
                id,
            });
            this.$refs.update_user_modal.show();
        },

    },
    components: {
        SmartModal, Reservations
    }

};
</script>
