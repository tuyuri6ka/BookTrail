class User < ApplicationRecord

    #name,email,passwordにバリデーション（空白を許さない）を追加
    validates :name,{presence:true}
    validates :email,{presence:true, uniqueness:true}
    validates :password,{presence:true}
    

    def posts
        return Post.where(user_id: self.id)
    end
end
