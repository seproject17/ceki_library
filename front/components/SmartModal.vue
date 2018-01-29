<template>
    <el-dialog class="modal-dialog-window"
               :visible.sync="opened"
               :fullscreen="fullScreen"
               :class="{'not-fullscreen' : !fullScreen}">
        <slot name="title" slot="title" :values="values">
            {{title}}
        </slot>
        <pre v-if="debug">
            {{values}}
            {{initialValues}}
        </pre>
        <slot name="fields"
              :values="values"
              :labels="labels"
              :placeholders="placeholders"
              :customData="modal_data.additional"
              :unique_id="unique_id">
            <div class="field" v-for="field in Object.keys(values)">
                <span v-if="labels[field]" class="label">{{labels[field]}}</span>
                <el-input v-model="values[field]"
                          :placeholder="placeholders[field]"></el-input>
            </div>
        </slot>
        <div slot="footer"
             class="dialog-footer">
            <slot name="buttons"
                  :values="values"
                  :buttons="modal_data.buttons"
                  :loading="loading"
                  :submit="submit">
                <el-button v-for="(btn, i) in modal_data.buttons"
                           :key="i"
                           :loading="loading"
                           :style="btn.style? btn.style : ''"
                           @click="submit(btn)"
                           :type="typeof btn.type === 'undefined' ? 'primary' : btn.type">{{btn.label}}
                </el-button>
            </slot>

        </div>
    </el-dialog>
</template>
<style lang="scss">
    .modal-dialog-window {
        &.not-fullscreen {
            .el-dialog {
                width: 50%;
                @media (max-width: 1050px) {
                    width: 65%;
                }
                @media (max-width: 700px) {
                    width: 75%;
                }
                @media (max-width: 450px) {
                    width: 97%;
                }
            }
        }
    }
</style>
<script>

export default {
    model: {
        prop: 'modal_data',
        event: 'changed'
    },
    props: {
        modal_data: { type: Object, required: true },
        title: { type: String, default: '' },
        signature: { type: String },
        debug: { type: Boolean, default: false },
        fullScreen: { type: Boolean, default: false }
    },
    data() {
        return {
            result: this.makeResult(),
            loading: false,
            errors: null,
            initialValues: {},
            placeholders: {},
            labels: {},
            values: {},
            unique_id: -1,
            sendOnlyIfNew: {},
            opened: false
        };
    },
    methods: {
        resetValues() {
            // console.log('kal', this.initialValues, this.modal_data.fields);
            Object.keys(this.modal_data.fields).forEach(key => {
                if (this.initialValues.hasOwnProperty(key)) {
                    console.log(`Reset values in modal ${key}, ${this.modal_data.fields[key].value}`);
                    this.modal_data.fields[key].value = this.initialValues[key];
                }
            });
        },
        updateInitialValues(newValues) {
            // console.log(newValues);
            Object.keys(this.modal_data.fields).forEach(key => {
                if (!this.initialValues.hasOwnProperty(key)) {
                    console.log(`Update initial value in modal ${key}, ${this.modal_data.fields[key].value}`);
                    this.$set(this.initialValues, key, this.modal_data.fields[key].value);
                }
            });
            Object.keys(newValues).forEach(key => {
                this.$set(this.initialValues, key, newValues[key]);
            });
        },
        makeResult() {
            const res = {};
            res.values = {};
            res.labels = {};
            res.placeholders = {};

            Object.keys(this.modal_data.fields).forEach(key => {
                res.values[key] = JSON.parse(JSON.stringify(this.modal_data.fields[key].value));
                res.labels[key] = this.modal_data.fields[key].label;
                res.placeholders[key] = this.modal_data.fields[key].placeholder;
            });
            res['unique_id'] = this.unique_id;
            // console.log('after making result', res);
            return res;
        },
        resetResult() {
            this.result = this.makeResult();
            this.placeholders = this.result.placeholders;
            this.values = this.result.values;
            this.labels = this.result.labels;
            Object.keys(this.modal_data.fields).forEach((key) => {
                this.sendOnlyIfNew[key] = this.modal_data.fields[key].sendOnlyIfNew;
            });
        },
        submit({ apply_vuex_action: vuexAction, success_msg: successMsg, success, failure, closingAfterSubmit = true }) {
            this.loading = true;
            if (vuexAction === undefined || vuexAction === null) {
                if (success)
                    success(this.values, this.$store, this);
                this.loading = false;
                return;
            }
            const reject = (err) => {
                // console.log('ERR rejecting', JSON.parse(JSON.stringify(err)));
                this.loading = false;
                if (err)
                    if (failure) {
                        failure(err, this.$store);
                    }
                    else {
                        console.log('err exists', err);
                    }
            };
            const requestData = {};
            // console.log(this.values);
            Object.keys(this.values).forEach(valueName => {
                // console.log('ss', this.sendOnlyIfNew);
                if (this.sendOnlyIfNew[valueName] && this.values[valueName] === this.initialValues[valueName])
                    return;
                requestData[valueName] = this.values[valueName];
            });
            console.log('request from modal', requestData, vuexAction);
            this.$store.dispatch(vuexAction, {
                unique_id: this.unique_id,
                ...(requestData)
            }).then(data => {
                console.log('AFTER REQUEST FROM MODAL', data);
                this.loading = false;
                if (success)
                    success(data, this.$store, this);
                this.$store.dispatch('showSuccessToast', successMsg);
                if (closingAfterSubmit)
                    this.close();
            }, reject);
        },
        show(bigArg) {
            let uniqueId;
            let tipsArgument;
            if (bigArg) {
                uniqueId = bigArg.uniqueId;
                tipsArgument = bigArg.tipsArgument;
            }

            this.unique_id = uniqueId;

            this.loading = false;
            this.resetValues();

            this.resetResult();
            this.opened = true;

            if (this.signature && this.signature in modalTips)
                this.$chooseTip(modalTips[this.signature], tipsArgument);
            return Promise.resolve();
        },
        close() {
            console.log('CLOSING');
            this.opened = false;
            this.$emit('close', this);
        }
    },
    computed: {
        error_description() {
            if (this.errors === null)
                return '';
            return this.errorsPrint(this.errors);
        }
    },
    watch: {
        modal_data: {
            deep: true,
            handler(newVal) {
                this.$emit('changed', newVal);
                this.resetResult();
            }
        }
    },
    mounted() {
        const requiredParams = ['fields', 'buttons'];
        requiredParams.forEach(param => {
            if (!this.modal_data.hasOwnProperty(param))
                throw new Error(`'${param}' property not found in modal_data (v-model)`);
        });
        this.resetResult();
    }
};
</script>
