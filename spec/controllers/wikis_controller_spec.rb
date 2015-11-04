require 'rails_helper'

RSpec.describe WikisController, type: :controller do
	let(:my_user) { create(:user) }
	let(:my_wiki) { create(:wiki, user: my_user) }
	let(:my_private_wiki) { create(:wiki, private: true, user: my_user) }
	let(:other_user) { create(:user) }

	context "guest user" do
		before do
			login_with nil
		end

		describe "GET index" do
			before do
				get :index
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "assigns Wiki.all to wiki" do
				my_user
				my_wiki
				expect(assigns(:wikis)).to eq([my_wiki])
			end
		end

		describe "GET show" do
			context "private wiki" do
				before do
					get :show, id: my_private_wiki.id
				end

				it "redirects from private wikis" do
					expect(response).to redirect_to(wikis_path)
				end
			end

			context "public wiki" do 
				before do
					get :show, id: my_wiki.id
				end

				it "returns http success" do
					expect(response).to have_http_status(:success)
				end

				it "renders the show view" do
					expect(response).to render_template :show
				end

				it "assigns my_wiki to @wiki" do
					expect(assigns(:wiki)).to eq(my_wiki)
				end
			end
		end

		describe "GET new" do
			before do
				get :new
			end

			it "redirects to user sign in" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "POST create" do
			before do
				post :create, wiki: { title: "MyTitle", body: "MyBodyMyBodyMyBodyMyBody" }
			end

			it "redirects to user sign in" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET edit" do
			before do
				get :edit, id: my_wiki.id
			end

			it "redirects to user sign in" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "PUT update" do
			before do
				put :update, id: my_wiki.id
			end

			it "redirects to user sign in" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "DELETE destroy" do
			before do
				delete :destroy, id: my_wiki.id
			end

			it "redirects to user sign in" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	context "member user doing CRUD on a wiki they don't own" do
		before do
			login_with other_user
		end

		describe "GET index" do
			before do
				get :index
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "assigns Wiki.all to wiki" do
				expect(assigns(:wikis)).to eq([my_wiki])
			end
		end

		describe "GET show" do
			context "private wiki" do
				before do
					get :show, id: my_private_wiki.id
				end

				it "redirects from private wikis" do
					expect(response).to redirect_to(wikis_path)
				end
			end

			context "public wiki" do
				before do
					get :show, id: my_wiki.id
				end

				it "returns http success" do
					expect(response).to have_http_status(:success)
				end

				it "renders the show view" do
					expect(response).to render_template :show
				end

				it "assigns my_wiki to @wiki" do
					expect(assigns(:wiki)).to eq(my_wiki)
				end
			end
		end

		describe "GET new" do
			before do
				get :new
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "renders the new view" do
				expect(response).to render_template :new
			end

			it "initializes a new wiki" do
				expect(assigns(:wiki)).not_to be_nil
			end
		end

		describe "POST create" do
			before do
				post :create, wiki: { title: "MyTitle", body: "MyBodyMyBodyMyBodyMyBody" }
			end

			it "increases the number of wikis by 1" do
				expect{get :create, wiki: { title: "MyTitle", body: "MyBodyMyBodyMyBodyMyBody" }}.to change(Wiki, :count).by(1)
			end

			it "assigns the new wiki to @wiki" do
				expect(assigns(:wiki)).to eq Wiki.last
			end

			it "redirects to the new wiki" do
				expect(response).to redirect_to Wiki.last
			end
		end

		describe "GET edit" do
			before do
				get :edit, id: my_wiki.id
			end

			it "returns http redirect" do
				expect(response).to redirect_to(my_wiki)
			end
		end

		describe "PUT update" do
			before do
				put :update, id: my_wiki.id
			end

			it "returns http redirect" do
				expect(response).to redirect_to(my_wiki)
			end
		end

		describe "DELETE destroy" do
			before do
				delete :destroy, id: my_wiki.id
			end

			it "returns http redirect" do
				expect(response).to redirect_to(my_wiki)
			end
		end
	end

	context "member user doing CRUD on a wiki they do own" do
		before do
			login_with my_user
		end

		describe "GET index" do
			before do
				get :index
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "assigns Wiki.all to wiki" do
				expect(assigns(:wikis)).to eq([my_wiki, my_private_wiki])
			end
		end

		describe "GET show" do
			context "private wiki" do
				before do
					get :show, id: my_private_wiki.id
				end

				it "returns http success" do
					expect(response).to have_http_status(:success)
				end

				it "renders the show view" do
					expect(response).to render_template :show
				end

				it "assigns my_private_wiki to @wiki" do
					expect(assigns(:wiki)).to eq(my_private_wiki)
				end
			end

			context "public wiki" do
				before do
					get :show, id: my_wiki.id
				end

				it "returns http success" do
					expect(response).to have_http_status(:success)
				end

				it "renders the show view" do
					expect(response).to render_template :show
				end

				it "assigns my_wiki to @wiki" do
					expect(assigns(:wiki)).to eq(my_wiki)
				end
			end
		end

		describe "GET new" do
			before do
				get :new
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "renders the new view" do
				expect(response).to render_template :new
			end

			it "initializes a new wiki" do
				expect(assigns(:wiki)).not_to be_nil
			end
		end

		describe "POST create" do
			before do
				get :create, wiki: { title: "MyTitle", body: "MyBodyMyBodyMyBodyMyBody" }
			end

			it "increases the number of wikis by 1" do
				expect{get :create, wiki: { title: "MyTitle", body: "MyBodyMyBodyMyBodyMyBody" }}.to change(Wiki, :count).by(1)
			end

			it "assigns the new wiki to @wiki" do
				expect(assigns(:wiki)).to eq Wiki.last
			end

			it "redirects to the new wiki" do
				expect(response).to redirect_to Wiki.last
			end
		end

		describe "GET edit" do
			before do
				get :edit, id: my_wiki.id
			end

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "renders the edit view" do
				expect(response).to render_template :edit
			end

			it "assigns wiki to be updated to @wiki" do
				wiki_instance = assigns(:wiki)

				expect(wiki_instance.id).to eq(my_wiki.id)
				expect(wiki_instance.title).to eq(my_wiki.title)
				expect(wiki_instance.body).to eq(my_wiki.body)
			end
		end

		describe "PUT update" do
			before do
				@new_title = "NewTitle"
				@new_body = "NewBodyNewBodyNewBodyNewBodyNewBody"
				put :update, id: my_wiki.id, wiki: { title: @new_title, body: @new_body }
			end

			it "updates post with expected attributes" do
				updated_wiki = assigns(:wiki)

				expect(updated_wiki.id).to eq(my_wiki.id)
				expect(updated_wiki.title).to eq(@new_title)
				expect(updated_wiki.body).to eq(@new_body)
			end

			it "redirects to the updated post" do
				expect(response).to redirect_to(my_wiki)
			end
		end

		describe "DELETE destroy" do
			before do
				delete :destroy, id: my_wiki.id
			end

			it "deletes the wiki" do
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        expect(response).to redirect_to wikis_path
      end
		end
	end
end
