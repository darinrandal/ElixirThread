class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_attached_file :avatar, :styles => { :medium => "100x300>", :thumb => "80x80>" }, :default_url => "/assets/:style/missing.png"
end
