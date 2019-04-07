class UsersController < ApplicationController
 
  #before_action----------------------------------------------

  #非ログイン時のアクセス制限
  before_action :authenticate_user,{only: [:index,:show,:edit,:update]}
  #ログイン時のアクセス制限
  before_action :forbid_login_user,{only: [:new,:create,:login_form,:login]}
  #他ユーザーに対する編集制限
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
    
    #値を格納
    @user.name = params[:name]
    @user.email = params[:email]
    #image.readで画像を抽出し、Flie.binwriter()でpublic内に保存
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
    @user = User.find_by(
      email: params[:email],
      password:params[:password]
    )
    
    if @user
      session[:user_id] = @user.id
      flash[:notice] ="ようこそ"
      redirect_to("/users/#{@user.id}")
    else
      #入力ミスの場合は、フォーム再表示に利用するため、値を格納（@userはnilのため@emailなどをそのまま利用）
      @email = params[:email]
      @password = params[:password]
      @error_message="アドレスまたはパスワードが間違っています"
      flash.now[:notice] = "入力内容に誤りがあります"
      render("/users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end
 
end
