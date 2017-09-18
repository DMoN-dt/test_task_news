<template lang='pug'>
  div(v-if="read_success")
    h1(v-if="is_top") Авторская новость
    h1(v-else) Новость Яндекса
  
    div.n-item
      h4 {{ title }}
      span.create-date {{ moment(pub_time).format('LLL') }}
      p.text {{ text }}
  
  div(v-else)
    h1 Новость Яндекса
    p.text На данный момент новости не загружены.
</template>

<script>
import AppSockets from '../../sockets/cable'

const moment = require('moment')// Moment.JS
moment.locale('ru')


export default {
  data (){return {data: null}},
  methods: {
    moment: function (data){
      return moment(data)
    },
    
    mountWSchannel (){
      const chnl_subs = new AppSockets({fnOnUpdate: this.onNewsUpdate})
      chnl_subs.subscribe()
    },
    
    onNewsUpdate (data) {
      if(data == "updated"){
        this.showNews()
		this.$notify({
          group: 'main',
	      type:  'info',
	      title: 'Обновление новостей',
          text: 'Выполнено обновление новостного блока.',
        })
      }
    },
    
    showNews (){
      this.$store.dispatch('showNews')
    },
  },
  
  
  created (){
      this.showNews()
      this.mountWSchannel()
  },
  
  
  watch: {
      '$route': 'showNews'
  },
  
  
  computed: {
    title (){return this.$store.state.news.title},
    text (){return this.$store.state.news.text},
    is_top (){return this.$store.state.news.is_top},
    pub_time (){return this.$store.state.news.pub_time},
    top_until_time (){return this.$store.state.news.top_until},
    read_success (){return this.$store.state.news.success},
  },
}
</script>
