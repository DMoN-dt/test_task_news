<template lang="pug">
  #news_edit_form
    h1 Авторская новость
    form(@submit.prevent="setAdminNews")
      .field.form-group.row
        .col-2
          label Заголовок
        .col-10
          input.form-control(v-model="title" name="title" type="text")
      .field.form-group.row
        .col-2
          label Аннотация
        .col-10
          textarea.form-control(v-model="text" name="text" rows="7" required placeholder="Аннотация к новости, отображаемая в ленте")
      .field.form-group.row
        .col-2
          label Действует до
        .col-10
          input.form-control(v-model="top_until_time" name="top_until_time" type="datetime-local")
      input.btn.btn-primary(value="Сохранить пост" type="submit" name="commit")
</template>

<script>
const moment = require('moment')// Moment.JS
moment.locale('ru')

export default {
  data (){return {data: null}},
  methods: {
    moment: function (data){
      return moment(data)
    },
	
	fillAdminNews (){
      this.$store.dispatch('fillAdminNews')
	},
	
	setAdminNews (){
	  this.$store.dispatch('setAdminNews')
	}
  },
  
  
  created (){
	  this.fillAdminNews()
  },
  
  
  watch: {
	  '$route': 'fillAdminNews'
  },
  
  
  computed: {
    title:{
	  get (){
	    return this.$store.state.news.title
	  },
	  set (nVal){
	    return this.$store.state.news.title = nVal
	  }
    },
	
	text:{
	  get (){
	    return this.$store.state.news.text
	  },
	  set (nVal){
	    return this.$store.state.news.text = nVal
	  }
    },
	
	top_until_time: {
	  get (){
		return this.$store.state.news.top_until
	  },
	  set (nVal){
	    return this.$store.state.news.top_until = nVal
	  }
    },
  },
}
</script>
