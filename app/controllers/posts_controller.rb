class PostsController < ApplicationController
	before_action :build_post, only: [:index, :new]

	load_and_authorize_resource

	def index
		@posts = Post.joins(:user).where(:visible => true).page(params[:page])
	end

	def show
		respond_to do |format|
			format.html { render '_posts', :locals => { posts: Array(@post) } }
			format.json { render :json => @post }
		end
	end

	def new
	end

	def edit
		render 'inline', :layout => false if request.xhr?
	end

	def create
		last = Post.last
		if last.nil? || last.user_id != current_user.id
			@post = current_user.posts.build(post_params)

			update_data()

			if @post.save
				current_user.update_attributes(:post_count => current_user.post_count + 1)
				if request.xhr?
					render '_posts', :locals => { posts: Array(@post) }, :layout => false
				else
					redirect_to @post, notice: 'Post was successfully created.'
				end
			else
				if request.xhr?
					render '_errors', :layout => false
				else
					render 'new'
				end
			end
		else
			last.content = last.content + "\n\n<span class='r50'>Edited:</span>\n\n" + params[:post][:content]
			last.save
			render '_posts', :locals => { posts: Array(last) }, :layout => false
		end
	end

	def update
		update_data()

		if @post.update(post_params)
			if request.xhr?
				render '_posts', :locals => { posts: Array(@post) }, :layout => false
			else
				redirect_to @post, notice: 'Post was successfully updated.'
			end
		else
			render 'edit'
		end
	end

	def destroy
		@post.update_attribute :visible, false
		render :text => 'true'
	end

	private
		def update_data
			user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
			country_code = JSON.parse(Weary::Request.new("http://api.hostip.info/get_json.php?ip=#{request.remote_ip}").perform.body.as_json)["country_code"]

			@post.os = user_agent.os
			@post.browser = user_agent.browser
			@post.country_code = country_code
		end

		def build_post
			@post = current_user.posts.build unless !user_signed_in?
		end

		def post_params
			params[:post].permit(:content)
		end
end