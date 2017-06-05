class UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday, :description, :avatar,
             :email,:access_token
end
