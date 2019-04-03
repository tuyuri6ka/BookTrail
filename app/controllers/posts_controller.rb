class PostsController < ApplicationController
  def index
    @posts= Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
  end

  def create
    @post = Post.new(
      title:  params[:title],
      author: params[:author],
      page:   params[:page],
      publish_data: params[:publish_data]
    )
    @post.save
    redirect_to("/posts/index")   #user/#{:id}/showに飛びたい。またはここを個人スペースにする。

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def destroy

  end

  def update
    @post = Post.find_by(id: params[:id]) #:idを仮置き
    @post.save
    redirect_to("/posts/index")
  end

end
