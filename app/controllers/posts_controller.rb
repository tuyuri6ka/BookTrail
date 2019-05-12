class PostsController < ApplicationController

  #before_action----------------------------------------------
  #他ユーザー（/users/:id/edit）への編集制限
  before_action :correct_user,{only: [:edit, :update, :destroy]}
  #------------------------------------------------------------

  #posts-------------------------------------------------------
  def index
    @posts= Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
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

    #validatesのpresence:trueにより、True/Falseの評価
    if @post.save
      flash[:notice]="書籍を追加しました"
      redirect_to("/posts/index")
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
    
    #下4行はもっと簡潔に代入できそう。
    @post.title = params[:title]
    @post.author = params[:author]
    @post.page = params[:page]
    @post.publish_data = params[:publish_data]

    #post.save時にvalidatesにより、True/Falseの評価
    if @post.save
      flash[:notice]="登録内容を変更しました"
      redirect_to("/posts/index")
    else
      flash.now[:notice]="変更内容に誤りがあります"
      render("/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy

    if @like = Like.find_by(post_id: @post.id)
      @like.destroy
    end
    
    flash[:notice]="登録内容を削除しました"
    redirect_to("/posts/index")
  end

  def find_form
    @post = Post.new
    @user = User.find_by(id: params[:id])
  end
 
  def find_result
    #メモ：あいまい検索機能（記述が長い）
    @user = User.find_by(id: params[:id])
    @posts = Post.where("title LIKE ? AND author LIKE ? AND publish_data LIKE ?","%#{params[:title]}%","%#{params[:author]}%","%#{params[:publish_data]}%").where(user_id: @user.id)
    @table_id = 0
  end


  private

    #他ユーザー（/users/:id/edit）への編集制限
    def correct_user
      @post = Post.find_by(id: params[:id])
      if @post.user_id != @current_user
        flash[:notice]= "権限がありません"
        redirect_to("/posts/index")
      end
    end

end