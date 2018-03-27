<template>
    <div class="reservations">
        <reservation-list-item  style="width:100%;" :key="reservation.id" v-for="reservation in reservations" :reserve-info="reservation"  :swipeable="swipeable" @decision-made="handleDecision" />
    </div>
</template>

<script>
import ReservationListItem from "~/components/ReservationListItem";

export default {
    components: {ReservationListItem},
    props:{
        swipeable:{
            type:Boolean,
            default:false
        },
        reservations: {
            type: Array,
            required: true
        }
    },
    methods:{
        handleDecision({borrowing, decision}){
            // let id = this.reservations.indexOf(val.reservation);
            console.log("HANDLE DECISION", borrowing, decision);
            this.$axios.post(`/borrowings/${borrowing.id}/${decision}`).then(res=>{
                console.log("AFTER AFTER res", res);
                this.$store.dispatch('loadBorrowings');
            })
            // this.$set(this.reservations[id],'accepted',val.accepted);
        }
    }
}
</script>

<style scoped>
    .reservations{
        display: flex;
        flex-direction: column;
        align-items: baseline;
    }
</style>
