<template>
    <transition name="slide-fade" appear>
        <no-ssr>
            <v-touch @pan="move" @panstart="startMove" @panend="stopMove" @pancancel="stopMove" @tap="select">
                <div v-bind:style="{'transform':this.transform}" class="reservation-list-item"
                     :class="{ selected:this.selected, accepted:accepted!=null&&accepted===true, declined:accepted!=null&&accepted===false }">
                    Запрос №{{reserveInfo.id}}<br>
                    от пользователя: <strong>{{reserveInfo.user.name}}</strong>
                    {{formattedDateTime}}
                    <div class="reservation-buttons-container" v-if="(!this.swipeable)&&accepted==null">
                        <div class="reservation-button accept" @click.stop="acceptReservation">принять</div>
                        &nbsp;
                        <div class="reservation-button decline" @click.stop="declineReservation">отклонить</div>
                    </div>
                </div>
            </v-touch>
        </no-ssr>

    </transition>
</template>

<script>
export default {
    props: {
        swipeable: Boolean,
        reserveInfo: {
            type: Object,
            required: false,
            default: function () {
                return { number: 1, name: 'Keker', dateTime: 0 };
            }
        }
    },
    data() {
        return {
            selected: false,
            swiping: false,
            transform: 'translate3d(0)'
        };

    },
    methods: {
        startMove(a) {
            if (!this.swipeable)
                return;
            this.swiping = true;
            if (this.accepted == null)
                this.transform = 'translate3d(0px,0px,0px)';
        },
        stopMove(a) {
            if (!this.swipeable)
                return;
            if (this.accepted == null)
                if (a.deltaX > 100)
                    this.acceptReservation();
                else if (a.deltaX < -100)
                    this.declineReservation();
            this.swiping = false;
            this.transform = 'translate3d(0px,0px,0px)';
        },
        move(a) {
            if (!this.swipeable)
                return;
            this.swiping = true;
            if (this.accepted == null) {
                this.transform = 'translate3d(' + (a.deltaX) + 'px,0px,0px)';
            }
        },
        select() {
            if (!this.swiping)
                this.selected = !this.selected;
        },
        acceptReservation() {
            this.$emit('decision-made', { borrowing: this.reserveInfo, 'decision': 'accept' });
        },
        declineReservation() {
            this.$emit('decision-made', { borrowing: this.reserveInfo, 'decision': 'reject' });
        }
    },
    beforeCreate(a) {
        console.log(a);
    },
    computed: {
        accepted() {
            return this.reserveInfo.accepted;
        },
        formattedDateTime() {
            let date = new Date(this.reserveInfo.created_at);
            let months = ['янв.', 'фев.', 'мар.', 'апр.', 'май', 'июнь', 'июль', 'авг.', 'сен.', 'окт.', 'нояб.', 'дек.'];
            return date.getDate() + ' ' + months[date.getMonth()] + ', ' + date.getFullYear() + ' г., ' + (date.getHours() >= 10 ? '' : '0') + date.getHours() + ':' + (date.getMinutes() >= 10 ? '' : '0') + date.getMinutes();
        }
    }
};
</script>

<style scoped>
    .reservation-list-item {
        display: flex;
        flex-direction: column;
        background-color: #fafafa;
        color: #444;
        margin-bottom: 10px;
        font-family: Roboto, serif;
        font-size: 11pt;
        box-shadow: rgba(0, 0, 0, 0.25) 0px 2px 5px;
        line-height: 20px;
        border: lightgray solid 1px;
        border-radius: 4px;
        /*cursor: grab;*/
        padding: 10px;
    }

    .reservation-button.reservation-button {
        cursor: pointer;
        font-size: 10pt;
        color: darkgray;
    }

    .reservation-button.reservation-button.decline:hover {
        cursor: pointer;
        font-size: 10pt;
        color: orangered;
    }

    .reservation-button.reservation-button.accept:hover {
        cursor: pointer;
        font-size: 10pt;
        color: green;
    }

    .reservation-buttons-container {
        display: flex;
        flex-direction: row;
        justify-content: flex-end;
    }

    .reservation-list-item.accepted {
        background-color: #f0fff0;
    }

    .reservation-list-item.declined {
        background-color: #f0f0f0;
    }

    .reservation-list-item.selected {
        background-color: #f0f0ff;
    }

    .slide-fade-enter-active {
        transition: all .3s ease;
    }

    .slide-fade-enter {
        transform: translateX(30px);
        opacity: 0;
    }
</style>
