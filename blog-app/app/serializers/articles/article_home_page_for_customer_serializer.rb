class Articles::ArticleHomePageForCustomerSerializer < ActiveModel::Serializer
  attributes :id, :title,:content,:title_image,:content,:user_id, :created_at, :updated_at
  # belongs_to :user

  belongs_to :category, serializer: CategorySerializer
  belongs_to :comments
  # has_many :article_tags, serializer: ArticleTagsSerializer
  # has_many :articles_tags, serializer: ArticleTagsSerializer

end
