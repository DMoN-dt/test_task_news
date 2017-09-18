require 'rails_helper'

RSpec.describe NewsController, type: :controller do
	describe "GET #show" do
		it "responds successfully" do
			get :show
			expect(response).to (have_http_status(:ok) or have_http_status(:not_found))
			expect(response.content_type).to eq("application/json")
		end
	end
	
	describe "GET #admin_news_get" do
		it "responds successfully" do
			get :admin_news_get
			expect(response).to have_http_status(:ok)
			expect(response.content_type).to eq("application/json")
		end
	end
	
	describe "POST #admin_news_set" do
		it "responds successfully" do
			params = {:news => {:title => 'Тестовая новость', :text => 'Аннотация', :top_until => Time.now + 2.hours}, :tz_offset => -300}
			post :admin_news_set, params: params
			expect(response).to have_http_status(:ok)
			expect(response.content_type).to eq("application/json")
		end
	end
end
