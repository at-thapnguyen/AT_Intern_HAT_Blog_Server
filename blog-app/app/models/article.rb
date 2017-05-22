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
  has_many :comments
  has_many :attentions
  belongs_to :category
  belongs_to :user
  has_many :article_tags
  has_many :tags,through: :article_tags

  validates :title_image, presence: true
  validates :content, presence: true

  acts_as_paranoid column: :deleted, sentinel_value: false

  # validates :deleted, presence: true
  # validates_inclusion_of :deleted, :in => [true, false]

  # validates_associated :comments, :attentions, :category, :user

end
