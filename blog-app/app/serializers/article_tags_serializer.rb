class ArticleTagsSerializer < ActiveModel::Serializer
  attributes :id,:name, :tag_id
  has_many :tags
end
