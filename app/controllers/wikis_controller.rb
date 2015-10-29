class WikisController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authorize_user, except: [:index, :show, :new, :create]

	def index
		@wikis = Wiki.all
	end

	def show
		@wiki = Wiki.find(params[:id])

		if @wiki.user != current_user && @wiki.private 
      flash[:error] = "You do not have permission to view this wiki"
      redirect_to wikis_path
    end
	end

	def new
		@wiki = Wiki.new
	end

	def create
		@wiki = Wiki.new(wiki_params)
		@wiki.user = current_user

		if @wiki.save
			flash[:notice] = "You have successfully created a new wiki."
			redirect_to @wiki
		else
			flash[:error] = "There was an error creating your wiki; Please try again."
			render :new
		end
	end

	private
	def wiki_params
		params.require(:wiki).permit(:title, :body)
	end

	def authorize_user
    user = User.find(params[:user_id])
    unless current_user == user
      flash[:alert] = "You do not have permission to do that."
      redirect_to wikis_path
    end
  end
end
