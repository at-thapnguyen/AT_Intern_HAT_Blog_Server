class User::UserArticleSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar, :isfollow

  def isfollow
    object.follow? current_user.id if current_user.present?
  end
end
