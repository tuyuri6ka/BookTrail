class UsersController < ApplicationController
 
  #before_action----------------------------------------------

  #非ログイン時のURI直接入力によるアクセス制限を設定するため
  before_action :authenticate_user,{only: [:index,:show,:edit,:update]}
  #ログイン時のURI直接入力によるアクセス制限を設定するため
  before_action :forbid_login_user,{only: [:new,:create,:login_form,:login]}
  #他ユーザー（/users/:id/edit）への編集制限するため
  before_action :ensure_correct_user,{only: [:edit,:update]}

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end

  #users-----------------------------------------
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @table_id = 0
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  #メモ:form_forでなく、form_tag利用時におけるstrong paramterとの実装法が不明
  def create
    @user = User.new(
      name: params[:name],
      email:params[:email],
      password:params[:password],
      image_name: "default_user_image.jpg"
    )

    if @user.save
      session[:user_id]= @user.id
      flash[:notice]="ようこそ"
      redirect_to("/users/#{@user.id}")
    else
      flash.now[:notice]="入力内容に誤りがあります"
      render("/users/new")
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    #メモ：image.readで画像を抽出し、Flie.binwriter()でpublic内に保存
    if image = params[:image]
      @user.image_name= "#{@user.id}.jpg"
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
      
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      flash.now[:notice]="入力内容に誤りがあります"
      render("users/edit")
    end
  end

  def destroy
    redirect_to("/login")
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] ="ようこそ"
      #Remember_me機能（ユーザーセッションの永続化）の実装のため
      params[:remember_me] =='1' ? @user.remember : @user.forget
      cookies.permanent.signed[:user_id] = @user.id
      cookies.permanent[:remember_token] = @user.remember_token

      redirect_to("/users/#{@user.id}")
    else
      #メモ:入力ミス時のフォーム再表示に利用するため
      @email = params[:email]
      @password = params[:password]
      @error_message="アドレスまたはパスワードが間違っています"
      flash.now[:notice] = "入力内容に誤りがあります"
      render("/users/login_form")
    end
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    @user.forget
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil

    redirect_to("/login")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @table_id = 0
  end

end
