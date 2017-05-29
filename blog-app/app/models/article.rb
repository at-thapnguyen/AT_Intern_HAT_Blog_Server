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
#
# Indexes
#
#  fk_rails_3d31dad1cc  (user_id)
#  fk_rails_af09d53ead  (category_id)
#

class Article < ApplicationRecord
  class_attribute :user_id
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

  # scope :article_user, -> (user_id) do
  #   joins("LEFT JOIN attentions on articles.id = attentions.article_id and attentions.user_id = #{user_id}")
  # end
  # scope :article_user, ->{ joins(:attentions).where}

  # scope :with_count_attentions, -> {joins("LEFT JOIN attentions ON attentions.article_id = articles.id AND isliked = 1").select("articles.* ,count(attentions.id) AS attentions_count").group("articles.id")}

  # validates :deleted, presence: true
  # validates_inclusion_of :deleted, :in => [true, false]

  # validates_associated :comments, :attentions, :category, :user

end
