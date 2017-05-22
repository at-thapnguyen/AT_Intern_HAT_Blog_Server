class UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday,
              :email, :access_token, :access
end
