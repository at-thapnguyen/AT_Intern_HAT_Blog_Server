class FollowUserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar
  belongs_to :user
end