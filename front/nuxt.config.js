module.exports = {
  srcDir: './',
  modules:['@nuxtjs/axios'],
  build: {
    analyze: false,
    vendor: ['element-ui']
    // filenames: {
    //   css: 'style.[hash:6].css',
    //   vendor: 'vendor.[hash:6].js',
    //   app: 'app.[chunkhash:6].js'
    // }
  },
  head: {
    title: 'KNIGI',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'KNIGI' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  plugins: [
    '~plugins/element-ui'
  ],
  css: [
    'element-ui/lib/theme-chalk/index.css'
  ]
}