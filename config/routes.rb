Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  mount ActionCable.server => '/cable'
  
  root to: 'welcome#js_app'
  
  get '/admin' => 'welcome#js_app'
  
  scope '/api' do
	scope '/news' do
		get  '/show' => 'news#show'
		get  '/admin_news' => 'news#admin_news_get'
		post '/set_admin_news' => 'news#admin_news_set'
	end
  end

end
