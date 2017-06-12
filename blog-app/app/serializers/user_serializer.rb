class UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday, :description, :avatar,
             :email,:access_token,:isfollow
  def isfollow
    object.follow? current_user.id if current_user.present?
  end
end
