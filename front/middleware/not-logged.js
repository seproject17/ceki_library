export default ({ store, redirect }) => {
    console.log("ALLALALA");
    if (store.getters.isLogged) {
        redirect('/');
    }
};
