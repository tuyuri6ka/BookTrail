module UsersHelper

    # 現在ログインしてるユーザーを返す
    def set_current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        # cookiesを利用した永続セッションの確立
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                session[:user_id] = user.id
                @current_user = user
            end
        end
    end

    # ユーザーはログインしている？ true : flase;
    def logged_in?
        !(set_current_user.nil?)
    end

    # ユーザーのセッションを永続化する
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = @user.id
        cookies.permanent[:remember_token] = @user.remember_token
    end

    # 現在のユーザーをログアウトする
    def log_out
        forget(set_current_user)
        session[:user_id] = nil
        @current_user = nil
    end
    
    ## 永続的セッションを破壊する
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

end
