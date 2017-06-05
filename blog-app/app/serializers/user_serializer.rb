class UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday, :description, :avatar,
              :email
end
