import axios from 'axios';

const state = () => ({
    user: null,
    pathnames: null,
    userLikes: null,
    cart: null,
    allProducts: null,
    wishlist: null,
    userData: null
});
const getters = {
    currentUser: ({ user }) => user,
    isLogged: ({ user }) => user !== null,
    isAdmin: (state, { currentUser }) => currentUser && currentUser.role === 'admin',
    currentUserData: state => state.userData,
    fetchCart: state => state.cart,
    getAllProducts: state => state.cart
};
const actions = {
    loadUser({ commit }) {
        return axios.get('/api/users/current').then(({data}) => {
            commit('userLoaded', data);
        });
    },
    logout({commit}){
        return this.$axios.post('/users/logout').then(res => {
            commit('userLoaded', null);
        });
    }
};
const mutations = {
  userLoaded(state, user){
    state.user = user;
  }
};
export default {
    state,
    getters,
    actions,
    mutations
};
