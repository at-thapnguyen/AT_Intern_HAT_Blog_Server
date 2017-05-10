class CategoriesTag < ApplicationRecord
  has_many :articles

  belongs_to :tag
  belongs_to :category

  validates_associated :articles, :tag, :category
end