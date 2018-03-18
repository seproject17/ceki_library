<template>
    <div class="editable-field">
        <div class="editable-container" v-if="isEditing">
            <el-input
                    v-model="editingText"
                    style="flex-grow: 1;"></el-input>
            <span style="padding-left:10px;">
                 <i class="el-icon-circle-check apply-icon"
                    @click="save"></i>
                <i class="el-icon-circle-close cancel-icon"
                   @click="isEditing = false"></i>
            </span>
        </div>
        <div class="editable-container" v-else>
            <span>{{text}}</span>
            <span v-if="controlsVisible">
                <i class="el-icon-edit-outline edit-icon"
                   @click="startEditing"></i>
                <i class="el-icon-remove delete-icon" v-if="showDelete"
                   @click="$emit('remove')"></i>
            </span>

        </div>
    </div>
</template>
<style lang="scss">
    .editable-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .edit-icon {
        color: red;
        cursor: pointer;
        font-size: 1.5em;
        &:hover {
            color: #821100;
        }
    }

    .apply-icon {
        color: limegreen;
        cursor: pointer;
        font-size: 1.5em;
        &:hover {
            color: green;
        }
    }

    .cancel-icon {
        color: red;
        cursor: pointer;
        font-size: 1.5em;
        &:hover {
            color: #821100;
        }
    }

    .delete-icon {
        color: red;
        cursor: pointer;
        font-size: 1.5em;
        &:hover {
            color: #821100;
        }
    }
</style>
<script>
export default {
    props: {
        controlsVisible: { default: true },
        text: { required: true },
        showDelete: { default: false }
    },
    data() {
        return {
            isEditing: false,
            editingText: ''
        };
    },
    methods: {
        startEditing() {
            this.editingText = this.text;
            this.isEditing = true;
        },
        save(){
            this.$emit('save', this.editingText);
            this.isEditing = false;
        }

    }

};
</script>
