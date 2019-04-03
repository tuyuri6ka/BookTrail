class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(
      name: params[:name],
      email:params[:email],
      password:params[:password]
    )

    if @user.save
      flash[:notice]="ようこそ"
      redirect_to("/users/show")
    else
      flash.now[:notice]="入力内容に誤りがあります"
      render("/users/new")
    end

  end

  def update
  end

  def destroy
  end
end
