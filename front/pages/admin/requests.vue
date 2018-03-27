<template>
    <div>
        book requests
        {{requests}}
        <div style="display: flex;align-items: center">
            <reservations :reservations="requests" style="flex-grow: 0; width: 250px;"></reservations>
            <div style="flex-grow: 1;">

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
            }
        },
        components: {Reservations}
    }
</script>
