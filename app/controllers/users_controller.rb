class UsersController < ApplicationController
 
  # before_action
  ## 非ログイン時・ログイン時・他ユーザーのアクセス制限
  before_action :require_login,{only: [:index,:show,:edit,:update]}
  before_action :forbid_login_user,{only: [:new,:create,:login_form,:login]}
  before_action :correct_user,{only: [:edit,:update]}


  # users-----------------------------------------

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

  def create
    @user = User.new(
      name:params[:user][:name],
      email:params[:user][:email],
      password:params[:user][:password],
      image_name: "default_user_image.jpg")
      
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="ようこそ"
      redirect_to(@user)
    else
      render("new")
    end
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    #メモ：image.readで画像を抽出し、Flie.binwriter()でpublic内に保存
    if image = params[:user][:image]
      @user.image_name= "#{@user.id}.jpg"
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
      
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      flash.now[:notice]="入力内容に誤りがあります"
      render "edit"
    end
  end


  # login・logout-------------------------------------

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      #Remember_me機能の有効化
      params[:user][:remember] =='1' ? remember(@user) : forget(@user)

      redirect_to(@user)  # user_url(user)すなわちredirect_to("/users/#{@user.id}")に同じ
    else
      @user = User.new(user_params)
      @error_message="アドレスまたはパスワードが間違っています"
      flash.now[:notice] = "入力内容に誤りがあります"
      render("/users/login_form")
    end
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    if logged_in?
      log_out
    end
    redirect_to root_url
  end

  # いいね機能-----------------------------------------

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @table_id = 0
  end

  private
    #strong_parameterの実装
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    def correct_user
      @user = User.find(params[:id])
      if @current_user.id != @user.id
        flash[:notice]="権限がありません"
        redirect_to("/posts/index")
      end
    end

end
