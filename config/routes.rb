Rails.application.routes.draw do
  
  get 'posts/index'
  get "/top"  => "home#top"
  get "/about" => "home#about"
  get "/posts/index" => "posts#index"
  
  #詳細ページに遷移
  get "/posts/:id/show" => "posts#show"

  get "/" => "home#top"

end
