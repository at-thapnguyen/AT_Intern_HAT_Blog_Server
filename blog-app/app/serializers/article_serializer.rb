class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title,:content,:title_image,:content,:user_id, :created_at, :updated_at
  # belongs_to :user
  belongs_to :attentions
  belongs_to :category, serializer: CategorySerializer
  belongs_to :comments

end
