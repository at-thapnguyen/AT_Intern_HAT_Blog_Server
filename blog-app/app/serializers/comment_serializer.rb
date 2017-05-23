class CommentSerializer < ActiveModel::Serializer
  attributes :content
  belongs_to :user,serializer: User::UserArticleSerializer
end
