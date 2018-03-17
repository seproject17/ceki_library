<template>
    <div>
        <h1 style="text-align: center">ЛИЧНЫЙ КАБИНЕТ</h1>
        <div style="display: flex; justify-content: center;align-items: center; height:100vh; margin-top:-37px;">
            <div>
                <div class="user-photo">

                </div>
                {{user}}

                <input type="file" @change="onFileChange">


            </div>

            <div style="padding-left:20px;">
                <p>{{user.name}}</p>
                <p>{{user.surname}}</p>
            </div>
        </div>
    </div>

</template>
<style lang="scss">
    .user-photo {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        background-color: red;
    }
</style>
<script>
let VueBase64FileUpload = null;
let components = {};
if (process.browser) {
    components['photo-upload'] = require('vue-base64-file-upload');
}


export default {
    middleware: ['logged'],

    computed: {
        user() {
            return this.$store.getters.currentUser;
        }
    },
    methods: {
        onFileChange(e) {
            //file object

            let files = e.target.files || e.dataTransfer.files;

            if (!files.length)
                return;

            let file = files[0];
            let size = file.size && file.size / Math.pow(1000, 2);

            // update file
            this.file = file;


            let reader = new FileReader();

            reader.onload = (e) => {
                let dataURI = e.target.result;

                if (dataURI) {
                    this.$emit('load', dataURI);
                    console.log('NEW DATA URI', dataURI);
                    this.preview = dataURI;
                    this.$axios.$put(`/users/${this.user.id}`, {avatar: dataURI}).then(res=>{
                        console.log("EEEEE", res);
                    })
                }
            };

            // read blob url from file data
            reader.readAsDataURL(file);
        }
    },
    mounted() {

    },
    data() {
        return {
            customImageMaxSize: 3,
            file: null// megabytes
        };
    },
    components
};
</script>
