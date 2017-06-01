class Article::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title,:content,:title_image,:content,:slug, :created_at, :updated_at,:count_like,:count_comment
  # belongs_to :category, serializer: CategorySerializer
  belongs_to :user,serializer: User::UserArticleSerializer
  belongs_to :attentions, serializer: AttentionSerializer
  def count_comment
  	object.comments.size
  end
  def count_like
  	object.attentions.where(isLiked: 1).size
  end

end
