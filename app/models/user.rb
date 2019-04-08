class User < ApplicationRecord
    #セキュアなパスワードを実装(passwordに対するvalidatesは不要)
    has_secure_password
    #name,email,passwordにバリデーション（空白を許さない）を追加
    validates :name,{presence:true}
    validates :email,{presence:true, uniqueness:true}
    

    def posts
        return Post.where(user_id: self.id)
    end
end
