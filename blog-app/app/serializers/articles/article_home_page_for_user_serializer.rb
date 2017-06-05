class Articles::ArticleHomePageForUserSerializer < ActiveModel::Serializer
  attributes :id, :title,:content,:title_image,:content,:user_id, :created_at, :updated_at,:slug,:count_like,:count_comment
  belongs_to :user,serializer: User::UserArticleSerializer
  has_one :attention, serializer: AttentionForUserSerializer
  belongs_to :category, serializer: CategorySerializer
end