class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise	:database_authenticatable, :registerable, 
  				:recoverable, :rememberable, :trackable, 
  				:validatable, :confirmable

  has_many :wikis

  validates :username, 
  					length: {minimum: 4}, 
  					uniqueness: { case_sensitive: false }, 
  					presence: true

  def premium?
    # role == "premium"
  end

  def admin?
    # role == "admin"
  end
end
