module Const

  def self.message article, current_user, types
    if types == "follow"
      "#{ current_user.username } followed your post #{ article.title[0..10] }"
    else
      "#{ current_user.username } liked your post #{ article.title[0..10] }"
    end
  end

end