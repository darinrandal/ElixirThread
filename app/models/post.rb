class Post < ActiveRecord::Base
	belongs_to :user
	has_many :ratings

	validates :content, :presence => true
end
