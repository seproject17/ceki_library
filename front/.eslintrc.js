module.exports = {
  parserOptions: {
    parser: 'babel-eslint',
    ecmaVersion: 8,
    sourceType: 'module'
  },
  env: {
    browser: true,
  },
  extends: ['standard', 'plugin:vue/strongly-recommended'],
  rules: {
    'no-mixed-operators': 'off',
    'no-undef': 'off',
    'eol-last': 'off',
    'no-floating-decimal': 'off',
    'space-before-function-paren': 'off',
    'no-new': 'off',
    'no-unmodified-loop-condition': 'off',
    'no-unused-vars': 'warn',
    'no-trailing-spaces': 'warn',
    'generator-star-spacing': 'off',
    'no-unused-expressions': 'warn',
    'one-var': 'warn',
    'indent': 'warn',
    'vue/max-attributes-per-line': 'off',
    'vue/require-default-prop': 'off',
    'vue/require-prop-types': 'off',
    'vue/valid-v-model': 'off',
    'vue/html-self-closing': 'warn'
  }
}