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
#  count_like  :integer          default("0")
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
  class_attribute :user_id
  class_attribute :count_comment

  extend FriendlyId
  friendly_id :title,  use: [:slugged]

  has_many :articles,dependent: :destroy
  has_many :comments
  has_many :attentions
  belongs_to :category
  belongs_to :user
  has_many :articles_tags
  has_many :tags,through: :articles_tags

  validates :title_image, presence: true
  validates :content, presence: true


  has_one :attention,-> {where(user_id: Article.user_id)}

  acts_as_paranoid column: :deleted, sentinel_value: false

  mount_uploader :title_image, ImageUploader
  acts_as_paranoid column: :deleted, sentinel_value: false
  def should_generate_new_friendly_id?
  slug.blank? || title_changed?
end

  scope :filter_category_tag_is_login, ->(category_id, tag_id, current_user){
    if current_user.blank?
      self.user_id = nil
      filter_category_tag category_id, tag_id
    else
      self.user_id = current_user.id
      filter_category_tag category_id, tag_id
    end
  }

  scope :filter_category_tag, -> (category_id, tag_id) {
    if category_id.present? && tag_id.blank?
      self.filter_category(category_id)
    elsif category_id.blank? && tag_id.present?
      self.filter_tag(tag_id)
    elsif category_id.present? && tag_id.present?
      self.filter_category(category_id).filter_tag(tag_id) if category_id.present?
    else
      self.all
    end
  }

  scope :filter_category, -> (id) { where(category_id: id) }
  scope :filter_tag, -> (id){ joins(:articles_tags).where("articles_tags.tag_id = ?", id)}
  # scope :filter_tag, lambda{|id| joins(:articles_tags).where("articles_tags.tag_id = ?", id)}

  scope :create_tags, -> (article, list_tags) {

    tags = list_tags.split(',')
    articles_tags = article.tags.pluck(:name)
    (tags - articles_tags).each do |f|
      tag = Tag.find_or_create_by(name: f)
      article.articles_tags.create(tag_id: tag.id)
    end
    (articles_tags - tags).each do |f|
      tag = Tag.find_by(name: f)
      article.articles_tags.find_by(tag_id: tag.id).destroy
    end
  }

  scope :search, ->(key){
    # joins(:user).joins(:category).joins(:articles_tags).joins(:tags).
    joins("LEFT JOIN users ON articles.user_id = users.id").
    joins("LEFT JOIN categories ON articles.category_id = categories.id").
    joins("LEFT JOIN articles_tags ON articles.id = articles_tags.article_id").
    joins("LEFT JOIN tags ON articles_tags.tag_id = tags.id").
    group("articles.id").
    where("articles.title LIKE ? OR articles.content LIKE ? OR categories.name LIKE ? OR users.username LIKE ?", key, key, key, key)
  }

  private
  def count_comment
    self.comments.size
  end


end
