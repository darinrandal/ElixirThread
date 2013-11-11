class UsersController < ApplicationController
	load_and_authorize_resource

	def index
		@users = User.all
	end

	def show
		@posts = Post.where('visible = ? AND user_id = ?', true, @user.id).order('created_at DESC').limit(5)
	end

	def edit
	end

	def update
		if params[:user][:password].blank?
			params[:user].delete(:password)
			params[:user].delete(:password_confirmation)
		end

		if @user.update(user_params)
			redirect_to edit_user_path(@user), notice: 'User was successfully updated.'
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :description, :lastfm, :steam, :admin, :moderator)
		end
end