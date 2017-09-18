
const _API_PATH = '/api'


export default({
  apiOnFailure: function (vApp, e) {
	vApp.$notify({
      group: 'main',
	  type:  'error',
	  title: 'Ошибка запроса к серверу',
      text: e.toString(),
    });
  },
  
  apiQuery: (context, method, url, params, data) => {
	let vApp = context.rootState.App
	let query = vApp.$http({method, url, params, data})
	query //.then(response => {console.log('API ANSWER: ', response.data);})
	.catch(e => {this.a.apiOnFailure(vApp, e);})
	return query
  },
  
  fetchNews: (context) => {
	return this.a.apiQuery(context, 'get', `${_API_PATH}/news/show`)
  },
  
  fetchNews_AdminTop: (context, tzOffset) => {
	return this.a.apiQuery(context, 'get', `${_API_PATH}/news/admin_news`, {tz_offset: tzOffset})
  },
  
  setNews_AdminTop: (context, data, tzOffset) => {
	return this.a.apiQuery(context, 'post', `${_API_PATH}/news/set_admin_news`, null, {news: data, tz_offset: tzOffset})
  },
})