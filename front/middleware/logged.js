export default ({ store, redirect }) => {
    if (!store.getters.isLogged) {
        redirect('/login');
    }
};
