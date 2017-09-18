require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
	describe "GET #js_app" do
		it "responds successfully" do
			get :js_app
			expect(response).to have_http_status(:ok)
		end
	end
end
