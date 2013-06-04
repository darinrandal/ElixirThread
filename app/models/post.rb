class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  validates :content, :length => { :minimum => 1 }
end
