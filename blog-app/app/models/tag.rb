# == Schema Information
#
# Table name: tags
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  deleted :boolean          default("0")
#

class Tag < ApplicationRecord
  has_many :articles_tags, foreign_key: :tag_id
  has_many :articles, :through => :articles_tags
end


