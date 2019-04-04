class ApplicationController < ActionController::Base
    #:set_current_userはすべてのcontrollerで利用するため予め宣言
    #特にユーザー編集画面において[編集]の表示・非表示には有効
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    #非ログイン時のアクセス制限
    def authenticate_user
        if @current_user == nil
            flash[:notice]="ログインが必要です"
            redirect_to("/login")
        end
    end

    #ログイン時のアクセス制限
    def forbid_login_user
        if @current_user
            flash[:notice]="すでにログインしています"
            redirect_to("/posts/index")
        end
    end

end
