/* eslint no-console:0 */
// To reference this file, add <%= javascript_pack_tag 'application' %>

const SOCKET_SERVER_URI = 'http://test_news.hometest.lan:3035'

import 'regenerator-runtime/runtime'
import "babel-polyfill"
import Vue           from 'vue'
import axios         from 'axios'
import Notifications from 'vue-notification'

Vue.prototype.$http = axios
Vue.use(Notifications)

import { AppRouter } from '../routes'
import AppStore      from '../store'
import App           from '../components/app.vue'
import Api           from '../api/api'

Vue.prototype.$api  = Api


export function createApp () {
  const router = AppRouter()

  const app = new Vue({
	router,
	store: AppStore,
    render: h => h(App),
  })
  
  return { app, router }
}

// import Vue from 'vue/dist/vue.esm'