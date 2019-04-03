Rails.application.routes.draw do

  #home_controller
  get "/top"  => "home#top"
  get "/about" => "home#about"
  
  #user_controller
  get "users/index" => "users#index"
  get "users/new" => "users#new"
  post "users/create" => "users#new"
  post "users/:id/edit" => "users#edit"
  get "users/:id/show" => "users#show"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"

  #posts_controller
  get "/posts/index" => "posts#index"
  get "/posts/new" => "posts#new" 
  post "/posts/create" => "posts#create"
  get "/posts/:id/edit" => "posts#edit"
  get "/posts/:id/show" => "posts#show"
  post "/posts/:id/update" => "posts#update"
  post "/posts/:id/destroy" => "posts#destroy"

  #root
  get "/" => "home#top"

end
