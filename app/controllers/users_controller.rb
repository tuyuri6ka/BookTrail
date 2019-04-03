class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
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
    @user.password = params[:password]
    #image.readで画像を抽出し、Flie.binwriter()でpublic内に保存
    if image = params[:image]
      @user.image_name= "#{@user.id}.jpg"
      File.binwriter("public/user_images/#{@user.image_name}",image.read)
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
  end
end
