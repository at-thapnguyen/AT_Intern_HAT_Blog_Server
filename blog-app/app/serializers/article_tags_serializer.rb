class ArticleTagsSerializer < ActiveModel::Serializer
  attributes :id,:name
  has_many :tags
end
