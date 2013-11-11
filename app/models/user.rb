class User < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	has_many :posts
	has_many :main_events, :foreign_key => :user_id1, :class_name => "Event"
	has_many :secondary_events, :foreign_key => :user_id2, :class_name => "Event"
	has_many :ratings, :through => :posts

	has_attached_file :avatar, :default_url => "/assets/:style/missing.png"#, 
		#:url => "/system/:hash.:extension",
    	#:hash_secret => "ElixirThread"
	validates_with AttachmentContentTypeValidator, :content_type => /image/, :attributes => :avatar, :message => "must be an image"
	validates_with AttachmentSizeValidator, :less_than_or_equal_to => 5.megabytes, :attributes => :avatar, :message => "must be less than or equal to 60 kilobytes"

	validates :username, :uniqueness => { :case_sensitive => false }
	validates :username, :presence => true
	validates :username, :length => 2..18

	def events
		main_events + secondary_events
	end

	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if username = conditions.delete(:username)
			where(conditions).where(["lower(username) = :value ", { :value => username.downcase }]).first
		else
			where(conditions).first
		end
	end
end