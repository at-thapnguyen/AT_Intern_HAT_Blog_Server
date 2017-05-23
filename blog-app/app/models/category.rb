# == Schema Information
#
# Table name: categories
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  deleted :boolean          default("0")
#

class Category < ApplicationRecord
  has_many :articles
  has_many :categories_tags, foreign_key: :category_id
  has_many :tags, :through => :categories_tags
  validates :name, presence: true, allow_blank: false
end
