ElixirThread::Application.routes.draw do
	resources :events, :posts, :ratings

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

	get '/posts/:id/inline' => "posts#inline"

	root to: 'posts#index'
end