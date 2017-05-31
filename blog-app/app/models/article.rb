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
  # belongs_to :user, -> { joins('LEFT JOIN follow_users ON users.id = follow_users.user_id').where('follow_users.be_followed_id = 2')}
  has_many :articles_tags
  has_many :tags,through: :articles_tags

  validates :title_image, presence: true
  validates :content, presence: true

  has_one :attention,-> {where(user_id: Article.user_id)}

  # has_one :user, -> { joins('JOIN follow_users ON users.id = follow_users.user_id')}

  acts_as_paranoid column: :deleted, sentinel_value: false

  mount_uploader :title_image, ImageUploader
  acts_as_paranoid column: :deleted, sentinel_value: false

  private
  def count_comment
    self.comments.size
  end
end
