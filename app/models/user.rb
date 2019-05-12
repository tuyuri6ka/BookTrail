class User < ApplicationRecord
    attr_accessor :remember_token
    has_many :posts, dependent: :destroy
    has_secure_password
    validates :name, {presence:true}
    validates :email,{presence:true, uniqueness:true}
    validates :password, {presence:true, length:{minimum: 1}, allow_nil: true}
    
    def posts
        return Post.where(user_id: self.id)
    end

    # Remember_meの実装
    ## 1.渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end
    ## 2.ランダムなトークンを作成する
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    ## 3.ランダムなトークンをDBに保存・更新する（永続セッション）
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    ## 4.渡されたトークンとダイジェストが一致したらtrueを返す
    def authenticated?(remember_token)
        BCrypt::Passsword.new(remember_digest).is_password?(remember_token)
    end
    
    ## 5. ログイン情報を破棄する
    def forget
        update_attribute(:remember_digest,nil)
    end
end
