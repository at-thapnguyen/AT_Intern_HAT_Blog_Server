class Article::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title,:slug, :content, :title_image,:content, :created_at, :updated_at,:count_like,:count_comment
  has_many :tags,through: :articles_tags
  belongs_to :user, serializer: User::UserArticleSerializer
  belongs_to :category, serializer: CategorySerializer
  has_many :comments,serializer: CommentSerializer
  has_one :attention, serializer: AttentionForUserSerializer
  
  def comments
  	object.comments.order(created_at: :desc).limit(5)
  end
end
