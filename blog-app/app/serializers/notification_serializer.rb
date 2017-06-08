class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :image, :types, :param, :isChecked

  def types
    object.notificationable_type == "FollowUser" ? "user" : "article"
  end
  def param
    if object.notificationable_type == FollowUser.name
      object.notificationable.follower_id
    else
      object.notificationable.article_id
    end
  end

end