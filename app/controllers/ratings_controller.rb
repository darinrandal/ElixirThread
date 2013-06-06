class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @rating = current_user.ratings.build(rating_params)

    if @rating.save
      true
    else
      false
    end
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
