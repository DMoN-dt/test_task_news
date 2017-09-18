import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import NewsFeedView from '../components/news/news_feed.vue'
import NewsEditView from '../components/news/news_edit.vue'

export function AppRouter() {
  return new VueRouter({
    mode: 'history',
    routes: [
      {path: '/', component: NewsFeedView},
      {path: '/admin', component: NewsEditView},
      //{path: '/admin', component: () => import('../components/news/news_edit.vue')},
    ]
  })
}
