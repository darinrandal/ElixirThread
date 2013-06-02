ElixirThread::Application.routes.draw do
  resources :events
  resources :posts
  resources :users

  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "login", :sign_out => "logout" }, :controllers => {:registrations => "registrations"}

  root to: 'posts#index'
end
