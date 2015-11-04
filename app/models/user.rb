class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise	:database_authenticatable, :registerable, 
  				:recoverable, :rememberable, :trackable, 
  				:validatable, :confirmable

  has_many :wikis
  before_save { self.role ||= :standard }

  validates :username, 
  					length: {minimum: 4}, 
  					uniqueness: { case_sensitive: false }, 
  					presence: true

  enum role: [:standard, :premium, :admin]

  def standard?
    role == "standard"
  end

  def premium?
    role == "premium"
  end

  def admin?
    role == "admin"
  end
end
