class Tag < ApplicationRecord
  has_many :categories_tags, foreign_key: :tag_id
  has_many :categories, :through => :categories_tags

  validated_associated :categories
end
