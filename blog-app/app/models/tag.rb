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

  # def self.add_tags tags, article_id
  #   tags.each do |f|
  #     tag = self.new name: f
  #     if tag.save
  #       tag.articles_tags.create article_id: article_id
  #     else
  #       tag = self.find_by name: f
  #       if !tag.nil? &&  (tag.articles_tags.find_by article_id: article_id).nil?
  #         tag.articles_tags.create article_id: article_id
  #       end
  #     end
  #   end
  # end

end


