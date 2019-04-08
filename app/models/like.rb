class Like < ApplicationRecord

    #user_id,post_idのペアで誰がどのポストへlikeしたかを特定する
    validates:user_id,{presence:true}
    validates:post_id,{presence:true}

end
