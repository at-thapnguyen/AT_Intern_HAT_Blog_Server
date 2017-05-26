# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text(65535)
#  title_image :string(255)
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean
#  slug        :string(255)
#
# Indexes
#
#  fk_rails_3d31dad1cc     (user_id)
#  fk_rails_af09d53ead     (category_id)
#  index_articles_on_slug  (slug)
#

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title,  use: [:slugged]
  # attr_accessor :attentions_count
  has_many :articles,dependent: :destroy
  has_many :comments
  has_many :attentions
  belongs_to :category
  belongs_to :user
  has_many :articles_tags
  has_many :tags,through: :articles_tags

  validates :title_image, presence: true
  validates :content, presence: true
  mount_uploader :title_image, ImageUploader
  acts_as_paranoid column: :deleted, sentinel_value: false

  # scope :with_count_attentions, -> {joins("LEFT JOIN attentions ON attentions.article_id = articles.id AND isliked = 1").select("articles.* ,count(attentions.id) AS attentions_count").group("articles.id")}

  # validates :deleted, presence: true
  # validates_inclusion_of :deleted, :in => [true, false]

  # validates_associated :comments, :attentions, :category, :user
end
