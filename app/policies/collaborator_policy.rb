class CollaboratorPolicy < ApplicationPolicy
	def create?
		# Wiki must be private     user must be premium and owner of wiki OR an admin           author can't be collaborator
		!record.wiki.public? && ((user.premium? && record.wiki.user == user)|| user.admin?) && record.wiki.user != record.user 
	end

	def destroy?
		((user.premium? && record.wiki.user == user)|| user.admin?) && !record.wiki.public? 
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
