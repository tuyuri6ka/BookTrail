class ApplicationController < ActionController::Base
    include UsersHelper

    #:set_current_userは先だって利用するため予め宣言
    before_action :set_current_user

    def set_current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        #cookiesを利用した永続セッションの確立
        elsif cookies.signed[:user_id]
            user = User.find_by(id: cookies.signed[:user_ud])
            if user && user.authenticated?(cookies[:remember_token])
                session[:user_id] = user.id
                @current_user = user
            end
        end
    end

    #非ログイン時のURI直接入力によるアクセス制限を設定するため
    def authenticate_user
        if @current_user == nil
            flash[:notice]="ログインが必要です"
            redirect_to("/login")
        end
    end

    #ログイン時のURI直接入力によるアクセス制限を設定するため
    def forbid_login_user
        if @current_user
            flash[:notice]="すでにログインしています"
            redirect_to("/posts/index")
        end
    end

end
