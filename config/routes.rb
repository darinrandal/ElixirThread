ElixirThread::Application.routes.draw do
	resources :events, :ratings

	devise_for :users, 
		:path_names => { 
			:sign_up => "register", 
			:sign_in => "login", 
			:sign_out => "logout" 
		}, 
		:controllers => { 
			:registrations => "registrations"
		}

	resources :users

	resources :posts do
		get 'page/:page', :action => :index, :on => :collection
	end

	root to: 'posts#index'
end