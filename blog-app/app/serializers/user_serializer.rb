class UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday,
              :email, :confirm_token, :access_token, :token
end
