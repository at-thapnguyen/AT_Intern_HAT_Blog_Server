class Attention < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :article_id, presence: true
  validates :user_id, presence: true
  validates :isLiked, presence: true
  validates :isFollowed, presence: true
  validates :notification_like, presence: true
  validates :notification_follow, presence: true

  validates_inclusion_of :isLiked, :in => [true, false]
  validates_inclusion_of :isFollowed, :in => [true, false]
  validates_inclusion_of :notification_like, :in => [true, false]
  validates_inclusion_of :notification_follow, :in => [true, false]

  validates_associated :articles, :user

end