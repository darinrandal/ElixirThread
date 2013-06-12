class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = Post.where('visible = ? AND user_id = ?', true, @user.id).order('created_at DESC').limit(5)
	end
end