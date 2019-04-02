Rails.application.routes.draw do
  
  #home_controller
  get "/top"  => "home#top"
  get "/about" => "home#about"

  #posts_controller
  get "/posts/new" => "posts#new" 
  get "/posts/index" => "posts#index"
  get "/posts/:id/show" => "posts#show"

  #root
  get "/" => "home#top"

end
