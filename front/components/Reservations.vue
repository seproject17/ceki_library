<template>
    <div class="reservations">
        <button @click="updateData">Add</button><br><br>
        <reservation-list-item  style="width:100%;" :key="i" v-for="(reservation, i ) in reservations" :reserve-info="reservation"  :swipeable="swipeable" @accept="handleAccept" />
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
        updateData(){
            this.reservations.push( {'number':4,'name':'mo7a','dateTime':0});
        },
        handleAccept(val){
            let id = this.reservations.indexOf(val.reservation);
            this.$set(this.reservations[id],'accepted',val.accepted);
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
