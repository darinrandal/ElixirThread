class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.all
	end
end