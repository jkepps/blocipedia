class CollaboratorsController < ApplicationController
	def create
		wiki = Wiki.find(params[:wiki_id])
		user = User.find(params[:collaborator][:user])

		collaborator = wiki.collaborators.build(user: user )

		authorize collaborator

		if collaborator.save
			flash[:notice] = "#{user.username.capitalize} has been added to this wiki as a collaborator."
			redirect_to request.referrer
		else
			flash[:error] = "There was an error creating the collaborator."
			redirect_to request.referrer
		end
	end

	def destroy
		wiki = Wiki.find(params[:wiki_id])
		collaborator = wiki.collaborators.find(params[:id])
		authorize collaborator

		if collaborator.delete
			flash[:notice] = "Collaborator successfully removed from this wiki."
		else
			flash[:error] = "An error occurred."
		end
		redirect_to request.referrer
	end
end
