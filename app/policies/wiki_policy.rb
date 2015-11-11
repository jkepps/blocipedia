class WikiPolicy < ApplicationPolicy
	def show?
		if user.present?
			record.public? or user.admin? or record.user == user or record.users.include?(user)
		else
			record.public?
		end
	end

	def new?
		user.present?
	end

	def create?
		user.present?
	end

	def edit?
		record.public? or user.admin? or record.user == user or record.users.include?(user)
	end

	def update?
		record.public? or user.admin? or record.user == user or record.users.include?(user)
	end

	def destroy?
		user.admin? or record.user == user
	end  

	class Scope
		attr_reader :user, :scope

		def initialize(user, scope)
			@user, @scope = user, scope
		end

		def resolve
			wikis = []
			if !user
				wikis = scope.where(private: false)
			elsif user.admin?
				wikis = scope.all 
			elsif user.premium?
				all_wikis = scope.all
				wikis = all_wikis.select { |wiki| wiki.public? || wiki.user == user || wiki.users.include?(user) }
			else
				all_wikis = scope.all
				wikis = all_wikis.select { |wiki| wiki.public? || wiki.users.include?(user) }
			end
			wikis
		end
	end
end