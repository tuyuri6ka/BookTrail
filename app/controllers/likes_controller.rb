class LikesController < ApplicationController
    #非ログイン時のURI直接入力によるアクセス制限を設定するため
    before_action :require_login
    
    def create
        @like = Like.new(user_id:@current_user.id,post_id:params[:post_id])
        @like.save
        redirect_to("/posts/#{params[:post_id]}")
    end
    
    def destroy
        @like = Like.find_by(user_id:@current_user.id,post_id:params[:post_id])
        @like.destroy
        redirect_to("/posts/#{params[:post_id]}")
    end
  end