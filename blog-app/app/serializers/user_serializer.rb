class UserSerializer < ActiveModel::Serializer
  attributes :id,:fullname,:birthday, :email, :username , :avatar,:access
  # has_many :articles 
end
