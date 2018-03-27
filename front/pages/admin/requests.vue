<template>
    <div>
        <div style="display: flex;">
            <div>
                Необработанные заявки
                <reservations :reservations="requests" style="flex-grow: 0; width: 250px;"></reservations>
            </div>
            <div>
                <div style="padding-left:50px;">Обработанные заяки</div>
                <div style="flex-grow: 1;margin-left:50px;">
                    <el-table :data="answered"
                              style="width: 100%">
                        <el-table-column
                                prop="id"
                                label="ID"
                                sortable
                                align="center"
                                width="100">
                        </el-table-column>
                        <el-table-column
                                prop="name"
                                label="Пользователь"
                                sortable
                                width="200"
                                align="center">
                            <template slot-scope="scope">
                                {{`${scope.row.user.name} ${scope.row.user.surname}`}}
                            </template>
                        </el-table-column>
                        <el-table-column
                                prop="book"
                                label="Книга"
                                sortable
                                width="300"
                                align="center">
                            <template slot-scope="scope">
                                {{`${scope.row.book.title} (id: ${scope.row.book.id})`}}
                            </template>
                        </el-table-column>
                        <el-table-column
                                prop="status"
                                label="Заявка"
                                sortable
                                width="200"
                                align="center">
                            <template slot-scope="scope">
                                {{describedStatus(scope.row.status)}}
                            </template>
                        </el-table-column>
                        <el-table-column
                                prop="status"
                                label="Действия"
                                sortable
                                width="200"
                                align="center">
                            <template slot-scope="scope">
                                <template v-if="scope.row.status === 'accepted'">
                                    <el-button size="mini"
                                               @click="borrowBook(scope.row)">Выдать книгу</el-button>

                                </template>
                                <template v-if="scope.row.status ==='borrowed'">
                                    <el-button size="mini"
                                               @click="returnBook(scope.row)">Принять обратно</el-button>
                                </template>
                            </template>
                        </el-table-column>


                    </el-table>
                </div>
            </div>
        </div>

    </div>
</template>
<script>
import Reservations from '~/components/Reservations.vue'
    export default {
        layout: 'admin',
        middleware:['logged', 'admin'],
        async fetch({ store, params }) {
            await store.dispatch('loadBorrowings');
        },
        computed:{
            borrowings(){
                return this.$store.getters.allBorrowings;
            },
            requests(){
                return this.borrowings.filter(el=>el.status === 'ordered');
            },
            answered(){
                return this.borrowings.filter(el=>el.status !== 'ordered');
            }
        },
        methods:{
            describedStatus(status){
                if (status === 'accepted')
                    return 'Принята';
                if (status === 'rejected')
                    return 'Отклонена';
                if (status === 'borrowed')
                    return 'На руках';
                if (status === 'returned')
                    return 'Возвращена';
                return status;
            },
            borrowBook({book_id, id}){
                console.log("BOOK BORROW",book_id);
                this.$axios.$post(`/borrowings/${id}/borrow`).then(res=>{
                    console.log("Borrowing выдана", res);
                    this.$message({type: 'success', message: 'Книга помечена как выданная'});
                    this.$store.dispatch('loadBorrowings');
                })
            },
            returnBook({book_id, id}){
                this.$axios.$post(`/borrowings/${id}/return`).then(res=>{
                    console.log("Borrowing вернулась", res);
                    this.$message({type: 'success', message: 'Книга помечена как вернувшаяся в библиотеку'});
                    this.$store.dispatch('loadBorrowings');

                });
            }
        },
        components: {Reservations}
    }
</script>
