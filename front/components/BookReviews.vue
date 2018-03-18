<template>
    <div>
        <div v-for="review in reviews">
            <div class="review-item">
                <el-rate disabled v-model="review.mark"
                         :colors="['#99A9BF', '#F7BA2A', '#FF9900']">
                </el-rate>
                <h4>{{review.user.name}}, {{review.user.surname}}</h4>
            </div>
            <div v-if="review.comments">
                {{review.comments}}
            </div>
            <div v-else>
                Пользователь не оставил комментариев
            </div>

        </div>
    </div>
</template>
<style lang="scss">
    .review-item {
        display: flex;
        align-items: center;
    }
</style>
<script>
export default {
    props: {
        reviews: { required: true, type: Array }
    },
    mounted(){
        this.$axios.$get('/users').then(res=>{
           console.log("RESULT", res);
        });
    }
};
</script>
