class WikisController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@wikis = policy_scope(Wiki)
	end

	def show
		@wiki = Wiki.friendly.find(params[:id])
		authorize @wiki
	end

	def new
		@wiki = Wiki.new
		authorize @wiki
	end

	def create
		@wiki = Wiki.new(wiki_params)
		@wiki.user = current_user
		authorize @wiki

		if @wiki.save
			flash[:notice] = "You have successfully created a new wiki."
			redirect_to @wiki
		else
			flash[:error] = "There was an error creating your wiki; Please try again."
			render :new
		end
	end

	def edit
		@wiki = Wiki.friendly.find(params[:id])
		authorize @wiki
	end

	def update
		@wiki = Wiki.friendly.find(params[:id])
		@wiki.assign_attributes(wiki_params)
		authorize @wiki

		if @wiki.save
			flash[:notice] = "The wiki was updated successfully."
			redirect_to wiki_path(@wiki)
		else
			flash[:error] = "An error occurred, please try again."
			render :edit
		end
	end

	def destroy
		@wiki = Wiki.friendly.find(params[:id])
		authorize @wiki

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
		params.require(:wiki).permit(:title, :body, :private)
	end
end
