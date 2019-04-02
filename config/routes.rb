Rails.application.routes.draw do
  get 'posts/index'
  get "/top"  => "home#top"
  get "/about" => "home#about"
  get "/posts/index" => "posts#index"

  get "/" => "home#top"

end
