class Category < ApplicationRecord
  has_many :articles
  has_many :categories_tags, foreign_key: :category_id
  has_many :tags, :through => :categories_tags

end
