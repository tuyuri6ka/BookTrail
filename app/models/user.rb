class User < ApplicationRecord

    attr_accessor :remember_token

    #セキュアなパスワードの実装のため(passwordに対するvalidatesは不要)
    has_secure_password
    #name,email,passwordは空白を許さない
    validates :name,{presence:true}
    validates :email,{presence:true, uniqueness:true}
    
    def posts
        return Post.where(user_id: self.id)
    end


    #Remember_me機能の実装のため
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    def authenticated?(remember_token)
        BCrypt::Passsword.new(remember_digest).is_password?(remember_token)
    end
    #ログアウト時にRemember情報を破棄するため
    def forget
        update_attribute(:remember_digest,nil)
    end
end
