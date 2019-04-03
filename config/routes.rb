Rails.application.routes.draw do

  #home_controller
  get "/top"  => "home#top"
  get "/about" => "home#about"
  
  #user_controller
  get "users/index" => "users#index"
  get "users/new" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  get "users/:id" => "user#show"

  #posts_controller
  get "/posts/index" => "posts#index"
  get "/posts/new" => "posts#new" 
  post "/posts/create" => "posts#create"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"
  get "/posts/:id" => "posts#show"

  #root
  get "/" => "home#top"

end
