class RatingsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@ratings = Rating.all
	end

	def create
		rating = Rating.where("user_id = ? AND post_id = ?", current_user.id, params[:post_id])
		@post = Post.find(params[:post_id])

		if rating.count == 0
			Rating.new(:user_id => current_user.id, :post_id => params[:post_id], :rating_type => params[:rating_type]).save
		else
			Rating.update(rating, :rating_type => params[:rating_type])
		end
		
		render :partial => "posts/post_ratings", :locals => { :post => @post }
	end

	def update
		if @rating.update(rating_params)
			true
		else
			false
		end
	end

	private
		def rating_params
			params.require(:rating).permit(:post_id, :rating_type)
		end
end