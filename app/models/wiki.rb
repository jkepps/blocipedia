class Wiki < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :user, presence: true
  validates :slug, presence: true

  def public?
  	!self.private
  end
end