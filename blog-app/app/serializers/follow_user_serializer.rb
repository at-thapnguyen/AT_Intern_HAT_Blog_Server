class FollowUserSerializer < ActiveModel::Serializer
  binding.pry
  attributes :id, :username, :avatar
end