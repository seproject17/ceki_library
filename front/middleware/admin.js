export default ({ store, redirect }) => {
    if (!store.getters.isAdmin) {
        redirect('/forbidden');
    }
};
