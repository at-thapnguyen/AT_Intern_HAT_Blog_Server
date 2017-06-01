class User::UserArticleSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar, :is_followed

  def is_followed
    object.follow? current_user.id if current_user.present?
  end
end
