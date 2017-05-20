# == Schema Information
#
# Table name: categories_tags
#
#  id          :integer          not null, primary key
#  category_id :integer
#  tag_id      :integer
#
# Indexes
#
#  fk_rails_105f06f133  (category_id)
#  fk_rails_937ed53929  (tag_id)
#

class CategoriesTag < ApplicationRecord
  has_many :articles

  belongs_to :tag
  belongs_to :category

  validates_associated :articles, :tag, :category
end
