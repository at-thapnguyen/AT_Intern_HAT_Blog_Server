# == Schema Information
#
# Table name: attentions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  isLiked    :boolean          default("0")
#  isFollowed :boolean          default("0")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

#  isLiked    :boolean          default("0")
#  isFollowed :boolean          default("0")
#
# Indexes
#
#  fk_rails_f8c0064c5c  (article_id)
#

class Attention < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :article_id, presence: true
  validates :user_id, presence: true
  has_many :notifications, as: :notificationable, dependent: :destroy
  # scope :with_count_like, -> {joins("LEFT JOIN attentions ON attentions.article_id = articles.id AND isliked = 1").select("articles.* ,count(attentions.id) AS attentions_count").group("articles.id")}
end
