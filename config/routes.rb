Rails.application.routes.draw do
  
  #home_controller
  get "/top"  => "home#top"
  get "/about" => "home#about"

  #posts_controller
  get "/posts/new" => "posts#new" 
  get "/posts/index" => "posts#index"
  post "/posts/create" => "posts#create"
  post "/posts/:id/update" => "posts#update"
  get "/posts/:id/edit" => "posts#edit"
  post "/posts/:id/destroy" => "posts#destroy"
  get "/posts/:id/show" => "posts#show"

  #root
  get "/" => "home#top"

end
