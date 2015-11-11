module CollaboratorsHelper
	def elligible_collaborators(wiki)
		User.order(:username).reject do |user| 
			user == wiki.user or wiki.users.include?(user)
		end
	end
end
