module Const
  LIMIT_ITEMS_DEFAULT = 10

  def self.message article, current_user, types
    if types == "follow"
      "#{ current_user.username } followed your post \"#{ article.title }\""
    else
      "#{ current_user.username } liked your post \"#{ article.title}\""
    end
  end

end