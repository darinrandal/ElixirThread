class Post < ActiveRecord::Base
  belongs_to :user

  validates :content, :length => { :minimum => 10 }
end
