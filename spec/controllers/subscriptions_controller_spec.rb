require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
	let(:my_user) { create(:user) }

  describe "GET #new" do
  	before do
  		login_with my_user
  	end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
end
