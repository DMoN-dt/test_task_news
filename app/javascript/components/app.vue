<template>
  <div id="app">
    <notifications group="main" />
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app',
  data (){return {
    csrf_Token: '',
  }},
  methods: {
    setMetaCsrfToken (){
	  this.csrf_Token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
	  return this.csrf_Token
	}
  },
  created (){
	this.$store.state.App = this
	this.$http.defaults.headers.common['X-CSRF-TOKEN'] = this.setMetaCsrfToken()
	// console.log('HTTP X-CSRF-TOKEN: ', this.csrf_Token)
  }
}
</script>