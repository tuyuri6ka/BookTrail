class ApplicationController < ActionController::Base
    include UsersHelper

    # 予め宣言
    before_action :set_current_user

    # 非ログイン時のURI直接入力によるアクセス制限を設定するため
    def authenticate_user
        if @current_user == nil
            flash[:notice]="ログインが必要です"
            redirect_to("/login")
        end
    end

    # ログイン時のURI直接入力によるアクセス制限を設定するため
    def forbid_login_user
        if @current_user
            flash[:notice]="すでにログインしています"
            redirect_to("/posts/index")
        end
    end

end
