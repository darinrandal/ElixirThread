class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_filter :record_user_activity
	before_filter :configure_permitted_parameters, if: :devise_controller?

	before_filter do
		resource = controller_name.singularize.to_sym
		method = "#{resource}_params"
		params[resource] &&= send(method) if respond_to?(method, true)
	end

	rescue_from CanCan::AccessDenied do |exception|
		if request.xhr?
			render :text => exception.message
		else
			redirect_to root_path, notice: exception.message
		end
	end

	def event_log(event_type = 0, user_id1 = 0, user_id2 = 0, post_id = 0)
		@event = Event.new(:event_type => event_type, :user_id1 => user_id1, :user_id2 => user_id2, :post_id => post_id)
		@event.save
	end

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username) }
			devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
			devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :avatar, :description, :lastfm, :steam, :admin, :moderator) }
		end

		def record_user_activity
			current_user.touch :last_active_at if user_signed_in?
		end
end