class Post < ApplicationRecord
    belongs_to :user

    validates :title,{presence: true, length:{maximum: 140}}    #最大文字数は特に意味はないが設定
    validates :author,{presence: true}                          #著者で参考リンクを飛ばせると嬉しい。
    validates :page, numericality: true
    #@post.userにより、postした投稿のuser情報を取得するメソッド
    def user
        return User.find_by(id: self.user_id)
    end

end
