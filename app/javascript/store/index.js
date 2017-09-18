import Vue  from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

import newsStore from './modules/news'


export default new Vuex.Store({
  state: {
    App: null
  },
  modules : {
	  news: newsStore
  }
})
