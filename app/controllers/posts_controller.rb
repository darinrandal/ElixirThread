class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :build_post, only: [:index, :new]

  def index
    @posts = Post.where(:visible => true).page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    update_data()

    if @post.save
      current_user.update_attributes(:post_count => current_user.post_count + 1)
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    update_data()

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def update_data
      user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
      country_code = JSON.parse(Weary::Request.new("http://api.hostip.info/get_json.php?ip=#{request.remote_ip}").perform.body.as_json)["country_code"]

      @post.os = user_agent.os
      @post.browser = user_agent.browser
      @post.country_code = country_code
    end

    def build_post
      if user_signed_in?
        @post = current_user.posts.build
      end
    end

    def post_params
      params[:post].permit(:content)
    end
end
