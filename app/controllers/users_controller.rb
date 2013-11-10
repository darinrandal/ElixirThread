class UsersController < ApplicationController
	load_and_authorize_resource

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where('visible = ? AND user_id = ?', true, @user.id).order('created_at DESC').limit(5)
	end

	def edit
	end
end