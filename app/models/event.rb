class Event < ActiveRecord::Base
	belongs_to :primary_user, :class_name => "User", :foreign_key => "id"
	belongs_to :secondary_user, :class_name => "User", :foreign_key => "id"
end
