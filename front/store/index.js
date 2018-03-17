import cookieparser from 'cookieparser'

import Vuex from 'vuex';
import Vue from 'vue';

Vue.use(Vuex);
import mainModule from './modules/main';

const modules = {
    main: mainModule
};
const state = {
    test: 'net'
};
const actions = {
    nuxtServerInit({commit, dispatch}, {req}) {
        if (req.headers.cookie){
           let cookieJSON = cookieparser.parse(req.headers.cookie);
           if (cookieJSON.token) {
               commit('testAdd',  cookieJSON.token);
               this.$axios.setHeader('Authorization', cookieJSON.token);
               return this.$axios.get('http://api:3000/users/current').then(({ data }) => {
                   commit('userLoaded', data);
               });
           }


        }


    },
    nuxtClientInit({ dispatch, getters }) {

        //return dispatch('loadUser');

    }
};
const mutations = {
    testAdd(state, add) {
        state.test = add;
    }
};
const getters = {
    tttt: (state) => {
        return state.test;
    }
};

const createStore = () => new Vuex.Store({
    modules,
    actions,
    state,
    mutations,
    getters
});

export default createStore;
