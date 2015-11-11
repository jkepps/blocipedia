require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:my_user) { create(:user) }

  describe "GET #show" do
  	before do
  		get :show, id: my_user.id
  	end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
    	expect(response).to render_template(:show)
    end

    it "assigns my_user to @user" do
    	expect(assigns(:user)).to eq(my_user)
    end
  end
end
