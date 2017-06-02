class CommentSerializer < ActiveModel::Serializer
  attributes :content,:created_at
  belongs_to :user,serializer: User::UserSerializer
  
end
