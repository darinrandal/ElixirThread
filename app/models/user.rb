class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_attached_file :avatar, :styles => { :medium => "100x300>", :thumb => "80x80>" }, :default_url => "/assets/:style/missing.png"

  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of :username

  def self.find_for_authentication(tainted_conditions)
    find_first_by_auth_conditions(tainted_conditions)
  end
end
