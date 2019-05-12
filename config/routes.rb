Rails.application.routes.draw do

  #トップ画面の表示
  root "home#top"
  get  "/about"              => "home#about"
  
  #ユーザーのCRUD処理
  get  "/login"              => "users#login_form"
  get  "/logout"             => "users#logout"
  post "/login"              => "users#login"
  get  "/users/:id/likes"    => "users#likes"
  resources :users

  #書籍投稿のCRUD処理
  get  "/posts/index"        => "posts#index"
  get  "/posts/new"          => "posts#new" 
  get  "/posts/:id/edit"     => "posts#edit"
  get  "/posts/:id/destroy"  => "posts#destroy"   #本来ならpostで取るべきだがなぜか機能しないので、getでキャッチする
  get  "/posts/:id"          => "posts#show"
  post "/posts/create"       => "posts#create"
  post "/posts/:id/update"   => "posts#update"

  #書籍の検索機能の実装
  get  "/find/:id"           => "posts#find_form"
  get  "/find_result"        => "posts#find_result"
  post "/find_result/:id"    => "posts#find_result"

  #いいね機能の実装（postで取るべきだがHeroku上で機能しなかったため、getでキャッチ）
  get  "/likes/:post_id/create"  => "likes#create"
  get  "/likes/:post_id/destroy" => "likes#destroy"

end
