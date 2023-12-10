import "@/assets/css/main.css";

import { createApp } from 'vue'

import App from '@/App.vue'
import router from '@/router'
import store from "@/store"

import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhLocale from 'element-plus/lib/locale/lang/zh-cn'
import Icons from '@/components/Icons.vue'

import '@/mock/index.js'

const app = createApp(App)

app.use(router)
app.use(store)
app.use(ElementPlus, {
    locale: zhLocale
  })
app.component("Icons", Icons)
app.mount('#app')
