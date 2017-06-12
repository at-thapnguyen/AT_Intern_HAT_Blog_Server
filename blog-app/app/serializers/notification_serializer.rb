class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :image, :types, :param, :isChecked

  def types
    object.notificationable_type == "FollowUser" ? "user" : "article"
  end
  def param
    if object.notificationable_type == FollowUser.name
      User.find(object.notificationable.follower_id).username
    else
      Article.find(object.notificationable.article_id).slug
    end
  end

end