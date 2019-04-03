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
    @user.name = params[:email]
    @user.name = params[:name]

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
