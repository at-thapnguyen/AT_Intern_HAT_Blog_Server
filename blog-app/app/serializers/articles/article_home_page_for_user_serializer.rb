class Articles::ArticleHomePageForUserSerializer < ActiveModel::Serializer
  attributes :id, :title,:content,:title_image,:content,:user_id, :created_at, :updated_at
  # belongs_to :user
  has_one :attention, serializer: AttentionForUserSerializer
  belongs_to :category, serializer: CategorySerializer
  belongs_to :comments, serializer: CommentSerializer
end