class User::UserSerializer < ActiveModel::Serializer
  attributes  :id, :username, :fullname, :birthday,:email,:avatar,:description
end
