class Article::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title,:slug, :content, :title_image,:content, :created_at, :updated_at,:count_like,:count_comment

  has_many :tags,through: :articles_tags
  belongs_to :user, serializer: User::UserArticleSerializer
  belongs_to :category, serializer: CategorySerializer
  belongs_to :comments,serializer: CommentSerializer
  belongs_to :attentions, serializer: AttentionSerializer

end
