
const state = {
    title: "",
	text: "",
	is_top: "",
	top_until: "",
	pub_time: "",
	success: false,
}


const mutations = {
  FILL_NEWS(state, response_data){
    state.title      = response_data['title']
    state.text       = response_data['text']
    state.is_top     = response_data['is_top']
    state.top_until  = response_data['top_until_time']
    state.url        = response_data['url']
    state.pub_time   = response_data['pub_time']
	state.success    = true
	
	// if(state.is_top){
	//  this.dispatch('setCountdownTopnews')
	// }
  },
}


const actions = {
  
  // Заполнить store news Актуальной новостью (авторской или из яндекса)
  async showNews (context){
	const response = await context.rootState.App.$api.fetchNews(context)
	context.commit('FILL_NEWS', response.data)
  },
  
  
  // Заполнить store news из Авторской новости
  async fillAdminNews (context){
    const response = await context.rootState.App.$api.fetchNews_AdminTop(context, new Date().getTimezoneOffset())
	context.commit('FILL_NEWS', response.data)
  },
  
  
  // Сохранить авторскую новость через API
  async setAdminNews (context){
	const vApp = context.rootState.App
	const response = await vApp.$api.setNews_AdminTop(context, context.state, new Date().getTimezoneOffset())
	if(response.data.status == 'ok'){
	  vApp.$notify({
        group: 'main',
	    type:  'success',
	    title: 'Выполнено',
        text: 'Авторская новость успешно сохранена.',
      });
	}
	else if(response.data.status == 'no_changes'){
	  vApp.$notify({
        group: 'main',
	    type:  'info',
	    title: 'Выполнено',
        text: 'Авторская новость не изменилась.',
      });
	}
  },
  
  // Ожидание, когда истечёт Авторская новость (задача переложена на Sidekiq)
  // setCountdownTopnews (context){
	// if(context.admintop_timer_id != null){
	//   clearInterval(context.admintop_timer_id)
	//   context.admintop_timer_id = null
	// }
	// 
	// context.admintop_until_time = (new Date(context.state.top_until)).getTime()
	// if(Date.now() <= context.admintop_until_time){
	//   context.admintop_timer_id = setInterval(function(){
	//     
	// 	if(context.state.is_top && (typeof context.state.top_until != "undefined") && (context.state.top_until != null)){
	// 	  if(Date.now() > context.admintop_until_time){
	// 		clearInterval(context.admintop_timer_id)
	//         context.admintop_timer_id = null
	//         context.dispatch('showNews')
	//       }
	//     }
	// 	
	//   }, 1000)
	// }
  //}
}


const methods = {}


export default {
  data (){return {
    admintop_timer_id: null,
    admintop_until_time: 0,
  }},
  state,
  mutations,
  methods,
  actions,
}