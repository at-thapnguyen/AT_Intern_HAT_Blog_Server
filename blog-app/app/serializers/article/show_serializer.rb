class Article::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title,:slug,:content,:title_image,:content, :created_at, :updated_at,:count_like,:count_comment
  belongs_to :user,serializer: User::UserArticleSerializer
  belongs_to :category, serializer: CategorySerializer
  belongs_to :comments,serializer: CommentSerializer
  has_many :tags,through: :articles_tags

  def count_like
  return object.attentions.where(isLiked: 1).size
  end
  def count_comment
  	object.comments.size
  	
  end
end
