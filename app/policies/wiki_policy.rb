class WikiPolicy < ApplicationPolicy
	def show?
		if user.present?
			record.public? or user.admin? or record.user == user
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
		record.public? or user.admin? or record.user == user
	end

	def update?
		record.public? or user.admin? or record.user == user
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
			if !user
				scope.where(private: false)
			elsif user.admin?
				scope.all 
			else
				scope.where("private = ? or user_id = ?", false, @user.id)
			end
		end
	end
end