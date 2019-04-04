class PostsController < ApplicationController
  def index
    @posts= Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user 
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title:  params[:title],
      author: params[:author],
      page:   params[:page],
      publish_data: params[:publish_data],
      user_id: @current_user.id
    )

    #post.save時にvalidatesにより、True/Falseの評価
    if @post.save
      flash[:notice]="書籍を追加しました"
      redirect_to("/posts/index")                       #user/#{:id}/showに飛びたい。またはここを個人管理スペースにする。
    else
      flash.now[:notice]="入力内容に誤りがあります"       #flash.nowはアクションが進まないときに利用
      render("/posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    
    #下はまとめて代入できそう。
    @post.title = params[:title]
    @post.author = params[:author]
    @post.page = params[:page]
    @post.publish_data = params[:publish_data]

    #post.save時にvalidatesにより、True/Falseの評価
    if @post.save
      flash[:notice]="登録内容を変更しました"
      redirect_to("/posts/index")
    else
      flash.now[:notice]="変更内容に誤りがあります"       #flash.nowはアクションが進まないときに利用
      render("/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    @post.destroy
    flash.now[:notice]="登録内容を削除しました"
    redirect_to("/posts/index")
  end

end
