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

	def edit
		@wiki = Wiki.find(params[:id])	
	end

	def update
		@wiki = Wiki.find(params[:id])
		@wiki.assign_attributes(wiki_params)

		if @wiki.save
			flash[:notice] = "The wiki was updated successfully."
			redirect_to wiki_path(@wiki)
		else
			flash[:error] = "An error occurred, please try again."
			render :edit
		end
	end

	def destroy
		@wiki = Wiki.find(params[:id])

		if @wiki.destroy
			flash[:notice] = "The wiki was deleted successfully."
			redirect_to wikis_path
		else
			flash[:error] = "An error occurred, please try again."
			redirect_to @wiki
		end
	end

	private
	def wiki_params
		params.require(:wiki).permit(:title, :body)
	end

	def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user
      flash[:alert] = "You do not have permission to do that."
      redirect_to wiki_path(wiki)
    end
  end
end
