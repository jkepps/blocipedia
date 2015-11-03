class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :user, presence: true

  def public?
  	!self.private
  end

  def self.visible_to(user)
  	wikis = []
  	all_wikis = Wiki.all

  	if false
  		wikis = all_wikis
  	elsif user
  		wikis = all_wikis.select { |wiki| wiki.public? || wiki.user == user }
  	else
  		wikis = all_wikis.select { |wiki| wiki.public? }
  	end
  	wikis
  end
end