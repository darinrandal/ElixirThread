ElixirThread::Application.routes.draw do
  resources :events
  resources :posts

  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "login", :sign_out => "logout" }, :controllers => {:registrations => "registrations"}
  resources :users

  get "/ratings/create" => "ratings#create"
  get "/ratings/update" => "ratings#update"

  root to: 'posts#index'
end
