import axios from 'axios';

const state = () => ({
    user: null,
    pathnames: null,
    userLikes: null,
    cart: null,
    allProducts: null,
    wishlist: null,
    userData: null,
    book: null,
    reviews: [],
    books: [],
    users: [],
    userBorrowings: [],
    borrowings: []
});
const getters = {
    currentUser: ({ user }) => user,
    isLogged: ({ user }) => user !== null,
    isAdmin: (state, { currentUser }) => currentUser && currentUser.role === 'admin',
    currentUserData: state => state.userData,
    fetchCart: state => state.cart,
    getAllProducts: state => state.cart,
    currentBook: state => state.book,
    currentReviews: state => state.reviews,
    currentUserBorrowings: state => state.userBorrowings,
    allBooks: state => state.books,
    allUsers: state => state.users,
    allBorrowings: state => state.borrowings
};
const actions = {
    loadUser({ commit }) {
        return this.$axios.get('/users/current').then(({ data }) => {
            commit('userLoaded', data);
        });
    },
    loadUsers({ commit }) {
        return this.$axios.$get('/users').then((data) => {
            commit('usersLoaded', data);
        });
    },
    logout({ commit }) {
        return this.$axios.post('/users/logout').then(res => {
            commit('userLoaded', null);
        });
    },
    loadBooks({ commit }) {
        return this.$axios.$get('/books').then(res => {
            commit('booksLoaded', res);
        });
    },
    loadBook({ commit }, bookId) {
        return this.$axios.$get(`/books/${bookId}`).then((res) => {
            commit('bookLoaded', res);
        });
    },
    loadReviews({ commit }, bookId) {
        return this.$axios.$get(`/books/${bookId}/reviews`).then((res) => {
            commit('reviewsLoaded', res);
        });
    },
    loadCurrentUserBorrowings({ commit, state }) {
        return this.$axios.$get(`/users/${state.user.id}/borrowings`).then(res => {
            commit('currentUserBorrowingsLoaded', res);
        });
    },
    loadBorrowings({ commit }) {
        return this.$axios.$get('/borrowings').then(res => {
            commit('allBorrowingsLoaded', res);
        });
    }
};
const mutations = {
    booksLoaded(state, books) {
        state.books = books;
    },
    userLoaded(state, user) {
        state.user = user;
    },
    usersLoaded(state, users) {
        state.users = users;
    },
    reviewsLoaded(state, reviews) {
        state.reviews = reviews;
    },
    bookLoaded(state, book) {
        state.book = book;
    },
    currentUserBorrowingsLoaded(state, borrowings) {
        console.log('currentUser borrowings cokmmit', borrowings);
        state.userBorrowings = borrowings;
    },
    allBorrowingsLoaded(state, borrowings) {
        state.borrowings = borrowings;
    }
};
export default {
    state,
    getters,
    actions,
    mutations
};
