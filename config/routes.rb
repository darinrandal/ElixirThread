ElixirThread::Application.routes.draw do
  resources :events
  resources :posts

  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "login", :sign_out => "logout" }, :controllers => {:registrations => "registrations"}
  resources :users

  get "/events/ajax/:id" => "events#ajax"

  root to: 'posts#index'
end
